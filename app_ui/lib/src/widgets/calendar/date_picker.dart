import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

enum DatePickerType {
  yearMonthDay,
  yearMonth,
}

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({
    super.key,
    this.type = DatePickerType.yearMonthDay,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onConfirm,
    this.confirmButtonText = '확인',
  });

  final DatePickerType type;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime)? onConfirm;

  final String confirmButtonText;

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;

  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  final DateTime now = DateTime.now();
  late final List<int> years;
  final List<String> months = [
    '1월',
    '2월',
    '3월',
    '4월',
    '5월',
    '6월',
    '7월',
    '8월',
    '9월',
    '10월',
    '11월',
    '12월',
  ];

  @override
  void initState() {
    super.initState();

    // Generate years list based on date limits
    final firstYear = widget.firstDate?.year ?? 2000;
    final lastYear = widget.lastDate?.year ?? (now.year + 50);
    years =
        List.generate(lastYear - firstYear + 1, (index) => firstYear + index);

    final initialDate = widget.initialDate ?? now;
    selectedYear = initialDate.year;
    selectedMonth = initialDate.month;
    selectedDay = initialDate.day;

    // Ensure selected date is within limits
    if (widget.firstDate != null && initialDate.isBefore(widget.firstDate!)) {
      selectedYear = widget.firstDate!.year;
      selectedMonth = widget.firstDate!.month;
      selectedDay = widget.firstDate!.day;
    } else if (widget.lastDate != null &&
        initialDate.isAfter(widget.lastDate!)) {
      selectedYear = widget.lastDate!.year;
      selectedMonth = widget.lastDate!.month;
      selectedDay = widget.lastDate!.day;
    }

    // Initialize controllers with current selection
    yearController = FixedExtentScrollController(
      initialItem: years.indexOf(selectedYear),
    );
    monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
    dayController = FixedExtentScrollController(
      initialItem: selectedDay - 1,
    );
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _updateDayController() {
    final daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (dayController.hasClients) {
          dayController.animateToItem(
            selectedDay - 1,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  Widget _buildPickerColumn({
    required List<String> items,
    required FixedExtentScrollController controller,
    required void Function(int) onSelectedItemChanged,
    required bool Function(int) isSelected,
  }) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppSemanticColors.bgQuinary,
                  ),
                ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 50,
            perspective: 0.0001,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onSelectedItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                final isCurrentSelected = isSelected(index);
                final isCurrentDate = _isCurrentDate(index);

                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    items[index],
                    style: TextStyle(
                      fontSize: isCurrentSelected ? 16 : 18,
                      fontWeight:
                          isCurrentSelected ? FontWeight.w600 : FontWeight.w400,
                      color: _getTextColor(isCurrentSelected, isCurrentDate),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isCurrentDate(int index) {
    // This method should be customized based on which column is being rendered
    // For now, returning false as a placeholder
    return false;
  }

  Color _getTextColor(bool isSelected, bool isCurrentDate) {
    if (isSelected) {
      return AppSemanticColors.fontIconPrimary; // Selected item (middle/active)
    } else if (isCurrentDate) {
      return AppSemanticColors.fontIconTertiary; // Current date items
    } else {
      return AppSemanticColors.fontIconTertiary; // Regular items
    }
  }

  Widget _buildYearColumn() {
    return _buildPickerColumn(
      items: years.map((year) => '$year년').toList(),
      controller: yearController,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedYear = years[index];
          _updateDayController();
        });
      },
      isSelected: (index) => years[index] == selectedYear,
    );
  }

  Widget _buildMonthColumn() {
    final availableMonths = <String>[];
    final availableMonthIndices = <int>[];

    var minMonth = 1;
    var maxMonth = 12;
    if (widget.firstDate != null && selectedYear == widget.firstDate!.year) {
      minMonth = widget.firstDate!.month;
    }
    if (widget.lastDate != null && selectedYear == widget.lastDate!.year) {
      maxMonth = widget.lastDate!.month;
    }

    for (var i = 0; i < months.length; i++) {
      final month = i + 1;
      if (month < minMonth || month > maxMonth) continue;
      availableMonths.add(months[i]);
      availableMonthIndices.add(i);
    }

    if (availableMonths.isEmpty) {
      return _buildPickerColumn(
        items: months,
        controller: monthController,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedMonth = index + 1;
            _updateDayController();
          });
        },
        isSelected: (index) => index + 1 == selectedMonth,
      );
    }

    return _buildPickerColumn(
      items: availableMonths,
      controller: monthController,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedMonth = availableMonthIndices[index] + 1;
          _updateDayController();
        });
      },
      isSelected: (index) => availableMonthIndices[index] + 1 == selectedMonth,
    );
  }

  Widget _buildDayColumn() {
    final daysInMonth = getDaysInMonth(selectedYear, selectedMonth);
    final availableDays = <String>[];
    final availableDayIndices = <int>[];

    for (var day = 1; day <= daysInMonth; day++) {
      final testDate = DateTime(selectedYear, selectedMonth, day);

      var isAvailable = true;
      if (widget.firstDate != null) {
        isAvailable = isAvailable && !testDate.isBefore(widget.firstDate!);
      }
      if (widget.lastDate != null) {
        isAvailable = isAvailable && !testDate.isAfter(widget.lastDate!);
      }

      if (isAvailable) {
        availableDays.add('$day일');
        availableDayIndices.add(day - 1);
      }
    }

    // If no days are available, show all days
    if (availableDays.isEmpty) {
      final days = List.generate(daysInMonth, (index) => '${index + 1}일');
      return _buildPickerColumn(
        items: days,
        controller: dayController,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedDay = index + 1;
          });
        },
        isSelected: (index) => index + 1 == selectedDay,
      );
    }

    return _buildPickerColumn(
      items: availableDays,
      controller: dayController,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedDay = availableDayIndices[index] + 1;
        });
      },
      isSelected: (index) => availableDayIndices[index] + 1 == selectedDay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Picker content
          SizedBox(
            height: 200,
            child: Row(
              children: [
                _buildYearColumn(),
                if (widget.type == DatePickerType.yearMonthDay ||
                    widget.type == DatePickerType.yearMonth)
                  _buildMonthColumn(),
                if (widget.type == DatePickerType.yearMonthDay)
                  _buildDayColumn(),
              ],
            ),
          ),

          // Confirm button
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 28),
              child: AppButton(
                label: widget.confirmButtonText,
                size: ButtonSize.l,
                onPressed: () {
                  final selectedDate = DateTime(
                    selectedYear,
                    selectedMonth,
                    widget.type == DatePickerType.yearMonthDay
                        ? selectedDay
                        : 1,
                  );
                  widget.onConfirm?.call(selectedDate);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
