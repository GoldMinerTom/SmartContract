pragma solidity 0.6.0;

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return a / b;
  }
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}

interface IErc20Contract {
  function transferPresale1(address recipient, uint amount) external returns (bool);
}
contract testPreSale1 {
  using SafeMath for uint;
  uint public constant _minimumDepositBNBAmount = 0.1 ether; // Minimum deposit is 1 BNB
  uint public constant _maximumDepositBNBAmount = 80 ether; // Maximum deposit is 10 BNB
  uint public constant _bnbAmountCap = 100000 ether; // Allow cap at 200 BNB
  uint256 public startBlock;
  uint256 public endBlock;
  address payable public _admin; // Admin address
  address public _erc20Contract; // External erc20 contract
  uint256 public totalBNBAmout;
  struct UserInfo{
  uint256 BuyTokenAmount;
  uint256 BNBAmout;
  bool Deposit;
  }
  mapping (address => UserInfo) public userInfo;
  constructor() public {
    _admin = msg.sender;
    _erc20Contract = ;
    startBlock = ;
    endBlock = ;
  }
  modifier onlyAdmin() {
    require(_admin == msg.sender);
    _;
  }
  event Deposit(address indexed _from, uint _value);
  function transferOwnership(address payable admin) public onlyAdmin {
    require(admin != address(0), "Zero address");
    _admin = admin;
  }
receive() external payable{
  require(block.number >= startBlock,'Wait for pre-sale start!');
  require(totalBNBAmout < _bnbAmountCap, 'reached cap amount');
  require(msg.value >= _minimumDepositBNBAmount, 'Deposit rejected, it is lesser than minimum amount');
  require(msg.value <= _maximumDepositBNBAmount, 'Deposit rejected, it is more than maximum amount');
  userInfo[msg.sender].BNBAmount = userInfo[msg.sender].BNBAmount.add(msg.value);
  userInfo[msg.sender].BuyTokenAmount = userInfo[msg.sender].BuyTokenAmount.add.(msg.value.mul(5000));
}
  function Distribute() external onlyAdmin{
  require(block.number >= endBlock, "Distribution fail, have not reached the distribution date");
  IErc20Contract erc20Contract = IErc20Contract(_erc20Contract);
  for(uint256 i =0;i < userInfo.length , i++)
    erc20Contract.transferPresale1(UserInfo[i],BuyTokenAmount);
  }

function withdrawAll() external onlyAdmin {
  _admin.transfer(address(this).balance);
}
}
