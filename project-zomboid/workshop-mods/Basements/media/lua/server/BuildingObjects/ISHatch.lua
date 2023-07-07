--***********************************************************
--**                       BitBraven                       **
--***********************************************************

local Basement = require("BasementMod/Basement")

ISHatch = ISBuildingObject:derive("ISSimpleFurniture");

function ISHatch:create(x, y, z, north, sprite)
	local facing = north and "N" or "E";
	Basement.CreateHatch(x, y, self.size, facing);
end

function ISHatch:new(name, size, sprite)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite.E);
	o:setNorthSprite(sprite.N);
	o.name = name;
	o.size = size;
	o.dismantable = false;
	o.canBarricade = false;
	o.blockAllTheSquare = false;
	o.buildLow = true;
	return o;
end

function ISHatch:isValid(square)
	if buildUtil.stairIsBlockingPlacement( square, true ) then return false; end
	if not self:haveMaterial(square) then return false end

	if square:getZ() > 0 then
		local below = getCell():getGridSquare(square:getX(), square:getY(), square:getZ() - 1)
		if below and below:HasStairs() then
			return false
		end
	end

	for i = 0, square:getObjects():size() - 1 do
		local item = square:getObjects():get(i);

		if (item:getTextureName() and luautils.stringStarts(item:getTextureName(), "vegetation_farming")) or (item:getSpriteName() and luautils.stringStarts(item:getSpriteName(), "vegetation_farming")) then
			return false;
		end
	end

	return ISBuildingObject.isValid(self, square) and Basement.CanCreateHatchOnSquare(square);
end

function ISHatch:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end
