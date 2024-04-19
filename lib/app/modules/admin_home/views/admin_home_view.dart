import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:rental/app/models/stats.dart';
import 'package:rental/app/modules/home/controllers/home_controller.dart';
import 'package:rental/app/routes/app_pages.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(AdminHomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getStats();
        },
        child: GetBuilder<AdminHomeController>(
          builder: (controller) {
            if (controller.statsResponse == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var stats = controller.statsResponse!.stats!;
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text('Select date and month to view monthly income:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      )),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: Get.width * 0.9,
                            child: TextField(
                              readOnly: true,
                              controller: controller.selectedDate,
                              decoration: InputDecoration(
                                hintText: 'Select month and year',
                                suffixIcon: GestureDetector(
                                    onTap: () async {
                                      var date = await showMonthYearPicker(
                                        context: context,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                        initialDate: DateTime.now(),
                                      );

                                      if (date != null) {
                                        controller.selectedDate.text =
                                            DateFormat.yMMM().format(date);
                                        controller.getStats(
                                            date: DateTime(
                                                date.year, date.month));
                                      }
                                    },
                                    child: const Icon(Icons.calendar_month)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.1,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.ADMIN_USER);
                        },
                        child: StatCard(
                          title: 'Total Users',
                          value: stats.totalUsers,
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          color: Colors.blue.shade400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.MY_VEHICLES);
                        },
                        child: StatCard(
                          title: 'Total Vehicles',
                          value: stats.totalVehicles.toString(),
                          icon: const Icon(
                            Icons.bike_scooter,
                            color: Colors.white,
                          ),
                          color: Colors.purple.shade300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PAYMENTS);
                        },
                        child: StatCard(
                          title: 'Total Income',
                          value: "Rs. ${int.parse(stats.totalIncome!) / 100}",
                          icon: const Icon(
                            Icons.money,
                            color: Colors.white,
                          ),
                          color: Colors.teal.shade300,
                        ),
                      ),
                      StatCard(
                        title: 'Total Monthly Income',
                        value:
                            "Rs. ${int.parse(stats.totalMonthlyIncome!) / 100}",
                        icon: const Icon(
                          Icons.money,
                          color: Colors.white,
                        ),
                        color: Colors.orange.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Top Earning Categories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  MyPieChart(
                      topCategories:
                          controller.statsResponse!.stats!.topCategories!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? color;
  final Widget? icon;
  const StatCard({super.key, this.title, this.value, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? Colors.blue,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.27,
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              icon ?? const Icon(Icons.person),
            ],
          ),
          const Spacer(),
          Text(
            value ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class MyPieChart extends StatelessWidget {
  final List<TopCategory> topCategories;
  const MyPieChart({super.key, required this.topCategories});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPurple,
      AppColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: topCategories
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: Indicator(
                          isSquare: true,
                          color: colors[topCategories.indexOf(e)],
                          text: e.category ?? '',
                          totalIncome: e.totalIncome.toString(),
                        ),
                      ))
                  .toList()),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPurple,
      AppColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    list = topCategories
        .map((e) => PieChartSectionData(
              color: colors[topCategories.indexOf(e)],
              value: e.percentage!,
              title: '${e.percentage}%',
              radius: 80,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1,
              ),
            ))
        .toList();
    return list;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.totalIncome,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  }) : super(key: key);

  final Color color;
  final String text;
  final String totalIncome;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              'Total Income: $totalIncome',
              style: TextStyle(
                fontSize: 12,
                color: textColor?.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
