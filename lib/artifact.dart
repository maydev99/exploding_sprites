import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:layout/player.dart';

import 'artifact_model.dart';
import 'game.dart';

class Artifact extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<JumpGame> {
  late final ArtifactModel artifactModel;
  bool isHit = false;
  final Timer _hitTimer = Timer(1);

  Artifact(this.artifactModel) {
    animation = SpriteAnimation.fromFrameData(
      artifactModel.image,
      SpriteAnimationData.sequenced(
          amount: artifactModel.nFrames,
          stepTime: artifactModel.stepTime,
          textureSize: artifactModel.textureSize),
    );
  }

  @override
  Future<void>? onLoad() async{
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void onMount() {

    _hitTimer.onTick = () {
      isHit = false;
    };

    size *= 0.3;

    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= artifactModel.speedX * dt;

    if (position.x < -artifactModel.textureSize.x) {

      removeFromParent();

    }

    _hitTimer.update(dt);

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if((other is PlayerComponent) && (!isHit)) {
     hit();
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {

    super.onCollisionEnd(other);
  }

  void hit() {
    isHit = true;
    _hitTimer.start();
    if(isHit) {
      print('hit');
    }
  }
}
