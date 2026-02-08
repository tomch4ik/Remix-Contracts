// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint256 _candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate");

        candidates[_candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getResults() public view returns (Candidate[] memory) {
        return candidates;
    }
}