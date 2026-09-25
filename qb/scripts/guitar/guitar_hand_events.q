
script Strum_iterator song_name = "test" difficulty = "easy" array_type = "song" player = 1
	get_song_prefix song = <song_name>
	FormatText checksumname = song '%s_song_expert' s = <song_prefix> AddToStringLookup
	array_entry = 0
	GetArraySize $<song>
	if (<array_size> = 0)
		return
	endif
	song_array_size = (<array_size> / $num_song_columns)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < ($<song> [<array_entry>]))
			break
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
	endif
	begin
	if (<song_array_size> = 0)
		break
	endif
	<check_time> = ($<song> [<array_entry>])
	begin
	if (<time> >= <check_time>)
		break
	endif
	Wait 1 gameframe
	GetSongTimeMs time_offset = <time_offset>
	repeat
	note_length = ($<song> [(<array_entry> + 1)])
	if (<note_length> > 0)
		BroadcastEvent type = strum_guitar data = {note_length = <note_length>}
	endif
	<array_entry> = (<array_entry> + $num_song_columns)
	repeat <song_array_size>
endscript

script 0x82356eba song_name = "test" difficulty = "easy" array_type = "song" player = 1
	get_song_prefix song = <song_name>
	FormatText checksumname = song '%s_song_rhythm_expert' s = <song_prefix> AddToStringLookup
	array_entry = 0
	GetArraySize $<song>
	if (<array_size> = 0)
		return
	endif
	song_array_size = (<array_size> / $num_song_columns)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < ($<song> [<array_entry>]))
			break
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
	endif
	begin
	if (<song_array_size> = 0)
		break
	endif
	<check_time> = ($<song> [<array_entry>])
	begin
	if (<time> >= <check_time>)
		break
	endif
	Wait 1 gameframe
	GetSongTimeMs time_offset = <time_offset>
	repeat
	note_length = ($<song> [(<array_entry> + 1)])
	if (<note_length> > 0)
		BroadcastEvent type = 0xe76c8218 data = {note_length = <note_length>}
	endif
	<array_entry> = (<array_entry> + $num_song_columns)
	repeat <song_array_size>
endscript

script FretPos_iterator 
	if ($disable_band = 1)
		return
	endif
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_anim_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		printf "FRETPOS ANIMS DISABLED: No midi events found for this song"
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>] [0])
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
		array_size = (<array_size> - <array_entry>)
		if (<array_size> = 0)
			return
		endif
		begin
		begin
		if (<time> >= $<event_array> [<array_entry>] [0])
			break
		endif
		Wait 1 gameframe
		GetSongTimeMs time_offset = <time_offset>
		repeat
		note = ($<event_array> [<array_entry>] [1])
		length = ($<event_array> [<array_entry>] [2])
		if ((<note> >= 118) && (<note> <= 127))
			LaunchEvent type = pose_fret target = Guitarist data = {note = <note> note_length = <note_length>}
		endif
		if ((<note> >= 101) && (<note> <= 110))
			LaunchEvent type = pose_fret target = bassist data = {note = <note> note_length = <note_length>}
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
	endif
endscript

script FretFingers_iterator 
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_song_expert' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		printf "FRETFINGER ANIMS DISABLED: No midi events found for this song"
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	song_array_size = (<array_size> / $num_song_columns)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>])
			break
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
		if (<song_array_size> = 0)
			return
		endif
		0xa6e43aa8 = false
		0xecb18770 = 0
		0x7eea19a9 = 0
		begin
		begin
		if (<time> >= ($<event_array> [<array_entry>]))
			break
		endif
		if (<0xa6e43aa8> = true)
			time_held = (<time> - <0xecb18770>)
			if (<time_held> > <0x7eea19a9>)
				0xa6e43aa8 = false
				BroadcastEvent type = pose_fingers data = {chord = none}
			endif
		endif
		Wait 1 gameframe
		GetSongTimeMs time_offset = <time_offset>
		repeat
		note_length = 0
		GetArraySize $gem_colors
		gem_count = 0
		0xc4a0a5fe = 0
		color_combo = none
		length = ($<event_array> [(<array_entry> + 1)])
		value_bitfield = ($<event_array> [(<array_entry> + 2)])
		begin
		value = 0
		if NOT ((<value_bitfield> / 2) * 2 = <value_bitfield>)
			value = <length>
		endif
		value_bitfield = (<value_bitfield> / 2)
		if (<value>)
			note_length = ($<event_array> [(<array_entry> + 1)])
			if (<color_combo> = none)
				color_combo = ($gem_colors [<gem_count>])
			else
				FormatText TextName = suffix '_%a' a = ($gem_colors_text [<gem_count>])
				AppendSuffixToChecksum Base = <color_combo> SuffixString = <suffix>
				color_combo = <appended_id>
			endif
			0xc4a0a5fe = (<0xc4a0a5fe> + 1)
			if (<0xc4a0a5fe> = 4)
				break
			endif
		endif
		gem_count = (<gem_count> + 1)
		repeat <array_size>
		if (<color_combo> != none)
			0xa6e43aa8 = true
			0xecb18770 = <time>
			0x7eea19a9 = (<note_length> + ($finger_note_padding * 1000))
			BroadcastEvent type = pose_fingers data = {chord = <color_combo>}
		else
			0xa6e43aa8 = false
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
	endif
