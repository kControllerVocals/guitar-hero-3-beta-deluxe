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