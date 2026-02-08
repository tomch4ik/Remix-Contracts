// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleShop {
    struct Item {
        string name;
        uint256 price;
    }

    Item[] public items;

    function addItem(string memory _name, uint256 _price) public {
        items.push(Item(_name, _price));
    }

    function buyItem(uint256 _index) public payable {
        require(_index < items.length, "Item does not exist");
        require(msg.value >= items[_index].price, "Not enough funds sent");
    }

    function getAllItems() public view returns (Item[] memory) {
        return items;
    }
}