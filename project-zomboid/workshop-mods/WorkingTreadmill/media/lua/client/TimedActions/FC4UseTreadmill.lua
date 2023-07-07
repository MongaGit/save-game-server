--[[
		Developed by FC4RICA
		Working Treadmill 41.68+
]]

require "TimedActions/ISBaseTimedAction"

FC4UseTreadmill = ISBaseTimedAction:derive("FC4UseTreadmill");

function FC4UseTreadmill:isValid()
	return true;
end

local function addXP(currentDelta)
	local player = getPlayer()
	local xp = player:getXp()
	
	-- get xp multtiply from sandbox options
	local fitnessXPMultiply = SandboxVars.FC4WorkingTreadmill.FitnessXPMultiply
	local strengthXPMultiply = SandboxVars.FC4WorkingTreadmill.StrengthXPMultiply
	local sprintingXPMultiply = SandboxVars.FC4WorkingTreadmill.SprintingXPMultiply
	
	-- add xp when perform or stop
	xp:AddXP(Perks.Fitness, 320*currentDelta * fitnessXPMultiply)
	xp:AddXP(Perks.Sprinting, 35*currentDelta * sprintingXPMultiply)
	if player:getInventoryWeight() > player:getMaxWeight() * 0.5 then
		xp:AddXP(Perks.Strength, 200*currentDelta * strengthXPMultiply)
	end
end

local function adjustStats(stats, currentDelta, enduranceReduction, fatigueIncrease, bodyDamage, temperatureIncrease)
	--reduce player endurance stat
	local enduranceChange = currentDelta * enduranceReduction
	stats:setEndurance(initialEndurance - enduranceChange)

	--add player fatigue stat
	local fatigueChange = currentDelta * fatigueIncrease
	stats:setFatigue(initialFatigue + fatigueChange)
	
	--add player temperature stat
	local temperatureChange = currentDelta * temperatureIncrease
	bodyDamage:setTemperature(initialTemperature + temperatureChange)
end

function FC4UseTreadmill:waitToStart()
	self.character:faceThisObject(self.machine);
	return self.character:shouldBeTurning();
end

-- call every frame while using treadmill
function FC4UseTreadmill:update()

	local isPlaying = self.gameSound
		and self.gameSound ~= 0
		and self.character:getEmitter():isPlaying(self.gameSound)

	if not isPlaying then
		-- Some examples of radius and volume found in PZ code:
		-- Fishing (20,1)
		-- Remove Grass (10,5)
		-- Remove Glass (20,1)
		-- Destroy Stuff (20,10)
		-- Remove Bush (20,10)
		-- Move Sprite (10,5)
		local soundRadius = 13
		local volume = 6

		-- Use the emitter because it emits sound in the world (zombies can hear)
		self.gameSound = self.character:getEmitter():playSound(self.soundFile);
		
		addSound(self.character,
				 self.character:getX(),
				 self.character:getY(),
				 self.character:getZ(),
				 soundRadius,
				 volume)
	end

	local currentDelta = self:getJobDelta()
	local deltaIncrease = currentDelta - self.deltaTabulated
	
	-- Update at every 0.05 delta milestone
	if deltaIncrease > 0.05 then
		adjustStats(self.character:getStats(), currentDelta, 0.85, 0.07, self.character:getBodyDamage(), 0.8)
		
		self.deltaTabulated = currentDelta
	end
	
	self.character:faceThisObject(self.machine);
end

-- call when start using treadmill
function FC4UseTreadmill:start()

	local actionType = self.actionType

	self:setActionAnim(actionType)
	-- Loot is used as a backup action, so keep this
	self.character:SetVariable("LootPosition", "Mid")
	
	local bodyDamage = self.character:getBodyDamage()
	initialEndurance = self.character:getStats():getEndurance()
	initialFatigue = self.character:getStats():getFatigue()
	initialTemperature = bodyDamage:getTemperature()
	print(initialTemperature)
	
	self:setOverrideHandModels(nil, nil)
end

--call when cancle using treadmill
function FC4UseTreadmill:stop()

	-- Make sure game sound has stopped
	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound);
	end

	local soundRadius = 15
	local volume = 6

	-- Use the emitter because it emits sound in the world (zombies can hear)
	self.gameSound = self.character:getEmitter():playSound(self.soundEnd);
		
	addSound(self.character,
			 self.character:getX(),
			 self.character:getY(),
			 self.character:getZ(),
			 soundRadius,
			 volume)
	
	-- Based on the Delta and piece level
	-- calculate Boredom/Unhappiness/Stress changes	
	local currentDelta = self:getJobDelta()
	local deltaIncrease = currentDelta - self.deltaTabulated
	
	--print("FC4WT: Adjusting stats for STOP")
	adjustStats(self.character:getStats(), currentDelta, 0.85, 0.07, self.character:getBodyDamage(), 0.8)
	addXP(currentDelta)
	
	self.deltaTabulated = currentDelta

	-- needed to remove from queue / start next.
	ISBaseTimedAction.stop(self);
end

--call when finish using treadmill
function FC4UseTreadmill:perform()

	-- Make sure game sound has stopped
	if self.gameSound and
		self.gameSound ~= 0 and
		self.character:getEmitter():isPlaying(self.gameSound) then
		self.character:getEmitter():stopSound(self.gameSound);
	end

	local soundRadius = 13
	local volume = 6

	-- Use the emitter because it emits sound in the world (zombies can hear)
	self.gameSound = self.character:getEmitter():playSound(self.soundEnd);
		
	addSound(self.character,
			 self.character:getX(),
			 self.character:getY(),
			 self.character:getZ(),
			 soundRadius,
			 volume)

	-- Based on the Delta and piece level
	-- calculate Boredom/Unhappiness/Stress changes	
	local currentDelta = self:getJobDelta()
	local deltaIncrease = currentDelta - self.deltaTabulated
	
	--print("FC4WT: Adjusting stats for PERFORM")
	adjustStats(self.character:getStats(), currentDelta, 0.85, 0.07, self.character:getBodyDamage(), 0.8)
	addXP(currentDelta)

	self.deltaTabulated = currentDelta

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function FC4UseTreadmill:new(character, machine, sound, soundEnd, actionType, length)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.machine = machine
	o.soundFile = sound
	o.soundEnd = soundEnd
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = length
	o.gameSound = 0
	o.actionType = actionType
	o.deltaTabulated = 0
	return o;
end