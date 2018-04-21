"use strict";
const Chiron = artifacts.require("./Chiron.sol");


contract('Chiron', function (accounts) {
    before(async function () {
       // this.chiron = await Chiron.new();
    });

    beforeEach(async function () {
        this.chiron = await Chiron.new();
    });

    it('should allow to add job', async function(){
        this.chiron.addJob("SOME_COOL_HASH");
        let firstJob = await this.chiron.availableJobs.call(0);
        assert.equal(firstJob,"SOME_COOL_HASH");
    });



    it('should accept answer', async function(){
        this.chiron.addJob("SOME_COOL_HASH2");
        this.chiron.addAnswer("SOME_COOL_HASH",5,accounts[1]);
    })




});