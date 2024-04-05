--[=[
	Helds encode Roblox enums into a string

	@class EnumUtils
]=]

local EnumUtils = {}

--[=[
	Encodes the value as a string. Note the general format will be such that the string is indexed
	using a regular Lua value. For example:

	```lua
	print(EnumUtils.encodeAsString(Enum.KeyCode.E)) --> Enum.KeyCode.E
	```

	@param enumItem EnumItem
	@return EnumItem
]=]
function EnumUtils.encodeAsString(enumItem)
	assert(typeof(enumItem) == "EnumItem", "Bad enumItem")

	return ("Enum.%s.%s"):format(tostring(enumItem.EnumType), enumItem.Name)
end

--[=[
	Returns whether an enum is of the expected type. Useful for asserts.

	```lua
	assert(EnumUtils.isOfType(Enum.KeyCode, enumItem))
	```

	@param expectedEnumType EnumType
	@param enumItem any
	@return boolean -- True if is of type
	@return string -- Error message if there is an error.
]=]
function EnumUtils.isOfType(expectedEnumType, enumItem)
	assert(typeof(expectedEnumType) == "Enum", "Bad enum")

	if typeof(enumItem) ~= "EnumItem" then
		return false, ("Bad enumItem. Expected enumItem to be %s, got %s '%s'"):format(tostring(expectedEnumType), typeof(enumItem), tostring(enumItem))
	end

	if enumItem.EnumType == expectedEnumType then
		return true
	else
		return false, ("Bad enumItem. Expected enumItem to be %s, got %s"):format(tostring(expectedEnumType), EnumUtils.encodeAsString(enumItem))
	end
end

--[=[
	Attempts to cast an item into an enum

	@param enumType EnumType
	@param value any
	@return EnumItem
]=]
function EnumUtils.toEnum(enumType, value)
	assert(typeof(enumType) == "Enum", "Bad enum")

	if typeof(value) == "EnumItem" then
		if value.EnumType == enumType then
			return value
		else
			return nil
		end
	elseif type(value) == "number" then
		-- There has to be a better way, right?
		for _, item in pairs(enumType:GetEnumItems()) do
			if item.Value == value then
				return item
			end
		end

		return nil
	elseif type(value) == "string" then
		local result = nil
		pcall(function()
			result = enumType[value]
		end)
		if result then
			return result
		end

		-- Check full string name qualifier
		local decoded = EnumUtils.decodeFromString(value)
		if decoded and decoded.EnumType == enumType then
			return decoded
		else
			return nil
		end
	end
end

--[=[
	Returns true if the value is an encoded enum

	@param value any? -- String to decode
	@return boolean
]=]
function EnumUtils.isEncodedEnum(value)
	return EnumUtils.decodeFromString(value) ~= nil
end

--[=[
	Decodes the enum from the string name encoding

	@param value string? -- String to decode
	@return EnumItem
]=]
function EnumUtils.decodeFromString(value)
	if type(value) ~= "string" then
		return nil
	end

	local enumType, enumName = string.match(value, "^Enum%.([^%.%s]+)%.([^%.%s]+)$")
	if enumType and enumName then
		local enumValue
		local ok, err = pcall(function()
			enumValue = Enum[enumType][enumName]
		end)
		if not ok then
			warn(err, ("[EnumUtils.decodeFromString] - Failed to decode %q into an enum value due to %q"):format(value, tostring(err)))
			return nil
		end

		return enumValue
	else
		return nil
	end
end

return EnumUtils