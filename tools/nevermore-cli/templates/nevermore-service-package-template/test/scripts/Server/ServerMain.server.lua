--[[
	@class ServerMain
]]
local ServerScriptService = game:GetService("ServerScriptService")

local loader = ServerScriptService:FindFirstChild("LoaderUtils", true).Parent
local require = require(loader).bootstrapGame(ServerScriptService.{{packageName}})

local serviceBag = require("ServiceBag").new()
serviceBag:GetService(require("{{packageNameProper}}Service"))
serviceBag:Init()
serviceBag:Start()