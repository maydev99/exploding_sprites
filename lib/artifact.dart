import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:layout/player.dart';

import 'game.dart';

enum ArtStates {
  normal,
  hit,
}

class Artifact extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameRef<JumpGame> {
  bool isHit = false;
  final Timer _hitTimer = Timer(1);

  static final animationMap = {
    ArtStates.normal: SpriteAnimationData.sequenced(
        amount: 1, stepTime: 0.1, textureSize: Vector2(256, 256)),
    ArtStates.hit: SpriteAnimationData.sequenced(
        amount: 7, stepTime: 0.1, textureSize: Vector2(256, 256), loop: true)
  };

  Artifact(Image image) : super.fromFrameData(image, animationMap);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    anchor = Anchor.bottomRight;
    size = Vector2(256, 256);
    position.y = gameRef.size.y / 2;
    position.x = gameRef.size.x + 250;

    add(RectangleHitbox());
  }

  @override
  void onMount() {
    _hitTimer.onTick = () {
      current = ArtStates.normal;
      isHit = false;
    };

    size *= 0.3;

    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= 200 * dt;

    if (position.x < -256) {
      removeFromParent();
    }

    _hitTimer.update(dt);

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is PlayerComponent) && (!isHit)) {
      hit();
    }

    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    isHit = true;
    _hitTimer.start();
    if (isHit) {
      current = ArtStates.hit;
    }
  }
}
