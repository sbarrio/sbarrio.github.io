package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.net.HTTPRequest;
import lime.system.CFFI;
import lime.text.Font;
import lime.utils.Bytes;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_pressstart2p_ttf);
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if flash
		
		className.set ("assets/music/stage.wav", __ASSET__assets_music_stage_wav);
		type.set ("assets/music/stage.wav", AssetType.SOUND);
		className.set ("assets/music/stage.ogg", __ASSET__assets_music_stage_ogg);
		type.set ("assets/music/stage.ogg", AssetType.MUSIC);
		className.set ("assets/images/maps/tile.png", __ASSET__assets_images_maps_tile_png);
		type.set ("assets/images/maps/tile.png", AssetType.IMAGE);
		className.set ("assets/images/icon.png", __ASSET__assets_images_icon_png);
		type.set ("assets/images/icon.png", AssetType.IMAGE);
		className.set ("assets/images/ending_bg.png", __ASSET__assets_images_ending_bg_png);
		type.set ("assets/images/ending_bg.png", AssetType.IMAGE);
		className.set ("assets/images/fire.png", __ASSET__assets_images_fire_png);
		type.set ("assets/images/fire.png", AssetType.IMAGE);
		className.set ("assets/images/spike.png", __ASSET__assets_images_spike_png);
		type.set ("assets/images/spike.png", AssetType.IMAGE);
		className.set ("assets/images/title_logo_big.png", __ASSET__assets_images_title_logo_big_png);
		type.set ("assets/images/title_logo_big.png", AssetType.IMAGE);
		className.set ("assets/images/block.png", __ASSET__assets_images_block_png);
		type.set ("assets/images/block.png", AssetType.IMAGE);
		className.set ("assets/images/splash.png", __ASSET__assets_images_splash_png);
		type.set ("assets/images/splash.png", AssetType.IMAGE);
		className.set ("assets/images/title_logo.png", __ASSET__assets_images_title_logo_png);
		type.set ("assets/images/title_logo.png", AssetType.IMAGE);
		className.set ("assets/images/water.png", __ASSET__assets_images_water_png);
		type.set ("assets/images/water.png", AssetType.IMAGE);
		className.set ("assets/images/title_bg.png", __ASSET__assets_images_title_bg_png);
		type.set ("assets/images/title_bg.png", AssetType.IMAGE);
		className.set ("assets/images/player.piskel", __ASSET__assets_images_player_piskel);
		type.set ("assets/images/player.piskel", AssetType.TEXT);
		className.set ("assets/images/fork.png", __ASSET__assets_images_fork_png);
		type.set ("assets/images/fork.png", AssetType.IMAGE);
		className.set ("assets/images/button.png", __ASSET__assets_images_button_png);
		type.set ("assets/images/button.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/sounds/hurt.wav", __ASSET__assets_sounds_hurt_wav);
		type.set ("assets/sounds/hurt.wav", AssetType.SOUND);
		className.set ("assets/sounds/water_out.ogg", __ASSET__assets_sounds_water_out_ogg);
		type.set ("assets/sounds/water_out.ogg", AssetType.SOUND);
		className.set ("assets/sounds/fire_out.wav", __ASSET__assets_sounds_fire_out_wav);
		type.set ("assets/sounds/fire_out.wav", AssetType.SOUND);
		className.set ("assets/sounds/fire_out.ogg", __ASSET__assets_sounds_fire_out_ogg);
		type.set ("assets/sounds/fire_out.ogg", AssetType.SOUND);
		className.set ("assets/sounds/water_out.wav", __ASSET__assets_sounds_water_out_wav);
		type.set ("assets/sounds/water_out.wav", AssetType.SOUND);
		className.set ("assets/sounds/hurt.ogg", __ASSET__assets_sounds_hurt_ogg);
		type.set ("assets/sounds/hurt.ogg", AssetType.SOUND);
		className.set ("assets/sounds/jump.wav", __ASSET__assets_sounds_jump_wav);
		type.set ("assets/sounds/jump.wav", AssetType.SOUND);
		className.set ("assets/sounds/jump.ogg", __ASSET__assets_sounds_jump_ogg);
		type.set ("assets/sounds/jump.ogg", AssetType.SOUND);
		className.set ("assets/sounds/buttonPressed.wav", __ASSET__assets_sounds_buttonpressed_wav);
		type.set ("assets/sounds/buttonPressed.wav", AssetType.SOUND);
		className.set ("assets/sounds/water_fill.wav", __ASSET__assets_sounds_water_fill_wav);
		type.set ("assets/sounds/water_fill.wav", AssetType.SOUND);
		className.set ("assets/sounds/start.ogg", __ASSET__assets_sounds_start_ogg);
		type.set ("assets/sounds/start.ogg", AssetType.SOUND);
		className.set ("assets/sounds/level_complete.ogg", __ASSET__assets_sounds_level_complete_ogg);
		type.set ("assets/sounds/level_complete.ogg", AssetType.SOUND);
		className.set ("assets/sounds/grounded.wav", __ASSET__assets_sounds_grounded_wav);
		type.set ("assets/sounds/grounded.wav", AssetType.SOUND);
		className.set ("assets/sounds/grounded.ogg", __ASSET__assets_sounds_grounded_ogg);
		type.set ("assets/sounds/grounded.ogg", AssetType.SOUND);
		className.set ("assets/sounds/level_complete.wav", __ASSET__assets_sounds_level_complete_wav);
		type.set ("assets/sounds/level_complete.wav", AssetType.SOUND);
		className.set ("assets/sounds/start.wav", __ASSET__assets_sounds_start_wav);
		type.set ("assets/sounds/start.wav", AssetType.SOUND);
		className.set ("assets/sounds/water_fill.ogg", __ASSET__assets_sounds_water_fill_ogg);
		type.set ("assets/sounds/water_fill.ogg", AssetType.SOUND);
		className.set ("assets/sounds/buttonPressed.ogg", __ASSET__assets_sounds_buttonpressed_ogg);
		type.set ("assets/sounds/buttonPressed.ogg", AssetType.SOUND);
		className.set ("assets/sounds/block_move.ogg", __ASSET__assets_sounds_block_move_ogg);
		type.set ("assets/sounds/block_move.ogg", AssetType.SOUND);
		className.set ("assets/sounds/block_move.wav", __ASSET__assets_sounds_block_move_wav);
		type.set ("assets/sounds/block_move.wav", AssetType.SOUND);
		className.set ("assets/font/PressStart2P.svg", __ASSET__assets_font_pressstart2p_svg);
		type.set ("assets/font/PressStart2P.svg", AssetType.TEXT);
		className.set ("assets/font/PressStart2P.woff", __ASSET__assets_font_pressstart2p_woff);
		type.set ("assets/font/PressStart2P.woff", AssetType.BINARY);
		className.set ("assets/font/PressStart2P.ttf", __ASSET__assets_font_pressstart2p_ttf);
		type.set ("assets/font/PressStart2P.ttf", AssetType.FONT);
		className.set ("assets/font/PressStart2P.eot", __ASSET__assets_font_pressstart2p_eot);
		type.set ("assets/font/PressStart2P.eot", AssetType.BINARY);
		className.set ("assets/data/maps/test.tmx", __ASSET__assets_data_maps_test_tmx);
		type.set ("assets/data/maps/test.tmx", AssetType.TEXT);
		className.set ("assets/data/maps/stage0.tmx", __ASSET__assets_data_maps_stage0_tmx);
		type.set ("assets/data/maps/stage0.tmx", AssetType.TEXT);
		className.set ("assets/data/maps/stage1.tmx", __ASSET__assets_data_maps_stage1_tmx);
		type.set ("assets/data/maps/stage1.tmx", AssetType.TEXT);
		className.set ("assets/data/maps/stage3.tmx", __ASSET__assets_data_maps_stage3_tmx);
		type.set ("assets/data/maps/stage3.tmx", AssetType.TEXT);
		className.set ("assets/data/maps/stage2.tmx", __ASSET__assets_data_maps_stage2_tmx);
		type.set ("assets/data/maps/stage2.tmx", AssetType.TEXT);
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/dropdown_mark.png", __ASSET__flixel_flixel_ui_img_dropdown_mark_png);
		type.set ("flixel/flixel-ui/img/dropdown_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/plus_mark.png", __ASSET__flixel_flixel_ui_img_plus_mark_png);
		type.set ("flixel/flixel-ui/img/plus_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/radio.png", __ASSET__flixel_flixel_ui_img_radio_png);
		type.set ("flixel/flixel-ui/img/radio.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_left.png", __ASSET__flixel_flixel_ui_img_button_arrow_left_png);
		type.set ("flixel/flixel-ui/img/button_arrow_left.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_thin.png", __ASSET__flixel_flixel_ui_img_button_thin_png);
		type.set ("flixel/flixel-ui/img/button_thin.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/tab.png", __ASSET__flixel_flixel_ui_img_tab_png);
		type.set ("flixel/flixel-ui/img/tab.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/finger_big.png", __ASSET__flixel_flixel_ui_img_finger_big_png);
		type.set ("flixel/flixel-ui/img/finger_big.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/invis.png", __ASSET__flixel_flixel_ui_img_invis_png);
		type.set ("flixel/flixel-ui/img/invis.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome_inset.png", __ASSET__flixel_flixel_ui_img_chrome_inset_png);
		type.set ("flixel/flixel-ui/img/chrome_inset.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/tooltip_arrow.png", __ASSET__flixel_flixel_ui_img_tooltip_arrow_png);
		type.set ("flixel/flixel-ui/img/tooltip_arrow.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_right.png", __ASSET__flixel_flixel_ui_img_button_arrow_right_png);
		type.set ("flixel/flixel-ui/img/button_arrow_right.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/radio_dot.png", __ASSET__flixel_flixel_ui_img_radio_dot_png);
		type.set ("flixel/flixel-ui/img/radio_dot.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome.png", __ASSET__flixel_flixel_ui_img_chrome_png);
		type.set ("flixel/flixel-ui/img/chrome.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/check_box.png", __ASSET__flixel_flixel_ui_img_check_box_png);
		type.set ("flixel/flixel-ui/img/check_box.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_toggle.png", __ASSET__flixel_flixel_ui_img_button_toggle_png);
		type.set ("flixel/flixel-ui/img/button_toggle.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_up.png", __ASSET__flixel_flixel_ui_img_button_arrow_up_png);
		type.set ("flixel/flixel-ui/img/button_arrow_up.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/minus_mark.png", __ASSET__flixel_flixel_ui_img_minus_mark_png);
		type.set ("flixel/flixel-ui/img/minus_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome_flat.png", __ASSET__flixel_flixel_ui_img_chrome_flat_png);
		type.set ("flixel/flixel-ui/img/chrome_flat.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/swatch.png", __ASSET__flixel_flixel_ui_img_swatch_png);
		type.set ("flixel/flixel-ui/img/swatch.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/chrome_light.png", __ASSET__flixel_flixel_ui_img_chrome_light_png);
		type.set ("flixel/flixel-ui/img/chrome_light.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/hilight.png", __ASSET__flixel_flixel_ui_img_hilight_png);
		type.set ("flixel/flixel-ui/img/hilight.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/check_mark.png", __ASSET__flixel_flixel_ui_img_check_mark_png);
		type.set ("flixel/flixel-ui/img/check_mark.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/tab_back.png", __ASSET__flixel_flixel_ui_img_tab_back_png);
		type.set ("flixel/flixel-ui/img/tab_back.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/box.png", __ASSET__flixel_flixel_ui_img_box_png);
		type.set ("flixel/flixel-ui/img/box.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/finger_small.png", __ASSET__flixel_flixel_ui_img_finger_small_png);
		type.set ("flixel/flixel-ui/img/finger_small.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button.png", __ASSET__flixel_flixel_ui_img_button_png);
		type.set ("flixel/flixel-ui/img/button.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/img/button_arrow_down.png", __ASSET__flixel_flixel_ui_img_button_arrow_down_png);
		type.set ("flixel/flixel-ui/img/button_arrow_down.png", AssetType.IMAGE);
		className.set ("flixel/flixel-ui/xml/default_popup.xml", __ASSET__flixel_flixel_ui_xml_default_popup_xml);
		type.set ("flixel/flixel-ui/xml/default_popup.xml", AssetType.TEXT);
		className.set ("flixel/flixel-ui/xml/default_loading_screen.xml", __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml);
		type.set ("flixel/flixel-ui/xml/default_loading_screen.xml", AssetType.TEXT);
		className.set ("flixel/flixel-ui/xml/defaults.xml", __ASSET__flixel_flixel_ui_xml_defaults_xml);
		type.set ("flixel/flixel-ui/xml/defaults.xml", AssetType.TEXT);
		
		
		#elseif html5
		
		var id;
		id = "assets/music/stage.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/music/stage.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/images/maps/tile.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/icon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ending_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/fire.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/spike.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/title_logo_big.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/block.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/splash.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/title_logo.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/water.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/title_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.piskel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/fork.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/sounds/hurt.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/water_out.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/fire_out.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/fire_out.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/water_out.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/hurt.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/jump.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/jump.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/buttonPressed.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/water_fill.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/start.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/level_complete.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/grounded.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/grounded.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/level_complete.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/start.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/water_fill.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/buttonPressed.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/block_move.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/block_move.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/font/PressStart2P.svg";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/font/PressStart2P.woff";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/font/PressStart2P.ttf";
		className.set (id, __ASSET__assets_font_pressstart2p_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/font/PressStart2P.eot";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/data/maps/test.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/maps/stage0.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/maps/stage1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/maps/stage3.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/maps/stage2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "flixel/sounds/beep.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/flixel.ogg";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__flixel_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/fonts/monsterrat.ttf";
		className.set (id, __ASSET__flixel_fonts_monsterrat_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/images/ui/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/images/logo/default.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/dropdown_mark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/plus_mark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/radio.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_left.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_thin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/tab.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/finger_big.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/invis.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome_inset.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/tooltip_arrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_right.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/radio_dot.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/check_box.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_toggle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_up.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/minus_mark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome_flat.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/swatch.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/chrome_light.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/hilight.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/check_mark.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/tab_back.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/box.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/finger_small.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/img/button_arrow_down.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/flixel-ui/xml/default_popup.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "flixel/flixel-ui/xml/default_loading_screen.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "flixel/flixel-ui/xml/defaults.xml";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/music/stage.wav", __ASSET__assets_music_stage_wav);
		type.set ("assets/music/stage.wav", AssetType.SOUND);
		
		className.set ("assets/music/stage.ogg", __ASSET__assets_music_stage_ogg);
		type.set ("assets/music/stage.ogg", AssetType.MUSIC);
		
		className.set ("assets/images/maps/tile.png", __ASSET__assets_images_maps_tile_png);
		type.set ("assets/images/maps/tile.png", AssetType.IMAGE);
		
		className.set ("assets/images/icon.png", __ASSET__assets_images_icon_png);
		type.set ("assets/images/icon.png", AssetType.IMAGE);
		
		className.set ("assets/images/ending_bg.png", __ASSET__assets_images_ending_bg_png);
		type.set ("assets/images/ending_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/fire.png", __ASSET__assets_images_fire_png);
		type.set ("assets/images/fire.png", AssetType.IMAGE);
		
		className.set ("assets/images/spike.png", __ASSET__assets_images_spike_png);
		type.set ("assets/images/spike.png", AssetType.IMAGE);
		
		className.set ("assets/images/title_logo_big.png", __ASSET__assets_images_title_logo_big_png);
		type.set ("assets/images/title_logo_big.png", AssetType.IMAGE);
		
		className.set ("assets/images/block.png", __ASSET__assets_images_block_png);
		type.set ("assets/images/block.png", AssetType.IMAGE);
		
		className.set ("assets/images/splash.png", __ASSET__assets_images_splash_png);
		type.set ("assets/images/splash.png", AssetType.IMAGE);
		
		className.set ("assets/images/title_logo.png", __ASSET__assets_images_title_logo_png);
		type.set ("assets/images/title_logo.png", AssetType.IMAGE);
		
		className.set ("assets/images/water.png", __ASSET__assets_images_water_png);
		type.set ("assets/images/water.png", AssetType.IMAGE);
		
		className.set ("assets/images/title_bg.png", __ASSET__assets_images_title_bg_png);
		type.set ("assets/images/title_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.piskel", __ASSET__assets_images_player_piskel);
		type.set ("assets/images/player.piskel", AssetType.TEXT);
		
		className.set ("assets/images/fork.png", __ASSET__assets_images_fork_png);
		type.set ("assets/images/fork.png", AssetType.IMAGE);
		
		className.set ("assets/images/button.png", __ASSET__assets_images_button_png);
		type.set ("assets/images/button.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/sounds/hurt.wav", __ASSET__assets_sounds_hurt_wav);
		type.set ("assets/sounds/hurt.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/water_out.ogg", __ASSET__assets_sounds_water_out_ogg);
		type.set ("assets/sounds/water_out.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/fire_out.wav", __ASSET__assets_sounds_fire_out_wav);
		type.set ("assets/sounds/fire_out.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/fire_out.ogg", __ASSET__assets_sounds_fire_out_ogg);
		type.set ("assets/sounds/fire_out.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/water_out.wav", __ASSET__assets_sounds_water_out_wav);
		type.set ("assets/sounds/water_out.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/hurt.ogg", __ASSET__assets_sounds_hurt_ogg);
		type.set ("assets/sounds/hurt.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/jump.wav", __ASSET__assets_sounds_jump_wav);
		type.set ("assets/sounds/jump.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/jump.ogg", __ASSET__assets_sounds_jump_ogg);
		type.set ("assets/sounds/jump.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/buttonPressed.wav", __ASSET__assets_sounds_buttonpressed_wav);
		type.set ("assets/sounds/buttonPressed.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/water_fill.wav", __ASSET__assets_sounds_water_fill_wav);
		type.set ("assets/sounds/water_fill.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/start.ogg", __ASSET__assets_sounds_start_ogg);
		type.set ("assets/sounds/start.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/level_complete.ogg", __ASSET__assets_sounds_level_complete_ogg);
		type.set ("assets/sounds/level_complete.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/grounded.wav", __ASSET__assets_sounds_grounded_wav);
		type.set ("assets/sounds/grounded.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/grounded.ogg", __ASSET__assets_sounds_grounded_ogg);
		type.set ("assets/sounds/grounded.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/level_complete.wav", __ASSET__assets_sounds_level_complete_wav);
		type.set ("assets/sounds/level_complete.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/start.wav", __ASSET__assets_sounds_start_wav);
		type.set ("assets/sounds/start.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/water_fill.ogg", __ASSET__assets_sounds_water_fill_ogg);
		type.set ("assets/sounds/water_fill.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/buttonPressed.ogg", __ASSET__assets_sounds_buttonpressed_ogg);
		type.set ("assets/sounds/buttonPressed.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/block_move.ogg", __ASSET__assets_sounds_block_move_ogg);
		type.set ("assets/sounds/block_move.ogg", AssetType.SOUND);
		
		className.set ("assets/sounds/block_move.wav", __ASSET__assets_sounds_block_move_wav);
		type.set ("assets/sounds/block_move.wav", AssetType.SOUND);
		
		className.set ("assets/font/PressStart2P.svg", __ASSET__assets_font_pressstart2p_svg);
		type.set ("assets/font/PressStart2P.svg", AssetType.TEXT);
		
		className.set ("assets/font/PressStart2P.woff", __ASSET__assets_font_pressstart2p_woff);
		type.set ("assets/font/PressStart2P.woff", AssetType.BINARY);
		
		className.set ("assets/font/PressStart2P.ttf", __ASSET__assets_font_pressstart2p_ttf);
		type.set ("assets/font/PressStart2P.ttf", AssetType.FONT);
		
		className.set ("assets/font/PressStart2P.eot", __ASSET__assets_font_pressstart2p_eot);
		type.set ("assets/font/PressStart2P.eot", AssetType.BINARY);
		
		className.set ("assets/data/maps/test.tmx", __ASSET__assets_data_maps_test_tmx);
		type.set ("assets/data/maps/test.tmx", AssetType.TEXT);
		
		className.set ("assets/data/maps/stage0.tmx", __ASSET__assets_data_maps_stage0_tmx);
		type.set ("assets/data/maps/stage0.tmx", AssetType.TEXT);
		
		className.set ("assets/data/maps/stage1.tmx", __ASSET__assets_data_maps_stage1_tmx);
		type.set ("assets/data/maps/stage1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/maps/stage3.tmx", __ASSET__assets_data_maps_stage3_tmx);
		type.set ("assets/data/maps/stage3.tmx", AssetType.TEXT);
		
		className.set ("assets/data/maps/stage2.tmx", __ASSET__assets_data_maps_stage2_tmx);
		type.set ("assets/data/maps/stage2.tmx", AssetType.TEXT);
		
		className.set ("flixel/sounds/beep.ogg", __ASSET__flixel_sounds_beep_ogg);
		type.set ("flixel/sounds/beep.ogg", AssetType.SOUND);
		
		className.set ("flixel/sounds/flixel.ogg", __ASSET__flixel_sounds_flixel_ogg);
		type.set ("flixel/sounds/flixel.ogg", AssetType.SOUND);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/dropdown_mark.png", __ASSET__flixel_flixel_ui_img_dropdown_mark_png);
		type.set ("flixel/flixel-ui/img/dropdown_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/plus_mark.png", __ASSET__flixel_flixel_ui_img_plus_mark_png);
		type.set ("flixel/flixel-ui/img/plus_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/radio.png", __ASSET__flixel_flixel_ui_img_radio_png);
		type.set ("flixel/flixel-ui/img/radio.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_left.png", __ASSET__flixel_flixel_ui_img_button_arrow_left_png);
		type.set ("flixel/flixel-ui/img/button_arrow_left.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_thin.png", __ASSET__flixel_flixel_ui_img_button_thin_png);
		type.set ("flixel/flixel-ui/img/button_thin.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/tab.png", __ASSET__flixel_flixel_ui_img_tab_png);
		type.set ("flixel/flixel-ui/img/tab.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/finger_big.png", __ASSET__flixel_flixel_ui_img_finger_big_png);
		type.set ("flixel/flixel-ui/img/finger_big.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/invis.png", __ASSET__flixel_flixel_ui_img_invis_png);
		type.set ("flixel/flixel-ui/img/invis.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome_inset.png", __ASSET__flixel_flixel_ui_img_chrome_inset_png);
		type.set ("flixel/flixel-ui/img/chrome_inset.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/tooltip_arrow.png", __ASSET__flixel_flixel_ui_img_tooltip_arrow_png);
		type.set ("flixel/flixel-ui/img/tooltip_arrow.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_right.png", __ASSET__flixel_flixel_ui_img_button_arrow_right_png);
		type.set ("flixel/flixel-ui/img/button_arrow_right.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/radio_dot.png", __ASSET__flixel_flixel_ui_img_radio_dot_png);
		type.set ("flixel/flixel-ui/img/radio_dot.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome.png", __ASSET__flixel_flixel_ui_img_chrome_png);
		type.set ("flixel/flixel-ui/img/chrome.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/check_box.png", __ASSET__flixel_flixel_ui_img_check_box_png);
		type.set ("flixel/flixel-ui/img/check_box.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_toggle.png", __ASSET__flixel_flixel_ui_img_button_toggle_png);
		type.set ("flixel/flixel-ui/img/button_toggle.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_up.png", __ASSET__flixel_flixel_ui_img_button_arrow_up_png);
		type.set ("flixel/flixel-ui/img/button_arrow_up.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/minus_mark.png", __ASSET__flixel_flixel_ui_img_minus_mark_png);
		type.set ("flixel/flixel-ui/img/minus_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome_flat.png", __ASSET__flixel_flixel_ui_img_chrome_flat_png);
		type.set ("flixel/flixel-ui/img/chrome_flat.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/swatch.png", __ASSET__flixel_flixel_ui_img_swatch_png);
		type.set ("flixel/flixel-ui/img/swatch.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/chrome_light.png", __ASSET__flixel_flixel_ui_img_chrome_light_png);
		type.set ("flixel/flixel-ui/img/chrome_light.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/hilight.png", __ASSET__flixel_flixel_ui_img_hilight_png);
		type.set ("flixel/flixel-ui/img/hilight.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/check_mark.png", __ASSET__flixel_flixel_ui_img_check_mark_png);
		type.set ("flixel/flixel-ui/img/check_mark.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/tab_back.png", __ASSET__flixel_flixel_ui_img_tab_back_png);
		type.set ("flixel/flixel-ui/img/tab_back.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/box.png", __ASSET__flixel_flixel_ui_img_box_png);
		type.set ("flixel/flixel-ui/img/box.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/finger_small.png", __ASSET__flixel_flixel_ui_img_finger_small_png);
		type.set ("flixel/flixel-ui/img/finger_small.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button.png", __ASSET__flixel_flixel_ui_img_button_png);
		type.set ("flixel/flixel-ui/img/button.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/img/button_arrow_down.png", __ASSET__flixel_flixel_ui_img_button_arrow_down_png);
		type.set ("flixel/flixel-ui/img/button_arrow_down.png", AssetType.IMAGE);
		
		className.set ("flixel/flixel-ui/xml/default_popup.xml", __ASSET__flixel_flixel_ui_xml_default_popup_xml);
		type.set ("flixel/flixel-ui/xml/default_popup.xml", AssetType.TEXT);
		
		className.set ("flixel/flixel-ui/xml/default_loading_screen.xml", __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml);
		type.set ("flixel/flixel-ui/xml/default_loading_screen.xml", AssetType.TEXT);
		
		className.set ("flixel/flixel-ui/xml/defaults.xml", __ASSET__flixel_flixel_ui_xml_defaults_xml);
		type.set ("flixel/flixel-ui/xml/defaults.xml", AssetType.TEXT);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == TEXT && assetType == BINARY) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), Bytes));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):Bytes {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return Bytes.ofData (cast (Type.createInstance (className.get (id), []), flash.utils.ByteArray));
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return Bytes.ofData (bitmapData.getPixels (bitmapData.rect));
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), Bytes);
		
		#elseif html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Bytes);
		else return Bytes.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes.getString (0, bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.getString (0, bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<Bytes> {
		
		var promise = new Promise<Bytes> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofData (event.currentTarget.data);
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			promise.completeWith (request.load (path.get (id) + "?" + Assets.cache.version));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Bytes> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id) + "?" + Assets.cache.version;
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = Bytes.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = Bytes.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = Bytes.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = Bytes.readFile ("../Resources/manifest");
			#elseif (ios || tvos)
			var bytes = Bytes.readFile ("assets/manifest");
			#else
			var bytes = Bytes.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				if (bytes.length > 0) {
					
					var data = bytes.getString (0, bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if (ios || tvos)
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			var future = request.load (path.get (id) + "?" + Assets.cache.version);
			future.onProgress (function (progress) promise.progress (progress));
			future.onError (function (msg) promise.error (msg));
			future.onComplete (function (bytes) promise.complete (bytes.getString (0, bytes.length)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.getString (0, bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_music_stage_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_music_stage_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_maps_tile_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ending_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_fire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_spike_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_title_logo_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_splash_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_title_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_water_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_title_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_piskel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_fork_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hurt_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_water_out_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_fire_out_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_fire_out_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_water_out_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hurt_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_jump_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_jump_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_buttonpressed_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_water_fill_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_start_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_level_complete_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_grounded_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_grounded_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_level_complete_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_start_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_water_fill_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_buttonpressed_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_block_move_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_block_move_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_pressstart2p_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_pressstart2p_woff extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_pressstart2p_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_font_pressstart2p_eot extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_maps_test_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_maps_stage0_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_maps_stage1_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_maps_stage3_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_maps_stage2_tmx extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }


#elseif html5








































@:keep #if display private #end class __ASSET__assets_font_pressstart2p_ttf extends lime.text.Font { public function new () { super (); name = "Press Start 2P"; } } 








@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 


































#else



#if (windows || mac || linux || cpp)


@:file("assets/music/stage.wav") #if display private #end class __ASSET__assets_music_stage_wav extends lime.utils.Bytes {}
@:file("assets/music/stage.ogg") #if display private #end class __ASSET__assets_music_stage_ogg extends lime.utils.Bytes {}
@:image("assets/images/maps/tile.png") #if display private #end class __ASSET__assets_images_maps_tile_png extends lime.graphics.Image {}
@:image("assets/images/icon.png") #if display private #end class __ASSET__assets_images_icon_png extends lime.graphics.Image {}
@:image("assets/images/ending_bg.png") #if display private #end class __ASSET__assets_images_ending_bg_png extends lime.graphics.Image {}
@:image("assets/images/fire.png") #if display private #end class __ASSET__assets_images_fire_png extends lime.graphics.Image {}
@:image("assets/images/spike.png") #if display private #end class __ASSET__assets_images_spike_png extends lime.graphics.Image {}
@:image("assets/images/title_logo_big.png") #if display private #end class __ASSET__assets_images_title_logo_big_png extends lime.graphics.Image {}
@:image("assets/images/block.png") #if display private #end class __ASSET__assets_images_block_png extends lime.graphics.Image {}
@:image("assets/images/splash.png") #if display private #end class __ASSET__assets_images_splash_png extends lime.graphics.Image {}
@:image("assets/images/title_logo.png") #if display private #end class __ASSET__assets_images_title_logo_png extends lime.graphics.Image {}
@:image("assets/images/water.png") #if display private #end class __ASSET__assets_images_water_png extends lime.graphics.Image {}
@:image("assets/images/title_bg.png") #if display private #end class __ASSET__assets_images_title_bg_png extends lime.graphics.Image {}
@:file("assets/images/player.piskel") #if display private #end class __ASSET__assets_images_player_piskel extends lime.utils.Bytes {}
@:image("assets/images/fork.png") #if display private #end class __ASSET__assets_images_fork_png extends lime.graphics.Image {}
@:image("assets/images/button.png") #if display private #end class __ASSET__assets_images_button_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:file("assets/sounds/hurt.wav") #if display private #end class __ASSET__assets_sounds_hurt_wav extends lime.utils.Bytes {}
@:file("assets/sounds/water_out.ogg") #if display private #end class __ASSET__assets_sounds_water_out_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/fire_out.wav") #if display private #end class __ASSET__assets_sounds_fire_out_wav extends lime.utils.Bytes {}
@:file("assets/sounds/fire_out.ogg") #if display private #end class __ASSET__assets_sounds_fire_out_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/water_out.wav") #if display private #end class __ASSET__assets_sounds_water_out_wav extends lime.utils.Bytes {}
@:file("assets/sounds/hurt.ogg") #if display private #end class __ASSET__assets_sounds_hurt_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/jump.wav") #if display private #end class __ASSET__assets_sounds_jump_wav extends lime.utils.Bytes {}
@:file("assets/sounds/jump.ogg") #if display private #end class __ASSET__assets_sounds_jump_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/buttonPressed.wav") #if display private #end class __ASSET__assets_sounds_buttonpressed_wav extends lime.utils.Bytes {}
@:file("assets/sounds/water_fill.wav") #if display private #end class __ASSET__assets_sounds_water_fill_wav extends lime.utils.Bytes {}
@:file("assets/sounds/start.ogg") #if display private #end class __ASSET__assets_sounds_start_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/level_complete.ogg") #if display private #end class __ASSET__assets_sounds_level_complete_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/grounded.wav") #if display private #end class __ASSET__assets_sounds_grounded_wav extends lime.utils.Bytes {}
@:file("assets/sounds/grounded.ogg") #if display private #end class __ASSET__assets_sounds_grounded_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/level_complete.wav") #if display private #end class __ASSET__assets_sounds_level_complete_wav extends lime.utils.Bytes {}
@:file("assets/sounds/start.wav") #if display private #end class __ASSET__assets_sounds_start_wav extends lime.utils.Bytes {}
@:file("assets/sounds/water_fill.ogg") #if display private #end class __ASSET__assets_sounds_water_fill_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/buttonPressed.ogg") #if display private #end class __ASSET__assets_sounds_buttonpressed_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/block_move.ogg") #if display private #end class __ASSET__assets_sounds_block_move_ogg extends lime.utils.Bytes {}
@:file("assets/sounds/block_move.wav") #if display private #end class __ASSET__assets_sounds_block_move_wav extends lime.utils.Bytes {}
@:file("assets/font/PressStart2P.svg") #if display private #end class __ASSET__assets_font_pressstart2p_svg extends lime.utils.Bytes {}
@:file("assets/font/PressStart2P.woff") #if display private #end class __ASSET__assets_font_pressstart2p_woff extends lime.utils.Bytes {}
@:font("assets/font/PressStart2P.ttf") #if display private #end class __ASSET__assets_font_pressstart2p_ttf extends lime.text.Font {}
@:file("assets/font/PressStart2P.eot") #if display private #end class __ASSET__assets_font_pressstart2p_eot extends lime.utils.Bytes {}
@:file("assets/data/maps/test.tmx") #if display private #end class __ASSET__assets_data_maps_test_tmx extends lime.utils.Bytes {}
@:file("assets/data/maps/stage0.tmx") #if display private #end class __ASSET__assets_data_maps_stage0_tmx extends lime.utils.Bytes {}
@:file("assets/data/maps/stage1.tmx") #if display private #end class __ASSET__assets_data_maps_stage1_tmx extends lime.utils.Bytes {}
@:file("assets/data/maps/stage3.tmx") #if display private #end class __ASSET__assets_data_maps_stage3_tmx extends lime.utils.Bytes {}
@:file("assets/data/maps/stage2.tmx") #if display private #end class __ASSET__assets_data_maps_stage2_tmx extends lime.utils.Bytes {}
@:file("/usr/local/lib/haxe/lib/flixel/4,3,0/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends lime.utils.Bytes {}
@:file("/usr/local/lib/haxe/lib/flixel/4,3,0/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends lime.utils.Bytes {}
@:font("/usr/local/lib/haxe/lib/flixel/4,3,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("/usr/local/lib/haxe/lib/flixel/4,3,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("/usr/local/lib/haxe/lib/flixel/4,3,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel/4,3,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/dropdown_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/plus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/radio.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button_arrow_left.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button_thin.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/tab.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/finger_big.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/invis.png") #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/chrome_inset.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/tooltip_arrow.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button_arrow_right.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/radio_dot.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/chrome.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/check_box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button_toggle.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button_arrow_up.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/minus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/chrome_flat.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/swatch.png") #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/chrome_light.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/hilight.png") #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/check_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/tab_back.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/finger_small.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/images/button_arrow_down.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:file("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/xml/default_popup.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends lime.utils.Bytes {}
@:file("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/xml/default_loading_screen.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends lime.utils.Bytes {}
@:file("/usr/local/lib/haxe/lib/flixel-ui/2,2,0/assets/xml/defaults.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends lime.utils.Bytes {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__assets_font_pressstart2p_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_font_pressstart2p_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end