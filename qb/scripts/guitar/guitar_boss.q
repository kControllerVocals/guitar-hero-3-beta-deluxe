Boss_TomMorello_Props = {
	GainPerNote = {
		easy = 0.85
		medium = 0.65000004
		hard = 0.5
		expert = 0.35000002
	}
	LossPerNote = {
		easy = 5.5
		medium = 3.2
		hard = 2.95
		expert = 2.5
	}
	PowerUpMissedNote = {
		easy = 65.0
		medium = 60.0
		hard = 55.0
		expert = 50.0
	}
	WhammySpeed = {
		easy = 1200
		medium = 950
		hard = 700
		expert = 450
	}
	BrokenStringSpeed = {
		easy = 1200
		medium = 950
		hard = 700
		expert = 450
	}
	BrokenStringMissedNote = {
		easy = 30.0
		medium = 25.0
		hard = 25.0
		expert = 20.0
	}
	PowerUps = [
		lightning
		DifficultyUp
		DoubleNotes
		WhammyAttack
	]
	character_profile = morello
	character_name = "Tom Morello"
}
Boss_Slash_Props = {
	GainPerNote = {
		easy = 0.85
		medium = 0.65000004
		hard = 0.5
		expert = 0.35000002
	}
	LossPerNote = {
		easy = 5.0
		medium = 2.7
		hard = 2.5
		expert = 2.0
	}
	PowerUpMissedNote = {
		easy = 55.0
		medium = 50.0
		hard = 45.0
		expert = 40.0
	}
	WhammySpeed = {
		easy = 1200
		medium = 950
		hard = 700
		expert = 450
	}
	BrokenStringSpeed = {
		easy = 1200
		medium = 950
		hard = 700
		expert = 450
	}
	BrokenStringMissedNote = {
		easy = 30.0
		medium = 25.0
		hard = 25.0
		expert = 20.0
	}
	PowerUps = [
		lightning
		DifficultyUp
		DoubleNotes
		BrokenString
		WhammyAttack
	]
	character_profile = slash
	character_name = "Slash"
}
Boss_Devil_Props = {
	GainPerNote = {
		easy = 0.7
		medium = 0.6
		hard = 0.3
		expert = 0.3
	}
	LossPerNote = {
		easy = 5.0
		medium = 2.7
		hard = 2.5
		expert = 2.0
	}
	PowerUpMissedNote = {
		easy = 60.0
		medium = 45.0
		hard = 40.0
		expert = 35.0
	}
	WhammySpeed = {
		easy = 1100
		medium = 850
		hard = 600
		expert = 350
	}
	BrokenStringSpeed = {
		easy = 1100
		medium = 850
		hard = 600
		expert = 350
	}
	BrokenStringMissedNote = {
		easy = 30.0
		medium = 25.0
		hard = 25.0
		expert = 20.0
	}
	PowerUps = [
		lightning
		DifficultyUp
		DoubleNotes
		LeftyNotes
		BrokenString
		WhammyAttack
	]
	character_profile = satan
	character_name = "Lou"
}

script bossbattle_init 
	if ($game_mode = p2_battle)
		ScriptAssert "Cannot choose p2_battle and bossbattle"
	endif
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = battlemode_container
		pos = (0.0, 0.0)
		just = [left top]
	}
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	change structurename = <player_status> battlemode_creation_selection = -1
	change structurename = <player_status> current_num_powerups = 0
	change structurename = <player_status> shake_notes = -1
	change structurename = <player_status> double_notes = -1
	change structurename = <player_status> diffup_notes = -1
	change structurename = <player_status> lefty_notes = -1
	change structurename = <player_status> stealing_powerup = -1
	change structurename = <player_status> death_lick_attack = -1
	change structurename = <player_status> last_hit_note = none
	change structurename = <player_status> last_selected_attack = -1
	change structurename = <player_status> broken_string_mask = 0
	change structurename = <player_status> broken_string_green = 0
	change structurename = <player_status> broken_string_red = 0
	change structurename = <player_status> broken_string_yellow = 0
	change structurename = <player_status> broken_string_blue = 0
	change structurename = <player_status> broken_string_orange = 0
	player = (<player> + 1)
	repeat 2
	change structurename = player2_status part = rhythm
	change boss_controller = ($player2_status.controller)
	change boss_pattern = 0
	change boss_strum = 0
	change boss_lastwhammytime = 0
	change boss_lastbrokenstringtime = 0
endscript

