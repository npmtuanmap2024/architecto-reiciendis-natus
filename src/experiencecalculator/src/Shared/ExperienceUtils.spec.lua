--[[
	@class ExperienceUtils.spec.lua
]]

local ExperienceUtils = require(script.Parent.ExperienceUtils)

return function()
	local config = ExperienceUtils.createExperienceConfig({
		factor = 200;
	})

	describe("ExperienceUtils.getLevel", function()
		it("should return a level", function()
			local level = ExperienceUtils.getLevel(config, 0)
			expect(level).to.equal(1)

			level = ExperienceUtils.getLevel(config, 399)
			expect(level).to.equal(1)

			level = ExperienceUtils.getLevel(config, 400)
			expect(level).to.equal(2)
		end)
	end)

	describe("ExperienceUtils.experienceFromLevel", function()
		it("should return experience", function()
			local experience = ExperienceUtils.experienceFromLevel(config, 1)
			expect(experience).to.equal(0)

			experience = ExperienceUtils.experienceFromLevel(config, 2)
			expect(experience).to.equal(400)

			experience = ExperienceUtils.experienceFromLevel(config, 3)
			expect(experience).to.equal(1200)
		end)
	end)
end
