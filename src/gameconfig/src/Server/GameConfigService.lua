--[=[
	@class GameConfigService
]=]

local require = require(script.Parent.loader).load(script)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfigUtils = require("GameConfigUtils")
local GameConfigPicker = require("GameConfigPicker")
local Maid = require("Maid")
local PreferredParentUtils = require("PreferredParentUtils")
local GameConfigAssetUtils = require("GameConfigAssetUtils")
local GameConfigAssetTypeUtils = require("GameConfigAssetTypeUtils")
local GameConfigAssetTypes = require("GameConfigAssetTypes")
local GameConfigServiceConstants = require("GameConfigServiceConstants")

local GameConfigService = {}
GameConfigService.ServiceName = "GameConfigService"

--[=[
	Initializes the configuration service. Should be done via [ServiceBag].
	@param serviceBag ServiceBag
]=]
function GameConfigService:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")
	self._maid = Maid.new()

	-- External
	self._serviceBag:GetService(require("CmdrService"))

	-- Internal
	self._serviceBag:GetService(require("GameConfigCommandService"))
	self._serviceBag:GetService(require("GameConfigTranslator"))
	self._binders = self._serviceBag:GetService(require("GameConfigBindersServer"))

	-- Setup picker
	self._configPicker = GameConfigPicker.new(self._binders.GameConfig, self._binders.GameConfigAsset)
	self._maid:GiveTask(self._configPicker)

	self._getPreferredParent = PreferredParentUtils.createPreferredParentRetriever(ReplicatedStorage, "GameConfigs")
end

--[=[
	Starts the configuration service. Should be done via [ServiceBag].
]=]
function GameConfigService:Start()
	assert(self._serviceBag, "Not initialized")
	self._started = true
end

--[=[
	Adds a new badge with the key configured to the `assetKey`
	@param assetKey string -- Key name to use for the badge
	@param badgeId number -- Cloud id
]=]
function GameConfigService:AddBadge(assetKey, badgeId)
	self:AddTypedAsset(GameConfigAssetTypes.BADGE, assetKey, badgeId)
end

--[=[
	Adds a new product with the key configured to the `assetKey`
	@param assetKey string -- Key name to use for the product
	@param productId number -- Cloud id
]=]
function GameConfigService:AddProduct(assetKey, productId)
	self:AddTypedAsset(GameConfigAssetTypes.PRODUCT, assetKey, productId)
end

--[=[
	Adds a new pass with the key configured to the `assetKey`
	@param assetKey string -- Key name to use for the pass
	@param passId number -- Cloud id
]=]
function GameConfigService:AddPass(assetKey, passId)
	self:AddTypedAsset(GameConfigAssetTypes.PASS, assetKey, passId)
end

--[=[
	Adds a new place with the key configured to the `assetKey`
	@param assetKey string -- Key name to use for the place
	@param placeId number -- Cloud id
]=]
function GameConfigService:AddPlace(assetKey, placeId)
	self:AddTypedAsset(GameConfigAssetTypes.PLACE, assetKey, placeId)
end

--[=[
	Adds a new asset with the key configured to the `assetKey`
	@param assetKey string -- Key name to use for the asset
	@param assetId number -- Cloud id
]=]
function GameConfigService:AddAsset(assetKey, assetId)
	self:AddTypedAsset(GameConfigAssetTypes.ASSET, assetKey, assetId)
end

--[=[
	Adds a new bundle with the key configured to the `assetKey`
	@param assetKey string -- Key name to use for the bundle
	@param bundleId number -- Cloud id
]=]
function GameConfigService:AddBundle(assetKey, bundleId)
	self:AddTypedAsset(GameConfigAssetTypes.BUNDLE, assetKey, bundleId)
end

--[=[
	Adds a new asset with the specified type

	@param assetType GameConfigAssetType
	@param assetKey string -- Key name to use for the bundle
	@param assetId number -- Cloud id
]=]
function GameConfigService:AddTypedAsset(assetType, assetKey, assetId)
	assert(GameConfigAssetTypeUtils.isAssetType(assetType), "Bad assetType")
	assert(type(assetKey) == "string", "Bad assetKey")
	assert(type(assetId) == "number", "Bad assetId")

	local gameConfig = self:_getOrCreateDefaultGameConfig()

	local asset = GameConfigAssetUtils.create(self._binders.GameConfigAsset, assetType, assetKey, assetId)
	asset.Parent = GameConfigUtils.getOrCreateAssetFolder(gameConfig, assetType)

	return asset
end

--[=[
	Gets the current config picker

	@return GameConfigPicker
]=]
function GameConfigService:GetConfigPicker()
	return self._configPicker
end

--[=[
	Returns the preferred parent for the configuration service

	@return Instance
]=]
function GameConfigService:GetPreferredParent()
	return self._getPreferredParent()
end

function GameConfigService:_getOrCreateDefaultGameConfig()
	for _, item in pairs(self._binders.GameConfig:GetAll()) do
		if item:GetGameId() == game.GameId then
			return item:GetFolder()
		end
	end

	local config = GameConfigUtils.create(self._binders.GameConfig, game.GameId)
	config.Name = GameConfigServiceConstants.DEFAULT_CONFIG_NAME
	config.Parent = self:GetPreferredParent()

	return config
end

--[=[
	Cleans up the configuration service. Should be done via [ServiceBag].
]=]
function GameConfigService:Destroy()
	self._maid:DoCleaning()
end

return GameConfigService