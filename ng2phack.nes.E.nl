$C000#PRG_bank_8000#
$C011#PRG_bank_A000#
$C022#Ryu: environment#and such
$C03D#l_wall#
$C044#r_wall#
$C064#not_moving#
$C069#touching ice|water#
$C07C#not crouching|slashing#
$C08E#go_left#
$C0A6#go_right#
$C0D0#go_right2#
$C0E4#go_left2#
$C105#on_surface#
$C114#on_climbable_surface#
$C124#down_pressed#
$C128#up_pressed#
$C141#slide_down_ice|water#
$C14A#do_jumps#
$C153#walljump_state_b5#
$C159#jump_state_b4#
$C16F#EnviroMovement#
$C180#wind_jump_table#
$C1A2#no_wind#
$C1BB#left_wind|water#
$C1C6#right_wind|water#
$C1D1#ice#
$C1DB#ice: standing#
$C201#ice: right#
$C205#ice: left#
$C23D#wind01#
$C242#wind02#
$C249#wind03#
$C24E#wind04#
$C255#wind05#
$C25A#wind06#
$C261#wind07#
$C266#wind08#
$C26D#wind09#
$C272#wind0A#
$C279#wind0B#
$C27E#wind0C#
$C285#wind0D#
$C28A#wind0E#
$C291#wind0F#
$C296#wind10#
$C29D#from_the_top#
$C2A2#wind_transition#
$C2A7#Ryu: BG_collision#
$C2D3#too_high_no_touching#
$C2E2#find_platform_right#
$C2FF#find_platform_left#
$C315#found_platform#
$C322#not_crouching#
$C333#find_wall_R(up)#
$C34B#(down)#
$C361#L_find_wall(up)#
$C379#(down)#
$C38C#overlapping_wall#
$C3AA#not_overlapping_wall#
$C3F6#Object: aim#
$C40E#ryu_left#
$C41D#ryu_right#
$C441#ryu_above#
$C44E#ryu_below#
$C45B#left|above_lo#
$C45C#left|above_hi#
$C47B#right|below_lo#
$C47C#right|below_hi#
$C49B#Object: BG collision#
$C4C9#not_too_high#
$C511#on_platform#
$C520#not_on_platform#
$C526#and_not_already_falling#
$C535#Object: set_vertical_movement#
$C544#Object: variant_spawn#
$C54E#Object: fix_projectile_to_owner#
$C558#Object: clear_speed#
$C567#arc_x_speed_lo#
$C56B#arc_x_speed_hi#
$C56F#Spawn: enemies#
$C575#check_list_R#
$C584#list_ok_R#
$C58C#check_list_L#
$C5A0#list_ok_L#
$C5A6#check_bits#make sure this spawn isn't already on screen
$C5C0#spawn_it!#write basic stats and position, ID for enemy-specific routines, where it came from
$C614#Object: id_specified_routine#
$C639#Miscellany#invulnerability, player death, end-stage score tally, lvl timer, lvl exits, spawn block
$C65B#waiting_to_land_after_hit#
$C66A#player_death_check#
$C67A#score_tally#
$C6EB#level_timer#
$C71D#check_for_exits#
$C739#get_block#divide level into 16 pixel "blocks" for spawn checks
$C74E#exit_to_cut_scene#
$C799#go_back#
$C7A2#go_forward#
$C820#Tecmo_Cinema#
$C85C#Ryu_is_dead#
$C8A6#Game_over#
$C8D6#game_over_loop#
$C913#tally_done#
$C925#lvls_with_cutscenes#
$C933#cs_list#
$C941#Read_Input#
$C95B#Update_background_data#
$CA02#Collision: enemies#and fire and spikes
$CA15#odd: spikes&enemies#
$CA1D#sword_slash#
$CA2C#ryu|clone active#
$CA4A#and an enemy is active#
$CA53#and not dead#
$CA5C#and ryu is facing right#
$CA6F#and ryu is facing left#
$CA84#and ryu is close enough on the x axis#
$CAAB#and ryu is close enough on the y axis#
$CAB0#-#first shadow to score a (non-boss) hit skips things on to Ryu, but leaves the temp X reg ($9) alone so double-kills can only happen if Ryu is hitting something lower on the list
$CABE#it's dead#
$CAD1#but it's still alive#
$CADD#damage_knockback#for non-boss enemies with health > 1
$CAE9#even: weapons#
$CB2F#Spc_weapons#
$CB9C#itsaboss#
$CBAA#throwing_star_boss_bounce#
$CBD6#Spike_collision#and fire
$CC07#enemy_collison#
$CC09#enemy_loop#
$CC22#check_collision#
$CC6A#ryu_touched_a_bad_guy#
$CC7D#Ryu_died#
$CCAD#absorb_if_projectile#
$CCBA#Boss_kill#
$CD36#debug_lvl_select#Disabled code: [20 37 DC]
$CD4B#Start_new_stage#or restart after death
$CD66#new_game#
$CD7B#died#
$CD95#game_over#
$CDA7#new_stage#
$CDAD#mid_act_cut_scene#
$CDC3#general#
$CE44#Status_setup#
$CE4F#bulk_ppu_trans_offsets#for score, lives, max ninpo, ninpo at stage start
$CE59#status_row_one#
$CE87#status_rows_two_and_three#
$CEB7#ten_ninpo#
$CEC5#2_lives_0_score#
$CED2#Load_level#
$CF19#bg_periods#
$CF1D#lvl_has_bg_animation#
$CF2D#lvl_has_no_bg_animation#
$CFA9#scroll_left#
$CFD7#scroll_right#
$D04E#level_load_loop#
$D081#train#
$D085#funky#
$D0FF#7-2_music_selection#
$D164#change_stage#
$D174#change_room#
$D17D#boss#
$D1DB#stage_number_template#
$D1E2#New_stage_prep#
$D1F2#set sprite priority for 6-1#
$D24A#chr_banks_table#
$D25A#irq_chr_banks#
$D262#start_x#
$D26E#music_tracks#
$D277#irq#
$D29C#irq_jump_pointers#
$D2B2#00#
$D2DC#01#
$D30D#02#
$D328#03#
$D350#04#
$D373#05#
$D37D#07#
$D3A1#08#
$D3D2#09#
$D3F4#0A#
$D41E#Object: move#(excludes Ryu, clones, equipped weapon symbol)
$D4F3#nmi#
$D62C#From_the_top#
$D668#tecmo_presents_1990#
$D682#ninja_gaiden_ii#
$D69A#title_screen_setup#
$D721#title_screen_loop#
$D751#start_game#
$D75D#do_sound_test#
$D78F#Wait_for_start_press#
$D7A1#Ryu: movement, input, BG collision#
$D7AD#in air, accelerate#
$D7BE#move#branch here if surface contact or at fall speed cap
$D7D2#pit_death_check#
$D7E9#clear wall-cling bits if dead#
$D7FA#RTS if bouncing off enemy (no control)#
$D803#on_platform_or_in_air#
$D817#A+away_from_wall_pressed#
$D832#wall_cling#
$D83D#B_pressed#
$D845#B+L#
$D84C#B+R#
$D851#facing_right#
$D856#facing_left#
$D85B#B_not_pressed#
$D85F#A_pressed#
$D866#on_left_wall#
$D86D#on_right_wall#
$D872#A_not_pressed#
$D877#up_pressed#
$D881#down_pressed#
$D88B#no direction or any opposing directions#
$D89D#N+B#
$D8BD#N+A#
$D8CF#right_pressed#
$D910#R+B#
$D92F#R+A#
$D941#left_pressed#
$D983#L+B#
$D9A2#L+A#
$D9B4#down_pressed#
$D9BD#D#
$D9C9#D+B#
$D9E8#up_pressed#
$D9F1#U#
$D9FD#U+B#
$DA13#dpad_jump_table#
$DA33#enemy_hp+dmg+pts#
$DA63#Ryu: scrolling#
$DA72#ryu_moved#
$DAAC#no_scroll#
$DAE0#scroll#
$DB10#scrolled_to_start_of_level#
$DB26#Nametable_updates#
$DBCF#Handle_metatile#
$DC37#Debug_lvl_select#disabled
$DCA4#MCsub1#
$DD8B#MCsub2#
$DDB3#Musicruise_setup#
$DEA2#Musicruise#
$DF43#musicruise_data#DF43-E23E, 0x2FC bytes
\first 0x59 bytes = bank list
$D60F#Hm#Looks like a crash handler or controller reset would have been here.
\Instead of the JMP $d618 it might have been:
\LDA somevar; CMP someval; BNE $03; JMP resetvector
\this segment isn't in NR2, is fully NOP'd in SW2 and is identical in the prototype rom
$DF9C#musicruise_tracklist#0x59 bytes
