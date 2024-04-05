--[=[
	@class CooldownServiceClient
]=]

local require = require(script.Parent.loader).load(script)

local CooldownServiceClient = {}
CooldownServiceClient.ServiceName = "CooldownServiceClient"

function CooldownServiceClient:Init(serviceBag)
	assert(not self._serviceBag, "Already initialized")
	self._serviceBag = assert(serviceBag, "No serviceBag")

	-- External
	self._serviceBag:GetService(require("TimeSyncService"))

	-- Internal
	self._serviceBag:GetService(require("CooldownClient"))
	self._serviceBag:GetService(require("CooldownShared"))
end

return CooldownServiceClient