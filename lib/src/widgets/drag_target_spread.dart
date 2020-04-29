import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarotcardapp/src/pages/single_card_detail_page.dart';
import 'package:tarotcardapp/src/providers/current_index.dart';

class DragTargetSpread extends StatefulWidget {
  @override
  _DragTargetSpreadState createState() => _DragTargetSpreadState();
}

class _DragTargetSpreadState extends State<DragTargetSpread> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _AuxModel(),
      child: DragTargetInstance(),
    );
  }
}

class DragTargetInstance extends StatefulWidget {
  @override
  _DragTargetInstanceState createState() => _DragTargetInstanceState();
}

class _DragTargetInstanceState extends State<DragTargetInstance> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<CurrentIndexProvider>(context);
    final goToPage = Provider.of<_AuxModel>(context);

    return Container(
      height: 150.0,
      width: 95.0,
      child: !accepted
          ? DragTarget<int>(
              onWillAccept: (data) {
//                    Navigator.pushNamed(context, '/detail');
//                print(data);
                //print(currentIndex.currentIndex);
                return true;
              },
              onAccept: (data) {
                goToPage.goToPage = currentIndex.currentIndex;
                accepted = true;
              },
              builder: (context, accepted, rejected) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF9c0c74),
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Color(0x44000000))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Image(
                      fit: BoxFit.cover,
                      color: Colors.grey,
                      colorBlendMode: BlendMode.hardLight,
                      image: AssetImage(
                        //'assets/images/back.jpeg',
                        'assets/images/tarotback.png',
                      ),
                    ),
                  ),
                );
              },
            )
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SingleCardDetailPage(
                      index: goToPage.goToPage,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF9c0c74),
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: Color(0x44000000))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      //'assets/images/back.jpeg',
                      'assets/images/tarotback.png',
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _AuxModel with ChangeNotifier {
  int _goToPage = 0;

  int get goToPage => _goToPage;

  set goToPage(int value) {
    _goToPage = value;
    notifyListeners();
  }
}