script bossbattle_deinit 
	if ($boss_battle = 1)
		change boss_battle = 0
		change current_num_players = 1
		change structurename = player2_status controller = ($boss_oldcontroller)
		KillSpawnedScript id = battlemode
		change structurename = <player_status> battlemode_creation_selection = -1
		change structurename = <player_status> current_num_powerups = 0
		change structurename = <player_status> shake_notes = -1
		change structurename = <player_status> double_notes = -1
		change structurename = <player_status> diffup_notes = -1
		change structurename = <player_status> lefty_notes = -1
		change structurename = <player_status> stealing_powerup = -1
		change structurename = <player_status> death_lick_attack = -1
		change structurename = <player_status> last_hit_note = none
		change structurename = <player_status> last_selected_attack = -1
		change structurename = <player_status> broken_string_mask = 0
		change structurename = <player_status> broken_string_green = 0
		change structurename = <player_status> broken_string_red = 0
		change structurename = <player_status> broken_string_yellow = 0
		change structurename = <player_status> broken_string_blue = 0
		change structurename = <player_status> broken_string_orange = 0
		if ScreenElementExists id = battlemode_container
			DestroyScreenElement id = battlemode_container
		endif
		KillSpawnedScript name = boss_battle_begin_deathlick
		KillSpawnedScript name = animate_death_icon
		battlemode_killspawnedscripts
	endif
endscript

script bossbattle_select player_status = player1_status
	printf "bossbattle_select"
	if ($game_mode = tutorial)
		change structurename = <player_status> battlemode_creation_selection = 0
		return
	endif
	change structurename = <player_status> battlemode_creation_selection = -1
	total_weight = 0
	if ($<player_status>.player = 1)
		other_player_difficulty = $current_difficulty2
	else
		other_player_difficulty = $current_difficulty
	endif
	next_attack = -1
	if ($<player_status>.current_num_powerups > 0)
		if ($<player_status>.player = 1)
			<next_attack> = ($current_powerups_p1 [($<player_status>.current_num_powerups - 1)])
		else
			<next_attack> = ($current_powerups_p2 [($<player_status>.current_num_powerups - 1)])
		endif
	endif
	GetArraySize ($current_boss.PowerUps)
	powerups_size = <array_size>
	GetArraySize $battlemode_powerups
	array_count = 0
	begin
	powerup_enabled = 0
	powerup_count = 0
	begin
	if ($current_boss.PowerUps [<powerup_count>] = $battlemode_powerups [<array_count>].name)
		powerup_enabled = 1
		break
	endif
	powerup_count = (<powerup_count> + 1)
	repeat <powerups_size>
	if (<powerup_enabled> = 1)
		if NOT ((<other_player_difficulty> = expert) && ($battlemode_powerups [<array_count>].name = DifficultyUp))
			if ($<player_status>.last_selected_attack = <array_count> || <next_attack> = <array_count>)
				total_weight = (<total_weight> + $battlemode_powerups [<array_count>].weight_low)
			else
				total_weight = (<total_weight> + $battlemode_powerups [<array_count>].weight)
			endif
		endif
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	GetRandomValue name = select_weight a = 0 b = (<total_weight> - 1) Integer
	array_count = 0
	begin
	powerup_enabled = 0
	powerup_count = 0
	begin
	if ($current_boss.PowerUps [<powerup_count>] = $battlemode_powerups [<array_count>].name)
		powerup_enabled = 1
		break
	endif
	powerup_count = (<powerup_count> + 1)
	repeat <powerups_size>
	if (<powerup_enabled> = 1)
		if NOT ((<other_player_difficulty> = expert) && ($battlemode_powerups [<array_count>].name = DifficultyUp))
			if ($<player_status>.last_selected_attack = <array_count> || <next_attack> = <array_count>)
				select_weight = (<select_weight> - $battlemode_powerups [<array_count>].weight_low)
			else
				select_weight = (<select_weight> - $battlemode_powerups [<array_count>].weight)
			endif
		endif
		if (<select_weight> < 0)
			change structurename = <player_status> battlemode_creation_selection = <array_count>
			change structurename = <player_status> last_selected_attack = <array_count>
			break
		endif
	endif
	array_count = (<array_count> + 1)
	repeat <array_size>
	if ($<player_status>.battlemode_creation_selection = -1)
		printstruct <...>
		ScriptAssert "Battlemode selection not found"
	endif
endscript

