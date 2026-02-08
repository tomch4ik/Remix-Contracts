// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProjectDAO {
    struct Project {
        string description;
        uint256 requestedAmount;
        uint256 votes;
        address payable beneficiary;
        bool funded;
    }

    Project[] public projects;
    mapping(uint256 => mapping(address => bool)) public userVoted;

    function proposeProject(string memory _desc, uint256 _amount) public {
        projects.push(Project(_desc, _amount, 0, payable(msg.sender), false));
    }

    function voteForProject(uint256 _index) public {
        require(!userVoted[_index][msg.sender], "Already voted for this project");
        projects[_index].votes += 1;
        userVoted[_index][msg.sender] = true;
    }

    function releaseFunds(uint256 _index) public {
        Project storage project = projects[_index];
        require(project.votes >= 10, "Not enough votes");
        require(!project.funded, "Already funded");
        require(address(this).balance >= project.requestedAmount, "DAO is broke");

        project.funded = true;
        project.beneficiary.transfer(project.requestedAmount);
    }

    receive() external payable {} 
}