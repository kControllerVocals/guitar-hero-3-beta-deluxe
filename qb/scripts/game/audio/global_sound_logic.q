
script stars 
	printf channel = sfx "*******************************************************"
	printf channel = sfx "*******************************************************"
	printf channel = sfx "*******************************************************"
	printf channel = sfx "*******************************************************"
	printf channel = sfx "*******************************************************"
endscript
musicvolume = 0
musicstreamvolume = 100
0xf198502f = 100
ambienttracknum = 0
forceambientsfxtomusicvolume = 0
musicvoloutsidebox = 30.0
0xe52d5df8 = 30.0
0x2968f804 = 0
0xb061a9be = 0
0xc7669928 = 0
0xd426dad9 = 0
0x5a66117d = 0
InteriorPanningRadius = 10
Global_User_SFX_Number = 10
Guitar_Always_Volume_100 = 0
sfx_adjusted_guitar_volume = 100
highpass_cutoff_freq_modulated = 2000
lowpass_cutoff_freq_modulated = 1000
phaser_delay_time_modulated = 10
auto_wah_is_on = 0
wah_cutoff_freq_modulated = 900
current_audio_effect_type = HighPass
guitar_audio_effects_are_on = 0
guitar_audio_effects_are_on_p1 = 0
guitar_audio_effects_are_on_p2 = 0
Debug_Audible_Downbeat = 0
Debug_Audible_Open = 0
Debug_Audible_Close = 0
Debug_Audible_HitNote = 0
CrowdListenerStateClapOn1234 = 0
CrowdLevelForSurges = 1.66
temp_language_hack = lang_english
StreamPriorityLow = 10
StreamPriorityLowMid = 30
StreamPriorityMid = 50
StreamPriorityMidHigh = 70
StreamPriorityHigh = 90
StreamPriorityHighest = 95
StreamPrioritySystem = 109
Global_SoundEvent_Default_Priority = 50
Global_SoundEvent_Default_Buss = `default`
Global_SoundEvent_NoRepeatFor = 0.1
Global_SoundEvent_InstanceManagement = stop_furthest
Global_SoundEvent_InstanceLimit = 1
Player1Pan = {
	panLCR1 = -100
	panLCR2 = -75
}
Player2Pan = {
	panLCR1 = 75
	panLCR2 = 100
}

script SoundEvent 
	SoundEventFast <...>
endscript

script RegisterSoundEvent 
	AddSoundEventScript SoundEvent_EventID = <SoundEvent_EventID>
	OnExitRun DeRegisterSoundEvent params = {SoundEvent_EventID = <SoundEvent_EventID>}
	<event> <...>
endscript

script DeRegisterSoundEvent 
	RemoveSoundEventScript SoundEvent_EventID = <SoundEvent_EventID>
endscript

script Master_SFX_Adding_Sound_Busses 
	CreateBussSystem $BussTree
	SetSoundBussParams $Default_BussSet
	SetSoundBussParams $Default_BussSet time = 0.5
	SoundBussLock User_Guitar
	SoundBussLock User_Band
	SoundBussLock User_Sfx
	SoundBussLock User_Music
	SoundBussLock Crowd_Beds
	SoundBussLock Crowd_Singalong
	SoundBussLock Band_Balance
	SoundBussLock Guitar_Balance
	SoundBussLock Music_Setlist
	createsoundbusseffects 0x71e20262 = {
		effect = $Echo_Guitar_Buss_Dry
		effect2 = $Reverb_Guitar_Buss_Dry
	}
	createsoundbusseffects Crowd_W_Reverb = {
		effect = $Echo_Crowd_Buss
		effect2 = $Reverb_Crowd_Buss
	}
endscript

script PrintPushPopDebugInfo 
	if NOT GotParam push
		if NOT GotParam Pop
			printf "Did not specify push or pop!"
			return
		endif
	endif
	if GotParam push
		pushPop = "push"
	else
		pushPop = "pop"
	endif
	if NOT GotParam name
		printf "Did not specify script name!"
		return
	endif
	printf "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= %a %b" a = <name> b = <pushPop>
endscript

