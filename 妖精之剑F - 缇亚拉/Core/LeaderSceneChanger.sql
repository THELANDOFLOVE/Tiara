ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverride' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideFriendly' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideGuarded' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideHostile' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideAfraid' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideDenouncing' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideWar' TEXT DEFAULT null;
ALTER TABLE Leaders ADD COLUMN 'LeaderSceneOverrideDefeat' TEXT DEFAULT null;
-- ALTER TABLE Buildings ADD COLUMN 'GlobalCityWorkingChange' INT DEFAULT null;
