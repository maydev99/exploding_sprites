import 'dart:math';

import 'package:flame/components.dart';
import 'package:layout/game.dart';
import 'artifact.dart';
import 'artifact_model.dart';

class ArtifactManager extends Component with HasGameRef<JumpGame> {
  final List<ArtifactModel> _data = [];
  List<String> levelArtifacts = [];
  final List<ArtifactModel> artifactDataList = [];
  final Random _random = Random();
  final Timer _timer = Timer(2, repeat: true);
  late int index;

  ArtifactManager() {
    _timer.onTick = spawnRandomArtifact;
  }

  void spawnRandomArtifact() {
    levelArtifacts.clear();
    artifactDataList.clear();

    var randomIndex = _random.nextInt(_data.length);

    final artifactData = _data.elementAt(randomIndex);
    final myArtifact = Artifact(artifactData);

    myArtifact.anchor = Anchor.bottomLeft;
    myArtifact.position = Vector2(gameRef.size.x + 32, gameRef.size.y - 1);

    myArtifact.position.y = gameRef.size.y - 200;

    myArtifact.size = artifactData.textureSize;
    add(myArtifact);
  }

  @override
  void onMount() {
    // shouldRemove = false;

    if (_data.isEmpty) {
      _data.addAll([
        ArtifactModel(
            name: 'coin',
            image: gameRef.images.fromCache('coin_ten.png'),
            nFrames: 1,
            stepTime: 0.1,
            textureSize: Vector2(256, 256),
            speedX: 180,
            altitude: 200)
      ]);
    }

    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllArtifacts() {
    final artifacts = gameRef.children.whereType<Artifact>();
    for (var artifact in artifacts) {
      artifact.removeFromParent();
    }
  }
}