endscript

script WatchForStartPlaying_iterator 
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_song_expert' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	song_array_size = (<array_size> / $num_song_columns)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>])
			break
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
		if (<song_array_size> = 0)
			return
		endif
		begin
		if (<time> >= ($<event_array> [<array_entry>]))
			break
		endif
		Wait 1 gameframe
		GetSongTimeMs time_offset = <time_offset>
		repeat
		BroadcastEvent type = start_playing
	endif
endscript

script Drum_iterator 
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_drums_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		printf "FRETPOS ANIMS DISABLED: No midi events found for this song"
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	event_array_size = <array_size>
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<event_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>] [0])
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <event_array_size>
		event_array_size = (<event_array_size> - <array_entry>)
		if (<event_array_size> = 0)
			return
		endif
		begin
		begin
		if (<time> >= $<event_array> [<array_entry>] [0])
			break
		endif
		Wait 1 gameframe
		GetSongTimeMs time_offset = <time_offset>
		repeat
		if CompositeObjectExists name = Drummer
			note = ($<event_array> [<array_entry>] [1])
			length = ($<event_array> [<array_entry>] [2])
			if ((<note> >= 37) && (<note> <= 45))
				FormatText checksumname = Anim 'track_%a' a = <note>
				anims = ($drummer_anims.<Anim>)
				GetArraySize <anims>
				GetRandomValue name = newindex Integer a = 0 b = (<array_size> - 1)
				anim_name = (<anims> [<newindex>])
				Drummer :hero_play_anim Tree = $hero_drumming_branch timerId = leftarm_timer target = DrummerLeftArm Anim = <anim_name> BlendDuration = $drum_blend_time
			elseif ((<note> >= 49) && (<note> <= 57))
				FormatText checksumname = Anim 'track_%a' a = <note>
				anims = ($drummer_anims.<Anim>)
				GetArraySize <anims>
				GetRandomValue name = newindex Integer a = 0 b = (<array_size> - 1)
				anim_name = (<anims> [<newindex>])
				Drummer :hero_play_anim Tree = $hero_drumming_branch timerId = rightarm_timer target = DrummerRightArm Anim = <anim_name> BlendDuration = $drum_blend_time
				if (<note> = 55 || <note> = 57)
					change structurename = drummer_info desired_twist = 1.0
				elseif (<note> = 49)
					change structurename = drummer_info desired_twist = 0.75
				elseif (<note> = 52)
					change structurename = drummer_info desired_twist = 0.5
				else
					change structurename = drummer_info desired_twist = 0.0
				endif
			elseif (<note> = 36)
				BroadcastEvent type = DrumKick_Left
				FormatText checksumname = Anim 'track_%a' a = <note>
				anims = ($drummer_anims.<Anim>)
				GetArraySize <anims>
				GetRandomValue name = newindex Integer a = 0 b = (<array_size> - 1)
				anim_name = (<anims> [<newindex>])
				if NOT (<anim_name> = none)
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = leftfoot timerId = leftfoot_timer Anim = <anim_name> BlendDuration = $drum_blend_time
				endif
			elseif (<note> = 48)
				BroadcastEvent type = DrumKick_Right
				FormatText checksumname = Anim 'track_%a' a = <note>
				anims = ($drummer_anims.<Anim>)
				GetArraySize <anims>
				GetRandomValue name = newindex Integer a = 0 b = (<array_size> - 1)
				anim_name = (<anims> [<newindex>])
				if NOT (<anim_name> = none)
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = rightfoot timerId = rightfoot_timer Anim = <anim_name> BlendDuration = $drum_blend_time
				endif
			endif
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <event_array_size>
	endif
endscript

