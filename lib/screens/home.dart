// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, unused_field, unused_element, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/screens/templates.dart';

class XHome extends StatefulWidget {
  const XHome({super.key});

  @override
  State<XHome> createState() => _XHomeState();
}

class _XHomeState extends State<XHome> {
  _Destionation groupValue = _Destionation.Home;
  final screens = <Widget>[SizedBox(), XTemplates(), SizedBox(), SizedBox()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[1],
      bottomNavigationBar: NavigationBar(
        destinations: [
          _DestinationWidget(
            value: _Destionation.Home,
            groupValue: groupValue,
            icon: Icons.home,
            onPress: (p0) {
              setState(() {
                groupValue = p0;
              });
            },
          ),
          _DestinationWidget(
              value: _Destionation.Templates,
              groupValue: groupValue,
              onPress: (p0) {
                setState(() {
                  groupValue = p0;
                });
              },
              icon: Icons.twelve_mp_sharp),
          _DestinationWidget(
              value: _Destionation.Services,
              groupValue: groupValue,
              onPress: (p0) {
                setState(() {
                  groupValue = p0;
                });
              },
              icon: Icons.sensor_door),
          _DestinationWidget(
              value: _Destionation.Profile,
              groupValue: groupValue,
              onPress: (p0) {
                setState(() {
                  groupValue = p0;
                });
              },
              icon: Icons.person)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // shape: ,
        onPressed: () {},
        label: Row(
          children: [
            Text(
              'Create Project',
              style: GoogleFonts.poppins(
                  color: Color(0xFFE7E7E7), fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.add,
              color: Color(0xFFD1D1D1),
            ),
          ],
        ),
        // child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}

class _DestinationWidget extends StatelessWidget {
  const _DestinationWidget({
    super.key,
    required this.value,
    required this.groupValue,
    this.label,
    required this.icon,
    this.onPress,
  });
  final _Destionation value, groupValue;
  final String? label;
  final IconData icon;
  final void Function(_Destionation)? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress != null ? onPress!(value) : null;
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  value == groupValue ? Color(0x2B9E9E9E) : Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: value == groupValue ? 1.5 : 1,
                child: Icon(
                  icon,
                  size: 18,
                  color: value == groupValue
                      ? Theme.of(context).colorScheme.tertiary
                      : Color(0xFFCFCFCF),
                ),
              ),
              FittedBox(
                child: Text(
                  label ?? value.name,
                  style: GoogleFonts.quicksand(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum _Destionation { Home, Templates, Services, Profile }
