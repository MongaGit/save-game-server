ZombiesZoneDefinition = ZombiesZoneDefinition or {};
ZombiesZoneDefinition.Default = ZombiesZoneDefinition.Default or {};
ZombiesZoneDefinition.Police = ZombiesZoneDefinition.Police or {};


table.insert(ZombiesZoneDefinition.Default, {name = "Dislaik.Skate", chance=2});
table.insert(ZombiesZoneDefinition.Default, {name = "Dislaik.SWAT", chance=0.5, gender="male", beardStyles="null:80"});
table.insert(ZombiesZoneDefinition.Police, {name = "Dislaik.SWAT", chance=20, gender="male", beardStyles="null:80"});
