package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxSpriteUtil.LineStyle;

/**
 * ...
 * @author Brandon
 */
class Ray extends FlxSprite {
  private var _color:Int;
  private var _thickness:Int = 5;

  public function new(color:Int) {
    super(0, 0);
    _color = color;
    this.kill();
    this.x = 0;
    this.y = 0;
    var width = FlxG.width;
    var height = FlxG.height;
    this.makeGraphic(width, height, 0x00000000);
  }

  public function setColor(color:Int):Void {
    _color = color;
  }

  public function setThickness(thickness:Int):Void {
    _thickness = thickness;
  }

  public function update2(start:FlxPoint, end:FlxPoint, strength:Float, percent:Float):Void {
    super.reset(0, 0);
    FlxSpriteUtil.fill(this, 0x00000000);
    //var a = Std.int(strength * 255);
    var color = (Math.round(strength * 255) << 24) | _color;
    var s:LineStyle = { color: color, thickness: _thickness };
    //FlxSpriteUtil.drawLine(this, start.x, start.y, end.x, end.y, s);
    var v = new FlxPoint(end.x * 2, end.y * 2);
    var step = 0.1;
    var count = Math.round((1 - percent) * 20);
    var prev_point = start;
    //FlxG.log.add("Start " + count);
    //FlxG.log.add("v.x: " + v.x + ", v.y: " + v.y);
    for (i in 0...count) {
      //var x = start.x + v.x * t;
      //var y = start.y + v.y * t + 800 * t * t;
      //FlxG.log.add("t: " + t + ", x: " + x + ", y: " + y);
      //FlxG.log.add(i);
      var x = prev_point.x + v.x * step;
      var y = prev_point.y + v.y * step;
      v.y += 800 * step;
      FlxSpriteUtil.drawLine(this, prev_point.x, prev_point.y, x, y, s);
      prev_point.x = x; prev_point.y = y;
    }
  }
}
