-- ============================================================================
-- Audio_Sounds table
-- ============================================================================
-- 

INSERT OR REPLACE INTO Audio_Sounds
        (SoundID,									Filename,							LoadType)
VALUES  ('SND_UNIT_233_KEDUOLI_ATTACK_VOX_A',		'233_keduoli_attack',           'DynamicResident'),
        ('SND_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T1',      '233_keduoli_amb_attack_T1',	'DynamicResident'),
        ('SND_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T2',      '233_keduoli_amb_attack_T1',	'DynamicResident'),
        ('SND_UNIT_233_KEDUOLI_FORTIFY_VOX_A',		'233_keduoli_attack',           'DynamicResident'),
        ('SND_UNIT_233_KEDUOLI_DEATH_VOX_A',		'233_keduoli_death',            'DynamicResident'),
        ('SND_UNIT_233_KEDUOLI_VICTORY_VOX_A',		'233_keduoli_victory',          'DynamicResident');


-- ============================================================================
-- Audio_3DSounds table
-- ============================================================================   
INSERT OR REPLACE INTO Audio_3DSounds
        (ScriptID,										 SoundID,									SoundType,  MaxVolume,  MinVolume)
VALUES  ('AS3D_UNIT_233_KEDUOLI_ATTACK_VOX_A',			'SND_UNIT_233_KEDUOLI_ATTACK_VOX_A',		'GAME_SFX',  100,         100),
        ('AS3D_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T1',             'SND_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T1',	'GAME_SFX',  100,         100),
        ('AS3D_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T2',             'SND_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T2',	'GAME_SFX',  100,         100),
        ('AS3D_UNIT_233_KEDUOLI_FORTIFY',			'SND_UNIT_FORTIFY',				'GAME_SFX',  100,         100),
        ('AS3D_UNIT_233_KEDUOLI_FORTIFY_VOX_A',			'SND_UNIT_233_KEDUOLI_FORTIFY_VOX_A',		'GAME_SFX',  100,         100),
        ('AS3D_UNIT_233_KEDUOLI_DEATH_VOX_A',			'SND_UNIT_233_KEDUOLI_DEATH_VOX_A',		'GAME_SFX',  100,         100),
        ('AS3D_UNIT_233_KEDUOLI_VICTORY_VOX_A',			'SND_UNIT_233_KEDUOLI_VICTORY_VOX_A',		'GAME_SFX',  100,         100);

-- Mario Attack, Fortify, Death, Victory
UPDATE Audio_3DSounds
SET PitchChangeUp = 1, PitchChangeDown = -1
WHERE ScriptID IN ('AS3D_UNIT_233_KEDUOLI_ATTACK_VOX_A', 'AS3D_UNIT_233_KEDUOLI_FORTIFY_VOX_A', 'AS3D_UNIT_233_KEDUOLI_DEATH_VOX_A', 'AS3D_UNIT_233_KEDUOLI_VICTORY_VOX_A');

-- Mario Fortify (no voiceover)
UPDATE Audio_3DSounds
SET DontPlayMoreThan = 1, DontTriggerDuplicates = 1
WHERE ScriptID IN ('AS3D_UNIT_233_KEDUOLI_FORTIFY');

-- Mario Charge Attack
UPDATE Audio_3DSounds
SET DontPlayMoreThan = 1, DontTriggerDuplicates = 1, MaxTimeMustNotPlayAgain = 6000, MinTimeMustNotPlayAgain = 6000
WHERE ScriptID IN ('AS3D_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T1', 'AS3D_UNIT_233_KEDUOLI_BATTLE_AMB_VOX_T2');



