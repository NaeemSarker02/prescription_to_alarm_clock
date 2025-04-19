import 'package:flutter/material.dart';
import '../Utils/data.dart';


class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alarm',
                style: TextStyle(
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 248, 4, 4),
                    fontSize: 24
                ),
              ),
              Expanded(
                child: ListView(
                  children: alarms.map((alarm) {
                    return Container(
                      margin: EdgeInsets.only(bottom:32),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.red
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(4, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: const Color.fromARGB(255, 252, 252, 252),
                                    size: 24,
                                  ),
                                  SizedBox(width: 8,),
                                  Text('medicine',
                                    style: TextStyle(
                                        color: Colors.white, fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: (bool value) {},
                                value: true,
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                          Text('mon-fri',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'avenir'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('8:00 AM',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir',fontSize: 24, fontWeight: FontWeight.w700),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 35,
                            )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        )
    );
  }
}