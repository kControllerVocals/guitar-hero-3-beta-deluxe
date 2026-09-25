script GuitarEvent_HitNote 
	SpawnScriptNow GuitarEvent_HitNote_Spawned Params = {<...>}
	if ($firework_gems = 1)
		SpawnScriptNow GuitarEvent_StarSequenceBonus Params = {<...> fireworks = 1}
	endif
endscript

script GuitarEvent_HitNote_Spawned 
	Wait \{1
		gameframe}
	if ($game_mode = p2_battle || $boss_battle = 1)
		change structurename = <player_status> last_hit_note = <color>
	endif
	Wait \{1
	GameFrame}
	if (<no_flames> = 0)
		SpawnScriptNow hit_note_fx Params = {Name = <fx_id> Pos = <Pos> player_Text = <player_Text> Star = ($<player_status>.star_power_used) Player = <Player>}
	endif
	if ($fc_hud_spawned = 0)
		dx_create_fc_hud
	endif
	if ($fc_hud_moved = 0)
		dx_fc_hud_watchdog
	endif
	if ($fc_glowburst_anim_started = 0)
		RunScriptOnScreenElement \{Id = dx_fc_hud_glowburst animate_dx_fc_glowburst}
		Change fc_glowburst_anim_started = 1
	endif
endscript

script difficulty_setup 
	scroll_time_factor = 1
	game_speed_factor = 1
	if ($current_num_players = 2 || $end_credits = 1)
		scroll_time_factor = ($p2_scroll_time_factor)
		game_speed_factor = ($p2_game_speed_factor)
	endif
	GetGlobalTags \{user_options}
	if ($Cheat_HyperSpeed > 0)
		hyperspeed_scale = -1
		switch $Cheat_HyperSpeed
			case 1
			<hyperspeed_scale> = 0.88
			case 2
			<hyperspeed_scale> = 0.83
			case 3
			<hyperspeed_scale> = 0.78
			case 4
			<hyperspeed_scale> = 0.72999996
			case 5
			<hyperspeed_scale> = 0.68
			case 6
			<hyperspeed_scale> = 0.63
			case 7
			<hyperspeed_scale> = 0.58
			case 8
			<hyperspeed_scale> = 0.53
			case 9
			<hyperspeed_scale> = 0.48
			case 10
			<hyperspeed_scale> = 1.25
			case 11
			<hyperspeed_scale> = 1.50
			case 12
			<hyperspeed_scale> = 1.75
			case 13
			<hyperspeed_scale> = 2
			case 14
			<hyperspeed_scale> = 2.25
		endswitch
		if (<hyperspeed_scale> > 0)
			scroll_time_factor = (<scroll_time_factor> * <hyperspeed_scale>)
			game_speed_factor = (<game_speed_factor> * <hyperspeed_scale>)
		endif
	endif
    if (<sync_diff_speeds> = 1)
	    AddParams ($difficulty_list_props.EXPERT)
    else
        AddParams ($difficulty_list_props.<DIFFICULTY>)
    endif
	if ($current_speedfactor < 1.0)
		Change StructureName = <player_status> scroll_time = (<scroll_time> * <scroll_time_factor>)
		Change StructureName = <player_status> game_speed = (<game_speed> * <game_speed_factor>)
	else
		Change StructureName = <player_status> scroll_time = ((<scroll_time> * <scroll_time_factor>) * $current_speedfactor)
		Change StructureName = <player_status> game_speed = ((<game_speed> * <game_speed_factor>) * $current_speedfactor)
	endif
endscript

script cameracuts_waitscript \{camera_time = 0
		camera_songtime = 0}
	getsongtimems
	change cameracuts_changetime = <camera_songtime>
    GetGlobalTags \{user_options}
	begin
	getsongtimems
	if ($gwinportcameralocked = 0 || <dx_frontrowcamera> = 0)
		if (<time> >= $cameracuts_changetime ||
				$cameracuts_changenow = true)
			if ($cameracuts_changecamenable = true)
				break
			endif
		endif
		if NOT ($cameracuts_forcechangetime = 0.0)
			if ($cameracuts_forcechangetime < (<time> - $cameracuts_lastcamerastarttime))
				change \{cameracuts_forcechangetime = 0.0}
				break
			endif
		endif
		if gotparam \{nowait}
			return \{false}
		endif
	endif
	wait \{1
		gameframe}
	repeat
	return \{true}
endscript

