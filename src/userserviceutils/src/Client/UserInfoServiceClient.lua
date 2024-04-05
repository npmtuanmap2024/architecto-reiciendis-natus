--[=[
	Centralized provider for user info so we can coordinate web requests.

	@class UserInfoServiceClient
]=]

local require = require(script.Parent.loader).load(script)

local UserInfoAggregator = require("UserInfoAggregator")
local Maid = require("Maid")

local UserInfoServiceClient = {}
UserInfoServiceClient.ServiceName = "UserInfoServiceClient"

function UserInfoServiceClient:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")
	self._maid = Maid.new()

	self._aggregator = UserInfoAggregator.new()
	self._maid:GiveTask(self._aggregator)
end

--[=[
	Promises the user info for the given user, aggregating all requests to reduce
	calls into Roblox.

	@param userId number
	@return Promise<UserInfo>
]=]
function UserInfoServiceClient:PromiseUserInfo(userId)
	assert(type(userId) == "number", "Bad userId")

	return self._aggregator:PromiseUserInfo(userId)
end

--[=[
	Promises the user display name for the userId

	@param userId number
	@return Promise<string>
]=]
function UserInfoServiceClient:PromiseDisplayName(userId)
	assert(type(userId) == "number", "Bad userId")

	return self._aggregator:PromiseDisplayName(userId)
end

--[=[
	Observes the user info for the user

	@param userId number
	@return Observable<UserInfo>
]=]
function UserInfoServiceClient:ObserveUserInfo(userId)
	assert(type(userId) == "number", "Bad userId")

	return self._aggregator:ObserveDisplayName(userId)
end

--[=[
	Observes the user display name for the userId

	@param userId number
	@return Observable<string>
]=]
function UserInfoServiceClient:ObserveDisplayName(userId)
	assert(type(userId) == "number", "Bad userId")

	return self._aggregator:ObserveDisplayName(userId)
end

function UserInfoServiceClient:Destroy()
	self._maid:DoCleaning()
end

return UserInfoServiceClient