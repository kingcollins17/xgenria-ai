// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SubscriptionPlan extends ConsumerStatefulWidget {
  const SubscriptionPlan({super.key});
  @override
  ConsumerState<SubscriptionPlan> createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends ConsumerState<SubscriptionPlan> {
  @override
  Widget build(BuildContext context) {
    var black = Colors.black;
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Ink(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(Icons.close, size: 20, color: Color(0xFF1F1F1F)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  children: List.generate(
                    _plans.length,
                    (index) => _PlanWidget(plan: _plans[index]),
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

class _PlanWidget extends StatelessWidget {
  const _PlanWidget({
    super.key,
    required this.plan,
  });
  final _PlanData plan;
  // final Color black;

  @override
  Widget build(BuildContext context) {
    const black = Colors.black;
    return Ink(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Colors.orangeAccent,
            Theme.of(context).colorScheme.primary
          ])),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: GoogleFonts.poppins(fontSize: 14, color: black),
            ),
            const SizedBox(height: 20),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  plan.price.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                      fontSize: 45, color: black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                Text(
                  '/month',
                  style: GoogleFonts.poppins(fontSize: 12, color: black),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Plan includes',
              style: GoogleFonts.poppins(fontSize: 14, color: black),
            ),
            const SizedBox(height: 15),
            ...List.generate(
                plan.features.length,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: black,
                            ),
                            child: Icon(Icons.check,
                                size: 10, color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            plan.features[index],
                            style:
                                GoogleFonts.poppins(fontSize: 14, color: black),
                          )
                        ],
                      ),
                    )),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF141414)),
                    ),
                    child: Text(
                      'Purchase Plan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

typedef _PlanData = ({
  double price,
  String name,
  List<String> features,
  // String tag
});

const _plans = <_PlanData>[
  (
    price: 0.0,
    name: 'Free',
    // tag: 'Simple',
    features: [
      'Incredible AI Model',
      '5 Artifacts and code',
      '1000 AI words per month',
      '25mb audio file transcription',
      '1 AI chat per month',
      'Unlimited chat messages per chat',
      '1 Project',
      'API access',
      'Text to Excel formula',
    ]
  ),
  (
    price: 9.99,
    name: 'Lite',
    // tag: 'Simple',
    features: [
      'Incredible AI Model',
      'Unlimited Artifacts and code',
      '10000 AI words per month',
      '25mb audio file transcription',
      '20 AI chat per month',
      'Unlimited chat messages per chat',
      '5 Projects ',
      'API access',
      'Text to Excel formula',
    ]
  ),
  (
    price: 19.99,
    name: 'Pro',
    // tag: 'Simple',
    features: [
      'Incredible AI Model',
      'Unlimited Artifacts and code',
      '50000 AI words per month',
      '25mb audio file transcription',
      '100 AI Images per month',
      '20 AI chat per month',
      'Unlimited chat messages per chat',
      '5 Projects',
      ' API access',
      'Text to Excel formula',
    ]
  ),
  (
    price: 29.99,
    name: 'Elite',
    // tag: 'Simple',
    features: [
      'Incredible AI Model',
      'Unlimited AI Documents',
      'Unlimited AI words per month',
      'Unlimited AI transcriptions per month',
      'Unlimited AI chat per month',
      'Unlimited chat messages per chat',
      'Unlimited Projects',
      ' API access',
      'Text to Excel formula',
    ]
  )
];