script Generic_Reverb_Functionality_Script NewEchoSettings = $Echo_Generic_Outside_Slap EchoFadeTime = 0.5 NewReverbSettings = $Reverb_Generic_Outside_Verb ReverbFadeTime = 0.5
	if inside
		if GotParam NewEchoSettings
			if GotParam EchoFadeTime
				setsoundbusseffects effect = <NewEchoSettings> time = <EchoFadeTime>
			else
				setsoundbusseffects effect = <NewEchoSettings>
			endif
		endif
		if GotParam NewReverbSettings
			if GotParam ReverbFadeTime
				setsoundbusseffects effect = <NewReverbSettings> time = <ReverbFadeTime>
			else
				setsoundbusseffects effect = <NewReverbSettings>
			endif
		endif
	else
		if GotParam Destroyed
		else
			if GotParam Created
			else
				if GotParam ExitEchoSettings
					if GotParam ExitEchoFadeTime
						setsoundbusseffects effect = <ExitEchoSettings> time = <ExitEchoFadeTime>
					else
						setsoundbusseffects effect = <ExitEchoSettings>
					endif
				endif
				if GotParam ExitReverbSettings
					if GotParam ExitReverbFadeTime
						setsoundbusseffects effect = <ExitReverbSettings> time = <ExitReverbFadeTime>
					else
						setsoundbusseffects effect = <ExitReverbSettings>
					endif
				endif
			endif
		endif
	endif
endscript

script GH_Guitar_Battle_DSP_Effects_Player1 
	switch <attack_effect>
		case double_note_flange
		printf channel = sfx "setting to doublenote flange"
		setsoundbusseffects effect = $Flange_DoubleNotes1
		printf channel = sfx "changing p1 balance buss"
		SetSoundBussParams {Guitar_Balance_First_Player = {vol = 2}}
		case overload_highpass
		printf channel = sfx "setting to overload highpass"
		setsoundbusseffects effect = $HighPass_Thin1
		printf channel = sfx "changing p1 balance buss"
		SetSoundBussParams {Guitar_Balance_First_Player = {vol = 3}}
		case brokenstring_chorus
		printf channel = sfx "setting to broken string chorus"
		setsoundbusseffects effect = $Chorus_Generic1
		printf channel = sfx "changing p1 balance buss"
		SetSoundBussParams {Guitar_Balance_First_Player = {vol = 0}}
		case lefty_eq
		printf channel = sfx "setting to lefty eq"
		setsoundbusseffects effect = $LowPass_Muffled1
		printf channel = sfx "changing p1 balance buss"
		SetSoundBussParams {Guitar_Balance_First_Player = {vol = 6}}
		case diffup_eq
		printf channel = sfx "setting to diffup eq"
		setsoundbusseffects effect = $EQ_Wah1
		printf channel = sfx "changing p1 balance buss"
		SetSoundBussParams {Guitar_Balance_First_Player = {vol = -6}}
		default
		printf channel = sfx "default"
	endswitch
endscript

script GH_Guitar_Battle_DSP_Effects_Player2 
	switch <attack_effect>
		case double_note_flange
		printf channel = sfx "setting to doublenote flange"
		setsoundbusseffects effect = $Flange_DoubleNotes2
		printf channel = sfx "changing p2 balance buss"
		SetSoundBussParams {Guitar_Balance_Second_Player = {vol = 2}}
		case overload_highpass
		printf channel = sfx "setting to overload highpass"
		setsoundbusseffects effect = $HighPass_Thin2
		printf channel = sfx "changing p2 balance buss"
		SetSoundBussParams {Guitar_Balance_Second_Player = {vol = 3}}
		case brokenstring_chorus
		printf channel = sfx "setting to broken string chorus"
		setsoundbusseffects effect = $Chorus_Generic2
		printf channel = sfx "changing p2 balance buss"
		SetSoundBussParams {Guitar_Balance_Second_Player = {vol = 0}}
		case lefty_eq
		printf channel = sfx "setting to lefty eq"
		setsoundbusseffects effect = $LowPass_Muffled2
		printf channel = sfx "changing p2 balance buss"
		SetSoundBussParams {Guitar_Balance_Second_Player = {vol = 6}}
		case diffup_eq
		printf channel = sfx "setting to diffup eq"
		setsoundbusseffects effect = $EQ_Wah2
		printf channel = sfx "changing p2 balance buss"
		SetSoundBussParams {Guitar_Balance_Second_Player = {vol = -6}}
		default
		printf channel = sfx "default"
	endswitch
endscript

script GH3_Change_Guitar_Audio_Effects_Guitar_Single_Player \{effect_type = `default`}
endscript

