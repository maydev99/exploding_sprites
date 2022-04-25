import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';


import 'game.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef<JumpGame> {
  SpriteAnimationComponent peepAnimation = SpriteAnimationComponent();
  static Vector2 gravity = Vector2(0, 600);
  Vector2 velocity = Vector2.zero();
  bool isJumping = false;
  double ground = 0.0;
  late SpriteAnimationComponent player;



  @override
  Future<void>? onLoad() async{
    await super.onLoad();
    var spriteSheet = await Flame.images.load('peep.png');
    SpriteAnimationData data = SpriteAnimationData.sequenced(amount: 3, stepTime: 0.1, textureSize: Vector2(256,256));
    ground = gameRef.size.y - 56;
    anchor = Anchor.center;
    animation = SpriteAnimation.fromFrameData(spriteSheet, data);
    playing = true;
    size = Vector2(128, 128);
    position = Vector2(gameRef.canvasSize.x / 8, ground);

  }



  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt - gravity * dt * dt / 2;
    velocity += gravity * dt;

    if(position.y > ground) {
      velocity = Vector2(0, 0);
      isJumping = false;
    }

  }

  void jump() {
    if(!isJumping) {
      velocity += Vector2(0, -400);
      isJumping = true;
    }

  }
}