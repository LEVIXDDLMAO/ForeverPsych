package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

// this comes from my own repo but its just like the foreverassets file from forever engine also, try not copying the same exact code without making it compatible with the engine - sanco
class Ratings
{
    public static function generateCombo(number:String, allSicks:Bool, isPixel:Bool, negative:Bool, createdColor:FlxColor, scoreInt:Int):FlxSprite
    {
        var width = 100;
        var height = 140;
        // if you want to change the texture (simply love, forever, default) change the thing after UI/
        // for ex = UI/simplylove/...
        var path = Paths.image('UI/default/${PlayState.isPixelStage ? "pixel" : "base"}/combo');

        if (isPixel)
        {
            width = 10;
            height = 12;
        }

        var newSprite:FlxSprite = new FlxSprite().loadGraphic(path, true, width, height);
        newSprite.alpha = 1;
        newSprite.screenCenter();
        newSprite.x += (43 * scoreInt) + 20;
        newSprite.y += 60;

        newSprite.visible = (!ClientPrefs.hideHud);
        newSprite.x += ClientPrefs.comboOffset[2];
        newSprite.y -= ClientPrefs.comboOffset[3];

        newSprite.color = FlxColor.WHITE;
        if (negative)
            newSprite.color = createdColor;

        newSprite.animation.add('base',
        [
            (Std.parseInt(number) != null ? Std.parseInt(number) + 1 : 0) + (!allSicks ? 0 : 11)
        ], 0, false);
        newSprite.animation.play('base');

        if (isPixel)
            newSprite.setGraphicSize(Std.int(newSprite.width * PlayState.daPixelZoom));
        else
        {
            newSprite.antialiasing = ClientPrefs.globalAntialiasing;
            newSprite.setGraphicSize(Std.int(newSprite.width * 0.5));
        }

        newSprite.updateHitbox();
        newSprite.acceleration.y = FlxG.random.int(200, 300);
        newSprite.velocity.x = FlxG.random.float(-5, 5);
        newSprite.velocity.y -= FlxG.random.int(140, 160);

        return newSprite;
    }

    private static var timings = ["sick", "good", "bad", "shit", "miss"];
    public static function generateRating(ratingName:String, perfectSick:Bool, timing:String, isPixel:Bool):FlxSprite
    {
        var width = 500;
        var height = 163;
        // if you want to change the texture (simply love, forever, default) change the thing after UI/
        // for ex = UI/simplylove/...
        var path = Paths.image('UI/default/${PlayState.isPixelStage ? "pixel" : "base"}/judgements');

        if (isPixel)
        {
            width = 72;
            height = 32;
        }

        var rating:FlxSprite = new FlxSprite().loadGraphic(path, true, width, height);
        rating.alpha = 1;
        rating.screenCenter();
        rating.x = (FlxG.width * 0.55) - 40;
        rating.y -= 60;

        rating.visible = (!ClientPrefs.hideHud);
        rating.x += ClientPrefs.comboOffset[0];
        rating.y -= ClientPrefs.comboOffset[1];

        rating.animation.add('base',
        [
            Std.int((timings.indexOf(ratingName) * 2) + (perfectSick ? 0 : 2) + (timing == "late" ? 1 : 0))
        ], 24, false);
        rating.animation.play('base');

        if (isPixel)
            rating.setGraphicSize(Std.int(rating.width * PlayState.daPixelZoom * 0.7));
        else
        {
            rating.antialiasing = ClientPrefs.globalAntialiasing;
            rating.setGraphicSize(Std.int(rating.width * 0.7));
        }

        rating.updateHitbox();
        rating.acceleration.y = 550;
		rating.velocity.x -= FlxG.random.int(0, 10);
		rating.velocity.y -= FlxG.random.int(140, 175);

        return rating;
    }
}