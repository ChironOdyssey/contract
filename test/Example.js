
"use strict";
const Example = artifacts.require("./Example.sol");

let testAmount = web3.toWei(1, "ether");

contract('Example', function (accounts) {
    before(async function () {

    });

    beforeEach(async function () {
        this.example = await Example.new();

    });

    it("should compile", async function () {
    });


});