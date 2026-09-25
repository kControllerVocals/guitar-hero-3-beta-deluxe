num_players_info = [
	{
		name = "2 Players"
		checksum = num_2
		num = 2
	}
]
num_private_slots = [
	{
		name = "0 Players"
		checksum = num_0
		num = 0
	}
	{
		name = "1 Players"
		checksum = num_1
		num = 1
	}
	{
		name = "2 Players"
		checksum = num_2
		num = 2
	}
]
FilterTypes = {
	diff = {
		values = [
			"ANY"
			"EASY"
			"MEDIUM"
			"HARD"
			"EXPERT"
		]
		checksum = [
			dont_care
			easy
			medium
			hard
			expert
		]
	}
	mode = {
		values = [
			"ANY"
			"FACE-OFF"
			"PRO FACE-OFF"
			"BATTLE"
			"CO-OP"
		]
		checksum = [
			dont_care
			p2_faceoff
			p2_pro_faceoff
			p2_battle
			p2_coop
		]
	}
	type = {
		values = [
			"PLAYER"
			"RANKED"
		]
		checksum = [
			player
			ranked
		]
	}
	num_songs = {
		values = [
			"ANY"
			"1"
			"3"
			"5"
			"7"
		]
		checksum = [
			dont_care
			num_1
			num_3
			num_5
			num_7
		]
	}
	tie = {
		values = [
			"ANY"
			"HOST"
			"CLIENT"
			"RANDOM"
		]
		checksum = [
			dont_care
			HOST
			CLIENT
			song_rand
		]
	}
	search = {
		values = [
			"My Score"
			"Top Players"
			"Friendslist"
		]
	}
	time = {
		values = [
			"All Time"
			"Last Week"
			"Last Monthly"
		]
	}
	vport = {
		values = [
			"DOUBLE"
			"SINGLE"
		]
	}
}
online_light_purple = [
	190
	180
	205
	250
]
online_dark_purple = [
	70
	40
	70
	250
]
online_light_blue = [
	180
	230
	250
	250
]
online_medium_blue = [
	35
	130
	175
	250
]
online_dark_blue = [
	0
	70
	100
	250
]
online_score_bars = [
	60
	50
	70
	128
]
online_trans_grey = [
	0
	0
	0
	200
]
online_grey = [
	75
	75
	75
	250
]
online_general_menu_pos = (640.0, 75.0)
online_general_menu_hi_lite_ypos = [
	0.0
	0.0
	0.0
	0.0
]
player1_song_selections = [
	null
	null
	null
]
player2_song_selections = [
	null
	null
	null
]
tie_breaker_song = bullsonparade
match_type = player
opponent_gamertag = null
0xdc0eb917 = [
	0
	0
]
online_song_count = 0
player2_present = 0
player1_max_song_selections = 0
player1_current_song_selections = 0
player2_max_song_selections = 0
player2_current_song_selections = 0
retrieved_message_of_the_day = 0
message_of_the_day = ""
OptionsGameModeValue = 0
OptionsDifficultyValue = 0
OptionsNumSongsValue = 0
OptionsTieBreakerValue = 0
OptionsHighwayValue = 0
LeaderboardSearchValue = 0
0x3ecb95c2 = 0
LeaderboardDiffValue = 0
CopyOfGlobal = 0
SearchMatchTypeValue = 0
SearchGameModeValue = 0
SearchDifficultyValue = 0
SearchNumSongsValue = 0
SearchTieBreakerValue = 0
TempGameModeValue = 0
TempDifficultyValue = 0
TempNumSongsValue = 0
TempTieBreakerValue = 0
TempHighwayValue = 0
net_game_type_info = [
	{
		name = "PRO FACEOFF"
		description = "Play a song with the same notes."
		checksum = p2_pro_faceoff
	}
	{
		name = "FACEOFF"
		description = "Dueling sections on lead guitar."
		checksum = p2_faceoff
	}
	{
		name = "BATTLE"
		description = "Battle mode."
		checksum = p2_battle
	}
	{
		name = "CO-OP"
		description = "Mix lead guitar with bass/rhythm guitar."
		checksum = p2_coop
	}
]
xenon_invite_confirm_title = "GAME INVITE"
xenon_invite_confirm_dialog = "Accepting this invite will lose progress in any currently active goals. Do you want to continue?"
xenon_invite_confirm_yes = "YES"
xenon_invite_confirm_no = "NO"
xenon_session_confirm_title = "JOIN SESSION"
xenon_session_confirm_dialog = "Joining this session will lose progress in any currently active goals. Do you want to continue?"
xenon_session_confirm_yes = "YES"
xenon_session_confirm_no = "NO"
NO_NET_MODE = 0
LAN_MODE = 1
INTERNET_MODE = 2
new_net_logic = 0

script quit_network_game 
	printf "------ quitting network game"
	NetSessionFunc obj = session func = unpost_game
	if ($match_type = ranked)
		NetSessionFunc obj = session func = unpost_game
	endif
	LeaveServer
	change net_ready_to_start = 0
	change current_num_players = 1
	change player2_present = 0
	change structurename = player2_status is_local_client = 1
	change opponent_gamertag = null
	change 0xdc0eb917 = [0 0]
	change structurename = player1_status part = guitar
	change structurename = player2_status part = guitar
endscript

script shut_down_net_play 
	change \{is_network_game = 0}
	change \{new_net_logic = 0}
	SetNetworkMode
	NetSessionFunc \{obj = match
		func = stop_server_list}
	NetSessionFunc \{obj = match
		func = free_server_list}
	NetSessionFunc \{func = match_uninit}
	NetSessionFunc \{func = voice_uninit}
	NetSessionFunc \{func = stats_uninit}
	destroy_gamertags
	cleanup_sessionfuncs
endscript

script select_quit_network_game 
	SendNetMessage {
		type = fail_song
		stars = ($player1_status.stars)
		note_streak = ($player1_status.best_run)
		notes_hit = ($player1_status.notes_hit)
		total_notes = ($player1_status.total_notes)
		quit_early_flag = 1
	}
	quit_network_game_early
endscript

script quit_network_game_early 
	change \{disable_attacks = 1}
	PauseGame
	if GotParam \{signin_change}
		shut_down_net_play
	else
		kill_gem_scroller
	endif
	quit_network_game
endscript

script cancel_join_server 
	printf \{"---cancel_join_server"}
	NetSessionFunc \{obj = session
		func = unpost_game}
	NetSessionFunc \{obj = match
		func = free_server_list}
	NetSessionFunc \{obj = match
		func = cancel_join_server}
	SetNetworkMode
endscript

script post_network_game 
	NetSessionFunc \{obj = match
		func = get_gamertag}
	SetNetworkPreference field = 'network_id' string = <name>
	SetNetworkPreference field = 'server_name' string = <name>
	NetSessionFunc \{obj = session
		func = post_game}
	SetServerMode
	StartServer
	SetJoinMode \{$JOIN_MODE_PLAY}
	JoinServer
endscript

script set_match_values 
	return {
		difficulty = ($current_difficulty)
		gamemode = ($game_mode)
		num_songs = ($num_songs)
	}
endscript

script set_network_preferences 
	if (($match_type) = player)
		printf "set_network_preferences - setting 'player' match"
		SetNetworkPreference field = 'ranked' string = "player" checksum = player num = 1
	else
		printf "set_network_preferences - setting 'ranked' match"
		SetNetworkPreference field = 'ranked' string = "ranked" checksum = ranked num = 0
	endif
endscript

script send_game_info_to_client 
	if (($tie_breaker = song_rand) || ($match_type = ranked))
		get_random_song
		change tie_breaker_song = <random_song>
	else
		random_song = bullsonparade
	endif
	prepare_lobby_message
	SendNetMessage {
		type = lobby_setup
		game_mode_index = <game_mode_index>
		venue = ($current_level)
		difficulty_index = <difficulty_index>
		number_of_songs_index = <number_of_songs_index>
		tie_breaker_index = <tie_breaker_index>
		random_song = <random_song>
		character = ($player1_status.character_id)
		outfit = ($player1_status.outfit)
		style = ($player1_status.style)
		guitar = ($player1_status.instrument_id)
		flow_state_index = <flow_state>
	}
	change structurename = player2_status character_id = axel
	change structurename = player2_status outfit = 1
	change structurename = player2_status style = 1
	change structurename = player2_status instrument_id = Instrument_Les_Paul_Black
	change player2_present = 1
	if ScreenElementExists id = character_hub_p1_continue
		character_hub_p1_continue :SetProps rgba = [180 100 60 255] unblock_events
	endif
	start_flow_manager flow_state = online_character_select_fs player = 2 create_params = {player = 2}
endscript