script bossbattle_ready battle_gem = 0 player_status = player1_status
	printf "bossbattle_ready"
	current_num_powerups = ($<player_status>.current_num_powerups)
	if (<current_num_powerups> >= $max_num_powerups)
		FormatText checksumname = card_checksum 'battlecard_%i_%s' i = ($<player_status>.current_num_powerups - 1) s = ($<player_status>.player)
		if ScreenElementExists id = <card_checksum>
			DestroyScreenElement id = <card_checksum>
		endif
		change structurename = <player_status> current_num_powerups = ($<player_status>.current_num_powerups - 1)
		update_battlecards_remove player_status = <player_status>
	endif
	current_num_powerups = ($<player_status>.current_num_powerups)
	select = <battle_gem>
	if ($<player_status>.player = 1)
		SetArrayElement ArrayName = current_powerups_p1 GlobalArray index = <current_num_powerups> newvalue = <select>
		card_pos = (($battle_hud_2d_elements.rock_pos_p1) + ($battle_hud_2d_elements.card_1_off_p1))
	else
		SetArrayElement ArrayName = current_powerups_p2 GlobalArray index = <current_num_powerups> newvalue = <select>
		card_pos = (($battle_hud_2d_elements.rock_pos_p2) + ($battle_hud_2d_elements.card_1_off_p2))
	endif
	change structurename = <player_status> current_num_powerups = ($<player_status>.current_num_powerups + 1)
	color = ($<player_status>.last_hit_note)
	switch <color>
		case green
		string_offset = (($battle_hud_2d_elements.string_offset) * 0)
		case red
		string_offset = (($battle_hud_2d_elements.string_offset) * 1)
		case Yellow
		string_offset = (($battle_hud_2d_elements.string_offset) * 2)
		case Blue
		string_offset = (($battle_hud_2d_elements.string_offset) * 3)
		case Orange
		string_offset = (($battle_hud_2d_elements.string_offset) * 4)
		default
		string_offset = (($battle_hud_2d_elements.string_offset) * 0)
	endswitch
	if ($<player_status>.player = 1)
		player_offset = (0.0, 0.0)
	else
		player_offset = ($battle_hud_2d_elements.buttons_p2_offset)
	endif
	if NOT ($<player_status>.lefthanded_button_ups = 1)
		begin_pos = (($battle_hud_2d_elements.green_button_pos) + <player_offset> + <string_offset>)
	else
		begin_pos = (($battle_hud_2d_elements.lefty_green_button_pos) + <player_offset> - <string_offset>)
	endif
	card_alpha = 1
	if NOT ($show_battle_text = 1)
		<card_alpha> = 0
	endif
	FormatText checksumname = card_checksum 'battlecard_%i_%s' i = <current_num_powerups> s = ($<player_status>.player)
	CreateScreenElement {
		type = SpriteElement
		id = <card_checksum>
		parent = battlemode_container
		texture = ($battlemode_powerups [<select>].card_texture)
		rgba = [255 255 255 255]
		pos = <begin_pos>
		dims = (64.0, 64.0)
		alpha = <card_alpha>
		just = [center center]
		z_priority = (($battle_hud_2d_elements.z) + 19)
	}
	doScreenElementMorph {
		id = <card_checksum>
		pos = <card_pos>
		time = 0.3
	}
	update_battlecards_add current_num_powerups = <current_num_powerups> player_status = <player_status>
	if ($show_battle_text = 1)
		spawnscriptnow attack_ready_text params = {current_num_powerups = <current_num_powerups> select = <select> player_status = <player_status>}
	endif
endscript

script bossbattle_trigger_on player = 1 player_text = 'p1' player_status = player1_status
	printf "bossbattle_trigger_on"
	if ($<player_status>.current_num_powerups = 0)
		return
	endif
	if ($<player_status>.player = 1)
		<other_player> = 2
		<other_player_text> = 'p2'
		<other_difficulty> = $current_difficulty2
		<other_player_status> = player2_status
		select = ($current_powerups_p1 [($<player_status>.current_num_powerups - 1)])
		if ($is_network_game)
			SendNetMessage {
				type = bossbattle_trigger_on
				select = <select>
			}
		endif
	else
		<other_player> = 1
		<other_player_text> = 'p1'
		<other_difficulty> = $current_difficulty
		<other_player_status> = player1_status
		select = ($current_powerups_p2 [($<player_status>.current_num_powerups - 1)])
	endif
	FormatText checksumname = card_checksum 'battlecard_%i_%s' i = ($<player_status>.current_num_powerups - 1) s = ($<player_status>.player)
	if ScreenElementExists id = <card_checksum>
		DestroyScreenElement id = <card_checksum>
	endif
	change structurename = <player_status> current_num_powerups = ($<player_status>.current_num_powerups - 1)
	update_battlecards_remove player_status = <player_status>
	drain_time = ($battlemode_powerups [<select>].drain_time)
	if ($<player_status>.player = 1)
		SpawnScript bossbattle_ai_damage params = {drain_time = <drain_time> player_status = <other_player_status> player_text = <other_player_text> select = <select>}
	endif
	spawnscriptnow ($battlemode_powerups [<select>].Scr) id = battlemode params = {drain_time = <drain_time>
		player = <other_player>
		player_text = <other_player_text>
		other_player_status = <other_player_status>
		player_status = <player_status>
		difficulty = <other_difficulty>
		($battlemode_powerups [<select>].params)}
	Band_PlayAttackAnim name = ($<player_status>.band_member) type = <select>
	Band_PlayResponseAnim name = ($<other_player_status>.band_member) type = <select>
	spawnscriptnow hammer_highway params = {other_player_text = <other_player_text>}
	if ($battlemode_powerups [<select>].fire_bolt = 1)
		spawnscriptnow attack_bolt params = {player_status = <player_status> other_player_status = <other_player_status>}
	endif
