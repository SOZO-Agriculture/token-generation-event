pragma solidity 0.4.24;

import './StandardToken.sol';

contract BurnableToken is StandardToken {

	address public burner = msg.sender;
	address public potentialOwner;

	modifier onlyBurner {
		require(msg.sender == burner);
		_;
	}

	event NewBurner(address burner);

	function setBurner(address _new)
		public
		onlyOwner
	{
		burner = _new;
		emit NewBurner(_new);
	}

	function burn(uint256 amount)
		public
		onlyBurner
	{
		require(balanceOf(msg.sender) >= amount);
		balances[msg.sender] -= amount;
		totalSupply -= amount;
		emit Transfer(msg.sender, address(0x0000000000000000000000000000000000000000), amount);
	}
}
