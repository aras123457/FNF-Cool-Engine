package;

import flixel.FlxG;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenflAssets;

class ModPaths {
    static var currentLevel:String = Paths.currentLevel;
    inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

    inline static public function getModFile(file:String, mod:String, type:AssetType = TEXT, ?library:String){
        return getPath('$mod/$file', type, library);
    }

    inline static public function getModTxt(key:String, mod:String, ?library:String){
		return getPath('$mod/data/$key.txt',TEXT,library);
	}

    inline static public function getModXml(key:String, mod:String ,?library:String)
    {
        return getPath('data/$key.xml', TEXT, library);
    }

    inline static public function getModJson(key:String, mod:String, ?library:String){
		return getPath('$mod/data/$key.json',TEXT,library);
	}

    static public function getModSound(key:String, mod:String, ?library:String)
	{
		return getPath('$mod/sounds/$key.$SOUND_EXT', SOUND, library);
	}

    inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
    {
        return getModSound(key + FlxG.random.int(min, max), library);
    }

    inline static public function getModVideo(key:String, mod:String, ?library:String)
	{
		trace('mods/$mod/videos/$key.mp4');
		return getPath('$mod/videos/$key.mp4', BINARY, library);
	}

    inline static public function getModMusic(key:String, mod:String, ?library:String)
	{
		return getPath('$mod/music/$key.$SOUND_EXT', MUSIC, library);
	}

    inline static public function getModVoices(song:String, mod:String)
	{
		trace('Loading VOICES');
		var loadingSong:Bool = true;
		if(loadingSong) {
			trace('Done Loading VOICES!');
			return 'songs:mods/$mod/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';}
		else {
			trace('ERROR Loading INST :c');
			return 'defaultsong:mods/$mod/defaultsong/Voices.$SOUND_EXT';}
	}

    inline static public function getModInst(song:String, mod:String)
	{
		trace('Loading INST');
		var loadingSong:Bool = true;
		if(loadingSong) {
			trace('Done Loading INST!');
			return 'songs:mods/$mod/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';}
		else {
			trace('ERROR Loading INST :c');
			return 'defaultsong:mods/$mod/defaultsong/Inst.$SOUND_EXT';}
	}
    
    inline static public function getModImage(key:String, mod:String, ?library:String){
		return getPath('$mod/data/$key.json',IMAGE,library);
	}

    inline static public function getModFont(key:String,mod:String)
	{
		return 'mods/$mod/fonts/$key';
	}

    static public function getPath(file:String, type:AssetType, ?library:Null<String>)
    {
        if (library != null)
            return getModLibPath(file, library);
        
        if (currentLevel != null)
        {
            var path = getLibraryMod(file, currentLevel);
            if (OpenflAssets.exists(path, type))
                return path;
        }
        
        return getPreloadMod(file);
    }

    static public function getModLibPath(file:String, library = "images")
    {
        return if (library == "images" || library == "default") getPreloadMod(file); else getLibraryMod(file, library);
    }

    inline static function getLibraryMod(file:String, library:String)
    {
        return '$library:$library/$file';
    }

    inline static public function getPreloadMod(file:String)
	{
		return 'mods/$file';
	}
}