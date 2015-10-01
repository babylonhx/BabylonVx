package;

import lime.app.Application;
import lime.Assets;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.graphics.RenderContext;
import com.babylonhx.Engine;
import com.babylonhx.Scene;


/**
 * ...
 * @author Brendon Smith
 */

class MainLime extends Application {
	
	var scene:Scene;
	var engine:Engine;
	
	
	public function new() {
		super();	
	}
	
	public override function init (context:RenderContext):Void {
		engine = new Engine(this.window, false);	
		scene = new Scene(engine);
		new samples.BabylonVX(scene);
		engine.width = this.window.width;
		engine.height = this.window.height;
	}
	
	override function onMouseDown(x:Float, y:Float, button:Int) {
		for(f in Engine.mouseDown) {
			f(x, y, button);
		}
	}
	
	override function onMouseUp(x:Float, y:Float, button:Int) {
		for(f in Engine.mouseUp) {
			f();
		}
	}
	
	override function onMouseMove(x:Float, y:Float) {
		for(f in Engine.mouseMove) {
			f(x, y);
		}
	}
	
	override function onMouseWheel(deltaX:Float, deltaY:Float) {
		for (f in Engine.mouseWheel) {
			f(deltaY / 2);
		}
	}
	
	override function onTouchStart(x:Float, y:Float, id:Int) {
		for (f in Engine.touchDown) {
			f(x, y, id);
		}
	}
	
	override function onTouchEnd(x:Float, y:Float, id:Int) {
		for (f in Engine.touchUp) {
			f(x, y, id);
		}
	}
	
	override function onTouchMove(x:Float, y:Float, id:Int) {
		for (f in Engine.touchMove) {
			f(x, y, id);
		}
	}

	override function onKeyUp(keycode:Int, modifier:KeyModifier) {
		for(f in Engine.keyUp) {
			f(keycode);
		}
	}
	
	override function onKeyDown(keycode:Int, modifier:KeyModifier) {
		for(f in Engine.keyDown) {
			f(keycode);
		}
	}
	
	override public function onWindowResize(width:Int, height:Int) {
		engine.width = this.window.width;
		engine.height = this.window.height;
	}
	
	override function update(deltaTime:Int) {
		if(engine != null) 
		engine._renderLoop();		
	}
	
}