script GH3_Guitar_Effects_Wait 
endscript

script GH3_Battle_Attack_Finished_SFX 
	if (<player> = 1)
		SoundEvent \{event = GH_SFX_BattleMode_Attack_Over_P1}
	else
		SoundEvent \{event = GH_SFX_BattleMode_Attack_Over_P2}
	endif
endscript

script Reset_Battle_DSP_Effects 
	if (<player> = 1)
		Reset_Battle_DSP_Effects_Player1
	else
		Reset_Battle_DSP_Effects_Player2
	endif
endscript

script Reset_Battle_DSP_Effects_Player1 
	setsoundbusseffects \{effect = $LowPass_Default1
		time = 0.15}
	setsoundbusseffects \{effect = $HighPass_Default1
		time = 0.15}
	setsoundbusseffects \{effect = $Flange_Default1
		time = 0.15}
	setsoundbusseffects \{effect = $Chorus_Default1
		time = 0.15}
	setsoundbusseffects \{effect = $EQ_Default1
		time = 0.15}
	printf \{channel = sfx
		"RESTTING p1 balance buss"}
	SetSoundBussParams \{Guitar_Balance_First_Player = {
			vol = 0
		}}
endscript

script Reset_Battle_DSP_Effects_Player2 
	setsoundbusseffects \{effect = $LowPass_Default2
		time = 0.15}
	setsoundbusseffects \{effect = $HighPass_Default2
		time = 0.15}
	setsoundbusseffects \{effect = $Flange_Default2
		time = 0.15}
	setsoundbusseffects \{effect = $Chorus_Default2
		time = 0.15}
	setsoundbusseffects \{effect = $EQ_Default2
		time = 0.15}
	printf \{channel = sfx
		"RESTTING p2 balance buss"}
	SetSoundBussParams \{Guitar_Balance_Second_Player = {
			vol = 0
		}}
endscript

script Check_And_Reset_Effects 
endscript

script cleanup_spawned_scripts_for_effects 
endscript

script turn_off_current_audio_effect 
endscript

script Profiling_FMOD_EFFECTS 
endscript

script GH_Star_Power_Verb_On 
	SoundEvent \{event = Star_Power_Deployed_SFX}
	SoundEvent \{event = Star_Power_Deployed_Cheer_SFX}
	PrintPushPopDebugInfo \{push
		name = "Star Power Verb On "}
	PushSoundBussParams
	SetSoundBussParams \{$Star_Power_BussSet
		time = 0.5}
	setsoundbusseffects \{effect = $Reverb_Guitar_Buss_Wikka
		time = 0.1}
endscript

script GH_Star_Power_Verb_Off 
	PrintPushPopDebugInfo \{Pop
		name = "Star Power Verb Off "}
	PopSoundBussParams
	setsoundbusseffects \{effect = $Reverb_Guitar_Buss_Dry
		time = 0.5}
endscript

script GH_SFX_Overloaded_Static_Player1 
endscript

script GH_SFX_wait_then_kill_Overloaded_Static_Player1 
endscript

script GH_SFX_Overloaded_Static_Player2 
endscript

script GH_SFX_wait_then_kill_Overloaded_Static_Player2 
endscript

script GH_BattleMode_Modulate_HPF_Cutoff 
endscript

script gh_battlemode_modulate_HPF_value 
endscript

script GH_BattleMode_Modulate_LPF_Cutoff 
endscript

script gh_battlemode_modulate_LPF_value 
endscript

script GH_BattleMode_Modulate_Phaser_Delay 
endscript

script gh_modulate_Phaser_Delay_Value 
endscript

script gh_battlemode_modulate_Wah_value 
endscript

script GH_BattleMode_Player1_SFX_DiffUp_Start 
	SoundEvent \{event = GH_SFX_BattleMode_DiffUp_P1}
endscript

script GH_BattleMode_Player2_SFX_DiffUp_Start 
	SoundEvent \{event = GH_SFX_BattleMode_DiffUp_P2}
endscript

script GH_BattleMode_Player1_SFX_DoubleNotes_Start 
	SoundEvent \{event = GH_SFX_BattleMode_DoubleNote_P1}
endscript

script GH_BattleMode_Player2_SFX_DoubleNotes_Start 
	SoundEvent \{event = GH_SFX_BattleMode_DoubleNote_P2}
endscript

