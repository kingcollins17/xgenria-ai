// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xgenria/models/access_token.dart';
import 'package:xgenria/providers/providers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key, required this.token});
  final AccessToken token;
  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  int currentCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    final templatesData = ref.watch(templatesProvider(widget.token));

    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
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
                  child: templatesData.isLoading
                      ? Center(
                          child: SpinKitRipple(
                              color: Theme.of(context).colorScheme.primary,
                              size: 30),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: templatesData.value!.categories!.length,
                          itemBuilder: (context, index) => Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: GestureDetector(
                                onTap: () => setState(
                                    () => currentCategoryIndex = index),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  constraints: BoxConstraints(minWidth: 100),
                                  decoration: BoxDecoration(
                                      color: index == currentCategoryIndex
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        () {
                                          final value = templatesData.value!;
                                          return value.categories![index].name;
                                        }(),
                                        style:
                                            GoogleFonts.quicksand(fontSize: 14),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        () {
                                          final value = templatesData.value!;
                                          return value.templates!
                                              .where((element) =>
                                                  element.categoryId ==
                                                  value
                                                      .categories![
                                                          currentCategoryIndex]
                                                      .id)
                                              .length
                                              .toString();
                                        }(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: index == currentCategoryIndex
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
                        )),
              //Catgory selector
              Builder(builder: (context) {
                final value = templatesData.value;
                if (value == null) return Center();

                final temps = value.templates!
                    .where((element) =>
                        element.categoryId ==
                        value.categories![currentCategoryIndex].id)
                    .toList();

                return Column(
                  children: [
                    if (!templatesData.isLoading)
                      ...List.generate(
                          temps.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/create-doc', arguments: (
                                      temps,
                                      value.categories![currentCategoryIndex],
                                      index,
                                    ));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
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
                                      temps[index].name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    const SizedBox(height: 100)
                  ],
                );
              })
            ],
          ),
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
