import 'package:flame/components.dart';

import 'artifact_model.dart';
import 'game.dart';

class Artifact extends SpriteAnimationComponent with HasGameRef<JumpGame> {
  late final ArtifactModel artifactModel;

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
  void onMount() {
    size *= 0.3;

    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= artifactModel.speedX * dt;

    if (position.x < -artifactModel.textureSize.x) {

      removeFromParent();

    }

    super.update(dt);
  }
}
