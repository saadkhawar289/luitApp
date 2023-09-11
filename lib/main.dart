import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:luvit_application/firebase_options.dart';
import 'package:luvit_application/networkRequest/apiRequest.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/svg_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DraggableCardApp());
}

class DraggableCardApp extends StatelessWidget {
  DraggableCardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Drag()
    );
  }
}

class Drag extends StatefulWidget {
  const Drag({Key? key}) : super(key: key);

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  List<String> name = [
    'ssss',
    'ccccc',
    'ccccc',
  ];
  ExpandableController expandableController =
      ExpandableController(initialExpanded: false);

  CarouselController carouselController = CarouselController();
  int selectedIndex = 0;
  final controller =
      PageController(viewportFraction: 0.4, keepPage: true, initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.black,
        child: ConvexAppBar(
          style: TabStyle.fixedCircle,
          curveSize: 90,
          top: -25,
          elevation: 1,
          shadowColor: Colors.grey,
          cornerRadius: 10,
          activeColor: Colors.pink,
          items: [
            TabItem(icon: Icons.home_rounded, title: '홈'),
            TabItem(icon: Icons.location_on, title: '스팟'),
            TabItem(
                title: '',
                icon: SvgWidget(
                  imgPath: 'assets/centerIcon.svg',
                  imageWidth: 30,
                  imageHeight: 20,
                )),
            TabItem(
                title: '채팅',
                icon: SvgWidget(
                  imgPath: 'assets/txt.svg',
                  imageWidth: 30,
                  imageHeight: 20,
                )),
            TabItem(
                title: '마이',
                icon: SvgWidget(
                  imgPath: 'assets/pro.svg',
                  imageWidth: 30,
                  imageHeight: 20,
                )),
          ],
          backgroundColor: Colors.black,
          initialActiveIndex: 0,
          onTap: (int i) => print('click index=$i'),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                child: SvgWidget(
                  imgPath: 'assets/loc.svg',
                  imageWidth: 14,
                  imageHeight: 18,
                ),
              ),
            ),
            Expanded(
              child: const Text('   목이길어슬픈기린님의 새로운 스팟',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // Remove the leading widget padding

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: const Color(0xff3A3A3A))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    SvgWidget(
                        imgPath: 'assets/star.svg',
                        imageWidth: 14,
                        imageHeight: 14),
                    Spacer(),
                    Text('323,323',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          SvgWidget(imgPath: 'assets/noti.svg', imageWidth: 45, imageHeight: 45)
        ],
      ),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 600,
                color: Colors.black,
                child: name.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "추천 드릴 친구들을 준비 중이에요",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "추천 드릴 친구들을 준비 중이에요",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ))
                    : CarouselSlider.builder(
                        itemCount: name.length,
                        carouselController: carouselController,
                        itemBuilder: (context, i, index) {
                          return Draggable(
                            onDragEnd: (details) {
                              double dx = details.velocity.pixelsPerSecond.dx;
                              double dy = details.velocity.pixelsPerSecond.dy;

                              if (dx > 0 && dx.abs() > dy.abs()) {
                                // Check for rightward drag and a stronger horizontal movement than vertical
                                setState(() {
                                  print('hori-----');
                                  name.removeAt(i);
                                });
                              } else if (dy > 0) {
                                // Check for downward drag
                                setState(() {
                                  print('verti-----');

                                  name.removeAt(i);
                                });
                              }
                            },
                            // ignore: sort_child_properties_last
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                      height: 600,
                                      width: 340,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xff3A3A3A)),
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Color(
                                                  0xFF3A3A3A), // Replace with your desired colors
                                              Colors.transparent,
                                            ],
                                            stops: [
                                              0.6333333,
                                              0.99999
                                            ], // Adjust the stops to control the gradient position
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                          ).createShader(bounds);
                                        },
                                        blendMode: BlendMode.dstIn,
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              index == 0
                                                  ? 'assets/100_main.png'
                                                  : index == 1
                                                      ? 'assets/101_main.png'
                                                      : 'assets/102_main.png', // Replace with your image URL
                                              fit: BoxFit
                                                  .fill, // You can adjust the image fit as needed
                                            ),
                                            Positioned(
                                              bottom: 25,
                                              left: 20,
                                              right: 0,
                                              child: ExpandableNotifier(
                                                controller:
                                                    expandableController,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    SizedBox(
                                                      child: Expandable(
                                                        collapsed: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Container(
                                                              width: 80,
                                                              height: 30,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      20),
                                                                  border: Border.all(
                                                                      width:
                                                                      1,
                                                                      color:
                                                                      const Color(0xff3A3A3A))),
                                                              child:
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    5),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                        child:
                                                                        SvgWidget(
                                                                          imgPath:
                                                                          'assets/star.svg',
                                                                          imageWidth:
                                                                          14,
                                                                          imageHeight:
                                                                          14,
                                                                          color:
                                                                          Colors.grey[800],
                                                                        )),
                                                                    Spacer(),
                                                                    Text(
                                                                        '323,323',
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 13))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 8),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width:
                                                                  240,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      const Text(
                                                                          '목이길어슬픈기린님의 새로운 스팟',
                                                                          maxLines: 2,
                                                                          style: TextStyle(fontFamily: 'Pretendard', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                                                                      SizedBox(
                                                                        height:
                                                                        5,
                                                                      ),
                                                                      Container(

                                                                        height:
                                                                        36,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          border:
                                                                          Border.all(width: 1, color: Color(0xFFFF016B)),
                                                                          borderRadius:
                                                                          BorderRadius.circular(20),
                                                                          gradient:
                                                                          LinearGradient(
                                                                            begin: Alignment.centerLeft,
                                                                            end: Alignment.centerRight,
                                                                            colors: [
                                                                              Color(0xFFFF016B).withOpacity(0.2),
                                                                              Color(0xFFFF016B).withOpacity(0.2),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets.symmetric(horizontal: 5,vertical: 6),
                                                                          child:Text('💖 진지한 연애를 찾는 중', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w500, fontSize: 13))

                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                        8,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                            36,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                                border:
                                                                                Border.all(width: 1, color: Colors.grey[500]!),
                                                                                borderRadius:
                                                                                BorderRadius.circular(20),
                                                                                color: Colors.grey[900]                                                                         ),
                                                                            child: Padding(
                                                                              padding:
                                                                              const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                                                                              child: Center(child: Text('🍸 전혀 안 함',style: TextStyle(color:Colors.white,fontSize:14,fontWeight:FontWeight.w400),)),

                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 5,),
                                                                          Container(
                                                                            height:
                                                                            36,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                                border:
                                                                                Border.all(width: 1, color: Colors.grey[500]!),
                                                                                borderRadius:
                                                                                BorderRadius.circular(20),
                                                                                color: Colors.grey[900]                                                                         ),
                                                                            child:
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                                                                              child: Center(child: Text('\u{1F6AC} 비흡연',style: TextStyle(color:Colors.white,fontSize:14,fontWeight:FontWeight.w400),)),

                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 8,),
                                                                      Container(
                                                                        width:
                                                                        130,
                                                                        height:
                                                                        36,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                            border:
                                                                            Border.all(width: 1, color: Colors.grey[500]!),
                                                                            borderRadius:
                                                                            BorderRadius.circular(20),
                                                                            color: Colors.grey[900]                                                                         ),
                                                                        child:
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets.symmetric(horizontal: 5),
                                                                          child:
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                                                                            child:
                                                                            Center(child: Text('💪🏻 매일 1시간 이상',style: TextStyle(color:Colors.white,fontSize:14,fontWeight:FontWeight.w400),)),

                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                            36,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                                border:
                                                                                Border.all(width: 1, color: Colors.grey[500]!),
                                                                                borderRadius:
                                                                                BorderRadius.circular(20),
                                                                                color: Colors.grey[900]                                                                         ),
                                                                            child:
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                                                                              child:
                                                                              Center(child: Text('🤝 만나는 걸 좋아함',style: TextStyle(color:Colors.white,fontSize:14,fontWeight:FontWeight.w400),)),

                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 5,),
                                                                          Container(

                                                                            height:
                                                                            36,
                                                                            decoration:
                                                                            BoxDecoration(
                                                                                border:
                                                                                Border.all(width: 1, color: Colors.grey[500]!),
                                                                                borderRadius:
                                                                                BorderRadius.circular(20),
                                                                                color: Colors.grey[900]                                                                         ),
                                                                            child:
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                                                                              child:
                                                                              Center(child: Text('NFP',style: TextStyle(color:Colors.white,fontSize:14,fontWeight:FontWeight.w400),)),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 10.0),
                                                                  child: Align(
                                                                      alignment: Alignment.centerRight,
                                                                      child: SvgWidget(imgPath: 'assets/fav.svg', imageWidth: 30, imageHeight: 60)),
                                                                )
                                                              ],
                                                            ),


                                                          ],
                                                        ),
                                                        expanded: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      0.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        width: 80,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .black,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                                    20),
                                                                            border: Border.all(
                                                                                width:
                                                                                    1,
                                                                                color:
                                                                                    const Color(0xff3A3A3A))),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                                  .symmetric(
                                                                              horizontal:
                                                                                  5),
                                                                          child: Row(
                                                                            children: [
                                                                              Container(
                                                                                  child:
                                                                                      SvgWidget(
                                                                                imgPath:
                                                                                    'assets/star.svg',
                                                                                imageWidth:
                                                                                    14,
                                                                                imageHeight:
                                                                                    14,
                                                                                color:
                                                                                    Colors.grey[800],
                                                                              )),
                                                                              Spacer(),
                                                                              Text(
                                                                                  '323,323',
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontSize: 13))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height: 5),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                250,
                                                                            child: const Text(
                                                                                '목이길어슬픈기린님의 새로운 스팟',
                                                                                maxLines: 2,
                                                                                style: TextStyle(fontFamily: 'Pretendard', color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                200,
                                                                            child: Text(
                                                                                '서로 아껴주고 힘이 되어줄 사람 찾아요 선릉으로 직장 다니고 있고 여행 좋아해요 이상한 이야기하시는 분 바로 차단입니다',
                                                                                maxLines: 4,
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 15)),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                    ],
                                                                  ),
                                                                  SizedBox(height:60),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right: 8.0),
                                                                    child: SvgWidget(
                                                                        imgPath:
                                                                        'assets/fav.svg',
                                                                        imageWidth:
                                                                        60,
                                                                        imageHeight:
                                                                        60),
                                                                  ),

                                                                ],
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: ExpandableButton(
                                                          child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            expandableController
                                                                .toggle();
                                                          });
                                                        },
                                                        child: expandableController
                                                                .expanded
                                                            ? Icon(
                                                                Icons
                                                                    .keyboard_arrow_up,
                                                                color: Colors
                                                                    .white,size: 35,)
                                                            : Icon(
                                                            size: 35,
                                                                Icons
                                                                    .keyboard_arrow_down,
                                                                color: Colors
                                                                    .white,),
                                                      )),
                                                    ),
                                                    SizedBox(height: 5),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                      height: 100,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: InkWell(
                                        onTap: () {
                                          carouselController.previousPage();
                                        },
                                      )),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                      height: 100,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                          carouselController.nextPage();
                                        },
                                      )),
                                ),
                                Positioned(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          child: AnimatedSmoothIndicator(
                                        activeIndex: index,
                                        count: name.length,
                                        effect: SlideEffect(
                                            spacing: 8.0,
                                            radius: 5.0,
                                            dotWidth: 80.0,
                                            dotHeight: 4.0,
                                            dotColor: Colors.black,
                                            activeDotColor: Colors.pink),
                                      )
                                          // DotsIndicator(
                                          //   dotsCount: name.length,
                                          //   position: index,
                                          //
                                          //     decorator: DotsDecorator(
                                          //       size: Size(50, 2), // Set the size to control the width and height of rectangles
                                          //       activeColor: Colors.green,
                                          //       color: Colors.white,
                                          //       spacing: EdgeInsets.only(left: 5, right: 5),
                                          //       shape: RoundedRectangleBorder(
                                          //         side: BorderSide(color: Colors.green),
                                          //         borderRadius: BorderRadius.circular(0), // Set this to 0 to make rectangles
                                          //       ),
                                          //       activeShape: RoundedRectangleBorder(
                                          //
                                          //         side: BorderSide(color: Colors.green,width: 30, ),
                                          //         borderRadius: BorderRadius.circular(0), // Set this to 0 to make rectangles
                                          //       ),
                                          //     ),
                                          // ),
                                          ),
                                    ),
                                  ),
                                )
                                // Positioned(
                                //   child: Container(
                                //     height:70,width:150,
                                //     child:DotsIndicator(
                                //     dotsCount: name.length,
                                //     position: index,
                                //
                                //     decorator: DotsDecorator(
                                //       size: Size.fromHeight(4),
                                //       activeColor: Colors.green,
                                //       color: Colors.white,
                                //       spacing: EdgeInsets.only(left: 5, right: 5),
                                //       shape:
                                //       //circle shape
                                //       RoundedRectangleBorder(
                                //           side: BorderSide(color: Colors.green),
                                //           borderRadius: BorderRadius.circular(5.0)),
                                //       activeShape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(5.0)),
                                //     ),
                                //   ),)
                                //
                                //
                                // )
                              ],
                            ),
                            feedback: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 600,
                                      width: 340,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xff3A3A3A)),
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [
                                              Color(
                                                  0xFF3A3A3A), // Replace with your desired colors
                                              Colors.transparent,
                                            ],
                                            stops: [
                                              0.1,
                                              0.99999
                                            ], // Adjust the stops to control the gradient position
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ).createShader(bounds);
                                        },
                                        blendMode: BlendMode.dstIn,
                                        child: Image.asset(
                                          index == 0
                                              ? 'assets/100_main.png'
                                              : index == 1
                                                  ? 'assets/101_main.png'
                                                  : 'assets/102_main.png', // Replace with your image URL
                                          fit: BoxFit
                                              .fill, // You can adjust the image fit as needed
                                        ),
                                      )),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 8,
                                  bottom: 8,
                                  child: Container(
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: GestureDetector(
                                        onTap: () {
                                          carouselController.previousPage();
                                        },
                                      )),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 8,
                                  bottom: 8,
                                  child: Container(
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: GestureDetector(
                                        onTap: () {
                                          carouselController.nextPage();
                                        },
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            initialPage: 1,
                            viewportFraction: 0.90,
                            enableInfiniteScroll: false,
                            scrollPhysics:
                                const NeverScrollableScrollPhysics() //AlwaysScrollableScrollPhysics()
                            ,
                            autoPlay: false,
                            enlargeCenterPage: false,
                            disableCenter: true)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