script client_lobby_setup 
	printf "--- client_lobby_setup"
	0xcdb702b1
	change current_level = <venue>
	change player2_present = 1
	translate_lobby_message {
		game_mode_index = <game_mode_index>
		difficulty_index = <difficulty_index>
		number_of_songs_index = <number_of_songs_index>
		tie_breaker_index = <tie_breaker_index>
		p2_flow_state = <flow_state_index>
	}
	change structurename = player2_status character_id = <character>
	change structurename = player2_status outfit = <outfit>
	change structurename = player2_status style = <style>
	change structurename = player2_status instrument_id = <guitar>
	change structurename = player1_status character_id = axel
	change structurename = player1_status outfit = 1
	change structurename = player1_status style = 1
	change structurename = player1_status instrument_id = Instrument_Les_Paul_Black
	if (($tie_breaker) = song_rand)
		change tie_breaker_song = <random_song>
	endif
	ui_flow_manager_respond_to_action action = join_server
	resolve_current_flow_state p2_current_flow_state = <p2_flow_state>
endscript

script 0x721ffdff 
	start_flow_manager \{flow_state = online_character_select_fs
		player = 2
		create_params = {
			player = 2
		}}
endscript

script prepare_lobby_message 
	switch ($game_mode)
		case p2_faceoff
		<game_mode_index> = 1
		case p2_pro_faceoff
		<game_mode_index> = 2
		case p2_battle
		<game_mode_index> = 3
		case p2_coop
		<game_mode_index> = 4
	endswitch
	switch ($current_difficulty)
		case easy
		<difficulty_index> = 1
		case medium
		<difficulty_index> = 2
		case hard
		<difficulty_index> = 3
		case expert
		<difficulty_index> = 4
	endswitch
	switch ($num_songs)
		case num_1
		<number_of_songs_index> = 1
		case num_3
		<number_of_songs_index> = 3
		case num_5
		<number_of_songs_index> = 5
		case num_7
		<number_of_songs_index> = 7
	endswitch
	switch ($tie_breaker)
		case HOST
		<tie_breaker_index> = 1
		case CLIENT
		<tie_breaker_index> = 2
		case song_rand
		<tie_breaker_index> = 3
	endswitch
	switch ($ui_flow_manager_state [0])
		case online_character_select_fs
		<flow_state> = 1
		case online_character_hub_fs
		<flow_state> = 2
		case online_select_outfit_fs
		<flow_state> = 3
		case online_select_style_fs
		<flow_state> = 4
		case online_select_guitar_fs
		<flow_state> = 5
		case online_select_guitar_finish_fs
		<flow_state> = 6
	endswitch
	return {
		game_mode_index = <game_mode_index>
		difficulty_index = <difficulty_index>
		number_of_songs_index = <number_of_songs_index>
		tie_breaker_index = <tie_breaker_index>
		flow_state = <flow_state>
	}
endscript

script translate_lobby_message 
	switch (<game_mode_index>)
		case 1
		change game_mode = p2_faceoff
		case 2
		change game_mode = p2_pro_faceoff
		case 3
		change game_mode = p2_battle
		case 4
		change game_mode = p2_coop
	endswitch
	switch (<difficulty_index>)
		case 1
		change current_difficulty = easy
		change current_difficulty2 = easy
		case 2
		change current_difficulty = medium
		change current_difficulty2 = medium
		case 3
		change current_difficulty = hard
		change current_difficulty2 = hard
		case 4
		change current_difficulty = expert
		change current_difficulty2 = expert
	endswitch
	switch (<number_of_songs_index>)
		case 1
		change num_songs = num_1
		case 3
		change num_songs = num_3
		case 5
		change num_songs = num_5
		case 7
		change num_songs = num_7
	endswitch
	switch (<tie_breaker_index>)
		case 1
		change tie_breaker = HOST
		case 2
		change tie_breaker = CLIENT
		case 3
		change tie_breaker = song_rand
	endswitch
	switch (<p2_flow_state>)
		case 1
		<p2_flow_state> = online_character_select_fs
		case 2
		<p2_flow_state> = online_character_hub_fs
		case 3
		<p2_flow_state> = online_select_outfit_fs
		case 4
		<p2_flow_state> = online_select_style_fs
		case 5
		<p2_flow_state> = online_select_guitar_fs
		case 6
		<p2_flow_state> = online_select_guitar_finish_fs
	endswitch
	return p2_flow_state = <p2_flow_state>
endscript

script resolve_current_flow_state 
	if (<p2_current_flow_state> = online_character_select_fs)
		start_flow_manager \{flow_state = online_character_select_fs
			player = 2
			create_params = {
				player = 2
			}}
	else
		setup_character_hub \{player = 2}
		start_flow_manager flow_state = <p2_current_flow_state> player = 2 create_params = {player = 2}
	endif
endscript

script 0xcdb702b1 
	change \{current_num_players = 2}
	clear_setlists
endscript

script clear_setlists 
	array_count = 0
	GetArraySize \{$player1_song_selections}
	begin
	SetArrayElement ArrayName = player1_song_selections GlobalArray index = <array_count> newvalue = null
	SetArrayElement ArrayName = player2_song_selections GlobalArray index = <array_count> newvalue = null
	<array_count> = (<array_count> + 1)
	repeat <array_size>
	change \{tie_breaker_song = null}
endscript

script choose_selected_server 
	NetSessionFunc obj = match func = choose_server params = <...>
endscript

script cleanup_sessionfuncs 
	printf \{"---cleanup sessionfuncs"}
	NetSessionFunc \{func = match_uninit}
	NetSessionFunc \{func = stats_uninit}
	NetSessionFunc \{func = voice_uninit}
	NetSessionFunc \{func = motd_uninit}
endscript

script setup_sessionfuncs 
	printf "---setup_sessionfuncs"
	NetSessionFunc func = match_init
	NetSessionFunc func = stats_init
	NetSessionFunc func = voice_init
	NetSessionFunc func = motd_init
	NetSessionFunc obj = voice func = enable
	NetSessionFunc obj = match func = get_gamertag
	SetNetworkPreference field = 'network_id' string = <name>
	SetNetworkPreference field = 'server_name' string = <name>
endscript

script get_current_level_name 
	return level_name = ($LevelZones.($current_level).title) level = 1
endscript

script GetCurrentAreaStringAndChecksum 
	<area_string> = 'z_online_venue'
	<area_checksum> = dummy_value
endscript

script dispatch_player_state 
	if ($<player_status>.player = 1)
		<other_player_status> = player2_status
	else
		<other_player_status> = player1_status
	endif
	if ($<other_player_status>.highway_layout = solo_highway)
		begin
		FormatText checksumname = type '%s' s = 'player_state_light'
		SendNetMessage {
			type = <type>
			score = ($<player_status>.score)
			current_run = ($<player_status>.current_run)
			star_power_amount = ($<player_status>.star_power_amount)
			current_health = ($<player_status>.current_health)
		}
		Wait 0.1 seconds
		repeat
	else
		begin
		GetHeldPattern controller = ($<player_status>.controller) player_status = <player_status>
		FormatText checksumname = type '%s' s = 'player_state'
		SendNetMessage {
			type = <type>
			guitar_volume = ($<player_status>.guitar_volume)
			star_power_toggle = ($<player_status>.star_power_used)
			score = ($<player_status>.score)
			current_run = ($<player_status>.current_run)
			star_power_amount = ($<player_status>.star_power_amount)
			hold_pattern = <hold_pattern>
			whammy_length = ($<player_status>.net_whammy)
			current_health = ($<player_status>.current_health)
		}
		Wait 0.1 seconds
		repeat
	endif
endscript

script load_and_sync_timing start_delay = 4000
	if ($<player_status>.highway_layout = solo_highway)
		change current_num_players = 1
	else
		change current_num_players = 2
	endif
	set_rich_presence_game_mode online = 1
	change structurename = player2_status is_local_client = 0
	Load_Venue
	printf "Starting Song with Zone = %i\\n" i = $current_level
	change net_ready_to_start = 0
	SyncAndLaunchNetGame start_delay = <start_delay>
	change current_transition = intro
	SpawnScriptLater restart_gem_scroller params = {
		song_name = ($current_song)
		difficulty = ($current_difficulty)
		difficulty2 = ($current_difficulty2)
		StartTime = ($current_starttime)
		device_num = ($player1_status.controller)
	}
endscript

script launch_network_game 
	change \{net_ready_to_start = 1}
endscript

script network_player_update 
	if NOT ($ui_flow_manager_state [0] = online_play_song_fs)
		return
	endif
	change structurename = <player_status> score = <score>
	change structurename = <player_status> current_run = <current_run>
	change structurename = <player_status> current_health = <current_health>
	change structurename = <player_status> star_power_amount = <star_power_amount>
	if NOT ($player1_status.highway_layout = solo_highway)
		if NOT (($<player_status>.guitar_volume) = <volume>)
			change structurename = <player_status> guitar_volume = <volume>
			0x1c07e771
		endif
		BroadcastEvent type = net_button_check_p2 data = {hold_pattern = <hold_pattern> player_status = <player_status> whammy_len = <whammy_length>}
		if ($game_mode = p2_coop)
			return
		endif
		if NOT ($<player_status>.star_power_used = <star_power>)
			if (<star_power>)
				spawnscriptnow star_power_activate_and_drain params = {
					player_status = <player_status>
					player_text = ($<player_status>.text)
					player = ($<player_status>.player)}
			endif
		endif
	endif
endscript

