--[=[
	Utility functions involving sounds and their state
	@class SoundPromiseUtils
]=]

local require = require(script.Parent.loader).load(script)

local Promise = require("Promise")
local PromiseUtils = require("PromiseUtils")
local PromiseMaidUtils = require("PromiseMaidUtils")
local Maid = require("Maid")

local SoundPromiseUtils = {}

--[=[
	Promises that a sound is loaded
	@param sound Sound
	@return Promise
]=]
function SoundPromiseUtils.promiseLoaded(sound)
	if sound.IsLoaded then
		return Promise.resolved()
	end

	local promise = Promise.new()
	local maid = Maid.new()

	maid:GiveTask(sound:GetPropertyChangedSignal("IsLoaded"):Connect(function()
		if sound.IsLoaded then
			promise:Resolve()
		end
	end))

	maid:GiveTask(sound.Loaded:Connect(function()
		if sound.IsLoaded then
			promise:Resolve()
		end
	end))

	promise:Finally(function()
		maid:DoCleaning()
	end)

	return promise
end

function SoundPromiseUtils.promisePlayed(sound)
	return SoundPromiseUtils.promiseLoaded(sound):Then(function()
		return PromiseUtils.delayed(sound.TimeLength)
	end)
end

function SoundPromiseUtils.promiseLooped(sound)
	local promise = Promise.new()

	PromiseMaidUtils.whilePromise(promise, function(maid)
		maid:GiveTask(sound.DidLoop:Connect(function()
			promise:Resolve()
		end))
	end)

	return promise
end
--[=[
	Promises that all sounds are loaded
	@param sounds { Sound }
	@return Promise
]=]
function SoundPromiseUtils.promiseAllSoundsLoaded(sounds)
	local promises = {}
	for _, sound in pairs(sounds) do
		table.insert(promises, SoundPromiseUtils.promiseLoaded(sound))
	end
	return PromiseUtils.all(promises)
end

return SoundPromiseUtils