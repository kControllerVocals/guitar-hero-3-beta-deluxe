battle_explanation_text = {
	bossslash = "Instead of Star Power, you get BATTLE POWER\\n\\nHit the BATTLE GEMS to get a POWER-UP\\n\\nTilt your guitar upward to attack Slash and make him miss\\n\\nYou HAVE to BEAT him before the end or else YOU LOSE\\n\\nBe careful, he can battle back"
	bosstom = "Instead of Star Power, you get BATTLE POWER\\n\\nHit the BATTLE GEMS to get a POWER-UP\\n\\nTilt your guitar upward to attack Slash and make him miss\\n\\nYou HAVE to BEAT him before the end or else YOU LOSE\\n\\nBe careful, he can battle back"
	bossdevil = "Instead of Star Power, you get BATTLE POWER\\n\\nHit the BATTLE GEMS to get a POWER-UP\\n\\nTilt your guitar upward to attack Slash and make him miss\\n\\nYou HAVE to BEAT him before the end or else YOU LOSE\\n\\nBe careful, he can battle back"
	generic = "Instead of Star Power, you get BATTLE POWER\\n\\nHit the BATTLE GEMS to get a POWER-UP\\n\\nTilt your guitar upward to attack the other player and make them miss\\n\\nYou HAVE to BEAT them before the end or else YOU LOSE\\n\\nBe careful, they can battle back"
}

