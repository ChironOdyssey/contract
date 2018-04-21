pragma solidity ^0.4.23;

contract Chiron {

    address private owner;

    string[] public availableJobs;

    mapping(string => JobStructure) jobs;

    mapping(address => int) reputation;

    mapping(address => int) balances;

    struct JobStructure {
        bool isFinished;
        bool isStarted;
        mapping(address => int) userAnswers;
        address[] users;
    }

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier isValidJob(string imageHash){
        require(jobs[imageHash].isStarted);
        require(!jobs[imageHash].isFinished);
        _;
    }

    function addJob(string imageHash) onlyOwner public {
        require(!jobs[imageHash].isStarted);
        require(!jobs[imageHash].isFinished);
        jobs[imageHash].isStarted = true;
       // availableJobs.push(imageHash);
    }

    function addAnswer(string imageHash, int answer, address user) onlyOwner isValidJob(imageHash) public {
        jobs[imageHash].userAnswers[user] = answer;
    }

    function finishJob(string imageHash, int validAnswer, int reward, int reputationIncrease) onlyOwner isValidJob(imageHash) public {
        jobs[imageHash].isFinished = true;
        removeByValue(imageHash);
        uint arrayLength = jobs[imageHash].users.length;
        for (uint i = 0; i < arrayLength; i++) {
            address userAddr = jobs[imageHash].users[i];
            if (jobs[imageHash].userAnswers[userAddr] == validAnswer) {
                reputation[userAddr] += reputationIncrease;
                balances[userAddr] += reward;

            } else {
                reputation[userAddr] -= reputationIncrease;

            }
        }
    }


    //https://github.com/raineorshine/solidity-by-example/blob/master/remove-from-array.sol
    function find(string value) internal view returns (uint) {
        uint i = 0;
        while (!compareStrings(availableJobs[i], value)) {
            i++;
        }
        return i;
    }

    function removeByValue(string value) internal {
        uint i = find(value);
        removeByIndex(i);
    }

    function removeByIndex(uint i) internal {
        while (i < availableJobs.length - 1) {
            availableJobs[i] = availableJobs[i + 1];
            i++;
        }
        availableJobs.length--;
    }

    //https://ethereum.stackexchange.com/questions/30912/how-to-compare-strings-in-solidity
    function compareStrings(string a, string b) internal pure returns (bool){
        return keccak256(a) == keccak256(b);
    }

}