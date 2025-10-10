import 'package:crytojay/config/constants/constant.dart';
import 'package:crytojay/config/extension/context.dart';
import 'package:crytojay/pages/calendar/calendar.dart';
import 'package:crytojay/pages/charts/charts.dart';
import 'package:crytojay/pages/history/history.dart';
import 'package:crytojay/pages/loading/loading.dart';
import 'package:crytojay/providers/coins_provider.dart';
import 'package:crytojay/widgets/home/background_curves_painter.dart';
import 'package:crytojay/widgets/home/history_item.dart';
import 'package:crytojay/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final searchController = TextEditingController();
  List<dynamic> filteredCoinsList = []; // Add filtered list
  int _selectedIndex = 0;

  @override
  void initState() {
    filteredCoinsList = coinsList;
    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredCoinsList = coinsList.where((coin) {
        final coinName = coin["name"].toString().toLowerCase();
        return coinName.contains(query.toLowerCase());
      }).toList();
    });
  }

  // Method to handle bottom navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Handle navigation for the 'Charts' screen
        break;
      case 1:
        // Navigate to the 'History' screen
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return History(); // Replace HistoryScreen with your actual screen
        }));
        break;
      case 2:
        // Handle navigation for the 'Settings' screen
        break;
    }
    // Handle navigation based on the selected index
    // You can navigate to different pages or perform actions here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: -300,
              top: -00,
              child: Container(
                height: 500,
                width: 600,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
            CustomPaint(
              painter: BackgroundCurvesPainter(),
              size: Size.infinite,
            ),
            Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.25),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'CryptoFy',
                            style: TextStyle(
                              color: context.colorScheme.background,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Icon(
                            IconlyLight.chart,
                            color: Colors.black,
                            // scale: 23,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: Text(
                    "Ready to predict \n the crypto market !? ",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchInput(
                    onButtonTap: () {},
                    onIconTap: () {},
                    buttonText: "",
                    textController: searchController,
                    hintText: "Search Crypto",
                    showDropdown: true,
                    onChanged: filterSearchResults,
                  ),
                ),
                if (filteredCoinsList.isEmpty)
                  Center(child: Text("No results found")),
                if (filteredCoinsList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCoinsList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final coin = filteredCoinsList[index];
                        final coinName = coin["name"];
                        final coinId = coin["id"];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: CryptoItem(
                            tapCrypto: () async {
                              var unixTimeMilliseconds =
                                  DateTime.now().millisecondsSinceEpoch ~/ 1000;

                              var aMonthAgo = DateTime.now()
                                  .subtract(const Duration(days: 60));

                              var unixTimeAMonthAgo =
                                  aMonthAgo.millisecondsSinceEpoch ~/ 1000;

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Loading();
                              }));
                              try {
                                final predictedData = await ref.read(
                                  getPredictDataProvider(
                                          coinName: coinId,
                                          endTime: unixTimeMilliseconds,
                                          fromTime: unixTimeAMonthAgo)
                                      .future,
                                );
                                final montlyData =
                                    await ref.read(getMontlyDataProvider(
                                  coinName: coinId,
                                ).future);

                                final dailyData =
                                    await ref.read(getDailyDataProvider(
                                  coinName: coinId,
                                ).future);

                                print(
                                    "This is the predicted Data $predictedData");
                                // print("This is the montly Data $montlyData");
                                // print("This is the daily Data $dailyData");
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Charts(
                                    predictedData: predictedData,
                                    monthlyData: montlyData,
                                    dailyData: dailyData,
                                    coinId: coinId,
                                  );
                                }));
                              } catch (e) {
                                print("An error occured print $e");
                              }
                            },
                            tapDate: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Calendar(coin_id: coinId,);
                              }));
                            },
                            label: coinName,
                            color: context.colorScheme.primary,
                          ),
                        );
                      },
                    ),
                  ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: SearchInput(
                //     onButtonTap: () {},
                //     onIconTap: () {},
                //     buttonText: "",
                //     textController: searchController,
                //     hintText: "Search Crypto",
                //     showDropdown: true,
                //     // onChanged: () => filterSearchResults(searchController.text),
                //     onChanged: () {},
                //   ),
                // ),
                // if (coinsList.isEmpty) Center(child: Text("No results found")),
                // if (coinsList.isNotEmpty)
                //   Expanded(
                //     child: ListView.builder(
                //       itemCount: coinsList.length,
                //       shrinkWrap: true,
                //       scrollDirection: Axis.vertical,
                //       primary: true,
                //       itemBuilder: (context, index) {
                //         final coin = coinsList[index];
                //         final coinName = coin["name"];
                //         return Padding(
                //           padding: const EdgeInsets.symmetric(horizontal:  16.0,vertical: 8),
                //           child: HistoryItem(
                //               label: coinName,
                //               color: context.colorScheme.primary),
                //         );
                //       },
                //     ),
                //   )

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'History',
                //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 18,
                //               color: Theme.of(context)
                //                   .colorScheme
                //                   .onPrimary
                //                   .withOpacity(0.95),
                //             ),
                //       ),
                //       TextButton(
                //         onPressed: () {},
                //         child: Text(
                //           'See all',
                //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: 14,
                //                 color: Theme.of(context)
                //                     .colorScheme
                //                     .onSurface
                //                     .withOpacity(0.8),
                //               ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.chart),
            label: 'Charts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyLight.star),
            label: 'Favourite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