script net_check_buttons 
	get_song_prefix song = <song_name>
	FormatText checksumname = guitar_stream '%s_guitar' s = <song_prefix> AddToStringLookup
	GuitarInputLogicInit player_status = <player_status> guitar_stream = <guitar_stream> time_offset = <time_offset>
	ExtendCRC button_up_pixel_array ($<player_status>.text) out = pixel_array
	<player_text> = ($<player_status>.text)
	GetArraySize $gem_colors
	begin
	array_count = 0
	begin
	color = ($gem_colors [<array_count>])
	pixels = ($<pixel_array> [<array_count>])
	button_lip_name = ($button_up_models.<color>.name)
	ExtendCRC <button_lip_name> '_lip' out = button_lip_name
	ExtendCRC <button_lip_name> <player_text> out = button_lip_name
	button_mid_name = ($button_up_models.<color>.name)
	ExtendCRC <button_mid_name> '_mid' out = button_mid_name
	ExtendCRC <button_mid_name> <player_text> out = button_mid_name
	button_neck_name = ($button_up_models.<color>.name)
	ExtendCRC <button_neck_name> '_neck' out = button_neck_name
	ExtendCRC <button_neck_name> <player_text> out = button_neck_name
	button_head_name = ($button_up_models.<color>.name)
	ExtendCRC <button_head_name> '_head' out = button_head_name
	ExtendCRC <button_head_name> <player_text> out = button_head_name
	now_scale = (($nowbar_scale_x * (1.0, 0.0)) + ($nowbar_scale_y * (0.0, 1.0)))
	if ($<player_status>.lefthanded_button_ups = 1)
		<pos2d> = ($button_up_models.<color>.left_pos_2d)
	else
		<pos2d> = ($button_up_models.<color>.pos_2d)
	endif
	if ($<player_status>.lefthanded_button_ups = 1)
		<playline_scale> = (((0 - <now_scale>.(1.0, 0.0)) * (1.0, 0.0)) + (<now_scale>.(0.0, 1.0) * (0.0, 1.0)))
	else
		<playline_scale> = <now_scale>
	endif
	<y_scale> = ((<pixels> + $neck_lip_add) / $neck_sprite_size)
	<neck_scale> = (((<playline_scale>.(1.0, 0.0)) * (1.0, 0.0)) + (<y_scale> * (0.0, 1.0)))
	<head_pos> = (<pos2d> - (<pixels> * (0.0, 1.0)))
	if ScreenElementExists id = <button_lip_name>
		SetScreenElementProps id = <button_lip_name> z_priority = 4.9
	endif
	if ScreenElementExists id = <button_mid_name>
		SetScreenElementProps id = <button_mid_name> z_priority = 4.6
	endif
	if ScreenElementExists id = <button_neck_name>
		SetScreenElementProps id = <button_neck_name> z_priority = 4.7 scale = <neck_scale>
	endif
	if ScreenElementExists id = <button_head_name>
		SetScreenElementProps id = <button_head_name> z_priority = 4.8 pos = <head_pos>
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	array_count = 0
	GetDeltaTime
	sub_amount = (($button_up_pixels * <delta_time>) / $button_sink_time)
	begin
	pixels = ($<pixel_array> [<array_count>])
	pixels = (<pixels> - <sub_amount>)
	if (<pixels> < 0.0)
		<pixels> = 0.0
	endif
	SetArrayElement ArrayName = <pixel_array> GlobalArray index = <array_count> newvalue = <pixels>
	array_count = (<array_count> + 1)
	repeat <array_size>
	Wait 1 gameframe
	repeat
endscript

script network_events 
	SetEventHandler \{response = call_script
		event = net_button_check_p2
		Scr = network_player_buttons}
	Block
endscript

script network_player_buttons 
	GetArraySize $gem_colors
	check_button = 65536
	<mask> = ($player2_status.broken_string_mask)
	array_count = 0
	begin
	if NOT (<mask> && <check_button>)
		color = ($gem_colors [<array_count>])
		button_head_name = ($button_up_models.<color>.name)
		ExtendCRC <button_head_name> '_head' out = button_head_name
		ExtendCRC <button_head_name> ($<player_status>.text) out = button_head_name
		if ScreenElementExists id = <button_head_name>
			if (<hold_pattern> && <check_button>)
				SetScreenElementProps id = <button_head_name> material = ($button_up_models.<color>.material_head_lit)
			else
				SetScreenElementProps id = <button_head_name> material = ($button_up_models.<color>.material_head)
			endif
		endif
	endif
	<check_button> = (<check_button> / 16)
	array_count = (<array_count> + 1)
	repeat <array_size>
	if ($display_debug_input = 1)
		input_debug <...>
	endif
endscript

script net_check_note_hold 
	GetArraySize $gem_colors
	begin
	<gem_count> = 0
	<exists> = 1
	begin
	if ((<pattern> && $button_values [<gem_count>]) = $button_values [<gem_count>])
		FormatText checksumname = whammy_id '%c_%i_gem_p%p' c = ($gem_colors_text [<gem_count>]) i = <array_entry> p = ($<player_status>.player) AddToStringLookup = true
		if NOT ScreenElementExists id = <whammy_id>
			<exists> = 0
			break
		endif
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
	if (<exists> = 0)
		break
	endif
	Wait 1 gameframe
	repeat
	ExtendCRC whammy_on <player_text> out = id
	BroadcastEvent type = <id> data = {pattern = <pattern> time = <time> guitar_stream = <guitar_stream> song = <song> array_entry = <array_entry> player = <player> player_status = <player_status> player_text = <player_text>}
	gem_count = 0
	begin
	if ((<pattern> && $button_values [<gem_count>]) = $button_values [<gem_count>])
		FormatText checksumname = whammy_id '%c_%i_whammybar_p%p' c = ($gem_colors_text [<gem_count>]) i = <array_entry> p = ($<player_status>.player) AddToStringLookup = true
		bar_name = (<whammy_id> + 1)
		if ScreenElementExists id = <bar_name>
			<bar_name> :SetTags holding = 1
		endif
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
	net_control_whammy_pitch_loop <...>
	reset_whammy_pitchshift player = <player>
	GetArraySize $gem_colors
	gem_count = 0
	begin
	if ((<pattern> && $button_values [<gem_count>]) = $button_values [<gem_count>])
		FormatText checksumname = whammy_id '%c_%i_3d_whammy_p%p' c = ($gem_colors_text [<gem_count>]) i = <array_entry> p = ($<player_status>.player) AddToStringLookup
		if CompositeObjectExists name = <whammy_id>
			<whammy_id> :Die
		endif
	endif
	gem_count = (<gem_count> + 1)
	repeat <array_size>
endscript

script net_control_whammy_pitch_loop 
	begin
	GetSongTime
	start_time = <songtime>
	Block type = net_button_check_p2
	GetSongTime
	delta_time = (<songtime> - <start_time>)
	hold_pattern = (<event_data>.hold_pattern)
	if single_note pattern = <pattern>
		strip_single_note_strum required_pattern = <pattern> pattern = <hold_pattern>
		<hold_pattern> = <stripped_strum>
	endif
	<0x71d1210f> = 1
	if NOT (<hold_pattern> = <pattern>)
		<0x71d1210f> = 0
	endif
	if ((<player_status>.guitar_volume) = 0)
		<0x71d1210f> = 0
	endif
	if (<0x71d1210f> = 0)
		change structurename = <player_status> guitar_volume = 0
		0x1c07e771
		ExtendCRC whammy_off <player_text> out = id
		BroadcastEvent type = <id> data = {pattern = <pattern> time = <time> guitar_stream = <guitar_stream> song = <song> array_entry = <array_entry> player = <player> player_status = <player_status> player_text = <player_text> finished = 0}
		break
	endif
	control_whammy_pitchshift song = <song> array_entry = <array_entry> pattern = <pattern> player_status = <player_status> net_whammy_length = (<event_data>.whammy_len) time = <time>
	<time> = (<time> - (<delta_time> * 1000))
	if (<time> <= 0)
		ExtendCRC whammy_off <player_text> out = id
		BroadcastEvent type = <id> data = {pattern = <pattern> time = <time> guitar_stream = <guitar_stream> song = <song> array_entry = <array_entry> player = <player> player_status = <player_status> player_text = <player_text> finished = 1}
		break
	endif
	repeat
endscript

script set_net_client_highway 
	change structurename = <player_status> highway_layout = <layout>
endscript

script finalize_connection_to_peer 
	change opponent_gamertag = <opponent_gamertag>
	SetArrayElement GlobalArray ArrayName = 0xdc0eb917 index = 0 newvalue = <0xccd09de2>
	SetArrayElement GlobalArray ArrayName = 0xdc0eb917 index = 1 newvalue = <0xbbd7ad74>
	if IsHost
		send_game_info_to_client
	endif
	FormatText \{checksumname = player_status
		'player1_status'}
	SendNetMessage {
		type = highway_update
		highway_layout = ($<player_status>.highway_layout)
	}
endscript

