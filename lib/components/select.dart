import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:vize/vize.dart';

class CustomDropdown extends StatefulWidget {
  final String? labelText;
  final String? labelTextSheet;
  final List<String> items;
  final String? initValue;
  final ValueChanged<String>? onChanged;

  const CustomDropdown({
    super.key,
    this.labelText = 'Select Department',
    this.labelTextSheet = 'Select Status',
    this.items = const [
      'New Applicants',
      'Interviewing',
      'Technical Interview',
      'Test Task',
      'Offer Sent',
      'Hired',
      'Rejected',
      'Not Selected'
    ],
    this.initValue = 'Engineering',
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initValue ?? (widget.items.isNotEmpty ? widget.items.first : '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          widget.labelText!,
          style: AppText.bodyS.copyWith(
            fontWeight: .w600,
            color: AppColors.secondary,
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width.fw,
                  decoration: BoxDecoration(
                    color: AppColors.darkenWhite,
                    borderRadius: .directional(
                      topStart: .circular(28.r),
                      topEnd: .circular(28.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withValues(alpha: 0.12),
                        blurRadius: 24,
                        offset: Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(height: 16.fh),
                      Center(
                        child: Container(
                          width: 32.fw,
                          height: 4.fh,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: .circular(9999.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.fh),
                      Padding(
                        padding: ps(h: 16.fh),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Padding(
                              padding: po(l: 16.fh, b: 16.fh),
                              child: Text(
                                widget.labelTextSheet!,
                                style: AppText.subHeader,
                              ),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height.fh * 0.6,
                              child: ListView.builder(
                                itemCount: widget.items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(widget.items[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            height: 48.fh,
            width: 350.fw,
            decoration: BoxDecoration(
              color: AppColors.darkenWhite,
              border: .all(color: AppColors.grey, width: 1),
              borderRadius: .circular(8.r),
            ),
            padding: ps(h: 16.fw, v: 11.fh),
            child: Row(
              children: [
                Text('Engineering', style: AppText.bodyM),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/arrowDown.svg',
                  package: 'ui_kit',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
