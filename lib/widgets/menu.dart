import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final radius = 50.0;
final height = 50.0;

class HoverMenu extends StatefulWidget {
  const HoverMenu({super.key});

  @override
  State<HoverMenu> createState() => _HoverMenuState();
}

enum _Destination { home, explore, projects, me }

class _HoverMenuState extends State<HoverMenu> {
  var groupValue = _Destination.home;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: height,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Color(0xFF313131),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _IconWrap(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                value: _Destination.home,
                groupValue: groupValue,
                onPress: (p0) => setState(() => groupValue = p0),
              ),
              _IconWrap(
                icon: Icons.explore_outlined,
                selectedIcon: Icons.explore_rounded,
                value: _Destination.explore,
                groupValue: groupValue,
                onPress: (p0) => setState(() => groupValue = p0),
              ),
              _IconWrap(
                icon: Icons.grid_view_outlined,
                selectedIcon: Icons.grid_view_rounded,
                value: _Destination.projects,
                groupValue: groupValue,
                onPress: (p0) => setState(() => groupValue = p0),
              ),
              _IconWrap(
                icon: Icons.person_4_outlined,
                selectedIcon: Icons.person_rounded,
                value: _Destination.me,
                groupValue: groupValue,
                onPress: (p0) => setState(() => groupValue = p0),
              ),
            ],
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
  final _Destination value, groupValue;
  final void Function(_Destination)? onPress;

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
