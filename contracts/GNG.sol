pragma solidity ^0.4.13;

import "./MiniMeToken.sol";

contract GNG is MiniMeToken{
  	
  	uint constant D160 = 0x0010000000000000000000000000000000000000000;

	function GNG(
	address _tokenFactory
	)MiniMeToken(
	_tokenFactory,
	0x0, 		//no parent token
	0,			//no snapshot block 
	"Genaro Genesis Token", 	//token name 
	1,			//Decimals
	"GNG",		//Symbol
	false
	){}

    // data is an array of uints. Each uint represents a transfer.
    // The 160 LSB is the destination of the addess that wants to be sent
    // The 96 MSB is the amount of tokens that wants to be sent.
    function multiMint(uint[] data) onlyController {
        for (uint i = 0; i < data.length; i++ ) {
            address addr = address( data[i] & (D160-1) );
            uint amount = data[i] / D160;

            if (!generateTokens(addr, amount)) throw;
        }
    }

}