script 0x8d0356a4 
	switch (<difficulty>)
		case easy
		printf "writing easy achievement"
		WriteAchievements achievement = 0x3bfd8d54
		case medium
		printf "writing medium achievement"
		WriteAchievements achievement = 0xd2efb5fb
		case hard
		printf "writing hard achievement"
		WriteAchievements achievement = 0xb38a0811
		case expert
		printf "writing expert achievement"
		WriteAchievements achievement = 0x6dc6f268
	endswitch
endscript

script net_battle_trigger 
	if ($disable_attacks)
		printf "---ignoring attack, I've already lost"
		return
	endif
	printf "Triggering battle mode: %s" s = ($battlemode_powerups [<select>].Scr)
	<other_player> = 1
	<other_player_text> = 'p1'
	<other_difficulty> = $current_difficulty
	<other_player_status> = player1_status
	FormatText checksumname = card_checksum 'battlecard_%i_%s' i = ($<player_status>.current_num_powerups - 1) s = ($<player_status>.player)
	if ScreenElementExists id = <card_checksum>
		DestroyScreenElement id = <card_checksum>
	endif
	change structurename = <player_status> current_num_powerups = ($<player_status>.current_num_powerups - 1)
	drain_time = ($battlemode_powerups [<select>].drain_time)
	spawnscriptnow ($battlemode_powerups [<select>].Scr) id = battlemode params = {drain_time = <drain_time>
		player = <other_player>
		player_text = <other_player_text>
		other_player_status = <other_player_status>
		player_status = <player_status>
		difficulty = <other_difficulty>
		($battlemode_powerups [<select>].params)}
endscript

script 0xe017c3b1 
	printf "Broadcasting p2 broken string: %i" i = <string>
	BroadcastEvent type = 0xdff720de data = {string = <string>}
endscript

script broadcast_whammy_attack_update 
	change structurename = <other_player_status> whammy_attack = <whammy_attack>
	BroadcastEvent \{type = whammy_attack_update}
endscript

script 0x239941f9 
	check_button = 65536
	GetArraySize $gem_colors
	array_count = 0
	begin
	broken_string_id = ($broken_strings [<array_count>])
	if (<check_button> && <flags>)
		if NOT ($<other_player_status>.<broken_string_id> = 0)
			switch (<array_count>)
				case 0
				change structurename = <other_player_status> broken_string_green = ($<other_player_status>.broken_string_green - 1)
				mask = 4369
				case 1
				change structurename = <other_player_status> broken_string_red = ($<other_player_status>.broken_string_red - 1)
				mask = 65809
				case 2
				change structurename = <other_player_status> broken_string_yellow = ($<other_player_status>.broken_string_yellow - 1)
				mask = 69649
				case 3
				change structurename = <other_player_status> broken_string_blue = ($<other_player_status>.broken_string_blue - 1)
				mask = 69889
				case 4
				change structurename = <other_player_status> broken_string_orange = ($<other_player_status>.broken_string_orange - 1)
				mask = 69904
			endswitch
			if ($<other_player_status>.<broken_string_id> = 0)
				if ($<other_player_status>.whammy_attack < 1)
					change structurename = <other_player_status> broken_string_mask = ($<other_player_status>.broken_string_mask && <mask>)
				endif
			endif
		endif
	endif
	<check_button> = (<check_button> / 16)
	array_count = (<array_count> + 1)
	repeat <array_size>
	total_broken_strings = ($<other_player_status>.broken_string_green +
		$<other_player_status>.broken_string_red +
		$<other_player_status>.broken_string_yellow +
		$<other_player_status>.broken_string_blue +
		$<other_player_status>.broken_string_orange)
	if (<total_broken_strings> = 0)
		change structurename = <other_player_status> broken_string_mask = 0
		ExtendCRC broken_string_text ($<other_player_status>.text) out = id
		doScreenElementMorph id = <id> alpha = 0 time = 1
	endif
endscript

script net_whammy_attack 
	shake_frequency = 1
	begin
	if (($<other_player_status>.whammy_attack) <= 5)
		<shake_frequency> = (6 - ($<other_player_status>.whammy_attack))
	endif
	Block \{type = whammy_attack_update}
	if (($<other_player_status>.whammy_attack) = 0)
		break
	endif
	repeat
endscript

script net_whammy_shake 
	shake_on = 0
	frame_count = 0
	begin
	if (<frame_count> = <shake_frequency>)
		if (<shake_on> = 0)
			<markers_name> :Obj_GetPosition
			<markers_name> :Obj_SetPosition position = (<pos> + (0.0, 0.05, 0.0))
			<shake_on> = 1
		else
			<markers_name> :Obj_GetPosition
			<markers_name> :Obj_SetPosition position = (<pos> + (0.0, -0.05, 0.0))
			<shake_on> = 0
		endif
		<frame_count> = 0
	else
		<frame_count> = (<frame_count> + 1)
	endif
	Wait 1 gameframe
	repeat
endscript

script net_copy_intial_params 
	change globalname = <copy_to> newvalue = $<copy_from>
endscript

script net_commit_or_reset_params 
	if GotParam \{commit}
		change globalname = <copy_to> newvalue = $<copy_from>
	else
		if (<type> = loc)
			<text> :SetProps text = ($LevelZones.($LevelZoneArray [$<global>]).title)
		else
			<text> :SetProps text = ($FilterTypes.<type>.values [$<global>])
		endif
	endif
endscript

script net_custom_up_down direction = up
	if (<type> = loc)
		GetArraySize ($LevelZoneArray)
	else
		GetArraySize ($FilterTypes.<type>.values)
	endif
	if (<direction> = up)
		if ((<array_size> -1) = $<global>)
			change globalname = <global> newvalue = 0
		else
			change globalname = <global> newvalue = ($<global> + 1)
		endif
	else
		if (0 = $<global>)
			change globalname = <global> newvalue = (<array_size> -1)
		else
			change globalname = <global> newvalue = (<global> - 1)
		endif
	endif
	if (<type> = loc)
		<text> :SetProps text = ($LevelZones.($LevelZoneArray [$<global>]).title)
	else
		<text> :SetProps text = ($FilterTypes.<type>.values [$<global>])
	endif
endscript

script block_unblock_difficulty_actions diff_focus = off menu = search
	if GotParam diff_focus
		<change_color> = ($online_light_blue)
	else
		<change_color> = ($online_dark_purple)
	endif
	if (<menu> = search)
		<gamemode> = ($SearchGameModeValue)
		<new_text> = ($FilterTypes.diff.values [($SearchDifficultyValue)])
	else
		<gamemode> = ($OptionsGameModeValue)
		<new_text> = ($FilterTypes.diff.values [($OptionsDifficultyValue)])
	endif
	if ((<gamemode> = 0) || (<gamemode> = 2))
		if ScreenElementExists id = difficulty
			difficulty :SetProps rgba = <change_color> unblock_events
		endif
		if ScreenElementExists id = difficulty_selection_text
			difficulty_selection_text :SetProps rgba = <change_color> text = <new_text> unblock_events
		endif
	else
		if ScreenElementExists id = difficulty
			difficulty :SetProps rgba = ($online_grey) block_events
		endif
		if ScreenElementExists id = difficulty_selection_text
			difficulty_selection_text :SetProps rgba = ($online_grey) text = "N/A" block_events
		endif
	endif
endscript

script online_menu_init 
	printf \{"--- online_menu_init"}
	change player1_device = ($primary_controller)
	change \{is_network_game = 1}
	change \{current_num_players = 1}
	change \{player2_present = 0}
	change \{structurename = player1_status
		part = guitar}
	change \{structurename = player2_status
		part = guitar}
	SetNetworkMode \{$INTERNET_MODE}
	cleanup_sessionfuncs
	setup_sessionfuncs
	NetSessionFunc \{func = getnumplayers}
endscript

script get_random_song 
	first_song_index = (-1)
	last_song_index = (-1)
	array_entry = 0
	GetArraySize $gh3_songlist
	begin
	song_checksum = ($gh3_songlist [<array_entry>])
	get_song_struct song = <song_checksum>
	if ((<song_struct>.version) = gh3)
		if (<first_song_index> = (-1))
			<first_song_index> = <array_entry>
		endif
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_size>
	<last_song_index> = (<array_entry> - 1)
	GetRandomValue name = random_value Integer a = <first_song_index> b = <last_song_index>
	return random_song = ($gh3_songlist [<random_value>])
endscript

script start_network_game 
	if IsHost
		startnetworkgame
	endif
endscript

script check_for_final_song_selection 
	if (($tie_breaker) = song_rand)
		return \{can_select_final_song = false}
	elseif (($tie_breaker) = HOST)
		if IsHost
			return \{can_select_final_song = true}
		else
			return \{can_select_final_song = false}
		endif
	elseif (($tie_breaker) = CLIENT)
		if IsHost
			return \{can_select_final_song = false}
		else
			return \{can_select_final_song = true}
		endif
	endif
endscript

script online_fail_song 
	printf \{"---online fail song"}
	PauseGame
	change \{disable_attacks = 1}
	SendNetMessage {
		type = fail_song
		stars = ($player1_status.stars)
		note_streak = ($player1_status.best_run)
		notes_hit = ($player1_status.notes_hit)
		total_notes = ($player1_status.total_notes)
		quit_early_flag = 0
	}
	Block \{type = 0xe88bd35b}
	change \{current_num_players = 2}
