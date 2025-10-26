// lib/screens/expense_chart_tab.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/expense_model.dart';
import '../main.dart';

class ExpenseChartTab extends StatelessWidget {

  // (Yêu cầu) Xử lý dữ liệu cho biểu đồ
  // Chúng ta sẽ nhóm tổng chi tiêu theo 7 ngày gần nhất
  List<BarChartGroupData> _generateChartData(List<Expense> expenses) {
    Map<int, double> dailyTotals = {};
    final now = DateTime.now();

    // 1. Lọc và tính tổng chi tiêu trong 7 ngày
    for (var expense in expenses) {
      // Chỉ lấy chi tiêu trong 7 ngày qua
      if (expense.date.isAfter(now.subtract(Duration(days: 7)))) {
        // Lấy thứ trong tuần (0 = T2, 1 = T3, ..., 6 = CN)
        int weekday = expense.date.weekday - 1;

        dailyTotals.update(
          weekday,
          (value) => value + expense.amount,
          ifAbsent: () => expense.amount,
        );
      }
    }

    // 2. Tạo dữ liệu cho BarChart
    return List.generate(7, (index) {
      // index 0 = T2, 1 = T3, ...
      return BarChartGroupData(
        x: index, // Vị trí trên trục X
        barRods: [
          BarChartRodData(
            toY: dailyTotals[index] ?? 0.0, // Giá trị trục Y
            color: Colors.green,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  // Helper để lấy tên các ngày trong tuần
  Widget _getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0: text = 'T2'; break;
      case 1: text = 'T3'; break;
      case 2: text = 'T4'; break;
      case 3: text = 'T5'; break;
      case 4: text = 'T6'; break;
      case 5: text = 'T7'; break;
      case 6: text = 'CN'; break;
      default: text = ''; break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
  }


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Expense>(expenseBoxName).listenable(),
      builder: (context, Box<Expense> box, _) {
        final expenses = box.values.toList().cast<Expense>();

        if (expenses.isEmpty) {
          return Center(
            child: Text('No data for chart.'),
          );
        }

        final chartData = _generateChartData(expenses);

        // (Yêu cầu) Dùng fl_chart
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Total Spending (Last 7 Days)',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: chartData,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false), // Ẩn trục Y
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: _getBottomTitles,
                          reservedSize: 30,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}