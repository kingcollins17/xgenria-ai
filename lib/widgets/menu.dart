// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const radius = 50.0;
const height = 50.0;

class HoverMenu extends StatefulWidget {
  const HoverMenu(
      {super.key,
      this.isOpen = true,
      this.onChanged,
      this.initDestination = HoverDestination.home});
  final bool isOpen;
  final void Function(HoverDestination)? onChanged;
  final HoverDestination initDestination;

  @override
  State<HoverMenu> createState() => _HoverMenuState();
}

enum HoverDestination { home, explore, projects, me }

class _HoverMenuState extends State<HoverMenu>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    isOpen = widget.isOpen;
    groupValue = widget.initDestination;
  }

  @override
  void didUpdateWidget(covariant HoverMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    isOpen = widget.isOpen;
    if (oldWidget.initDestination != widget.initDestination) {
      setState((){
        groupValue = widget.initDestination;
      });
      
    }
  }

  void navigate(HoverDestination destination) {
    setState(() {
      groupValue = destination;
      if (widget.onChanged != null) {
        widget.onChanged!(groupValue);
      }
    });
  }

  var groupValue = HoverDestination.home;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          height: height,
          width: isOpen ? MediaQuery.of(context).size.width * 0.9 : 70,
          decoration: BoxDecoration(
            gradient: isOpen
                ? null
                : LinearGradient(colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary
                  ]),
            color: const Color(0xFF313131),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: isOpen
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _IconWrap(
                      icon: Icons.home_outlined,
                      selectedIcon: Icons.home_rounded,
                      value: HoverDestination.home,
                      groupValue: groupValue,
                      onPress: navigate,
                    ),
                    _IconWrap(
                      icon: Icons.explore_outlined,
                      selectedIcon: Icons.explore_rounded,
                      value: HoverDestination.explore,
                      groupValue: groupValue,
                      onPress: navigate,
                    ),
                    _IconWrap(
                      icon: Icons.grid_view_outlined,
                      selectedIcon: Icons.grid_view_rounded,
                      value: HoverDestination.projects,
                      groupValue: groupValue,
                      onPress: navigate,
                    ),
                    _IconWrap(
                      icon: Icons.person_4_outlined,
                      selectedIcon: Icons.person_rounded,
                      value: HoverDestination.me,
                      groupValue: groupValue,
                      onPress: navigate,
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () => setState(() => isOpen = true),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      size: 15, color: Colors.white),
                ),
        ),
      ),
    );
  }
}

class _IconWrap extends StatelessWidget {
  const _IconWrap({
    super.key,
    // this.isSelected = false,
    required this.icon,
    required this.selectedIcon,
    required this.value,
    required this.groupValue,
    this.onPress,
  });
  // final bool isSelected;
  final IconData icon, selectedIcon;
  final HoverDestination value, groupValue;
  final void Function(HoverDestination)? onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: value == groupValue ? 2 : 1,
      child: GestureDetector(
        onTap: () => onPress != null ? onPress!(value) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: value == groupValue
                  ? LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ])
                  : null),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(value == groupValue ? selectedIcon : icon),
              const SizedBox(width: 4),
              value == groupValue
                  ? Text(
                      value.name[0].toUpperCase() + value.name.substring(1),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
