pragma solidity >=0.4.22 <0.6.0;
pragma experimental ABIEncoderV2;

/**
 * 
 * Registration interface which defines the regist method.
 * This applies to all who want to register to the platform 
 * either Supplier or CampLeader. 
 */
contract registration{
    
    struct userInfo{
        address addressValue;
        string name;
        string phoneNumber;
        //bool isDistributor;
    }
    
    mapping (address => userInfo) public userAddressToUserInfoMap;

    modifier isValidPhoneNumber(string _phoneNumber){
        require(bytes(_phoneNumber).length != 10);
        _;
    }
    
    function register (address _address, string name, string _phoneNumber) 
    public{
        userAddressToUserInfoMap[_address].addressValue = _address;
        userAddressToUserInfoMap[_address].name = name;
        userAddressToUserInfoMap[_address].phoneNumber = _phoneNumber;
    }
    
    function getRegistrationDetails(address _address) 
    view
    public 
    returns (userInfo res)
    {
        return userAddressToUserInfoMap[_address];
    }
    
    modifier isRegisteredUser(address _userAddr){
        require(userAddressToUserInfoMap[_userAddr].addressValue != 0 );
        _;
    }
    
}

/**
 *
 * AssetRegistration Interface for registering multiple 
 * types of assets, like Food, water clothes.
 */
contract assetRegistration{
    
    enum AssetCategory {FOOD, WATER, CLOTHES}
    
    struct assetDetails{
        uint256 assetId;
        string assetName;
        uint256 quantity;
        AssetCategory assetCategory;
        address supplierAddress;
    }
    
    uint256 public maxAssetId = 0;
    
    mapping (uint256 => address) public assetToSupplierDetails;
    mapping (uint256 => assetDetails[]) public assetCategoryToAssetList; 
    
    function _assetRegister(string _assetName, uint256 _qty, AssetCategory _assetCategory) public{
        maxAssetId = maxAssetId + 1;
        assetToSupplierDetails[maxAssetId] = msg.sender;
        
        assetDetails newAsset;
        newAsset.assetId = maxAssetId;
        newAsset.supplierAddress = msg.sender;
        newAsset.assetCategory = _assetCategory;
        newAsset.assetName = _assetName;
        newAsset.quantity = _qty;
        assetCategoryToAssetList[uint(_assetCategory)].push(newAsset);
    }
}

/**
 * 
 * Master contract DisasterRecovery, which further implements 
 * registration and assetregistration being mandatory.
 * Also provides interfaces for placing order, despensing order, 
 * creation of user and asser invetory.
 */
contract DisasterRecovery is registration, assetRegistration {

    enum OrderStatus {PROCESSING, PLACED, DISPATCHED, RECIEVED}
    
    struct order{
        uint256 orderId;
        OrderStatus status;
        AssetCategory assetCategory;
        uint256 qty;
    }
     
    mapping (uint256 => order) orderIdToOrderMapping;
    mapping (uint256 => userInfo) orderIdToSupplierMapping;
    mapping (uint256 => userInfo) orderIdToDistributorMapping;
    
    function placeOrder(AssetCategory _assetCategory, uint _qty) public{
        
    }
    
    function dispense(uint256 _qty, AssetCategory _assetCategory) public{
        
    }
    
    function acknowledge(address _distAddress, uint256 orderId){
        
    }
    
    function fullfillDemand(address _supplierAddress, uint256 orderId){
        
    }
    
}