endscript

script online_win_song 
	printf "---online_win_song"
	if (<quit_early>)
		0xcffbc469
		ExtendCRC hud_destroygroup_window 'p1' out = hud_destroygroup
		FormatText TextName = notification_text "%n has quit" n = <name>
		CreateScreenElement {
			type = TextElement
			parent = <hud_destroygroup>
			font = text_a1
			just = [center top]
			scale = 1.5
			rgba = [255 0 0 250]
			z_priority = 200.0
			pos = (650.0, 420.0)
			text = <notification_text>
		}
	endif
	change structurename = <player_status> stars = <stars>
	change structurename = <player_status> best_run = <note_streak>
	change structurename = <player_status> total_notes = <total_notes>
	change structurename = <player_status> notes_hit = <notes_hit>
	player_text = (<player_status>.text)
	change current_num_players = 2
	Wait 1 second
	ExtendCRC song_won <player_text> out = type
	BroadcastEvent type = <type>
endscript

script broadcast_received_winner_stats 
	unpausespawnedscript \{online_fail_song}
	change structurename = <player_status> stars = <stars>
	change structurename = <player_status> best_run = <note_streak>
	change structurename = <player_status> total_notes = <total_notes>
	change structurename = <player_status> notes_hit = <notes_hit>
	BroadcastEvent \{type = 0xe88bd35b}
endscript

script set_rich_presence_searching 
	change \{rich_presence_context = presence_online_searching}
endscript

script set_rich_presence_game_mode online = 0
	if (<online>)
		change rich_presence_context = presence_online_game_mode
	else
		switch ($game_mode)
			case p1_career
			change rich_presence_context = presence_career
			case p1_quickplay
			change rich_presence_context = presence_quick_play
			case p2_career
			change rich_presence_context = presence_coop_career
			case p2_pro_faceoff
			change rich_presence_context = presence_2player
			case p2_faceoff
			change rich_presence_context = presence_2player
			case p2_battle
			change rich_presence_context = presence_battle
			case training
			change rich_presence_context = presence_practice
		endswitch
	endif
endscript

script get_custom_match_search_params 
	GetPreferenceChecksum ranked
	ranked = <checksum>
	GetPreferenceValue ranked
	ranked_value = <value>
	if (($SearchGameModeValue = 0) || ($SearchGameModeValue = 2))
		game_mode_checksum = ($FilterTypes.mode.checksum [($SearchGameModeValue)])
	else
		game_mode_checksum = dont_care
	endif
	return {
		difficulty = ($FilterTypes.diff.checksum [($SearchDifficultyValue)])
		gamemode = <game_mode_checksum>
		num_songs = ($FilterTypes.num_songs.checksum [($SearchNumSongsValue)])
		tie_breaker = dont_care
		ranked = <ranked>
		ranked_value = <ranked_value>
	}
endscript

script get_quick_match_search_params 
	GetGlobalTags user_options
	GetPreferenceChecksum ranked
	ranked = <checksum>
	GetPreferenceValue ranked
	ranked_value = <value>
	if ((<online_game_mode> = 0) || (<online_game_mode> = 2))
		game_mode_checksum = ($FilterTypes.mode.checksum [($SearchGameModeValue)])
	else
		game_mode_checksum = dont_care
	endif
	return {
		difficulty = ($FilterTypes.diff.checksum [<online_difficulty>])
		gamemode = <game_mode_checksum>
		num_songs = ($FilterTypes.num_songs.checksum [<online_num_songs>])
		tie_breaker = dont_care
		ranked = <ranked>
		ranked_value = <ranked_value>
	}
endscript
bPS3SingleSignOnCheckComplete = 0

script xenon_singleplayer_session_init {ps3_signin_callback = xenon_singleplayer_session_init}
	if CheckForSignIn
		NetSessionFunc func = stats_uninit
		NetSessionFunc func = stats_init
		if isXenon
			NetSessionFunc func = start_singleplayer_session obj = session
			MassiveInit sku = 'ATVI_Guitar_Hero_3_x360_na' startzone = 'GlobalZone'
		endif
	else
		if NOT isXenon
			if NOT GotParam from_callback
				if (0 = $bPS3SingleSignOnCheckComplete)
					NetSessionFunc func = onlinesignin params = {callback = <ps3_signin_callback>}
					change bPS3SingleSignOnCheckComplete = 1
				endif
			else
				printf "PS3: unable to signin in to the network platform"
			endif
		endif
	endif
endscript

script begin_singleplayer_game 
	if NetSessionFunc \{obj = session
			func = has_active_session}
		NetSessionFunc \{obj = session
			func = begin_singleplayer_game}
	endif
endscript

script xenon_singleplayer_session_begin_uninit 
	if isXenon
		NetSessionFunc \{func = stop_singleplayer_session
			obj = session}
	endif
endscript

script xenon_singleplayer_session_complete_uninit 
	NetSessionFunc \{func = stats_uninit}
	NetSessionFunc \{func = match_uninit}
endscript

script send_leader_board_message 
	NetSessionFunc {
		func = write_stats
		obj = stats
		params = {
			leaderboard_id = <leaderboard_id>
			score = <score>
		}
	}
endscript

script 0xd29e8974 {
		pos = (550.0, 350.0)
		rgba = [210 210 210 250]
	}
	if NOT ScreenElementExists id = gamertag_container
		CreateScreenElement {
			type = ContainerElement
			parent = root_window
			id = gamertag_container
			pos = <pos>
			just = [center top]
			not_focusable
		}
		NetSessionFunc obj = match func = get_gamertag
		CreateScreenElement {
			type = TextElement
			parent = gamertag_container
			font = text_a1
			scale = 0.75
			rgba = <rgba>
			text = <name>
			just = [center top]
			pos = (0.0, 0.0)
			z_priority = 100.0
		}
	endif
endscript

script network_player_lobby_message 
	switch <type>
		case character_select
		<selection_type> = 0
		case character_hub_select
		<selection_type> = 1
		case outfit_select
		<selection_type> = 2
		case style_select
		<selection_type> = 3
		case guitar_select
		<selection_type> = 4
		case skin_select
		<selection_type> = 5
		case song_select
		<selection_type> = 6
		case ready_up
		<selection_type> = 7
	endswitch
	switch <action>
		case update
		<selection_action> = 0
		case deselect
		<selection_action> = 1
		case select
		<selection_action> = 2
	endswitch
	if GotParam value1
		<selection_index1> = <value1>
	else
		<selection_index1> = 0
	endif
	if GotParam value2
		<selection_index2> = <value2>
	else
		<selection_index2> = 0
	endif
	if GotParam checksum
		<checksum_value> = <checksum>
	else
		<checksum_value> = null
	endif
	SendNetMessage {
		type = lobby_selection
		selection_type = <selection_type>
		selection_action = <selection_action>
		selection_index1 = <selection_index1>
		selection_index2 = <selection_index2>
		net_checksum = <checksum_value>
	}
endscript

script network_player_lobby_update 
	switch <selection_type>
		case 0
		switch <selection_action>
			case 0
			if (($player2_status.character_id) = <checksum_value>)
				if (<selection_index1> = 0)
					cs_scroll_up_or_down player = 2 dir = up
				else
					cs_scroll_up_or_down player = 2 dir = down
				endif
			else
				script_assert "we don't have the same guitarist"
			endif
			case 1
			cs_go_back player = 1
			case 2
			if (($player2_status.character_id) = <checksum_value>)
				character_select_choose player = 2
			else
				script_assert "we don't have the same guitarist"
			endif
		endswitch
		case 1
		switch <selection_action>
			case 1
			character_hub_go_back player = 2
			case 2
			if (<selection_index1> = 1)
				character_hub_select_change_outfit player = 2
				return
			endif
			if (<selection_index1> = 2)
				character_hub_select_change_guitar player = 2
				return
			endif
		endswitch
		case 2
		switch <selection_action>
			case 0
			0x720c8447 outfit = <selection_index1> player_status = player2_status player = 2
			case 1
			menu_flow_go_back player = 2
			case 2
			0x96e1c669 outfit = <selection_index1> player_status = player2_status 0x296a29c3 = 0x484c9e16 player = 2
		endswitch
		case 3
		switch <selection_action>
			case 0
			0xc8793904 style = <selection_index1> player_status = player2_status player = 2
			case 1
			menu_flow_go_back player = 2
			case 2
			0xdb682cbd style = <selection_index1> player_status = player2_status 0x296a29c3 = 0x484c9e16 player = 2
		endswitch
		case 4
		switch <selection_action>
			case 0
			gs_scroll_up_or_down player = 2 guitar_id = <checksum_value>
			case 1
			spawnscriptnow select_guitar_go_back params = {player = 2}
			case 2
			if (<checksum_value> = none)
				select_guitar_choose player = 2
			else
				select_guitar_choose player = 2 guitar_id = <checksum_value> player = 2
			endif
		endswitch
		case 5
		switch <selection_action>
			case 0
			printstruct <...>
			case 1
			select_guitar_go_back_from_finish_menu player = 2
			case 2
			select_guitar_finish_highlight player = 2 id = <checksum_value>
		endswitch
		case 6
		switch <selection_action>
			case 1
			online_song_deselect player = 2
			case 2
			online_song_select song = <checksum_value> player = 2
		endswitch
		case 7
		switch <selection_action>
			case 1
			if (<checksum_value> = final)
				online_song_deselect player = 2
				return
			endif
			character_hub_go_back player = 2
			case 2
			if (<checksum_value> = final)
				online_song_select player = 2
				return
			endif
			SpawnScriptLater character_hub_select_play_show params = {player = 2}
		endswitch
	endswitch
