import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;

  const CalendarWidget({Key? key, this.initialDate, this.onDateSelected}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _displayedMonth;
  DateTime? _selectedDate;
  bool _showYearPicker = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _displayedMonth = DateTime(_selectedDate!.year, _selectedDate!.month);
  }

  void _onPrevMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1);
    });
  }

  void _onNextMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);
    });
  }

  void _onDateTap(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    if (widget.onDateSelected != null) {
      widget.onDateSelected!(date);
    }
  }

  void _toggleYearPicker() {
    setState(() {
      _showYearPicker = !_showYearPicker;
    });
  }

  void _onYearSelected(int year) {
    setState(() {
      _displayedMonth = DateTime(year, _displayedMonth.month);
      _showYearPicker = false;
    });
  }

  List<Widget> _buildDayHeaders() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days
        .map((day) => Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ))
        .toList();
  }

  List<Widget> _buildDateCells() {
    final firstDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7; // Sunday=0
    final totalDays = lastDayOfMonth.day;

    final totalCells = firstWeekday + totalDays;
    final rows = (totalCells / 7).ceil();

    List<Widget> rowsWidgets = [];

    int dayCounter = 1;

    for (int row = 0; row < rows; row++) {
      List<Widget> weekDays = [];
      for (int col = 0; col < 7; col++) {
        final cellIndex = row * 7 + col;
        if (cellIndex < firstWeekday || dayCounter > totalDays) {
          weekDays.add(const Expanded(child: SizedBox()));
        } else {
          final date = DateTime(_displayedMonth.year, _displayedMonth.month, dayCounter);
          final isSelected = _selectedDate != null &&
              _selectedDate!.year == date.year &&
              _selectedDate!.month == date.month &&
              _selectedDate!.day == date.day;

          weekDays.add(Expanded(
            child: GestureDetector(
              onTap: () => _onDateTap(date),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : null,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    dayCounter.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ));
          dayCounter++;
        }
      }
      rowsWidgets.add(Row(children: weekDays));
    }
    return rowsWidgets;
  }

  Widget _buildYearPicker() {
    final currentYear = DateTime.now().year;
    final years = List<int>.generate(100, (i) => currentYear - 50 + i);

    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = year == _displayedMonth.year;
          return ListTile(
            title: Text(
              year.toString(),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
            onTap: () => _onYearSelected(year),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthYear = DateFormat.yMMMM().format(_displayedMonth);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _onPrevMonth,
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: _toggleYearPicker,
                    child: Text(
                      monthYear,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _onNextMonth,
              ),
            ],
          ),
          if (_showYearPicker) _buildYearPicker(),
          Row(children: _buildDayHeaders()),
          ..._buildDateCells(),
        ],
      ),
    );
  }
}
// ..........................
// import 'package:flutter/material.dart';
// import 'calender_widget.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   void _onDateSelected(DateTime date) {
//     //print('Selected date: \$date');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Calendar Widget Demo',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Calendar Widget')),
//         body: Center(
//           child: CalendarWidget(
//             initialDate: DateTime.now(),
//             onDateSelected: _onDateSelected,
//           ),
//         ),
//       ),
//     );
//   }
// }
