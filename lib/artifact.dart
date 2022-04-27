import 'package:flame/collisions.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:layout/game.dart';

enum ArtAnimationStates {
  normal,
  explode,
  explode2,
}

class Artifact extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameRef<JumpGame> {
  final Timer _hitTimer = Timer(0.4);

  //final Timer _coinReturnTimer = Timer(3);
  double ground = 0.0;
  bool isHit = false;

  //bool isCoinReturned  = true;
  bool isCoinExploded = false;

  static final _animationMap = {
    ArtAnimationStates.normal: SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(256, 256)),
    ArtAnimationStates.explode: SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        texturePosition: Vector2((3) * 256, 0),
        textureSize: Vector2(256, 256),
        loop: false
    ),
  };

  Artifact(Image image) : super.fromFrameData(image, _animationMap);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    ground = gameRef.size.y - 56;
    anchor = Anchor.center;
    size = Vector2(128, 128);
    position = Vector2(gameRef.canvasSize.x / 2, gameRef.canvasSize.y / 2);
  }

  @override
  void onMount() {

    current = ArtAnimationStates.normal;

    _hitTimer.onTick = () {
      //current = ArtAnimationStates.normal;
      isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if(isHit) {
      current = ArtAnimationStates.explode;
      isHit = false;

    }



    _hitTimer.update(dt);
  }

  void coinExplode() {
    isHit = true;
    _hitTimer.start();


  }

  @override
  void onRemove() {
    super.onRemove();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
  }
}
