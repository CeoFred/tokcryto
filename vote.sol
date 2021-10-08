// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vote {

  
  address public admin;
  uint public candidateCount = 0;
  uint256 public votingEndTime;
  uint256 public votingStartTime;
  uint public totalVoteCasted = 0;
  
  modifier validityPeriod {
		require(block.timestamp < votingEndTime);
		_;
	}
  mapping(uint256 => Candidate) public candidates;
  mapping(address => bool) public userHasVoted;

   struct Candidate{
    uint256 id;
    string name;
    uint votes;
  }

   modifier onlyAdmin() {
    require(msg.sender == admin, 'caller is not the admin');
    _;
  }
      constructor(uint voteStart, uint voteEnds) {
       admin = msg.sender;
       votingStartTime = voteStart;
       votingEndTime = voteEnds;
      }


  function addCandidate(string memory name)public onlyAdmin returns (uint) {
     require(bytes(name).length > 0, "Candidate Name is required");
     uint candidateId = candidateCount++;
     candidates[candidateId] = Candidate(candidateId,name,1);
     return candidateId;
  }

  function vote(uint candidateId) public validityPeriod returns (bool) {
    // vote for a  candidate by id
    // require(candidateId,"Candidate Id is required");
    require(!userHasVoted[msg.sender], "You cannot vote twice");
    require(candidates[candidateId].id > 0, "Invalid candidate");
    candidates[candidateId].votes = candidates[candidateId].votes + 1;
    totalVoteCasted++;
    return true;
  }
  
  function countVotesForCandidate(uint candidateId) public view returns(uint){
      return candidates[candidateId].votes;
  }
  
  function getCandidate(uint candidate) public view returns(string memory){
      return (candidates[candidate].name);
  }
  
  function pickWinner()public onlyAdmin returns(uint){
   
      for(uint i=0; i < totalVoteCasted; i++){
          
      }
  }

}
