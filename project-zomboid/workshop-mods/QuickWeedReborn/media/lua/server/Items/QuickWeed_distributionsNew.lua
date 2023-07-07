require 'Items/Distributions'
require 'Items/ProceduralDistributions'

function add_zip_bag_10(items, result, player)
	local Inventory = player:getInventory();
	Inventory:AddItem("QuickWeed.zipbag10");
end

function add_zip_bag_50(items, result, player)
	local Inventory = player:getInventory();
	Inventory:AddItem("QuickWeed.zipbag50");
end

function add_zip_bag_100(items, result, player)
	local Inventory = player:getInventory();
	Inventory:AddItem("QuickWeed.zipbag100");
end

table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Base.Lighter");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 3);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Base.Matches");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 3); 
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Base.Cigarettes");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 3);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 3);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 2);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.zipbag10");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.whitewidow");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.silverhaze");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.orangebud");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "QuickWeed.hashishspecial");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.3);

table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Base.Lighter");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 3); 
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Base.Matches");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 3); 
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Base.Cigarettes");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 3);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 3);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 2);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.zipbag10");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.whitewidow");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.silverhaze");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.orangebud");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 1);
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "QuickWeed.hashishspecial");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.3 );

table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 5);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 5);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.badskunk");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 5);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.zipbag10");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 3);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.whitewidow");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 2);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.silverhaze");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 2);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.orangebud");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 2);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.hashishspecial");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 1);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.zipbag50");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 1);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.hashishpollen10");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 1);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.badskunk10");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 1);
table.insert(SuburbsDistributions["all"]["sidetable"].items, "QuickWeed.zipbag100");
table.insert(SuburbsDistributions["all"]["sidetable"].items, 0.1);

table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.hashishpollen10");
table.insert(SuburbsDistributions["all"]["crate"].items, 1);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.badskunk10");
table.insert(SuburbsDistributions["all"]["crate"].items, 1);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.zipbag10");
table.insert(SuburbsDistributions["all"]["crate"].items, 0.5);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.zipbag50");
table.insert(SuburbsDistributions["all"]["crate"].items, 0.3);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.whitewidow10");
table.insert(SuburbsDistributions["all"]["crate"].items, 0.2);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.silverhaze10");
table.insert(SuburbsDistributions["all"]["crate"].items, 0.2);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.orangebud10");
table.insert(SuburbsDistributions["all"]["crate"].items, 0.2);
table.insert(SuburbsDistributions["all"]["crate"].items, "QuickWeed.zipbag100");
table.insert(SuburbsDistributions["all"]["crate"].items, 0.1);

table.insert(SuburbsDistributions["Bag_Schoolbag"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, 2);
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, 2);
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, "QuickWeed.whitewidow");
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, 1);
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, "QuickWeed.orangebud");
table.insert(SuburbsDistributions["Bag_Schoolbag"].items, 1);

table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, "QuickWeed.hashishspecial");
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, 2);
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, 2);
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, 1);
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, "QuickWeed.silverhaze");
table.insert(SuburbsDistributions["Bag_NormalHikingBag"].items, 1);

table.insert(SuburbsDistributions["Bag_DuffelBag"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, 2);
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, 2);
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, "QuickWeed.whitewidow");
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, 1);
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, "QuickWeed.orangebud");
table.insert(SuburbsDistributions["Bag_DuffelBag"].items, 1);

table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, "QuickWeed.hashishspecial");
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, 2);
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, "QuickWeed.rollingpapers");
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, 2);
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, "QuickWeed.hashishpollen");
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, 1);
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, "QuickWeed.silverhaze");
table.insert(SuburbsDistributions["Bag_BigHikingBag"].items, 1);