endscript

script net_pausegh3 
	BroadcastEvent \{type = event_pause_game}
	ui_flow_manager_respond_to_action \{action = pause_game}
	Wait \{1
		gameframe}
endscript

script net_unpausegh3 
	ui_flow_manager_respond_to_action \{action = select_resume}
endscript

script createjoinrefuseddialog 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [center center]
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = net_popup_container
		font = text_a1
		scale = 1.5
		rgba = [210 210 210 250]
		text = "CONNECTION LOST"
		pos = (640.0, 550.0)
		z_priority = 200.0
		just = [center center]
		not_focusable
	}
	Wait 3 seconds
	DestroyScreenElement id = net_popup_container
	if ($ui_flow_manager_state [0] = online_play_song_fs)
		connection_lost_end_song
	elseif ($ui_flow_manager_state [0] = online_pause_fs)
		ui_flow_manager_respond_to_action action = select_resume
		connection_lost_end_song
	else
		lobby_connection_lost
	endif
endscript

script create_connection_lost_dialog 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [center center]
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = net_popup_container
		font = text_a1
		scale = 1.5
		rgba = [210 210 210 250]
		text = "Lost Connection to Opponent"
		pos = (640.0, 550.0)
		z_priority = 200.0
		just = [center center]
		not_focusable
	}
	Wait 3 seconds
	DestroyScreenElement id = net_popup_container
	if ($ui_flow_manager_state [0] = online_play_song_fs)
		connection_lost_end_song
	elseif ($ui_flow_manager_state [0] = online_pause_fs)
		ui_flow_manager_respond_to_action action = select_resume
		connection_lost_end_song
	else
		lobby_connection_lost
	endif
endscript

script showjointimeoutnotice 
	cancel_join_server
	setup_sessionfuncs
	spawnscriptnow \{timeout_connection_attempt}
endscript

script timeout_connection_attempt 
	create_timeout_dialog
	ui_flow_manager_respond_to_action \{action = timeout}
	net_repeat_last_search
endscript

script failedtocreategame 
	cancel_join_server
	setup_sessionfuncs
	create_failed_connection_dialog
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script create_timeout_dialog 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [center center]
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = net_popup_container
		font = text_a1
		scale = 1.5
		rgba = [210 210 210 250]
		text = "TIMEOUT TO CONNECTION"
		pos = (640.0, 600.0)
		z_priority = 200.0
		just = [center center]
		not_focusable
	}
	Wait 3 seconds
	DestroyScreenElement id = net_popup_container
endscript

script create_failed_connection_dialog 
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = net_popup_container
		just = [center center]
		pos = (0.0, 0.0)
	}
	CreateScreenElement {
		type = TextElement
		parent = net_popup_container
		font = text_a1
		scale = 1.5
		rgba = [210 210 210 250]
		text = "SESSION CREATE FAILED"
		pos = (640.0, 600.0)
		z_priority = 200.0
		just = [center center]
		not_focusable
	}
	Wait 3 seconds
	DestroyScreenElement id = net_popup_container
endscript

script net_repeat_last_search 
	Wait \{1
		gameframe}
	ui_flow_manager_respond_to_action \{action = select_done}
endscript

script check_if_selecting_tie_breaker player = 1
	if IsHost
		if (($tie_breaker = HOST) && (<player> = 1))
			return selecting_tiebreaker = 1
		endif
		if (($tie_breaker = CLIENT) && (<player> = 2))
			return selecting_tiebreaker = 1
		endif
	else
		if (($tie_breaker = HOST) && (<player> = 2))
			return selecting_tiebreaker = 1
		endif
		if (($tie_breaker = CLIENT) && (<player> = 1))
			return selecting_tiebreaker = 1
		endif
	endif
	return selecting_tiebreaker = 0
endscript

script get_num_players_by_gamemode 
	if (($game_mode = p1_career) || ($game_mode = p1_quickplay))
		return \{num_players = 1}
	else
		return \{num_players = 2}
	endif
endscript

script connection_lost_end_song 
	change \{current_num_players = 2}
	ExtendCRC \{song_won
		'p1'
		out = type}
	BroadcastEvent type = <type>
endscript

script test_events \{passed_in_value = 'test value'}
	printf \{"test_events"}
	printstruct <...>
	NetSessionFunc \{obj = stats
		func = write_key_value
		params = {
			wtf_value = 'test value'
			key = 'test key'
		}}
endscript

script net_failed_signin 
	printf \{"--- net_failed_signin"}
	if ($respond_to_signin_changed = 0)
		return
	endif
	if (($ui_flow_manager_state [0]) = online_signin_fs)
		ui_flow_manager_respond_to_action \{action = go_back}
	endif
endscript

script xbox360_live_not_allowed 
	if isXenon
		net_failed_signin
	else
		CreateScreenElement {
			type = ContainerElement
			parent = root_window
			id = signin_container
			pos = (0.0, 0.0)
		}
		change menu_focus_color = [180 50 50 255]
		change menu_unfocus_color = [0 0 0 255]
		create_pause_menu_frame z = 5
		displaySprite parent = signin_container tex = Dialog_Title_BG scale = (1.7, 1.7) z = 9 pos = (640.0, 100.0) just = [right top] flip_v
		displaySprite parent = signin_container tex = Dialog_Title_BG scale = (1.7, 1.7) z = 9 pos = (640.0, 100.0) just = [left top]
		displaySprite parent = signin_container tex = dialog_frame_joiner pos = (480.0, 510.0) rot_angle = 5 scale = (1.575, 1.5) z = 10
		displaySprite parent = signin_container tex = dialog_frame_joiner pos = (750.0, 514.0) flip_v rot_angle = -5 scale = (1.575, 1.5) z = 10
		displaySprite id = hi_right parent = signin_container tex = Dialog_Highlight pos = <bookend_r_pos> scale = (1.0, 1.0) z = (11)
		displaySprite id = hi_left parent = signin_container tex = Dialog_Highlight flip_v pos = <bookend_l_pos> scale = (1.0, 1.0) z = (11)
		displaySprite parent = signin_container tex = dialog_bg pos = (480.0, 500.0) scale = (1.25, 1.0) z = 9 just = [left botom]
		displaySprite parent = signin_container tex = dialog_bg pos = (480.0, 530.0) scale = (1.25, 1.0) z = 9 just = [left top] flip_h
		CreateScreenElement {
			type = TextElement
			parent = signin_container
			font = fontgrid_title_gh3
			scale = 1.3
			rgba = [223 223 223 250]
			text = "WARNING"
			just = [center top]
			z_priority = 10.0
			pos = (640.0, 175.0)
			shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [0 0 0 255]
		}
		<sign_in_text> = "You must be signed in to enter the PlayStation Network lobby."
		CreateScreenElement {
			type = TextBlockElement
			parent = signin_container
			font = fontgrid_title_gh3
			scale = 0.6
			rgba = [210 210 210 250]
			text = <sign_in_text>
			just = [center top]
			internal_just = [center top]
			z_priority = 10.0
			pos = (640.0, 310.0)
			dims = (700.0, 320.0)
			line_spacing = 1.0
		}
		CreateScreenElement {
			type = TextElement
			parent = sign_in_vmenu
			font = fontgrid_title_gh3
			scale = 0.85
			rgba = ($menu_unfocus_color)
			text = "CONTINUE"
			just = [center top]
			z_priority = 10.0
			event_handlers = [
				{focus 0x16ea0ce8 params = {y_pos = 515}}
				{unfocus retail_menu_unfocus}
				{pad_choose ui_flow_manager_respond_to_action params = {action = go_back}}
			]
		}
		add_user_control_helper text = "SELECT" button = green z = 100
		add_user_control_helper text = "BACK" button = red z = 100
		LaunchEvent type = focus target = sign_in_vmenu
	endif
endscript

script xenon_auto_load_progress 
	printf \{"--- xenon_auto_load_progress"}
	if (($ui_flow_manager_state [0]) = online_signin_fs)
		ui_flow_manager_respond_to_action \{action = online_enabled}
	endif
endscript

script scale_element_to_size time = 0
	if NOT GotParam id
		printf 'Did not pass in id to scale_element_to_size! Returning'
		return
	endif
	GetScreenElementDims id = <id>
	orig_height = <Height>
	orig_width = <width>
	if NOT GotParam target_width
		target_width = <orig_width>
	endif
	if NOT GotParam target_height
		target_height = <orig_height>
	endif
	xScale = (<target_width> / (<orig_width> * 1.0))
	yScale = (<target_height> / (<orig_height> * 1.0))
	<id> :DoMorph scale = (<xScale> * (1.0, 0.0) + <yScale> * (0.0, 1.0)) time = <time>
	GetScreenElementDims id = <id>