script GH_BattleMode_Player1_SFX_Shake_Start 
	SoundEvent \{event = GH_SFX_BattleMode_Lightning_Player1}
endscript

script GH_BattleMode_Player2_SFX_Shake_Start 
	SoundEvent \{event = GH_SFX_BattleMode_Lightning_Player2}
endscript

script GH_BattleMode_Player1_SFX_LeftyNotes_Start 
	SoundEvent \{event = GH_SFX_BattleMode_Lefty_P1}
endscript

script GH_BattleMode_Player2_SFX_LeftyNotes_Start 
	SoundEvent \{event = GH_SFX_BattleMode_Lefty_P2}
endscript

script GH_BattleMode_Player1_SFX_BrokenString_Start 
	SoundEvent \{event = GH_SFX_BattleMode_StringBreak_P1}
endscript

script GH_BattleMode_Player2_SFX_BrokenString_Start 
	SoundEvent \{event = GH_SFX_BattleMode_StringBreak_P2}
endscript

script GH_BattleMode_Player1_SFX_Steal 
	SoundEvent \{event = GH_SFX_BattleMode_Steal_P1}
endscript

script GH_BattleMode_Player2_SFX_Steal 
	SoundEvent \{event = GH_SFX_BattleMode_Steal_P2}
endscript

script GH_BattleMode_Player1_SFX_Whammy_Start 
	SoundEvent \{event = GH_SFX_BattleMode_WhammyAttack_P1}
endscript

script GH_BattleMode_Player2_SFX_Whammy_Start 
	SoundEvent \{event = GH_SFX_BattleMode_WhammyAttack_P2}
endscript

script GH3_Crowd_Manipulate_SFX 
endscript

script GH3_Crowd_Event_Listener event_type = surge_fast
	if GotParam event_type
		if ($current_crowd > $CrowdLevelForSurges)
			switch <event_type>
				case sing
				printf " "
				spawnscriptnow GH3_AdjustCrowdSingingVolumeUp
				case surge_fast
				printf " "
				GH3_AdjustCrowdFastSurge <...>
				case surge_slow
				printf " "
				GH3_AdjustCrowdSlowSurge <...>
				default
				printf "idiot"
			endswitch
		else
			if GotParam override_state
				switch <event_type>
					case sing
					printf " "
					spawnscriptnow GH3_AdjustCrowdSingingVolumeUp
					case surge_fast
					GetPakManCurrent map = zones
					switch <pak>
						case z_hell
						SoundEvent event = Hell_Crowd_Swell
						case z_budokan
						case z_wikker
						printf " "
						SoundEvent event = Crowd_Fast_Surge_Cheer
						case z_artdeco
						case z_video
						case z_prison
						case z_soundcheck
						SoundEvent event = Medium_Crowd_Swell
						case z_dive
						SoundEvent event = Small_Crowd_Swell
						case z_party
						SoundEvent event = Small_Crowd_Med_To_Good
						default
						SoundEvent event = Medium_Crowd_Swell
					endswitch
					case surge_slow
					printf " "
					default
					printf "idiot"
				endswitch
			endif
		endif
	endif
endscript

script GH3_AdjustCrowdSingingVolumeUp 
endscript

script GH3_AdjustCrowdSingingVolumeDown 
endscript

script GH3_AdjustCrowdFastSurge 
	SoundBussUnlock \{Crowd_Beds}
	SetSoundBussParams \{$CrowdSurgeBig_BussSet
		time = 1.2}
	SoundBussLock \{Crowd_Beds}
	Wait \{1.5
		seconds}
	SoundBussUnlock \{Crowd_Beds}
	SetSoundBussParams \{$CrowdNormal_BussSet
		time = 4}
	SoundBussLock \{Crowd_Beds}
endscript

script GH3_AdjustCrowdSlowSurge 
	SoundBussUnlock \{Crowd_Beds}
	SetSoundBussParams \{$CrowdSurgeSmall_BussSet
		time = 4}
	SoundBussLock \{Crowd_Beds}
	Wait \{8
		seconds}
	SoundBussUnlock \{Crowd_Beds}
	SetSoundBussParams \{$CrowdNormal_BussSet
		time = 4}
	SoundBussLock \{Crowd_Beds}
endscript

script Crowd_Singalong_Volume_Up 
	SoundBussUnlock \{Crowd_Singalong}
	SetSoundBussParams \{$CrowdSingingVolUp_BussSet
		time = 4}
	SoundBussLock \{Crowd_Singalong}