nx_intro_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = -400
	hud_move_time = 200
}
nx_fastintro_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = -6700
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = -400
	hud_move_time = 200
}
nx_practice_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -3000
	highway_move_time = 2000
	button_ripple_start_time = -1800
	button_ripple_per_button_time = 100
	hud_start_time = -1400
	hud_move_time = 200
}
nx_immediate_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 135.0)
	song_artist_pos = (255.0, 150.0)
	song_title_start_time = 0
	song_title_fade_time = 700
	song_title_on_time = 0
	highway_start_time = 0
	highway_move_time = 0
	button_ripple_start_time = 0
	button_ripple_per_button_time = 0
	hud_start_time = 0
	hud_move_time = 0
}
dx_intro_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 115.0)
	song_artist_pos = (255.0, 138.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = -400
	hud_move_time = 200
}
dx_fastintro_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 115.0)
	song_artist_pos = (255.0, 138.0)
	song_title_start_time = -6700
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -2000
	highway_move_time = 2000
	button_ripple_start_time = -800
	button_ripple_per_button_time = 100
	hud_start_time = -400
	hud_move_time = 200
}
dx_practice_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 115.0)
	song_artist_pos = (255.0, 138.0)
	song_title_start_time = -6500
	song_title_fade_time = 700
	song_title_on_time = 3000
	highway_start_time = -3000
	highway_move_time = 2000
	button_ripple_start_time = -1800
	button_ripple_per_button_time = 100
	hud_start_time = -1400
	hud_move_time = 200
}
dx_immediate_sequence_props = {
	song_title_pos = (255.0, 75.0)
	performed_by_pos = (255.0, 115.0)
	song_artist_pos = (255.0, 138.0)
	song_title_start_time = 0
	song_title_fade_time = 700
	song_title_on_time = 0
	highway_start_time = 0
	highway_move_time = 0
	button_ripple_start_time = 0
	button_ripple_per_button_time = 0
	hud_start_time = 0
	hud_move_time = 0
}

script setup_user_option_tags 
	SetGlobalTags user_options params = {
		guitar_volume = 11
		band_volume = 11
		sfx_volume = 11
		lefty_flip_p1 = 0
		lefty_flip_p2 = 0
		lag_calibration = 0.0
		autosave = 1
		resting_whammy_position_device_0 = -0.76
		resting_whammy_position_device_1 = -0.76
		resting_whammy_position_device_2 = -0.76
		resting_whammy_position_device_3 = -0.76
		star_power_position_device_0 = 16.0
		star_power_position_device_1 = 16.0
		star_power_position_device_2 = 16.0
		star_power_position_device_3 = 16.0
		gamma_brightness = 5
		online_game_mode = 0
		online_difficulty = 0
		online_num_songs = 0
		online_tie_breaker = 0
		online_highway = 0
		unlock_Cheat_AirGuitar = 0
		Cheat_AirGuitar = 0
		unlock_Cheat_PerformanceMode = 0
		unlock_Cheat_Hyperspeed = 0
		Cheat_HyperSpeed = 0
		unlock_Cheat_NoFail = 0
		Cheat_NoFail = 0
		unlock_Cheat_EasyExpert = 0
		unlock_Cheat_PrecisionMode = 0
		unlock_Cheat_BretMichaels = 0
		Cheat_BretMichaels = 0
		unlock_Cheat_LargeGems = 0
		black_highway = 0
		black_background = 0
		transparent_highway = 0
		song_title = 0
		highway_shake = 0
		early_timing = 0
		no_flames = 0
		no_whammy_particles = 0
		no_whammy_pitch_shift = 0
		track_muting = 0
		no_miss_sfx = 0
		select_restart = 0
		awesomeness = 0
		nopostproc = 0
		dx_large_gems = 0
		insta_fail = 0
		proto_sp = 0
		dx_frontrowcamera = 0
		dx_brutal_mode = 0
		fast_highway = 0
		mult_vocalist = 0
		dx_force_encore = 0
        sync_diff_speeds = 1
        disable_hand_flames = 0
        song_select_stats = 0
        hw_angle = 0
	}
endscript

script Do_StarPower_StageFX
	GetGlobalTags \{user_options}
	if (<black_background> = 1)
		return
	endif
	switch (<player_status>.character_id)
		case Johnny
		SpawnScriptLater Do_StarPower_FlameThrowerFX id = <scriptID> params = {<...>}
		case judy
		SpawnScriptLater Do_StarPower_HeartsFX id = <scriptID> params = {<...>}
		case Lars
		SpawnScriptLater Do_StarPower_BatFX id = <scriptID> params = {<...>}
		case Midori
		SpawnScriptLater Do_StarPower_ButterfliesFX id = <scriptID> params = {<...>}
		case Xavier
		SpawnScriptLater Do_StarPower_PeaceFX id = <scriptID> params = {<...>}
		default
		SpawnScriptLater Do_StarPower_TeslaFX id = <scriptID> params = {<...>}
	endswitch
endscript

