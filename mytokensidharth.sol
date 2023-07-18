// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTokenSidharth {

    //public variable 
    string public name = " SmartToken ";
    string public symbol = " ETH ";
    uint256 public totalSupply = 0;


    //mapping variable
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);

    address public owner;

    //mint
    function mint(address _to, uint256 _value) public onlyOwner {
        require(_value > 0, "Invalid value");
        
        balanceOf[_to] += _value;
        totalSupply += _value;
        
        emit Mint(_to, _value);
        emit Transfer(address(0), _to, _value);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    //burn
    function burn(uint256 _value) public {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        
        emit Burn(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }

    //transfer
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

    }
}
