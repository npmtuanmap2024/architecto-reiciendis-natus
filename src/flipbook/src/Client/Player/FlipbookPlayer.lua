--[=[
	Plays an [Flipbook] on a given imagelabel.
	@class FlipbookPlayer
]=]

local require = require(script.Parent.loader).load(script)

local RunService = game:GetService("RunService")

local BaseObject = require("BaseObject")
local Flipbook = require("Flipbook")
local Maid = require("Maid")
local Promise = require("Promise")
local Rx = require("Rx")
local ValueObject = require("ValueObject")

local FlipbookPlayer = setmetatable({}, BaseObject)
FlipbookPlayer.ClassName = "FlipbookPlayer"
FlipbookPlayer.__index = FlipbookPlayer

--[=[
	Constructs a new FlipbookPlayer

	@param imageLabel ImageLabel
	@return FlipbookPlayer
]=]
function FlipbookPlayer.new(imageLabel)
	local self = setmetatable(BaseObject.new(imageLabel), FlipbookPlayer)

	assert(typeof(self._obj) == "Instance" and (self._obj:IsA("ImageLabel") or self._obj:IsA("ImageButton")), "Bad imageLabel")

	self._isPlaying = ValueObject.new(false, "boolean")
	self._maid:GiveTask(self._isPlaying)

	self._isBoomarang = ValueObject.new(false, "boolean")
	self._maid:GiveTask(self._isBoomarang)

	self._playData = ValueObject.new(nil)
	self._maid:GiveTask(self._playData)

	self._flipbook = ValueObject.new(nil)
	self._maid:GiveTask(self._flipbook)

	self._originalImage = self._obj.Image
	self._originalRectOffset = self._obj.ImageRectOffset
	self._originalRectSize = self._obj.ImageRectSize

	self._maid:GiveTask(Rx.combineLatest({
		playData = self._playData:Observe();
		flipbook = self._flipbook:Observe();
	}):Subscribe(function(state)
		if state.flipbook then
			if state.playData then
				self._isPlaying.Value = true
				self._maid._playing = self:_execPlay(state.flipbook, state.playData)
			else
				self._isPlaying.Value = false
				self._maid._playing = nil

				local restFrame = state.flipbook:GetRestFrame()
				if restFrame then
					self:_updateToFrame(state.flipbook, restFrame)
				else
					self._obj.Image = self._originalImage
					self._obj.ImageRectOffset = self._originalRectOffset
					self._obj.ImageRectSize = self._originalRectSize
				end
			end
		else
			self._isPlaying.Value = false
			self._obj.Image = self._originalImage
			self._obj.ImageRectOffset = self._originalRectOffset
			self._obj.ImageRectSize = self._originalRectSize
		end
	end))

	return self
end

--[=[
	Sets the current sheet and starts play if needed
	@param flipbook Flipbook
]=]
function FlipbookPlayer:SetFlipbook(flipbook)
	assert(Flipbook.isFlipbook(flipbook), "Bad flipbook")

	self._flipbook.Value = flipbook
end

--[=[
	Gets the current flipbook
	@return Flipbook?
]=]
function FlipbookPlayer:GetFlipbook()
	return self._flipbook.Value
end

--[=[
	Plays the flipbook once

	@return Promise
]=]
function FlipbookPlayer:PromisePlayOnce()
	return self:PromisePlayRepeat(1)
end

--[=[
	Plays the flipbook the number of times specified and then stops.

	@param times number
	@return Promise
]=]
function FlipbookPlayer:PromisePlayRepeat(times)
	assert(type(times) == "number", "Bad times")

	local data = {
		startTime = os.clock();
		times = times;
	}

	self._playData.Value = data

	return self:_promiseDonePlaying(data)
end

--[=[
	Sets whether play should boomarang

	@param isBoomarang boolean
]=]
function FlipbookPlayer:SetIsBoomarang(isBoomarang)
	assert(type(isBoomarang) == "boolean", "Bad isBoomarang")

	self._isBoomarang.Value = isBoomarang
end

--[=[
	Plays the flipbook indefinitely
]=]
function FlipbookPlayer:Play()
	self._playData.Value = {
		startTime = 0; -- Synchronize with other variants
		times = math.huge;
	}
end

--[=[
	Stops the flipbook
]=]
function FlipbookPlayer:Stop()
	self._playData.Value = nil
end

--[=[
	Returns true if the flipbook is playing
	@return boolean
]=]
function FlipbookPlayer:IsPlaying()
	return self._isPlaying.Value
end

--[=[
	Observes if the flipbook is playing
	@return Observable<boolean>
]=]
function FlipbookPlayer:ObserveIsPlaying()
	return self._isPlaying:Observe()
end

function FlipbookPlayer:_promiseDonePlaying(data)
	assert(type(data) == "table", "Bad data")

	local maid = Maid.new()
	local promise = Promise.new()
	maid:GiveTask(promise)

	self._maid[promise] = maid

	maid:GiveTask(self._playData:Observe():Subscribe(function(playData)
		if playData ~= data then
			promise:Resolve()
		end
	end))

	maid:GiveTask(self._isPlaying.Changed:Connect(function()
		if not self._isPlaying.Value then
			promise:Resolve()
		end
	end))

	promise:Finally(function()
		maid:DoCleaning()
	end)

	return promise
end

function FlipbookPlayer:_execPlay(flipbook, playData)
	assert(type(playData) == "table", "Bad playData")
	assert(type(playData.startTime) == "number", "Bad playData.startTime")

	local maid = Maid.new()

	maid:GiveTask(RunService.RenderStepped:Connect(function()
		self:_update(flipbook, os.clock(), playData)
	end))
	self:_update(flipbook, os.clock(), playData)

	return maid
end

function FlipbookPlayer:_computeFrameCount(originalFrameCount, isBoomarang)
	if isBoomarang then
		return 2*originalFrameCount - 2
	else
		return originalFrameCount
	end
end

function FlipbookPlayer:_update(flipbook, currentTime, playData)
	local isBoomarang = self._isBoomarang.Value
	local fps = flipbook:GetFrameRate()
	local originalFrameCount = flipbook:GetFrameCount()

	local frameCount = self:_computeFrameCount(originalFrameCount, isBoomarang)
	local frame = (math.floor((currentTime - playData.startTime)*fps)%frameCount) + 1

	if isBoomarang then
		if frame > originalFrameCount then
			frame = frameCount - frame + 2
		end
	end

	local isOver = false
	if playData.times ~= math.huge then
		local executeFrameCount = originalFrameCount
		if isBoomarang then
			executeFrameCount = 2*originalFrameCount - 1
		end

		local elapsed = os.clock() - playData.startTime
		local totalPlayTimeAllowed = playData.times*executeFrameCount/fps

		if elapsed > totalPlayTimeAllowed then
			isOver = true
		end
	end

	if isOver then
		self:_updateToFrame(flipbook, frameCount)
		self._playData.Value = nil
	else
		self:_updateToFrame(flipbook, frame)
	end
end

function FlipbookPlayer:_updateToFrame(flipbook, frame)
	local sprite = flipbook:GetSprite(frame)
	if sprite then
		sprite:Style(self._obj)
	end
end

return FlipbookPlayer