endscript
boss_powerup_delay = 0

script 0x2042fe56 
	if ($game_mode = tutorial)
		return do_star = 0
	endif
	if ($<player_status>.current_num_powerups = 0)
		change boss_powerup_delay = 100
		return do_star = 0
	elseif ($<player_status>.current_num_powerups = 1)
		if ($boss_powerup_delay = 0)
			return do_star = 1
		else
			change boss_powerup_delay = ($boss_powerup_delay - 1)
			return do_star = 0
		endif
	elseif ($<player_status>.current_num_powerups = 2)
		return do_star = 1
	endif
endscript
bossbattle_missingnotefraction = 0.0

script bossbattle_ai_damage player_status = player2_status drain_time = 15000 player_text = 'p2'
	if StructureContains Structure = ($battlemode_powerups [<select>]) no_ai_damage
		return
	endif
	gem_fraction = 0.0
	FormatText checksumname = input_array 'bossresponse_array%p' p = <player_text>
	FormatText checksumname = input_array_entry 'bossresponse_array%p_entry' p = <player_text>
	GetSongTimeMs
	if StructureContains Structure = ($battlemode_powerups [<select>]) immediate
		start_creation_time = <time>
		end_creation_time = (<start_creation_time> + <drain_time>)
		start_creation_index = ($last_bossresponse_array_entry)
	else
		start_creation_time = (<time> + ($<player_status>.scroll_time - $destroy_time) * 1000.0 + 1000)
		end_creation_time = (<start_creation_time> + <drain_time>)
		start_creation_index = ($<input_array_entry>)
	endif
	missed_note_percentage = ($current_boss.PowerUpMissedNote.($current_difficulty))
	if ($battlemode_powerups [<select>].name = BrokenString)
		<end_creation_time> = (<start_creation_time> + 60000)
		<missed_note_percentage> = ($current_boss.BrokenStringMissedNote.($current_difficulty))
	endif
	begin
	begin
	GetSongTimeMs
	if (<time> > <start_creation_time> - 200)
		break
	endif
	Wait 1 gameframe
	repeat
	if ($battlemode_powerups [<select>].name = BrokenString)
		if ($<player_status>.broken_string_green < 3 &&
				$<player_status>.broken_string_red < 3 &&
				$<player_status>.broken_string_yellow < 3 &&
				$<player_status>.broken_string_blue < 3 &&
				$<player_status>.broken_string_orange < 3)
			break
		endif
	endif
	ApplyBossBattleGemMisses {miss_percent = <missed_note_percentage>
		start_creation_index = <start_creation_index>
		start_creation_time = <start_creation_time>
		end_creation_time = <end_creation_time>
		gem_fraction = <gem_fraction>}
	GetSongTimeMs
	start_creation_time = (<time> + ($<player_status>.scroll_time - $destroy_time) * 1000.0 + 1000)
	if NOT ($battlemode_powerups [<select>].name = BrokenString)
		if (<start_creation_time> >= <end_creation_time>)
			break
		endif
	endif
	repeat
endscript

script check_buttons_boss 
	FormatText checksumname = input_array 'bossresponse_array%p' p = <player_text>
	song = <input_array>
	change last_bossresponse_array_entry = <array_entry>
	GetStrumPattern song = <song> entry = <array_entry>
	do_hammer = ($<song> [<array_entry>] [6])
	0x80b865ab = 1
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

script bossbattle_fill 
	bossbattle_ready \{battle_gem = 5
		player_status = player1_status}
	bossbattle_ready \{battle_gem = 5
		player_status = player1_status}
	bossbattle_ready \{battle_gem = 5
		player_status = player1_status}
endscript

script boss_battle_begin_deathlick 
	battle_death_lick \{death_speed = 0.1
		player_status = player2_status
		other_player_status = player1_status
		drain_time = 5000}
endscript

script boss_battle_death_icon 
	boss_pos = (900.0, 150.0)
	player_pos = (300.0, 183.0)
	displaySprite parent = root_window tex = icon_attack_deth pos = <boss_pos> just = [center center] z = 500
	doScreenElementMorph id = <id> pos = <player_pos> scale = 3.1 relative_scale time = 1.0
	Wait \{2.0
		seconds}
	doScreenElementMorph id = <id> alpha = 0 time = 2.0
	Wait \{2.0
		seconds}
	destroy_menu menu_id = <id>
endscript
