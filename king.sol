pragma solidity ^0.5.0;

import "./kingToken.sol";
import "./SafeMath.sol";

contract Invest{
    using SafeMath for uint256;

    kingToken internal tokenContract;

    uint256 internal NumEth;
    uint256 internal tokenPrice;
    uint256 internal sumDisplay;
    uint256 internal totalDividend;
    uint256 internal totalStaticDividend;
    uint256 internal totalN;
    uint256 internal totalWithdraw;
    uint8 internal royalNum;
    uint8 internal b4Num;
    uint8 internal b3Num;
    uint8 internal b2Num;
    uint8 internal b1Num;
    address internal admin;

    mapping (address => address) internal _fatherAdd;
    mapping (address => uint256) internal _playerethnuminbigpool;
    mapping (address => uint256) internal _displayNum;
    mapping (address => uint256) internal _totalRelease;
    mapping (address => uint256) internal _bigZonethNum;
    mapping (address => uint256) internal _smallZonethNum;
    mapping (address => uint256) internal _realNum;
    mapping (address => uint256) internal _nodeETHnum;
    mapping (address => uint256) internal _staticReleaseNum;
    mapping (address => uint256) internal _playerInviteNum;
    mapping (address => uint256) internal _withdrawProfit;
    mapping (address => uint256) internal _recommendProfit;
    mapping (address => uint256) internal _titleProfit;
    mapping (address => uint256) internal _royalProfit;
    mapping (address => uint8) internal _nationalRank;
    mapping (address => uint256) internal _playerPerStaticTime;
    mapping (address => bool) internal _isRoyal;
    mapping (address => bool) internal _isValid;
    mapping (uint256 => uint256) internal _rewardProportion;
    mapping (address => uint8) internal _playerTitle;
    mapping (address => uint16) internal index;

    constructor(address _tokenContract) payable public{
        admin = msg.sender;
        tokenContract = kingToken(_tokenContract);
        tokenPrice = 5e14;
        _rewardProportion[0] = 10;
        _rewardProportion[1] = 8;
        _rewardProportion[2] = 7;
    }

    function () external payable{
        uint256 transferNum;

        NumEth += msg.value;
        _realNum[admin] += msg.value;
        if(msg.value >= 100e18){
            if(_isRoyal[msg.sender] == false){
                royalNum += 1;
                _isRoyal[msg.sender] = true;
            }
            _nationalRank[msg.sender] = 4;
        }
        _playerethnuminbigpool[msg.sender] += msg.value;
        if(msg.value >= 1e18 && msg.value <= 10e18){
            if(_nationalRank[msg.sender] < 1){
                _nationalRank[msg.sender] = 1;
            }
            _displayNum[msg.sender] += msg.value * 3;
            sumDisplay += msg.value * 3;
        }else if(msg.value >= 11e18 && msg.value <= 30e18){
            if(_nationalRank[msg.sender] < 2){
                _nationalRank[msg.sender] = 2;
            }
            _displayNum[msg.sender] += msg.value * 4;
            sumDisplay += msg.value * 4;
        }else if(msg.value >= 31e18){
            if(_nationalRank[msg.sender] < 3){
                _nationalRank[msg.sender] = 3;
            }
            _displayNum[msg.sender] += msg.value * 5;
            sumDisplay += msg.value * 5;
        }
        dynamicProfit();
    }

    function getRoyalNum() public view returns(uint8){
        return royalNum;
    }

    function getB4Num() public view returns(uint8){
        return b4Num;
    }

    function getB3Num() public view returns(uint8){
        return b3Num;
    }

    function getB2Num() public view returns(uint8){
        return b2Num;
    }

    function getB1Num() public view returns(uint8){
        return b1Num;
    }

    function withdrawForPlayer() public returns(bool){
        msg.sender.transfer(_totalRelease[msg.sender]);
        _withdrawProfit[msg.sender] += _totalRelease[msg.sender];
        totalWithdraw += _totalRelease[msg.sender];
        _totalRelease[msg.sender] = 0;
        return true;
    }

    function getTotalWithdraw() public view returns(uint256){
        return totalWithdraw;
    }

    function getPlayerWithdrawProfit() public view returns(uint256){
        return _withdrawProfit[msg.sender];
    }

    function calcStaticProfitEveryday() public returns(bool){
        uint256 tempNumEth;
        uint256 tempSumDisplay;
        uint256 tempBase = 1e18;
        uint256 tempProfit;
        uint256 tempIntervalTime;
        uint256 dailyRate;

        tempIntervalTime = now - _playerPerStaticTime[msg.sender];
        _playerPerStaticTime[msg.sender] = now;
        require(tempIntervalTime >= 24 hours);
        tempSumDisplay = sumDisplay * 30;
        _staticReleaseNum[msg.sender] = 0;
        dailyRate = 0;
        tempNumEth = NumEth;
        dailyRate = tempNumEth / tempSumDisplay;
        tempProfit =  (_displayNum[msg.sender] * dailyRate) / 1e18;
        if(tempProfit > _displayNum[msg.sender]){
            tempProfit = _displayNum[msg.sender];
            _displayNum[msg.sender] = 0;
        }
        _staticReleaseNum[msg.sender] = tempProfit;
        _displayNum[msg.sender] -= _staticReleaseNum[msg.sender];
        _totalRelease[msg.sender] += _staticReleaseNum[msg.sender];
        sumDisplay -= _staticReleaseNum[msg.sender];
        totalDividend += _staticReleaseNum[msg.sender];
        totalStaticDividend += _staticReleaseNum[msg.sender];

        return true;
    }

    function getPlayerLastStaticTime() public view returns(uint256){
        return _playerPerStaticTime[msg.sender];
    }

    function getTotalStaticDividend() public view returns(uint256){
        return totalStaticDividend;
    }

    function dynamicProfit() internal {
        address tmpAddress;
        bool royalProfit = true;
        uint256 generationNum = 0;
        uint256 proportion = 12;
        uint256 releaseNum = 0;

        tmpAddress = msg.sender;
        while(_fatherAdd[tmpAddress] != address(0x0)){
            if(generationNum <= 4){
                generationNum += 1;
            }
            if(generationNum <= 3){
                if(generationNum == 1){
                     releaseNum = (msg.value * _rewardProportion[generationNum-1]) / 100;
                }else{
                    if(_displayNum[_realationAdd[generationNum-1][tmpAddress]] > 0){
                        releaseNum = (msg.value * _rewardProportion[generationNum-1]) / 100;
                    }
                }
                if(releaseNum >= _displayNum[tmpAddress]){
                    releaseNum = _displayNum[tmpAddress];
                    _playerTitle[tmpAddress] = 1;
                }
                _displayNum[tmpAddress] -= releaseNum;
                _recommendProfit[tmpAddress] += releaseNum;
                sumDisplay -= releaseNum;
                _totalRelease[tmpAddress] += releaseNum;
                totalDividend += releaseNum;
                NumEth -= releaseNum;
            }

            // royal profit just for one
            if(royalProfit && _isRoyal[tmpAddress] && _displayNum[tmpAddress] > 0){
                releaseNum = msg.value / 20;
                if(releaseNum >= _displayNum[tmpAddress]){
                    releaseNum = _displayNum[tmpAddress];
                }
                _displayNum[tmpAddress] -= releaseNum;
                _royalProfit[tmpAddress] += releaseNum;
                sumDisplay -= releaseNum;
                _totalRelease[tmpAddress] += releaseNum;
                totalDividend += releaseNum;
                NumEth -= releaseNum;
            }
        }
    }

    function getRecommendProfit() public view returns(uint256){
        return _recommendProfit[msg.sender];
    }

    function getTitleProfit() public view returns(uint256){
        return _titleProfit[msg.sender];
    }

    function getRoyalProfit() public view returns(uint256){
        return _royalProfit[msg.sender];
    }

    function getPlayerisValid() public view returns(bool){
        return _isValid[msg.sender];
    }

    function getotalDividend() public view returns(uint256){
        return totalDividend;
    }

    function getPlayerBigZonethNum() public view returns(uint256){
        return _bigZonethNum[msg.sender];
    }

    function getPlayerSmallZonethNum() public view returns(uint256){
        return _smallZonethNum[msg.sender];
    }

    function getPlayerTotalPerformance() public view returns(uint256){
        return (_bigZonethNum[msg.sender] + _smallZonethNum[msg.sender]);
    }

    function getPlayerInviteNum() public view returns(uint256){
        return _playerInviteNum[msg.sender];
    }

    function getPlayerDisplayNum() public view returns(uint256){
        return _displayNum[msg.sender];
    }

    function getTotalRelease() public view returns(uint256){
        return _totalRelease[msg.sender];
    }

    function getSumInvestValue() public view returns(uint256){
        return NumEth;
    }

    function getRealValue() public view returns(uint256){
        return _realNum[admin];
    }

    function getPlayerTitle() public view returns(uint8){
        return _playerTitle[msg.sender];
    }

    function getPlayerNationalRank() public view returns(uint8){
        return _nationalRank[msg.sender];
    }

    function getPlayerisRoyal() public view returns(bool){
        return _isRoyal[msg.sender];
    }
//===========The Contract End===========//

}