endscript

script Crowd_Singalong_Volume_Down 
	SoundBussUnlock \{Crowd_Singalong}
	SetSoundBussParams \{$CrowdSingingVolDown_BussSet
		time = 1}
	SoundBussLock \{Crowd_Singalong}
endscript

script menu_music_on 
	SetSpawnInstanceLimits \{max = 1
		management = ignore_spawn_request}
	if GotParam \{waitforguitarlick}
		Wait \{3
			seconds}
	endif
	EnableUserMusic
	begin
	SoundEvent \{event = Menu_Music_SE}
	Wait \{3
		seconds}
	Menu_music_Checking
	Wait \{1
		second}
	repeat
endscript

script Menu_music_Checking 
	begin
	if NOT isSoundEventPlaying \{Menu_Music_SE}
		break
	endif
	Wait \{1
		second}
	repeat
endscript

script Menu_Music_Off 
	EnableUserMusic \{disable}
	KillSpawnedScript \{name = menu_music_on}
	StopSoundEvent \{Menu_Music_SE}
endscript

script PlayEncoreStreamSFX 
endscript

script Song_Intro_Kick_SFX_Waiting 
	printingtext = ($current_intro.hud_move_time)
	Wait ($current_intro.hud_move_time / 1000.0) seconds
	SoundEvent \{event = Song_Intro_Kick_SFX}
endscript

script Song_Intro_Highway_Up_SFX_Waiting 
	printingtext = ($current_intro.highway_move_time)
	waittime = (($current_intro.highway_move_time / 1000.0) - 1.5)
	if (<waittime> < 0)
		waittime = 0
	endif
	Wait <waittime> seconds
	SoundEvent \{event = Song_Intro_Highway_Up}
endscript

script Change_Crowd_Looping_SFX \{crowd_looping_state = good}
	if GotParam \{crowd_looping_state}
		switch <crowd_looping_state>
			case Bad
			Change_Crowd_Looping_SFX_Bad
			case neutral
			Change_Crowd_Looping_SFX_Neutral
			case good
			Change_Crowd_Looping_SFX_Good
			default
			Change_Crowd_Looping_SFX_Good
		endswitch
	endif
endscript

script Change_Crowd_Looping_SFX_Bad 
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_dive
		case z_party
		BG_Crowd_Small_Bad
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		BG_Crowd_Medium_Bad
		case z_budokan
		case z_wikker
		BG_Crowd_Large_Bad
		case z_hell
		BG_Crowd_Hell_Bad
		default
		BG_Crowd_Medium_Bad
	endswitch
endscript

script Change_Crowd_Looping_SFX_Neutral 
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_dive
		case z_party
		BG_Crowd_Small_Neutral
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		BG_Crowd_Medium_Neutral
		case z_budokan
		case z_wikker
		BG_Crowd_Large_Neutral
		case z_hell
		BG_Crowd_Hell_Neutral
		default
		BG_Crowd_Medium_Neutral
	endswitch
endscript

script Change_Crowd_Looping_SFX_Good 
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_dive
		case z_party
		BG_Crowd_Small_Good
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		BG_Crowd_Medium_Good
		case z_budokan
		case z_wikker
		BG_Crowd_Large_Good
		case z_hell
		BG_Crowd_Hell_Good
		default
		BG_Crowd_Medium_Good
	endswitch
endscript

script Crowd_Transition_SFX_Poor_To_Medium 
	GetPakManCurrent map = zones
	switch <pak>
		case z_dive
		case z_party
		SoundEvent event = Small_Crowd_Bad_To_Med_SFX
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		SoundEvent event = Medium_Crowd_Bad_To_Med_SFX
		case z_budokan
		case z_wikker
		SoundEvent event = Crowd_Bad_To_Med_SFX
		case z_hell
		SoundEvent event = Hell_Crowd_Bad_To_Med_SFX
		default
		SoundEvent event = Medium_Crowd_Bad_To_Med_SFX
	endswitch
endscript

script Crowd_Transition_SFX_Medium_To_Good 
	GetPakManCurrent map = zones
	switch <pak>
		case z_dive
		case z_party
		SoundEvent event = Small_Crowd_Med_To_Good_SFX
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		SoundEvent event = Medium_Crowd_Med_To_Good_SFX
		case z_budokan
		case z_wikker
		SoundEvent event = Crowd_Med_To_Good_SFX
		case z_hell
		SoundEvent event = Hell_Crowd_Med_To_Good_SFX
		default
		SoundEvent event = Medium_Crowd_Med_To_Good_SFX
	endswitch