endscript

script translate_screen_element \{time = 0}
	if NOT GotParam \{id}
		printf \{'Did not pass in id to translate_screen_element! Returning'}
		return
	endif
	if NOT GotParam \{pos}
		GetScreenElementPosition id = <id>
		new_position = <screenelementpos>
	else
		new_position = <pos>
	endif
	<id> :DoMorph pos = <new_position> time = <time>
endscript

script get_my_highway_layout 
	player = 1
	begin
	FormatText checksumname = player_status 'player%p_status' p = <player>
	if ($<player_status>.is_local_client)
		return my_highway = ($<player_status>.highway_layout)
	endif
	<player> = (<player> + 1)
	repeat 2
endscript

script agora_update 
	get_game_mode_name
	get_current_band_info
	GetGlobalTags <band_info>
	FormatText TextName = band_text '%s' s = <name>
	FormatText checksumname = band_id 'band_%s_%g' s = <band_text> g = <game_mode_name>
	FormatText TextName = band_name '%s' s = <name>
	if NOT GotParam new_band
		get_difficulty_text_nl difficulty = ($current_difficulty)
		if (<game_mode_name> = p2_career)
			coop_difficulty = <difficulty_text_nl>
			get_diff_completion_percentage for_p2_career = 1
		else
			career_difficulty = <difficulty_text_nl>
			get_diff_completion_percentage
		endif
		if ($game_mode = p2_career)
			coop_percent_complete_easy = (<diff_completion_percentage> [0])
			coop_percent_complete_medium = (<diff_completion_percentage> [1])
			coop_percent_complete_hard = (<diff_completion_percentage> [2])
			coop_percent_complete_expert = (<diff_completion_percentage> [3])
		else
			career_percent_complete_easy = (<diff_completion_percentage> [0])
			career_percent_complete_medium = (<diff_completion_percentage> [1])
			career_percent_complete_hard = (<diff_completion_percentage> [2])
			career_percent_complete_expert = (<diff_completion_percentage> [3])
		endif
	endif
	WriteUpdate <...>
endscript

script agora_write_stats 
	if ($game_mode = p1_quickplay)
		return
	endif
	player_id = 1000
	player_id2 = 1001
	get_num_players_by_gamemode
	GetGlobalTags user_options param = lefty_flip_p1
	GetGlobalTags user_options param = lefty_flip_p2
	if ($is_network_game)
		NetSessionFunc obj = match func = get_gamertag
		FormatText TextName = gamertag1 '%s' s = <name>
		FormatText TextName = gamertag2 '%s' s = ($opponent_gamertag)
		p1_name = <gamertag1>
		p2_name = <gamertag2>
	else
		if (($game_mode = p1_career) || ($game_mode = p2_career))
			menu_ebn_get_band_name_text
			StringRemoveTrailingWhitespace string = <band_name_text_string>
			FormatText TextName = band_text '%s' s = <band_name_text_string>
			<p1_name> = <band_text>
			<p2_name> = <band_text>
		else
		endif
	endif
	band_name = <p1_name>
	venue = (($LevelZones.$current_level).name)
	get_game_mode_name
	mode = <game_mode_name>
	get_song_prefix song = ($current_song)
	title = <song_prefix>
	get_difficulty_text_nl difficulty = ($current_difficulty)
	difficulty = <difficulty_text_nl>
	Speed = ($player1_status.highway_speed)
	CastToInteger Speed
	if ($player1_status.part = guitar)
		part = 'guitar'
	elseif ($player1_status.part = Bass)
		part = 'bass'
	else
		part = 'rhythm'
	endif
	score = ($player1_status.score)
	CastToInteger score
	stars = ($player1_status.stars)
	notes_hit = ($player1_status.notes_hit)
	best_streak = ($player1_status.best_run)
	0x0b9fac5a = ($player1_status.sp_phrases_hit)
	if (<lefty_flip_p1>)
		lefty = true
	else
		lefty = false
	endif
	get_character_name player = 1
	character_name = <character_name>
	get_character_outfit_name player = 1
	outfit = <outfit_name>
	character_color = ($player1_status.style)
	get_player_instrument_desc_name player = 1
	guitar = <instrument_name>
	skin = <instrument_name>
	if (<num_players> = 2)
		if ($player1_status.score > $player2_status.score)
			winner = <p1_name>
		else
			winner = <p2_name>
		endif
		0xb1fb3025 = ($player2_status.highway_speed)
		CastToInteger 0xb1fb3025
		if ($player2_status.part = guitar)
			part2 = 'guitar'
		elseif ($player2_status.part = Bass)
			part2 = 'bass'
		else
			part2 = 'rhythm'
		endif
		score2 = ($player2_status.score)
		CastToInteger score2
		stars2 = ($player2_status.stars)
		notes_hit2 = ($player2_status.notes_hit)
		best_streak2 = ($player2_status.best_run)
		star_power_received2 = ($player2_status.sp_phrases_hit)
		if (<lefty_flip_p2>)
			lefty2 = true
		else
			lefty2 = false
		endif
		get_character_name player = 2
		character_name2 = <character_name>
		get_character_outfit_name player = 2
		outfit2 = <outfit_name>
		character_color2 = ($player2_status.style)
		get_player_instrument_desc_name player = 2
		guitar2 = <instrument_name>
		skin2 = <instrument_name>
		WriteMultiPerformance <...>
	else
		winner = <p1_name>
		WritePerformance <...>
	endif
endscript

script WritePerformance {
		band_id = default_band_id
		venue = 'test venue'
		mode = 'test mode'
		submode = 'test submode'
		cheats = 'all cheats'
		title = 'killing me softly'
		difficulty = 'test'
		Speed = 'test'
		star_power_available = 0
		player_id = 0
		part = 'guitar'
		score = 1
		stars = 0
		notes_hit = 2
		best_streak = 5
		star_power_achieved = 1
		lefty = true
		character_name = 'test'
		character_color = 1
		guitar = 'test'
		skin = 'test'
		outfit = 'test'
	}
	NetSessionFunc obj = stats func = write_performance params = {<...>}
endscript

script WriteMultiPerformance {
		winner = 'participant_1'
		venue = 'test venue'
		mode = 'test mode'
		cheats = 'all cheats'
		title = 'killing me softly'
		difficulty = 'test'
		Speed = 'test'
		star_power_available = 0
		player_id = 0
		part = 'guitar'
		score = 1
		stars = 0
		notes_hit = 2
		best_streak = 5
		star_power_achieved = 0
		lefty = true
		character_name = 'test'
		character_color = 1
		guitar = 'test'
		skin = 'test'
		outfit = 'test'
		player_id2 = 1
		part2 = 'bass'
		score2 = 1
		stars2 = 0
		notes_hit2 = 2
		best_streak2 = 5
		star_power_achieved2 = 1
		lefty2 = true
		character_name2 = 'test'
		character_color2 = 'test'
		guitar2 = 'test'
		skin2 = 'test'
		outfit2 = 'test'
	}
	NetSessionFunc obj = stats func = write_multi_match params = {<...>}
endscript

script WriteUpdate {
		band_id = 0
		band_name = 'test name'
		Cash = 100
		purchases = 'test purchases'
		career_percent_complete_easy = 50
		career_score_overall_easy = 0
		career_percent_complete_medium = 50
		career_score_overall_medium = 0
		career_percent_complete_hard = 50
		career_score_overall_hard = 0
		career_percent_complete_expert = 50
		career_score_overall_expert = 0
		coop_percent_complete_easy = 50
		coop_score_overall_easy = 0
		coop_percent_complete_medium = 50
		coop_score_overall_medium = 0
		coop_percent_complete_hard = 50
		coop_score_overall_hard = 0
		coop_percent_complete_expert = 50
		coop_score_overall_expert = 0
		campaign_score_easy = 0
		campaign_score_medium = 0
		campaign_score_hard = 0
		campaign_score_expert = 0
		campaign_score_overall = 0
		achievements = 'temp achievement string'
	}
	NetSessionFunc obj = stats func = write_update params = {<...>}
endscript

script invite_accepted 
	do_join_invite_stuff <...> accepted_invite
endscript

script do_join_invite_stuff 
	printf "--- do_join_invite_stuff"
	if GotParam accepted_invite
		printf "accepted invite"
		begin
		if ($is_shutdown_safe = 1)
			break
		endif
		Wait 1 gameframe
		repeat
		printf "do_join_invite_stuff started"
		disable_pause
		shutdown_game_for_signin_change unloadcontent = 0
		LaunchEvent type = unfocus target = root_window
		online_menu_init
		start_flow_manager flow_state = quick_match_joining_game_fs
		JoinInviteServer
	else
		printf "didn't get an invite"
		if (($ui_flow_manager_state [0]) = online_signin_fs)
			ui_flow_manager_respond_to_action action = online_enabled
		endif
	endif
endscript

