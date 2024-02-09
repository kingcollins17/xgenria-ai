// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});
  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  int currentCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Explore ',
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'You can use any of our available templates to get results quickly',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Color(0xFFCACACA),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: GestureDetector(
                      onTap: () => setState(() => currentCategory = index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        constraints: BoxConstraints(minWidth: 100),
                        decoration: BoxDecoration(
                            color: index == currentCategory
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              categories[index].$1,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              categories[index].$2.length.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: index == currentCategory
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Catgory selector
            Column(
              children: [
                ...List.generate(
                    categories[currentCategory].$2.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              categories[currentCategory].$2[index],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

final categories = [
  ('Coding', ['Python', 'C++', 'Java', 'C#']),
  ('Formula Bot', ['Google Sheet', 'Excel']),
  ('Content', ['Instagram post', 'Blog posts'])
];