endscript

script Crowd_Transition_SFX_Medium_To_Poor 
	GetPakManCurrent map = zones
	switch <pak>
		case z_dive
		case z_party
		SoundEvent event = Small_Crowd_Med_To_Bad_SFX
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		SoundEvent event = Small_Crowd_Med_To_Bad_SFX
		case z_budokan
		case z_wikker
		SoundEvent event = Crowd_Med_To_Bad_SFX
		case z_hell
		SoundEvent event = Hell_Crowd_Med_To_Bad_SFX
		default
		SoundEvent event = Small_Crowd_Med_To_Bad_SFX
	endswitch
endscript

script Crowd_Transition_SFX_Good_To_Medium 
	GetPakManCurrent map = zones
	switch <pak>
		case z_dive
		case z_party
		SoundEvent event = Small_Crowd_Good_To_Med_SFX
		case z_artdeco
		case z_video
		case z_prison
		case z_soundcheck
		SoundEvent event = Medium_Crowd_Good_To_Med_SFX
		case z_budokan
		case z_wikker
		SoundEvent event = Crowd_Good_To_Med_SFX
		case z_hell
		SoundEvent event = Hell_Crowd_Good_To_Med_SFX
		default
		SoundEvent event = Medium_Crowd_Good_To_Med_SFX
	endswitch
endscript

script You_Rock_Waiting_Crowd_SFX 
	Wait \{2
		seconds}
	SoundEvent \{event = Crowd_Fast_Surge_Cheer}
	SoundEvent \{event = Medium_Crowd_Applause}
endscript
save_check_time_early = 0.0
save_check_time_late = 0.0

script Audio_Sync_Test_Disable_Highway 
	disable_bg_viewport
	change \{save_check_time_early = $check_time_early}
	change \{save_check_time_late = $check_time_late}
	change \{check_time_early = 1.0}
	change \{check_time_late = 1.0}
endscript

script Audio_Sync_Test_Enable_Highway 
	enable_bg_viewport
	change \{check_time_early = $save_check_time_early}
	change \{check_time_late = $save_check_time_late}
endscript

script GH_SFX_Intro_WarmUp 
	GetPakManCurrent map = zones
	switch <pak>
		case z_party
		PlaySound z_party_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_dive
		PlaySound z_dive_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_artdeco
		PlaySound z_artdeco_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_video
		PlaySound z_video_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_prison
		PlaySound z_prison_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_budokan
		PlaySound z_budokan_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_wikker
		PlaySound z_wikker_intro vol = 100 buss = Crowd_PreSong_Intro
		case z_hell
		PlaySound z_hell_intro vol = 45 buss = Crowd_PreSong_Intro
		case z_soundcheck
		PlaySound z_party_intro vol = 100 buss = Crowd_PreSong_Intro
		default
		PlaySound z_party_intro vol = 100 buss = Crowd_PreSong_Intro
	endswitch
endscript

script PreEncore_Crowd_Build_SFX 
	GetPakManCurrent map = zones
	switch <pak>
		case z_party
		printf channel = sfx "playing party build"
		SoundEvent event = PreEncore_Crowd_Build_SFX_Backyard
		case z_dive
		SoundEvent event = PreEncore_Crowd_Build_SFX_Dive
		case z_artdeco
		SoundEvent event = PreEncore_Crowd_Build_SFX_Deco
		case z_video
		SoundEvent event = PreEncore_Crowd_Build_SFX_Video
		case z_prison
		SoundEvent event = PreEncore_Crowd_Build_SFX_Prison
		case z_budokan
		SoundEvent event = PreEncore_Crowd_Build_SFX_Budokan
		case z_wikker
		SoundEvent event = PreEncore_Crowd_Build_SFX_Wikker
		case z_hell
		SoundEvent event = PreEncore_Crowd_Build_SFX_Hell
		case z_soundcheck
		SoundEvent event = PreEncore_Crowd_Build_SFX_Backyard
		default
		SoundEvent event = PreEncore_Crowd_Build_SFX_Backyard
	endswitch
endscript

