--[[
	Generated KeyboardLight with Python
	@class KeyboardLight
]]

local parent = script:FindFirstAncestorWhichIsA("ModuleScript")
local require = require(parent.Parent.loader).load(parent)

local Spritesheet = require("Spritesheet")

local KeyboardLight = setmetatable({}, Spritesheet)
KeyboardLight.ClassName = "KeyboardLight"
KeyboardLight.__index = KeyboardLight

function KeyboardLight.new()
	local self = setmetatable(Spritesheet.new("rbxassetid://1244653012"), KeyboardLight)

	self:AddSprite("BackspaceAlt", Vector2.zero, Vector2.new(100, 100))
	self:AddSprite("Command", Vector2.new(100, 0), Vector2.new(100, 100))
	self:AddSprite("Eleven", Vector2.new(200, 0), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Return, Vector2.new(300, 0), Vector2.new(100, 100))
	self:AddSprite("EnterAlt", Vector2.new(400, 0), Vector2.new(100, 100))
	self:AddSprite("EnterTall", Vector2.new(500, 0), Vector2.new(100, 100))
	self:AddSprite("MarkLeft", Vector2.new(600, 0), Vector2.new(100, 100))
	self:AddSprite("MarkRight", Vector2.new(700, 0), Vector2.new(100, 100))
	self:AddSprite(Enum.UserInputType.MouseButton1, Vector2.new(800, 0), Vector2.new(100, 100))
	self:AddSprite(Enum.UserInputType.MouseButton3, Vector2.new(900, 0), Vector2.new(100, 100))
	self:AddSprite(Enum.UserInputType.MouseWheel, Vector2.new(900, 0), Vector2.new(100, 100))
	self:AddSprite(Enum.UserInputType.MouseButton2, Vector2.new(0, 100), Vector2.new(100, 100))
	self:AddSprite(Enum.UserInputType.MouseMovement, Vector2.new(100, 100), Vector2.new(100, 100))
	self:AddSprite("PlusTall", Vector2.new(200, 100), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.LeftShift, Vector2.new(300, 100), Vector2.new(100, 100))
	self:AddSprite("ShiftAlt", Vector2.new(400, 100), Vector2.new(100, 100))
	self:AddSprite("Ten", Vector2.new(500, 100), Vector2.new(100, 100))
	self:AddSprite("Tilda", Vector2.new(600, 100), Vector2.new(100, 100))
	self:AddSprite("Twelve", Vector2.new(700, 100), Vector2.new(100, 100))
	self:AddSprite("Win", Vector2.new(800, 100), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.A, Vector2.new(900, 100), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Asterisk, Vector2.new(0, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.B, Vector2.new(100, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Backspace, Vector2.new(200, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.C, Vector2.new(300, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.CapsLock, Vector2.new(400, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.D, Vector2.new(500, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Delete, Vector2.new(600, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Down, Vector2.new(700, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.E, Vector2.new(800, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Eight, Vector2.new(900, 200), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.End, Vector2.new(0, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Escape, Vector2.new(100, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F, Vector2.new(200, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F1, Vector2.new(300, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F10, Vector2.new(400, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F11, Vector2.new(500, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F12, Vector2.new(600, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F2, Vector2.new(700, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F3, Vector2.new(800, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F4, Vector2.new(900, 300), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F5, Vector2.new(0, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F6, Vector2.new(100, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F7, Vector2.new(200, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F8, Vector2.new(300, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.F9, Vector2.new(400, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Five, Vector2.new(500, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Four, Vector2.new(600, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.G, Vector2.new(700, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.H, Vector2.new(800, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Home, Vector2.new(900, 400), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.I, Vector2.new(0, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Insert, Vector2.new(100, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.J, Vector2.new(200, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.K, Vector2.new(300, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.L, Vector2.new(400, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Left, Vector2.new(500, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.LeftAlt, Vector2.new(600, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.LeftBracket, Vector2.new(700, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.LeftControl, Vector2.new(800, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.M, Vector2.new(900, 500), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Minus, Vector2.new(0, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.N, Vector2.new(100, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Nine, Vector2.new(200, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.NumLock, Vector2.new(300, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.O, Vector2.new(400, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.One, Vector2.new(500, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.P, Vector2.new(600, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.PageDown, Vector2.new(700, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.PageUp, Vector2.new(800, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Plus, Vector2.new(900, 600), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Print, Vector2.new(0, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Q, Vector2.new(100, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Question, Vector2.new(200, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Quote, Vector2.new(300, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.R, Vector2.new(400, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Right, Vector2.new(500, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.RightBracket, Vector2.new(600, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.S, Vector2.new(700, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Semicolon, Vector2.new(800, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Seven, Vector2.new(900, 700), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Six, Vector2.new(0, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Slash, Vector2.new(100, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Space, Vector2.new(200, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.T, Vector2.new(300, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Tab, Vector2.new(400, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Three, Vector2.new(500, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Two, Vector2.new(600, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.U, Vector2.new(700, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Up, Vector2.new(800, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.V, Vector2.new(900, 800), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.W, Vector2.new(0, 900), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.X, Vector2.new(100, 900), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Y, Vector2.new(200, 900), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Z, Vector2.new(300, 900), Vector2.new(100, 100))
	self:AddSprite(Enum.KeyCode.Zero, Vector2.new(400, 900), Vector2.new(100, 100))

	return self
end

return KeyboardLight