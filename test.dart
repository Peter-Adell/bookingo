import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/ticket.png"),
            fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 40, top: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Patient name : ahmed ali",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                      .withOpacity(.5)),
                            ),
                            Text(
                              "Phone Num : 01222222222",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                      .withOpacity(.5)),
                            ),
                            Text(
                              "Reservation number : 18",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                      .withOpacity(.5)),
                            ),
                            Text(
                              "Clinic number : 8",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                                      .withOpacity(.5)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/cancel.png'),
                        SizedBox(width: 5),
                        Image.asset('assets/icons/help.png'),
                        SizedBox(width: 5),
                        Image.asset('assets/icons/23.png'),
                        SizedBox(width: 5),
                        Image.asset('assets/icons/30.png'),
                        SizedBox(width: 5),
                        Image.asset(
                            'assets/icons/location.png'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Image.asset('assets/icons/qr_code.png')),
                    SizedBox(width: 5),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 70,
                        width: 80,
                        child: Image.asset('assets/icons/number.png')),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
