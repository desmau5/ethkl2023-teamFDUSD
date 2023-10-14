// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MaliciousAddressChecker {
    struct ReportDetails {
        address reporter;        
        uint256 reportCount;
    }

    mapping (address => ReportDetails) public maliciousAddressDetails;
    
    uint256 public checkFee = 0.01 ether; // Set your desired fee amount

    // Constructor
    constructor() {
        // Initialize any contract settings or parameters here
    }
    
    function reportMaliciousAddress(address _maliciousAddress) public {
        require(msg.sender != _maliciousAddress, "You cannot report your own address.");    
        require(msg.sender != maliciousAddressDetails[_maliciousAddress].reporter, "You cannot report the same address more than once.");

        if (maliciousAddressDetails[_maliciousAddress].reportCount == 0){            
            maliciousAddressDetails[_maliciousAddress] = ReportDetails(msg.sender, 1);
        }
        else {
            maliciousAddressDetails[_maliciousAddress].reportCount++;
        }                     
    }
    
    function checkMaliciousAddress(address _addressToCheck) view  public returns (uint256) {
        /*require(msg.value >= checkFee, "Insufficient fee provided."); */
       
        if (maliciousAddressDetails[_addressToCheck].reportCount > 0){            
            return maliciousAddressDetails[_addressToCheck].reportCount;
        }    
        // Return 0 and false if the address has not been reported
        return (0);
    }
}
