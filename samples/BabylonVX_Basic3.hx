package samples;

import com.babylonhx.cameras.FreeCamera;
import com.babylonhx.lights.PointLight;
import com.babylonhx.lights.HemisphericLight;
import com.babylonhx.materials.StandardMaterial;
import com.babylonhx.math.Color3;
import com.babylonhx.math.Vector3;
import com.babylonhx.mesh.Mesh;
import com.babylonhx.Scene;
import com.babylonvx.utility.Utils;
import com.babylonvx.*;

/**
 * ...
 * @author Brendon Smith
 */
 @:expose('BabylonVX_Basic3') class BabylonVX_Basic3 {

 	public var _worldController:WorldController;
 	public var camera:FreeCamera;
 	public var _scene:Scene;



 	public function randomInt(minimum:Int, maximum:Int):Int {
 		return Math.floor(Math.random() * (maximum - minimum + 1)) + minimum;
 	}

 	public function generateVoxels(dims):Dynamic {
 		var voxels:Array<Dynamic> = [];
 		for (i in 0...(dims[0]*dims[1]*dims[2]) ) {
 			var rand = randomInt(1,10);
 			if (rand == 3 || rand == 4){
 				voxels.push([rand, {isTransparent: true}]);
 				} else {
 					voxels.push([rand, {isTransparent: false}]);
 				}
 			}
 			return voxels;
 		}


 		public function new(scene:Scene) {
 			this._scene = scene;
 			untyped window._scene = scene;
 			_scene.clearColor = new Color3(0, 1, 0);
 			this.camera = new FreeCamera("Camera", new Vector3(0, 0, -7), scene);
 			var light = new HemisphericLight("light1", new Vector3(0, 1, 0), scene);
 			this.camera.setTarget(new Vector3(0, 0, 0));
 			this.camera.attachControl(this, false);

			
			var chunk = new VoxelMesh('vX', scene);
			
			chunk.coloringFunction = function(id, meta) {
				return Utils.hex2rgb(id.toString(16));	
			}
			

			chunk.makeVoxels([0, 0, 0], [32,32,32], function(i,j,k) {
			    var h0 = 3.0 * Math.sin(Math.PI * i / 12.0 - Math.PI * k * 0.1) + 27;    
			    if(j > h0+1) {
			      return 0;
			    }
			    if(h0 <= j) {
			      return 0x23dd31;
			    }
			    var h1 = 2.0 * Math.sin(Math.PI * i * 0.25 - Math.PI * k * 0.3) + 20;
			    if(h1 <= j) {
			      return 0x964B00;
			    }
			    if(2 < j) {
			      return Math.random() < 0.1 ? 0x222222 : 0xaaaaaa;
			    }
			    return 0xff0000;
		  });

		chunk.updateMesh();

		scene.getEngine().runRenderLoop(function () {
			scene.render();
		});
	}

}
