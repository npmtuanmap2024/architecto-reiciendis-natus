--[=[
	@class MessagingServiceUtils
]=]

local require = require(script.Parent.loader).load(script)

local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")

local Promise = require("Promise")

local DEBUG_PUBLISH = false
local DEBUG_SUBSCRIBE = false

local MessagingServiceUtils = {}

--[=[
	Wraps MessagingService:PublishAsync(topic, message)
	@param topic string
	@param message any
	@return Promise
]=]
function MessagingServiceUtils.promisePublish(topic, message)
	assert(type(topic) == "string", "Bad topic")

	return Promise.spawn(function(resolve, reject)
		if DEBUG_PUBLISH then
			print(("Publishing on %q: "):format(topic), HttpService:JSONEncode(message))
		end

		local ok, err = pcall(function()
			MessagingService:PublishAsync(topic, message)
		end)
		if not ok then
			if DEBUG_PUBLISH then
				warn(("Failed to publish on %q due to %q"):format(topic, err or "nil"))
			end
			return reject(err)
		end
		return resolve()
	end)
end

--[=[
	Wraps MessagingService:SubscribeAsync(topic, callback)
	@param topic string
	@param callback callback
	@return Promise<RBXScriptConnection>
]=]
function MessagingServiceUtils.promiseSubscribe(topic, callback)
	assert(type(topic) == "string", "Bad topic")
	assert(type(callback) == "function", "Bad callback")

	if DEBUG_SUBSCRIBE then
		print(("Listening on %q"):format(topic))

		local oldCallback = callback
		callback = function(message)
			print(("Recieved on %q"):format(topic), HttpService:JSONEncode(message))
			oldCallback(message)
		end
	end

	return Promise.spawn(function(resolve, reject)
		local connection
		local ok, err = pcall(function()
			connection = MessagingService:SubscribeAsync(topic, callback)
		end)
		if not ok then
			if DEBUG_PUBLISH then
				warn(("Failed to subscribe on %q due to %q"):format(topic, err or "nil"))
			end
			return reject(err)
		end

		return resolve(connection)
	end)
end

return MessagingServiceUtils