script PreEncore_Crowd_Build_SFX_STOP 
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Backyard}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Dive}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Deco}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Video}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Prison}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Budokan}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Wikker}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Hell}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Backyard}
	StopSoundEvent \{PreEncore_Crowd_Build_SFX_Backyard}
endscript

script GH_BossDevil_Death_Transition_SFX 
	SoundEvent \{event = Devil_Die_Transition_SFX}
endscript

script Battle_SFX_Repair_Broken_String 
	if GotParam num_strums
		if GotParam player_pan
			if GotParam difficulty
				if (<player_pan> = 1)
					<pan1x> = -0.76199996
					<pan1y> = 0.6470001
					<pan2x> = -0.44799998
					<pan2y> = 0.894
				else
					<pan1x> = 0.47
					<pan1y> = 0.883
					<pan2x> = 0.728
					<pan2y> = 0.685
				endif
				switch <difficulty>
					case easy
					<total_strums> = ($battlemode_powerups [5].easy_repair)
					case medium
					<total_strums> = ($battlemode_powerups [5].medium_repair)
					case hard
					<total_strums> = ($battlemode_powerups [5].hard_repair)
					case expert
					<total_strums> = ($battlemode_powerups [5].expert_repair)
					default
					printf "moron"
				endswitch
				<change_pitch> = (1.0 * <num_strums> / <total_strums>)
				<local_pitch> = (100.0 - (10.0 * <change_pitch>))
				PlaySound GH3_Battlemode_StringTune_2 vol = 50 pitch = <local_pitch> pan1x = <pan1x> pan1y = <pan1y> pan2x = <pan2x> pan2y = <pan2y>
			endif
		endif
	endif
endscript

script GH_SFX_Play_Encore_Audio_From_Zone_Memory 
	GetPakManCurrent map = zones
	switch <pak>
		case z_party
		PlaySound z_party_encore_L vol = 90 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_party_encore_R vol = 90 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0x4a8520eb vol = 90 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_party_encore_LS vol = 90 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_party_encore_RS vol = 90 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		case z_dive
		PlaySound z_dive_encore_L vol = 100 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_dive_encore_R vol = 100 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0x7fd10f11 vol = 100 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_dive_encore_LS vol = 100 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_dive_encore_RS vol = 100 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		case z_video
		PlaySound z_video_encore_L vol = 90 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_video_encore_R vol = 90 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0x4ea91a88 vol = 90 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_video_encore_LS vol = 90 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_video_encore_RS vol = 90 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		case z_artdeco
		PlaySound z_artdeco_encore_L vol = 100 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_artdeco_encore_R vol = 100 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0x8f147b45 vol = 100 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_artdeco_encore_LS vol = 100 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_artdeco_encore_RS vol = 100 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		case z_prison
		PlaySound z_prison_encore_L vol = 90 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_prison_encore_R vol = 90 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0xe00f52f0 vol = 90 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_prison_encore_LS vol = 90 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_prison_encore_RS vol = 90 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		case z_wikker
		PlaySound z_wikker_encore_L vol = 100 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_wikker_encore_R vol = 100 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0xe7f14dc0 vol = 100 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_wikker_encore_LS vol = 100 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_wikker_encore_RS vol = 100 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		case z_budokan
		PlaySound z_budokan_encore_L vol = 90 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound z_budokan_encore_R vol = 90 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0xe2394283 vol = 90 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound z_budokan_encore_LS vol = 90 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound z_budokan_encore_RS vol = 90 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		default
		printf "do nothing - default case"
	endswitch
endscript

script GH_SFX_Play_Boss_Audio_From_Zone_Memory 
	GetPakManCurrent map = zones
	switch <pak>
		case z_hell
		PlaySound 0xc092517f vol = 90 buss = binkcutscenes pan1x = -0.5000002 pan1y = 0.8660253
		PlaySound 0x3a9d6c1c vol = 90 buss = binkcutscenes pan1x = 0.5 pan1y = 0.86602545
		PlaySound 0x502d4cee vol = 90 buss = binkcutscenes pan1x = 0.0 pan1y = 1
		PlaySound 0x0976de7a vol = 90 buss = binkcutscenes pan1x = -0.86602545 pan1y = -0.4999999
		PlaySound 0xdd37e1a5 vol = 90 buss = binkcutscenes pan1x = 0.86602545 pan1y = -0.5000001
		default
		printf "do nothing - default case"
	endswitch
endscript
