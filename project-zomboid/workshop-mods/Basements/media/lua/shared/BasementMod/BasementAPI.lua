local Basement = require("BasementMod/Basement");

--- Storing all basement definition in this private object
local basements = {};

-----------------------------------------

BasementAPI = {};

--- Add a basement
---@param basement Basement
function BasementAPI.AddBasement(basement)
    if type(basement) == "table" then
        table.insert(basements, basement);
        basement.id = #basements;
    end
end

--- Get all basements
---@return table<Basement>
function BasementAPI.GetBasements()
    return basements;
end

--- Get all basements of size
---@param size string small,medium,large
---@return table<Basement>
function BasementAPI.GetBasementsOfSize(size)
    local found = {};
    for _, basement in ipairs(basements) do
        if basement.size == size then
            table.insert(found, basement);
        end
    end
    return found;
end

--- Add Default Basements

--- ROW 1

BasementAPI.AddBasement( Basement:new("small", 20103, 9322, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9322, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9340, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9340, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9358, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9358, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9376, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9376, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9394, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9394, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9412, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9412, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9430, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9430, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9448, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9448, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9466, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9466, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9484, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9484, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9502, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9502, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9520, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9520, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9538, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9538, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9556, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9556, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9574, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9574, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20103, 9592, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20103, 9592, 4, 5, 5, 0, 2) );

--- ROW 2

BasementAPI.AddBasement( Basement:new("small", 20131, 9313, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9313, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9331, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9331, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9349, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9349, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9367, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9367, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9403, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9403, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9421, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9421, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9439, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9439, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9457, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9457, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9475, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9475, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9493, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9493, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9511, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9511, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9529, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9529, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9547, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9547, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9565, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9565, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9583, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9583, 4, 5, 5, 0, 2) );

BasementAPI.AddBasement( Basement:new("small", 20131, 9583, 0, 5, 5, 0, 2) );
BasementAPI.AddBasement( Basement:new("small", 20131, 9583, 4, 5, 5, 0, 2) );

--- ROW 3

BasementAPI.AddBasement( Basement:new("medium", 20151, 9307, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9307, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9331, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9331, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9355, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9355, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9379, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9379, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9403, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9403, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9427, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9427, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9451, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9451, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9475, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9475, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9499, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9499, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9523, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9523, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9547, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9547, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20151, 9571, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20151, 9571, 4, 10, 10, 0, 2) );

--- ROW 4

BasementAPI.AddBasement( Basement:new("medium", 20177, 9307, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9307, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9331, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9331, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9355, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9355, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9379, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9379, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9403, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9403, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9427, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9427, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9451, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9451, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9475, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9475, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9499, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9499, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9523, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9523, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9547, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9547, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20177, 9571, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20177, 9571, 4, 10, 10, 0, 2) );

--- ROW 5

BasementAPI.AddBasement( Basement:new("medium", 20203, 9307, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20203, 9307, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20203, 9331, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20203, 9331, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20203, 9355, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20203, 9355, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20203, 9379, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20203, 9379, 4, 10, 10, 0, 2) );

--- ROW 6 

BasementAPI.AddBasement( Basement:new("medium", 20229, 9307, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20229, 9307, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20229, 9331, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20229, 9331, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20229, 9355, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20229, 9355, 4, 10, 10, 0, 2) );

BasementAPI.AddBasement( Basement:new("medium", 20229, 9379, 0, 10, 10, 0, 2) );
BasementAPI.AddBasement( Basement:new("medium", 20229, 9379, 4, 10, 10, 0, 2) );

--- ROW 7

BasementAPI.AddBasement( Basement:new("large", 20266, 9341, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9341, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20266, 9377, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9377, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20266, 9413, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9413, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20266, 9449, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9449, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20266, 9485, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9485, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20266, 9521, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9521, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20266, 9557, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20266, 9557, 4, 15, 15, 0, 2) );

--- ROW 8

BasementAPI.AddBasement( Basement:new("large", 20320, 9341, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20320, 9341, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20320, 9377, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20320, 9377, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20320, 9413, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20320, 9413, 4, 15, 15, 0, 2) );

BasementAPI.AddBasement( Basement:new("large", 20320, 9449, 0, 15, 15, 0, 2) );
BasementAPI.AddBasement( Basement:new("large", 20320, 9449, 4, 15, 15, 0, 2) );
