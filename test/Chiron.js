"use strict";
const Chiron = artifacts.require("./Chiron.sol");


contract('Chiron', function (accounts) {
    before(async function () {

    });

    beforeEach(async function () {
        this.chiron = await Chiron.new();

    });

    it("should compile", async function () {
    });


});