// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract CrowdFunding {
    struct Campaign{
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256  amountcollected;
        address[] donators;
        uint256[] donations;

    }

    mapping(uint => Campaign) public  campaigns;
    uint public numberOfCampaigns =0;
    function createcamaign(address _owner, string memory _title, string memory _description,uint _target,uint _deadline) public returns (uint){
        Campaign storage campaign = campaigns[numberOfCampaigns];

        require(campaign.deadline<block.timestamp, "the deadline should be a date in the future:");
        campaign.owner =_owner;
        campaign.title =_title;
        campaign.description=_description;
        campaign.target=_target;
        campaign.deadline=_deadline;
        campaign.amountcollected=0;

        numberOfCampaigns++;

        return numberOfCampaigns -1;
    }



    function donateToCampaign(uint256 _id)  public payable {
        uint amount =msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);
        (bool sent,) = payable(campaign.owner).call{value: amount}("");
        if(sent){
            campaign.amountcollected = campaign.amountcollected + amount;
        }
          
        
    }


    function getDonators(uint256 _id) view public returns (address[] memory,uint[]
    memory) {
        return (campaigns [_id].donators,campaigns[_id].donations);
    }

    function getCampaigns () public view returns (Campaign[]memory) {
        Campaign[]memory allCampaigns = new Campaign[](numberOfCampaigns);
        for(uint256 i=0; i <numberOfCampaigns; i++){
            Campaign storage item = campaigns[i];

            allCampaigns[i]= item;
        }

        return allCampaigns;
         
    }


}