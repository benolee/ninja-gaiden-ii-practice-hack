$8000#bg_palettes_1#
$8030#bg_palettes_2#
$8060#bg_palettes_3#
$8090#sprite_palettes_2#
$80C0#sprite_palettes_3#plus b7 set = no bg animation
$80F0#level_data#b7=left scroller
$8120#more_lvl_data#b7-3 = $18; b2-0 = $34
$8150#lvl_chr_bank_offsets#hi nybble = chr_bank_5 ; lo nybble = chr_bank_4
$8180#lvl_widths#lo=width in screens; hi=universal bg color offset
$81B0#lvl_start_positions#hi nybble = ypos; lo = offset to xpos @ $D262
$81E0#lvl_revisit_positions#
$8210#bg_animation_data#b7-3=pal change stuff; b2=flag; b1-0=period offset
$8240#lvl_transition_info#b7-2 = restart point after game over ; b1-0 = transition type
$8270#stage_numbers&bg_mask#
$82A0#orb spawn quantity per lvl#
$82D0#enemy spawn quantity per lvl#
$8300#music_offsets#
$8330#template_ptrs_lo#
$8340#template_ptrs_hi#
$8350#00#GAME OVER
$835D#01#sound test channel visualizer
$83A9#02#title screen attribute table
$83E5#03#title 2
$8443#04#title 3
$84A1#05#title 4
$8505#06#title 5
$853F#07#title 6
$858D#08#TECMO PRESENTS 1990
$85CA#09#NINJA GAIDEN II
$85F4#0C#sound test and lvl select palettes
$8618#0D#musicruise 1
$8620#0E#musicruise 2
$865A#0F#musicruise 3
$86AF#unused_0x71_bytes#
$8720#orb_spawn_blocks_lo#
$8750#orb_spawn_blocks_hi#
$8780#orb_contents_and_ypos_lo#
$87B0#orb_contents_and_ypos_hi#
$87E0#enemy_spawn_blocks_lo#
$8810#enemy_spawn_blocks_hi#
$8840#enemy_spawn_pos_lo#
$8870#enemy_spawn_pos_hi#
$88A0#enemy_spawn_id_offsets_lo#
$88D0#enemy_spawn_id_offsets_hi#
$8900#orb_spawn_data#0x29A bytes
$8B9A#enemy_spawn_data#referenced by pointers stored at $C3-$C8; 0x5FD bytes
$91A0#Object: face_Ryu#
$91B6#Object: approach_Ryu#
$91CF#Object: proximity_check#
$91E2#Object: find_free_slot#
$920E#Object: x_reverse#
$9220#Object: y_reverse#
$9232#Object: set_hitbox#
$924A#x_sizes#
$9250#y_sizes#
$9258#Object: x_movement#
$9267#Object: y_movement#
$9293#Object: animate#
$92CE#Animate_spcW&orbs_while_paused#
$92DD#bg_properties#
$92ED#bitmasks#
$92F5#bitmask_offsets#
$930D#act_obj_bf_offs#
$9325#Level_fade_in#
$9374#Level_fade_out#
$93CD#Ryu_clone_&_weapon_flicker#
$93F4#Collision: pick_ups & ground#
$9442#Animate_background#
$946C#Setup_bg_pal_animation#
$94A2#Palette_junk#
$951C#Set_attack_state#
$9548#Set_airborne_state#
$954D#contact#
$9569#no_contact#
$9583#Set_crouch_state#
$95CE#Clear_object_RAM#
$95E8#Clear_nametables#
$962E#Shutter_fade_prep#
$968A#Blacken_palettes#
$96C2#Update_status_bar#
$96EB#05_ninja_bar#
$96F1#06_enemy_bar#
$9717#0-4_score_lives_maxninpo_ninpo_timer#
$9743#Fade_from_black#
$9746#Fade_to_black#
$977C#Find_collision_tile#
$97A8#get_hi_nybble#
$97AE#get_lo_nybble#
$97B2#column_offsets#
$97BB#Collision: pick_ups & Ryu#
$97D8#PickUp_collision_check#
$97F5#PickUp_collision_occurred#
$9810#sub_weapon_pickup#
$9812#non_weapon#
$9821#item_pickup_ptrs#
$983B#blue_ninpo#
$985E#red_ninpo#
$9876#scroll#
$98AA#blue_sack#
$98AF#red_sack#
$98B4#health_jar#
$98C9#shadow_clone#
$98EB#extra_life#
$98FE#all_weapons#
$9903#jsr_equip_star_for_new_stage#
$993C#weapon_IDs#
$9941#weapon_attr#
$9946#weapon_sizes#
$994B#weapon_index#
$994E#Collision: orbs & attacks#
$9959#slash#
$99B0#special_attack#
$9A1E#Orb_opened#
$9A2C#replace scroll with blue ninpo if already taken from this level#
$9A5B#pickup_graphics#
$9A68#pickup_colors#1=red
$9A75#Wait_for_irq#
$9A7C#Ryu: special attack#
$9B4B#spc_atk_HUD_dec_ones#
$9B50#spc_atk_HUD_dec_tens#
$9B55#spc_attack_costs#
$9B5A#spc_attack_sounds#
$9B5F#spc_atk_x_speeds_right#
$9B64#spc_atk_x_speeds_left#
$9B69#spc_atk_y_speeds#
$9B7A#room_revisit_offsets_lo#
$9B7B#room_revisit_offsets_hi#
$9B9A#Preset_ppu_transmission#
$9BD5#Set_ppu_trans_and_wait_for_vblank#
$9BD9#Wait_for_vblank#
$9BE1#Ryu: shadow stuff#
$9C37#branch here if stationary#
$9C4B#clones_attack#
$9C60#Shadow: animate attack#
$9C67#sword#
$9C78#spc_atk#
$9C97#L#
$9C9D#R#
$9CAB#Shadow: animate#
$9CC0#Shadow: animate1#
$9CEB#Shadow: set pos and state#
$9D0C#Get_Shdw1_offset#
$9D16#Object: remove#
$9D55#projectile_or_not_enemy#
$9D68#Add_points#
$9D92#Set_bg_collision#
$9DC3#Setup_palettes#
$9E16#Clear_sprites#
$9E24#Set_sprites#
$9F30#Spawn: orbs#
$9F34#moving_right#
$9F4C#moving_left#
$9F58#left_spawn#
$9F5E#right_spawn#
$9FB4#already_opened#
$9FD3#Palette_update#
$9FE0#Palette_stuff#
$9735#hud_upd_ppuAddr_lo#
$973C#hud_upd_end_offsets#
$9730#hud_upd_ram_offset#
$9729#hud_upd_size#
