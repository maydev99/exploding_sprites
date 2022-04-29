import 'package:flame/components.dart';
import 'package:layout/game.dart';

import 'artifact.dart';
import 'artifact_model.dart';

class ArtifactManager extends Component with HasGameRef<JumpGame> {
  List<String> levelArtifacts = [];
  final List<ArtifactModel> artifactDataList = [];
  final Timer _timer = Timer(2, repeat: true);
  late int index;


  ArtifactManager() {
    _timer.onTick = spawnRandomArtifact;
  }

  void spawnRandomArtifact() {
    final myArtifact = Artifact(gameRef.images.fromCache('coin_ten.png'));
    add(myArtifact);
  }

  @override
  void onMount() {

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