script Drum_cymbal_iterator 
	get_song_prefix song = <song_name>
	FormatText checksumname = event_array '%s_drums_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists name = <event_array> type = array
		printf "FRETPOS ANIMS DISABLED: No midi events found for this song"
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>] [0])
			break
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
		array_size = (<array_size> - <array_entry>)
		if (<array_size> = 0)
			return
		endif
		begin
		begin
		if (<time> >= $<event_array> [<array_entry>] [0])
			break
		endif
		Wait 1 gameframe
		GetSongTimeMs time_offset = <time_offset>
		repeat
		if CompositeObjectExists name = Drummer
			note = ($<event_array> [<array_entry>] [1])
			length = ($<event_array> [<array_entry>] [2])
			if ((<note> >= 37) && (<note> <= 45))
				switch (<note>)
					case 44
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal1 timerId = CymbalTimer1 Anim = ($cymbal_anims [0]) BlendDuration = $drum_blend_time
					case 45
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal2 timerId = CymbalTimer2 Anim = ($cymbal_anims [1]) BlendDuration = $drum_blend_time
					case 43
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal3 timerId = CymbalTimer3 Anim = ($cymbal_anims [2]) BlendDuration = $drum_blend_time
					case 41
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
					case 42
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
				endswitch
			elseif ((<note> >= 49) && (<note> <= 57))
				switch (<note>)
					case 56
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal1 timerId = CymbalTimer1 Anim = ($cymbal_anims [0]) BlendDuration = $drum_blend_time
					case 57
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal2 timerId = CymbalTimer2 Anim = ($cymbal_anims [1]) BlendDuration = $drum_blend_time
					case 55
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal3 timerId = CymbalTimer3 Anim = ($cymbal_anims [2]) BlendDuration = $drum_blend_time
					case 53
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
					case 54
					Drummer :hero_play_anim Tree = $hero_drumming_branch target = cymbal4 timerId = CymbalTimer4 Anim = ($cymbal_anims [3]) BlendDuration = $drum_blend_time
				endswitch
			endif
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_size>
	endif
endscript

script handle_strum_event 
	Obj_KillSpawnedScript \{name = hero_strum_guitar}
	Obj_SpawnScriptNow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_missed_strum_event 
	Obj_KillSpawnedScript \{name = hero_strum_guitar}
	Obj_SpawnScriptNow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_start_playing 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if (<info_struct>.stance = intro || <info_struct>.stance = intro_smstg)
		handle_change_stance \{stance = Stance_A}
	endif
endscript

script handle_fret_event 
	FormatText checksumname = track 'track_%n' n = <note>
	if ((<note> >= 118) && (<note> <= 127))
		Anim = (($fret_anims).<track>)
	elseif ((<note> >= 101) && (<note> <= 110))
		Anim = (($fret_anims).<track>)
	else
		return
	endif
	Obj_KillSpawnedScript \{name = hero_play_fret_anim}
	Obj_SpawnScriptNow hero_play_fret_anim params = {Anim = <Anim>}
endscript

script handle_finger_event 
	Obj_KillSpawnedScript \{name = hero_play_chord}
	Obj_SpawnScriptNow hero_play_chord params = {chord = <chord>}
endscript

script handle_missed_note 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if ($<info_struct>.playing_missed_note = false)
		change structurename = <info_struct> playing_missed_note = true
		strum_anims = $bad_strums
		anim_length = ($<info_struct>.last_strum_length)
		strum_anim = (<strum_anims>.<anim_length> [0])
		hero_play_strum_anim Anim = <strum_anim> BlendDuration = 0.1
	endif
endscript

script handle_hit_note 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	if ($<info_struct>.playing_missed_note = true)
		change structurename = <info_struct> playing_missed_note = false
	endif
endscript

script 0x1a86ca93 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	if NOT StructureContains Structure = ($<anim_set>) name = <old_stance>
		return
	endif
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if StructureContains Structure = ($<anim_set>.<old_stance>.Transitions) name = <new_stance>
		0x193df704
		if StructureContains Structure = ($<anim_set>.<old_stance>.Transitions.<new_stance>) name = <skill>
			0x42194fa9
			CastToInteger tempo
			0x04724821
			if StructureContains Structure = ($<anim_set>.<old_stance>.Transitions.<new_stance>.<skill>) name = <anim_speed>
				anim_name = ($<anim_set>.<old_stance>.Transitions.<new_stance>.<skill>.<anim_speed>)
			else
				printf channel = AnimInfo "transition anim not defined for skill %d from %a to %b at speed %c ..." a = <old_stance> b = <new_stance> c = <anim_speed> d = <skill>
				return
			endif
		else
			anim_name = ($<anim_set>.<old_stance>.Transitions.<new_stance>)
		endif
		Obj_KillSpawnedScript name = hero_play_adjusting_random_anims
		if (<new_stance> = intro)
			hero_disable_arms
		else
			hero_enable_arms
		endif
		if (<display_debug_info> = true)
			printf channel = 0x9e686549 "name-%a   stance_transition   old-%b   new-%c   file-%d " a = <ObjID> b = <old_stance> c = <new_stance> d = <anim_name>
		endif
		hero_play_anim Anim = <anim_name>
		hero_wait_until_anim_finished
	else
		if (<display_debug_info> = true)
			printf channel = AnimInfo "*** %a transition not defined from %b to %c" a = <ObjID> b = <old_stance> c = <new_stance>
		endif
	endif
