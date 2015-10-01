package samples;

import com.babylonhx.cameras.FreeCamera;
import com.babylonhx.lights.PointLight;
import com.babylonhx.lights.HemisphericLight;
import com.babylonhx.materials.StandardMaterial;
import com.babylonhx.math.Color3;
import com.babylonhx.math.Vector3;
import com.babylonhx.mesh.Mesh;
import com.babylonhx.Scene;
import com.babylonvx.*;

/**
 * ...
 * @author Brendon Smith
 */
@:expose('BabylonVX') class BabylonVX {

    public
    var _worldController: WorldController;
    public
    var camera: FreeCamera;
    public
    var _scene: Scene;



    public
    function randomInt(minimum: Int, maximum: Int): Int {
        return Math.floor(Math.random() * (maximum - minimum + 1)) + minimum;
    }

    public
    function generateVoxels(dims): Dynamic {
        var voxels: Array < Dynamic > = [];
        for (i in 0...(dims[0] * dims[1] * dims[2])) {
            var rand = randomInt(1, 10);
            if (rand == 3 || rand == 4) {
                voxels.push([rand, {
                    isTransparent: true
                }]);
            } else {
                voxels.push([rand, {
                    isTransparent: false
                }]);
            }
        }
        return voxels;
    }


    public
    function new(scene: Scene) {
        this._scene = scene;
        untyped window._scene = scene;
        _scene.clearColor = new Color3(0, 1, 0);
        this.camera = new FreeCamera("Camera", new Vector3(0, 0, -7), scene);
        var light = new HemisphericLight("light1", new Vector3(0, 1, 0), scene);
        this.camera.setTarget(new Vector3(0, 0, 0));
        this.camera.attachControl(this, false);


        var voxColors = [
            [0, 0, 0],
            [20, 120, 0],
            [0, 122, 0],
            [0, 150, 300, 90],
            [700, 100, 0, 150],
            [20, 128, 0],
            [0, 130, 0],
            [20, 132, 0],
            [0, 134, 0],
            [20, 136, 0],
            [0, 138, 0],
            [20, 140, 0],
            [255, 0, 0]
        ];


        for (i in 0...2) {
            for (i2 in 0...2) {
                var chunk = new VoxelMesh(i + '-' + i2, scene);
                chunk.setVoxelData({
                    dimensions: [16, 6, 16],
                    voxels: generateVoxels([16, 6, 16])
                });
                chunk.checkCollisions = true;
                chunk.hasTransparency = true;
                chunk.coloringFunction = function(id, meta) {
                    return voxColors[id];
                }
                chunk.evaluateFunction = function(id, meta, passID): Bool {
                    if (passID == 0 && meta != null) {
                        if (meta.isTransparent) {
                            return false;
                        } else {
                            return !!id;
                        }

                    } else if (passID == 1 && meta != null) {
                        if (meta.isTransparent) {
                            return !!id;
                        } else {
                            return false;
                        }
                    }
                    return !!id;
                }
                chunk.originToCenterOfBounds(true);
                chunk.updateMesh();
                chunk.position = new Vector3(i * 16, 0, i2 * 16);
            }
        }
        scene.getEngine().runRenderLoop(function() {
            scene.render();
        });
    }

}