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
    
    // Category to Asset Id List Mapping, Food => AssetId 1, AssetId 3
    mapping (uint256 => uint256[]) public assetCategoryToAssetIdList;
    
    mapping (uint256 => assetDetails) public assetIdToAssetDetailsMapping;
    mapping (uint256 => uint256) public assetCategoryToTotalQuantity;
    mapping (uint256 => uint256) public categoryToMinIndex;
    mapping (uint256 => uint256) public categoryToMaxIndex;
    
    // Constructor
    function assetRegistration() public {
        categoryToMinIndex[uint(AssetCategory.FOOD)] = 0;
        categoryToMinIndex[uint(AssetCategory.WATER)] = 0;
        categoryToMinIndex[uint(AssetCategory.CLOTHES)] = 0;
    }
    
    function _assetRegister(string _assetName, uint256 _qty, AssetCategory _assetCategory) public{
        assetToSupplierDetails[maxAssetId] = msg.sender;
        
        assetDetails newAsset;
        newAsset.assetId = maxAssetId;
        newAsset.supplierAddress = msg.sender;
        newAsset.assetCategory = _assetCategory;
        newAsset.assetName = _assetName;
        newAsset.quantity = _qty;
        
        // Asset Id to AssetDetails Map
        assetIdToAssetDetailsMapping[newAsset.assetId] = newAsset;
        
        // Category to Asset Id List Mapping, Food => AssetId 1, AssetId 3
        assetCategoryToAssetIdList[uint(_assetCategory)].push(newAsset.assetId);
        
        // Category to Max index, Food => 3 (max array index)
        categoryToMaxIndex[uint(_assetCategory)] = maxAssetId;
       
        
        // Category to Total Quantity , Food => total quantity 100
        assetCategoryToTotalQuantity[uint(_assetCategory)] = assetCategoryToTotalQuantity[uint(_assetCategory)] + _qty;
        
        maxAssetId = maxAssetId + 1;
        
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


