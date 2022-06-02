//SPDX-license-Identifier: GPL-3.0

pragma solidty >=0.5.0 <0.9.0;

contract Auction{
    address payable public owner;
    uint public startBlock;
    uint pulbic endBlock;
    string public ipfsHash;

    enum State {Started, Running, Ended, Canceled}
    State public auctionState;

    uint public highestBindingBid;
    address payable public highestBidder;

    mapping(address => uint) public bids;
    uint bidIncrement;

    constructor(){
        owner = payable(msg.sender);
        auctionState = State.Running;
        startBlock = block.number;
        endBlock = startBlock + 40320;
    }

    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }

    modifier afterStart(){
        require(block.number <= startBlock);
    }

    modifier beforeEnd(){
        require(block.number <= endBlock);
        _;
    }

function min(uint a, uint b) pure internal returns (uint){
    if (a <= b){
        return a ;
    }  else{
        return b;
    }
}


    function placeBid() public payable notOwner afterStart beforeEnd {
        require(auctionState == State.running);
        require(msg.value >= 100);

        uint currentBid = bids[msg.sender] + msg.value;
        require(currentBid > highestBindingBid)

        if (currentBid <= bids[highestBidder]){
            highestBidder = min (currentBid + bidIncrement,bids[highestBidder])
        }

    }
}