// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    bool public isApproved;
    event Approved(uint balance);
    modifier onlyArbiter{
        require(msg.sender==arbiter);
        _;
    }
    constructor(address _arb,address _ben) payable{
        depositor=msg.sender;
arbiter=_arb;
beneficiary=_ben;
    }
    function approve() external payable onlyArbiter{
        uint balance=address(this).balance;
(bool s,)=beneficiary.call{value:address(this).balance}("");
require(s);

isApproved=true;
emit Approved(balance);
    }
}