endscript

script handle_change_stance 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam no_wait
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		0x1a86ca93 anim_set = <anim_set> old_stance = <old_stance> new_stance = <stance>
		change structurename = <info_struct> stance = <stance>
		change structurename = <info_struct> next_stance = <stance>
		if (<display_debug_info> = true)
			printf channel = AnimInfo "%a stance is immediately changing to %b ...." a = <ObjID> b = <stance>
		endif
		if (<ObjID> = Guitarist || <ObjID> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> disable_arms = true
				change structurename = <info_struct> next_anim_disable_arms = true
			else
				change structurename = <info_struct> disable_arms = false
				change structurename = <info_struct> next_anim_disable_arms = false
			endif
			Obj_SwitchScript guitarist_idle
		else
			Obj_SwitchScript BandMember_Idle
		endif
	else
		if (<display_debug_info> = true)
			printf channel = AnimInfo "%a is queuing stance change to %b............." a = <ObjID> b = <stance>
		endif
		change structurename = <info_struct> next_stance = <stance>
		if (<ObjID> = Guitarist || <ObjID> = bassist)
			if (<stance> = intro || <stance> = intro_smstg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				change structurename = <info_struct> next_anim_disable_arms = true
			else
				change structurename = <info_struct> next_anim_disable_arms = false
			endif
		endif
	endif
	return
endscript

script queue_change_stance 
	Obj_GetID
	ExtendCRC <ObjID> '_Info' out = info_struct
	change structurename = <info_struct> next_stance = <stance>
endscript

script handle_play_anim 
	Obj_GetID
	if (<ObjID> != <name>)
		return
	endif
	ExtendCRC <ObjID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	stance = ($<info_struct>.stance)
	display_debug_info = false
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam no_wait
		if (<display_debug_info> = true)
			printf channel = AnimInfo "%a will immediately start the %b anim........" a = <ObjID> b = <Anim>
		endif
		change structurename = <info_struct> current_anim = <Anim>
		change structurename = <info_struct> next_anim = none
		if GotParam repeat_count
			change structurename = <info_struct> anim_repeat_count = <repeat_count>
		else
			change structurename = <info_struct> anim_repeat_count = 1
		endif
		if GotParam Cycle
			change structurename = <info_struct> cycle_anim = true
		else
			change structurename = <info_struct> cycle_anim = false
		endif
		if (<name> = Guitarist || <name> = bassist)
			if GotParam disable_auto_arms
				change structurename = <info_struct> disable_arms = true
			else
				change structurename = <info_struct> disable_arms = false
			endif
		endif
		Obj_KillSpawnedScript name = hero_play_adjusting_random_anims
		Obj_SpawnScriptNow hero_play_adjusting_random_anims params = {Anim = <Anim>}
	else
		if (<display_debug_info> = true)
			if (<info_struct>.next_anim != none)
				printf channel = AnimInfo "******* %a is replacing queued anim %b with %c ******* " a = <ObjID> b = (<info_struct>.next_anim) c = <Anim>
			else
				printf channel = AnimInfo "%a is queueing the %b anim........" a = <ObjID> b = <Anim>
			endif
		endif
		change structurename = <info_struct> next_anim = <Anim>
		if GotParam repeat_count
			change structurename = <info_struct> next_anim_repeat_count = <repeat_count>
		else
			change structurename = <info_struct> next_anim_repeat_count = 1
		endif
		if GotParam Cycle
			change structurename = <info_struct> cycle_next_anim = true
		else
			change structurename = <info_struct> cycle_next_anim = false
		endif
		if (<name> = Guitarist || <name> = bassist)
			if GotParam disable_auto_arms
				change structurename = <info_struct> next_anim_disable_arms = true
			else
				change structurename = <info_struct> next_anim_disable_arms = false
			endif
		endif
	endif
endscript

script handle_walking 
	Obj_GetID
	if (<ObjID> != <name>)
		return
	endif
	ExtendCRC <ObjID> '_Info' out = info_struct
	if NOT ($<info_struct>.stance = Stance_A)
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		0x1a86ca93 anim_set = <anim_set> old_stance = <old_stance> new_stance = Stance_A
		change structurename = <info_struct> stance = Stance_A
	endif
	change structurename = <info_struct> disable_arms = false
	if ($<info_struct>.allow_movement = true)
		Obj_SwitchScript guitarist_walking params = {<...>}
	endif
endscript
