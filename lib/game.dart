
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:layout/artifact.dart';
import 'package:layout/artifact_manager.dart';
import 'package:layout/player.dart';

class JumpGame extends FlameGame with HasCollisionDetection, TapDetector {
  late final PlayerComponent player;
  late final Artifact artifact;
  late ArtifactManager artifactManager;
  final Timer _tapTimer = Timer(2);

  //late final PeepAnimation peepAnimation;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await images.load('coin_ten.png');

    player = PlayerComponent();


    add(player);
   // add(artifact);
    artifactManager = ArtifactManager();
    add(artifactManager);

  }

  @override
  void update(double dt) {
    super.update(dt);
    _tapTimer.update(dt);

  }

  @override
  void onTapDown(TapDownInfo info) {
    player.jump();
    /*artifact.coinExplode();
    _tapTimer.start();
    Future.delayed(const Duration(milliseconds: 400)).then((_) => {
      artifact.removeFromParent()
    });
*/


  }
}