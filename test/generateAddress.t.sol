// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import "forge-std/Test.sol";
// import "forge-std/console.sol";

// contract addressTest is Test {

//     // creates a labeled address
//     function mkaddr(string memory name) public returns (address) {
//         address addr = address(
//             uint160(uint256(keccak256(abi.encodePacked(name))))
//         );
//         vm.label(addr, name);
//         return addr;
//     }

//     function testPrint() public {
//         console.log(mkaddr("Isaac"));
//         console.log(mkaddr("BlackAdam"));
//         console.log(mkaddr("Ultra-Tech-code"));
//         console.log(mkaddr("Iyanuoluwa"));
//         console.log(mkaddr("Timidan"));
//         console.log(mkaddr("Wura"));
//         console.log(mkaddr("Kelvin"));
//         console.log(mkaddr("Abims"));
//         console.log(mkaddr("Web3bridge"));
//         console.log(mkaddr("Tosin"));
//     }
// }

// //Result
// //Logs:
// //   0xf9056af4cd1211dd9638e9979e99a43de830779e
// //   0x99cb7f24da7f4bf494bb9740a3ff46d07bee1525
// //   0x9a3a60f5aee7aef1fb0d4da8534452a2e2a89d46
// //   0xf5ab70ada82e7260a4e09d79b8e09bd2fc08970c
// //   0xc9cd96ce406eeb5b7ccecf19415eb640953ff6a0
// //   0xfd5671504514c0214dfb30b1d820d71a891af913
// //   0x14fab7ffc93cecea209cd310a18eb1a760a904a0
// //   0xe32971a6c76188ee8eb336e80b97fc079dcedbeb
// //   0x3281e1230367bcdee7ff37331a1798b9f2af0c53
// //   0xc8211f26bb21afc25bb784208a63d96deaae55cb
// //   0x8421d718c12a750879306c54dec14b90952f46ee