script practice_start_song \{device_num = 0}
	change \{game_mode = training}
	change \{current_transition = practice}
	if (<black_background> = 0)
		Change \{current_level = load_z_soundcheck}
	else
		Change \{current_level = z_viewer}
	endif
	start_song StartTime = ($practice_start_time) device_num = <device_num> practice_intro = 1 endtime = ($practice_end_time)
	change \{practice_audio_muted = 0}
	if ($current_speedfactor = 1.0)
		menu_audio_settings_update_band_volume \{vol = 7}
	else
		menu_audio_settings_update_band_volume \{vol = 0}
	endif
	SetSoundBussParams \{Crowd = {
			vol = -100.0
		}}
	spawnscriptnow \{practice_update}
endscript

script quickplay_start_song device_num = 0
	printf "quickplay_start_song"
	get_progression_globals game_mode = ($game_mode)
	songlist = <tier_global>
	cs_get_total_guitarists
	GetRandomValue a = 0 b = (<num_guitarists> -1) name = random_guitarist_index Integer
	get_valid_character_index char_index = <random_guitarist_index>
	get_musician_profile_struct index = <index>
	FormatText checksumname = character_id '%s' s = (<profile_struct>.name)
	change structurename = player1_status character_id = <character_id>
	get_total_num_venues
	GetRandomValue a = 0 b = (<num_venues> -1) name = random_venue_index Integer
	get_valid_venue_index venue_index = <random_venue_index>
	get_LevelZoneArray_checksum index = <index>
	if (<black_background> = 0)
		Change current_level = <level_checksum>
	else
		Change current_level = z_viewer
	endif
	dx_reset_fc_counters
	printstruct x = <...>
	printf "Random Guitarist index is %g. Random venue index is %v" g = <random_guitarist_index> v = <random_tier_index>
	start_song device_num = <device_num>
endscript

script GuitarEvent_MissedNote 
	if (<bum_note> = 1)
		SoundEvent event = Single_Player_Bad_Note_Guitar
	endif
	if NOT ($<player_status>.guitar_volume = 0)
		if (<silent_miss> = 1)
			spawnscriptnow highway_pulse_black params = {player_text = ($<player_status>.text)}
		else
			change structurename = <player_status> guitar_volume = 0
			0x1c07e771
		endif
	endif
	CrowdDecrease player_status = <player_status>
	if ($always_strum = false)
		if ($disable_band = 0)
			if CompositeObjectExists name = (<player_status>.band_member)
				LaunchEvent type = Anim_MissedNote target = (<player_status>.band_member)
			endif
		endif
	endif
	note_time = ($<song> [<array_entry>] [0])
	if ($show_play_log = 1)
		output_log_text "Missed Note (%t)" t = <note_time> color = Orange
	endif
	if ($fc_hud_moved = 0)
		Change dont_create_fc_hud = 1
	endif
	Change fc_hud_go_away = 1
	dx_fc_hud_watchdog
	GetGlobalTags \{user_options}
	if (<insta_fail> = 1)
		GuitarEvent_SongFailed
	endif
	if ($fc_glowburst_anim_started = 1)
		Change fc_glowburst_anim_started = 2
	endif
endscript

script GuitarEvent_UnnecessaryNote 
	if NOT ($current_song = improv)
		SoundEvent event = Single_Player_Bad_Note_Guitar
	endif
	change structurename = <player_status> guitar_volume = 0
	0x1c07e771
	CrowdDecrease player_status = <player_status>
	if ($always_strum = false)
		if ($disable_band = 0)
			if CompositeObjectExists name = (<player_status>.band_member)
				LaunchEvent type = Anim_MissedNote target = (<player_status>.band_member)
			endif
		endif
	endif
	if ($show_play_log = 1)
		if (<array_entry> > 0)
			<songtime> = (<songtime> - ($check_time_early * 1000.0))
			next_note = ($<song> [<array_entry>] [0])
			prev_note = ($<song> [(<array_entry> -1)] [0])
			next_time = (<next_note> - <songtime>)
			prev_time = (<songtime> - <prev_note>)
			if (<prev_time> < ($check_time_late * 1000.0))
				<prev_time> = 1000000.0
			endif
			if (<next_time> < <prev_time>)
				<next_time> = (0 - <next_time>)
				output_log_text "ME: %n (%t)" n = <next_time> t = <next_note> color = red
			else
				output_log_text "ML: %n (%t)" n = <prev_time> t = <prev_note> color = darkred
			endif
		endif
	endif
	if ($fc_hud_moved = 0)
		Change dont_create_fc_hud = 1
	endif
	Change fc_hud_go_away = 1
	dx_fc_hud_watchdog
	GetGlobalTags \{user_options}
	if (<insta_fail> = 1)
		GuitarEvent_SongFailed
	endif
	if ($fc_glowburst_anim_started = 1)
		Change fc_glowburst_anim_started = 2
	endif
endscript