script ui_print_gamertags pos1 = (235.0, 100.0) pos2 = (1065.0, 100.0) just1 = [left top] just2 = [right top] offscreen = 0
	NetSessionFunc obj = match func = get_gamertag
	ui_print_gamertag name = <name> start_pos = <pos1> color = ($player1_color) player = 1 just = <just1> dims = <dims> offscreen = <offscreen>
	ui_print_gamertag name = ($opponent_gamertag) start_pos = <pos2> color = ($player2_color) player = 2 just = <just2> dims = <dims> offscreen = <offscreen>
endscript

script ui_print_gamertag name = "NO GAMERTAG!" start_pos = (235.0, 100.0) color = ($player1_color) player = 1 dims = (450.0, 35.0) z = 60 offscreen = 0
	if NOT ScreenElementExists id = gamertag_container
		if (<offscreen> = 1)
			CreateScreenElement {
				type = ContainerElement
				id = gamertag_container
				parent = root_window
				pos = (0.0, -400.0)
				just = [center center]
				z_priority = <z>
			}
		else
			CreateScreenElement {
				type = ContainerElement
				id = gamertag_container
				parent = root_window
				pos = (0.0, 0.0)
				just = [center center]
				z_priority = <z>
			}
		endif
	endif
	FormatText checksumname = gamertag_text_px 'gamertag_text_p%d' d = <player>
	FormatText checksumname = debug_gamertag_container_px 'debug_gamertag_container_p%d' d = <player>
	FormatText checksumname = gt_frame_top 'gt_frame_top_p%d' d = <player>
	FormatText checksumname = gt_frame_top_fill 'gt_frame_top_fill_p%d' d = <player>
	FormatText checksumname = gt_frame_bottom 'gt_frame_bottom_p%d' d = <player>
	FormatText checksumname = gt_frame_bottom_fill 'gt_frame_bottom_fill_p%d' d = <player>
	if (ScreenElementExists id = <gamertag_text_px>)
		return
	endif
	CreateScreenElement {
		type = TextElement
		parent = gamertag_container
		font = fontgrid_title_gh3
		rgba = <color>
		text = <name>
		id = <gamertag_text_px>
		pos = (<start_pos> + (0.0, 3.0))
		just = <just>
		scale = 0.75
		z_priority = (<z> + 1)
	}
	GetScreenElementDims id = <gamertag_text_px>
	x_dim = ((<dims>.(1.0, 0.0)) * 0.5625)
	y_dim = (<dims>.(0.0, 1.0) * 0.75)
	x_scale = 1.0
	y_scale = 1.0
	if (<width> > <x_dim>)
		<x_scale> = (<x_dim> / <width>)
	endif
	if (<Height> > <y_dim>)
		<y_scale> = (<y_dim> / <Height>)
	endif
	scale_pair = ((1.0, 0.0) * <x_scale> + (0.0, 1.0) * <y_scale>)
	SetScreenElementProps {id = <gamertag_text_px> scale = <scale_pair>}
	displaySprite {
		id = <gt_frame_top>
		parent = gamertag_container
		tex = window_frame_cap
		rgba = ($online_medium_blue)
		pos = <start_pos>
		just = <just>
		z = <z>
	}
	displaySprite {
		id = <gt_frame_top_fill>
		parent = gamertag_container
		tex = window_fill_cap
		rgba = ($online_trans_grey)
		pos = <start_pos>
		just = <just>
		z = <z>
	}
	GetScreenElementDims id = <gamertag_text_px>
	text_w = (<width> + 80)
	text_h = (<dims>.(0.0, 1.0) + 10)
	GetScreenElementDims id = <gt_frame_top>
	frame_w = (<width> / 1.0)
	frame_h = (<Height> / 1.0)
	frame_scale_x = (<text_w> / <frame_w>)
	frame_scale_y = (<text_h> / <frame_h>)
	frame_scale = ((<frame_scale_x> * (1.0, 0.0)) + (<frame_scale_y> * (0.0, 0.5625)))
	SetScreenElementProps {id = <gt_frame_top> scale = <frame_scale>}
	SetScreenElementProps {id = <gt_frame_top_fill> scale = <frame_scale>}
	x_adjust = (0.0, 0.0)
	y_adjust = (0.0, 0.0)
	y_adjust = ((0.0, 1.0) * ((-5 * <y_scale>) -5))
	if ((<just> [0]) = right)
		x_adjust = ((1.0, 0.0) * 40)
	elseif ((<just> [0]) = left)
		x_adjust = ((1.0, 0.0) * -40)
	endif
	new_pos = (<start_pos> + (<x_adjust> + <y_adjust>))
	SetScreenElementProps {id = <gt_frame_top> pos = <new_pos>}
	SetScreenElementProps {id = <gt_frame_top_fill> pos = <new_pos>}
	GetScreenElementProps id = <gt_frame_top>
	GetScreenElementDims id = <gt_frame_top>
	displaySprite {
		id = <gt_frame_bottom>
		parent = gamertag_container
		tex = window_frame_cap
		rgba = ($online_medium_blue)
		pos = (<pos> + (<Height> * (0.0, 1.0)))
		just = <just>
		scale = <scale>
		z = (<z> + 5)
		flip_h
	}
	displaySprite {
		id = <gt_frame_bottom_fill>
		parent = gamertag_container
		tex = window_fill_cap
		rgba = ($online_trans_grey)
		pos = (<pos> + (<Height> * (0.0, 1.0)))
		just = <just>
		scale = <scale>
		z = <z>
		flip_h
	}
endscript

script destroy_gamertags 
	if ScreenElementExists \{id = gamertag_container}
		DestroyScreenElement \{id = gamertag_container}
	endif
	if ScreenElementExists \{id = gamertag_container_p1}
		DestroyScreenElement \{id = gamertag_container_p1}
	endif
	if ScreenElementExists \{id = gamertag_container_p2}
		DestroyScreenElement \{id = gamertag_container_p2}
	endif
	if ScreenElementExists \{id = debug_gamertag_container_p1}
		DestroyScreenElement \{id = debug_gamertag_container_p1}
	endif
	if ScreenElementExists \{id = debug_gamertag_container_p2}
		DestroyScreenElement \{id = debug_gamertag_container_p2}
	endif
endscript

script morph_gamertags 
	if ScreenElementExists \{id = gamertag_container}
		move_gamertag_pos = ((1.0 - <delta>) * (($g_hud_2d_struct_used).offscreen_gamertag_pos) + (<delta> * ((($g_hud_2d_struct_used).final_gamertag_pos) + <off_set>)))
		doScreenElementMorph id = gamertag_container pos = <move_gamertag_pos> time = <time_to_move>
	endif
endscript
net_star_power_pending = 0

script coop_attempt_star_power 
	if ($net_star_power_pending)
		return
	endif
	change \{net_star_power_pending = 1}
	SendNetMessage \{type = coop_star_power_notify}
	Wait \{30
		frames}
	change \{net_star_power_pending = 0}
endscript

script test_write_leaderboards 
	printf \{"test_write_leaderboards"}
	begin_singleplayer_game
	Wait \{0.3
		seconds
		ignoreslomo}
	if NOT should_update_stats_leader_board
		return
	endif
	NetSessionFunc obj = stats func = write_stats params = {leaderboard_id = anarchy_in_the_uk score = 10000 rating = <rating_val>}
endscript

script test_read_leaderboards 
	NetSessionFunc \{obj = stats
		func = get_stats
		params = {
			leaderboard_id = m_test_gh3
			callback = test_callback
			num_rows = 10
			listtype = rating
			rating_val = 5
			columns = 0
		}}
endscript

script test_callback 
	printf \{"test_callback"}
	printstruct <...>
endscript

script menu_show_gamercard 
	if NOT ($is_network_game)
		return
	endif
	NetSessionFunc func = showGamerCard params = {player_xuid = ($0xdc0eb917)}
endscript

script new_net_logic_init 
	change boss_controller = ($player2_status.controller)
	change \{boss_pattern = 0}
	change \{boss_strum = 0}
	change \{boss_lastwhammytime = 0}
	change \{boss_lastbrokenstringtime = 0}
endscript

script 0x88d796ac 
	FormatText checksumname = input_array 'bossresponse_array%p' p = <player_text>
	song = <input_array>
	change last_bossresponse_array_entry = <array_entry>
	0x52661e74 song = <song> entry = <array_entry>
	do_hammer = ($<song> [<array_entry>] [6])
	GetArraySize $gem_colors
	gem_count = 1
	begin
	if (($<song> [<array_entry>] [(<gem_count>)]) > ($player2_status.current_song_beat_time / 2))
		0x80b865ab = 0
		break
	else
		0x80b865ab = 1
	endif
	<gem_count> = (<gem_count> + 1)
	repeat <array_size>
	if (<0x80b865ab> = 1)
		change boss_pattern = <strum>
		change boss_controller = ($<player_status>.controller)
		if (<do_hammer> = 1)
			change boss_strum = 0
		else
			change boss_strum = 1
		endif
	else
		change boss_pattern = 0
		change boss_strum = 0
	endif
endscript

script 0x1d7ce08b 
	ExtendCRC \{song_won
		'p1'
		out = type}
	BroadcastEvent type = <type>
endscript