script create_battle_helper_menu device_num = 0 popup = 0
	menu_z = 10
	CreateScreenElement {
		type = ContainerElement
		parent = root_window
		id = battle_explanation_container
	}
	CreateScreenElement {
		type = SpriteElement
		parent = battle_explanation_container
		id = battle_explanation_screen
		pos = (640.0, 360.0)
		texture = battle_help_bg
		rgba = [223 223 223 255]
		just = [center center]
		dims = (1280.0, 720.0)
		z_priority = 0
	}
	if ($is_demo_mode = 0)
		if (<popup> = 1)
			stars = ($player1_status.stars)
			Cash = ($player1_status.new_cash)
			change structurename = player1_status new_cash = 0
			if ($game_mode = p2_career)
				score = ($player1_status.score + $player2_status.score)
			else
				score = ($player1_status.score)
			endif
			if (<stars> < 3)
				<stars> = 3
			endif
			CastToInteger score
			FormatText TextName = scoretext "%d" d = <score> usecommas
			FormatText TextName = moneytext "$%d" d = <Cash> usecommas
			textscale = 0.8
			starscale = 0.0075000003
			displayText {
				id = ec_scoretext
				font = text_a6
				parent = battle_explanation_container
				rgba = [0 0 0 255]
				pos = (520.0, 120.0)
				scale = 1
				text = <scoretext>
				just = [right center]
				noshadow
				z = (<menu_z> + 20)
			}
			star_add = (40.0, 0.0)
			star_pos = (600.0, 120.0)
			switch <stars>
				case 4
				<star_pos> = (580.0, 120.0)
				case 5
				<star_pos> = (560.0, 120.0)
			endswitch
			i = 0
			begin
			FormatText checksumname = starchecksum 'star_id0%d' d = <i>
			rot = Random (@ 10 @ 30 @ 80 @ 120 @ 160 @ 200 @ 250 @ 270 @ 320 )
			displaySprite {
				parent = battle_explanation_container
				id = <starchecksum>
				pos = <star_pos>
				tex = Encore_Star_Outline
				just = [center center]
				scale = 1.125
				rgba = [0 0 0 255]
				rot_angle = <rot>
				z = (<menu_z> + 20)
			}
			FormatText checksumname = starchecksum 'star_id0%d_2' d = <i>
			displaySprite {
				parent = battle_explanation_container
				id = <starchecksum>
				pos = <star_pos>
				tex = Encore_Star_Outline
				just = [center center]
				scale = 1
				rgba = [110 30 20 255]
				rot_angle = <rot>
				z = (<menu_z> + 21)
			}
			<star_pos> = (<star_pos> + <star_add>)
			<i> = (<i> + 1)
			repeat <stars>
			displayText {
				id = ec_moneytext
				font = text_a6
				parent = battle_explanation_container
				rgba = [0 0 0 255]
				pos = (760.0, 120.0)
				scale = 1
				text = <moneytext>
				just = [left center]
				noshadow
				z = (<menu_z> + 20)
			}
		endif
	endif
	CreateScreenElement {
		type = TextBlockElement
		parent = battle_explanation_container
		id = 0x0eb1f440
		just = [center top]
		internal_just = [left top]
		internal_scale = 0.625
		font = text_a4
		rgba = [245 220 200 255]
		dims = (450.0, 500.0)
		z_priority = 50
		event_handlers = [
			{pad_choose battle_helper_continue params = {device_num = <device_num>}}
			{pad_back ui_flow_manager_respond_to_action params = {action = go_back}}
		]
		line_spacing = 0.9
		shadow
		shadow_rgba = [0 0 0 255]
		shadow_offs = (5.0, 5.0)
	}
	if GotParam boss
		if ($game_mode = p2_battle)
			<id> :SetProps text = ($battle_explanation_text.generic)
			printf "heh %d" d = ($battle_explanation_text.generic)
			0x0126b091 = generic
		else
			<id> :SetProps text = ($battle_explanation_text.<boss>)
			0x0126b091 = <boss>
		endif
	else
		GetGlobalTags Progression
		<id> :SetProps text = ($battle_explanation_text.<boss_song>)
		0x0126b091 = <boss_song>
	endif
	displaySprite {
		parent = battle_explanation_container
		id = who_wants_to_battle_image
		pos = (800.0, 360.0)
		dims = (720.0, 720.0)
		just = [right center]
		z = 5
	}
	displaySprite {
		parent = battle_explanation_container
		tex = battle_help_flourish
		pos = (770.0, 165.0)
		dims = (384.0, 96.0)
		just = [center bottom]
		z = 50
	}
	displaySprite {
		parent = battle_explanation_container
		tex = battle_help_flourish
		pos = (770.0, 145.0)
		just = [center top]
		dims = (384.0, 96.0)
		z = 50
		flip_h
	}
	CreateScreenElement {
		type = TextElement
		parent = battle_explanation_container
		id = who_wants_to_battle_text
		font = text_a10
		scale = 1
		pos = (770.0, 120.0)
		rgba = [237 169 0 255]
		just = [center top]
		z_priority = 51
		font_spacing = 5
		shadow
		shadow_rgba = [0 0 0 255]
		shadow_offs = (5.0, 5.0)
	}
	displayText {
		parent = battle_explanation_container
		text = " "
		font = text_a4
		scale = 0.7
		pos = (770.0, 225.0)
		rgba = [237 169 0 255]
		just = [center top]
		z = 50
	}
	displayText {
		parent = battle_explanation_container
		text = "Ready to Rock?"
		font = text_a4
		scale = 0.7
		pos = (575.0, 580.0)
		rgba = [237 169 0 255]
		just = [left top]
		z = 50
	}
	sprite_params = {
		parent = battle_explanation_container
		tex = battle_help_bullet
		just = [right center]
		dims = (64.0, 32.0)
		z = 40
	}
	if (<0x0126b091> = bossslash)
		0x0eb1f440 :SetProps pos = (800.0, 220.0)
		who_wants_to_battle_text :SetProps text = "SLASH WANTS TO BATTLE!"
		who_wants_to_battle_image :SetProps texture = 0xa6c80bbf
		displaySprite <sprite_params> pos = (590.0, 242.0)
		displaySprite <sprite_params> pos = (590.0, 323.0)
		displaySprite <sprite_params> pos = (590.0, 378.0)
		displaySprite <sprite_params> pos = (590.0, 458.0)
		displaySprite <sprite_params> pos = (590.0, 538.0)
	elseif (<0x0126b091> = bosstom)
		0x0eb1f440 :SetProps pos = (800.0, 220.0)
		who_wants_to_battle_text :SetProps text = "MORELLO CHALLENGES YOU!"
		who_wants_to_battle_image :SetProps texture = 0x04844da5
		displaySprite <sprite_params> pos = (590.0, 242.0)
		displaySprite <sprite_params> pos = (590.0, 323.0)
		displaySprite <sprite_params> pos = (590.0, 378.0)
		displaySprite <sprite_params> pos = (590.0, 458.0)
		displaySprite <sprite_params> pos = (590.0, 538.0)
	elseif (<0x0126b091> = bossdevil)
		0x0eb1f440 :SetProps pos = (800.0, 220.0)
		who_wants_to_battle_text :SetProps text = "ALL RIGHT, THIS IS IT!"
		who_wants_to_battle_image :SetProps texture = 0xdfd8671f
		displaySprite <sprite_params> pos = (590.0, 242.0)
		displaySprite <sprite_params> pos = (590.0, 323.0)
		displaySprite <sprite_params> pos = (590.0, 378.0)
		displaySprite <sprite_params> pos = (590.0, 458.0)
		displaySprite <sprite_params> pos = (590.0, 538.0)
	else
		0x0eb1f440 :SetProps pos = (800.0, 220.0)
		who_wants_to_battle_text :SetProps text = "BATTLE MODE!"
		who_wants_to_battle_image :SetProps alpha = 0
		displaySprite <sprite_params> pos = (590.0, 242.0)
		displaySprite <sprite_params> pos = (590.0, 323.0)
		displaySprite <sprite_params> pos = (590.0, 378.0)
		displaySprite <sprite_params> pos = (590.0, 458.0)
		displaySprite <sprite_params> pos = (590.0, 538.0)
	endif
	LaunchEvent type = focus target = 0x0eb1f440
	change user_control_pill_text_color = [0 0 0 255]
	change user_control_pill_color = [180 180 180 255]
	add_user_control_helper text = "BATTLE" button = green z = 100
	add_user_control_helper text = "DECLINE" button = red z = 100
endscript

script battle_helper_continue 
	ui_flow_manager_respond_to_action action = continue device_num = <device_num>
endscript

script destroy_battle_helper_menu 
	clean_up_user_control_helpers
	destroy_menu \{menu_id = battle_explanation_container}
endscript
