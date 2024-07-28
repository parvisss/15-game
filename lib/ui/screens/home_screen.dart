import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<int?> gridItems;
  late int emptyIndex;

  @override
  void initState() {
    super.initState();
    gridItems = List<int>.generate(16, (index) => index < 15 ? index + 1 : 16);
    gridItems.shuffle();
    emptyIndex = gridItems.indexOf(16);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/main.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: 470.h,
            width: 320.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0.w),
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final item = gridItems[index];
                  return InkWell(
                    onTap: () {
                      _onTap(index);
                    },
                    child: Container(
                      height: 80.h,
                      width: 80.w,
                      color: item == 16 ? Colors.transparent : Colors.amber,
                      // decoration: const BoxDecoration(),
                      child: Center(
                        child: Text(
                          item == 16 ? '' : '$item',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    if (_canChange(index, emptyIndex)) {
      setState(
        () {
          gridItems[emptyIndex] = gridItems[index];
          gridItems[index] = 16;
          emptyIndex = index;
        },
      );
    }
  }

  bool _canChange(int index1, int index2) {
    final row1 = index1 ~/ 4; //2
    final col1 = index1 % 4; //0
    final row2 = index2 ~/ 4; //1
    final col2 = index2 % 4; //1
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }
}
