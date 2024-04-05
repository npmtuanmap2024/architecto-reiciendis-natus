--[=[
	@class GameConfigAssetUtils
]=]

local require = require(script.Parent.loader).load(script)

local AttributeUtils = require("AttributeUtils")
local GameConfigAssetConstants = require("GameConfigAssetConstants")
local BadgeUtils = require("BadgeUtils")
local GameConfigAssetTypes = require("GameConfigAssetTypes")
local MarketplaceUtils = require("MarketplaceUtils")
local Promise = require("Promise")

local GameConfigAssetUtils = {}

--[=[
	Creates a new game configuration
	@param binder Binder<GameConfigAssetBase>
	@param assetType GameConfigAssetType
	@param assetKey string
	@param assetId number
	@return Instance
]=]
function GameConfigAssetUtils.create(binder, assetType, assetKey, assetId)
	local asset = Instance.new("Folder")
	asset.Name = assetKey

	binder:Bind(asset)

	AttributeUtils.initAttribute(asset, GameConfigAssetConstants.ASSET_TYPE_ATTRIBUTE, assetType)
	AttributeUtils.initAttribute(asset, GameConfigAssetConstants.ASSET_ID_ATTRIBUTE, assetId)

	return asset
end

--[=[
	Promises cloud data for a given asset type

	@param assetType GameConfigAssetType
	@param assetId number
	@return Promise<any>
]=]
function GameConfigAssetUtils.promiseCloudDataForAssetType(assetType, assetId)
	assert(type(assetType) == "string", "Bad assetType")
	assert(type(assetId) == "number", "Bad assetId")

	-- We really hope this stuff is cached
	if assetType == GameConfigAssetTypes.BADGE then
		return BadgeUtils.promiseBadgeInfo(assetId)
	elseif assetType == GameConfigAssetTypes.PRODUCT then
		return MarketplaceUtils.promiseProductInfo(assetId, Enum.InfoType.Product)
	elseif assetType == GameConfigAssetTypes.PASS then
		return MarketplaceUtils.promiseProductInfo(assetId, Enum.InfoType.GamePass)
	elseif assetType == GameConfigAssetTypes.PLACE then
		return MarketplaceUtils.promiseProductInfo(assetId, Enum.InfoType.Asset)
	elseif assetType == GameConfigAssetTypes.ASSET then
		return MarketplaceUtils.promiseProductInfo(assetId, Enum.InfoType.Asset)
	elseif assetType == GameConfigAssetTypes.BUNDLE then
		return MarketplaceUtils.promiseProductInfo(assetId, Enum.InfoType.Bundle)
	else
		local errorMessage = string.format("[GameConfigAssetUtils.promiseCloudDataForAssetType] - Unknown GameConfigAssetType %q. Ignoring asset.",
			tostring(assetType))

		return Promise.rejected(errorMessage)
	end
end

return GameConfigAssetUtils