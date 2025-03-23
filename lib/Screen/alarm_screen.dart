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
                    color: Color.fromARGB(255, 156, 37, 37),
                    fontSize: 24
                ),
              ),
              Expanded(
                child: ListView(
                  children: alarms.map((alarm) {
                    return Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 87, 26, 110), Color.fromARGB(
                              255, 241, 44, 159)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        children:<Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: Colors.white,
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