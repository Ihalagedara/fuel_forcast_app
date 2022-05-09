import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gen_fuel_data/critical.dart';
import 'package:gen_fuel_data/urgent.dart';
import 'package:gen_fuel_data/site.dart';
import 'package:gen_fuel_data/other.dart';
import 'package:gen_fuel_data/request.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Useful Flutter Code",
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _siteController = TextEditingController();

  String? site;

  String dropdownregion = 'Region';
  var regions = ['Region', 'All', 'Central', 'Nothern', 'Southern', 'Easern'];

  String dropdowndeport = 'Deport';
  var deports = ['Deport', 'All', 'Kandy', 'Kirunegala', 'Giriulla'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Gen Fuel Data"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _siteController,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0.8)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                width: 0.8,
                                color: Theme.of(context).primaryColor)),
                        hintText: "Search Site",
                        prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              //print(_siteController);
                              site =
                                  RequestUtil.sitedetails(_siteController.text)
                                      .toString();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SitePage(
                                            site_name: site,
                                          )));
                            }),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _siteController.text = '';
                            })),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: DropdownButtonHideUnderline(
                            child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 0.8),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: DropdownButton(
                                value: dropdownregion,
                                underline: Container(),
                                borderRadius: BorderRadius.circular(30),
                                items: regions.map((String regions) {
                                  return DropdownMenuItem(
                                    value: regions,
                                    child: Text("Regions"),
                                  );
                                }).toList(),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                hint: const Text('Regions'),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownregion = newValue!;
                                  });
                                }),
                          ),
                        ))),
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: DropdownButtonHideUnderline(
                            child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 0.8),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: DropdownButton(
                                borderRadius: BorderRadius.circular(30),
                                underline: Container(),
                                value: dropdowndeport,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: deports.map((String deports) {
                                  return DropdownMenuItem(
                                    value: deports,
                                    child: Text("Deports"),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdowndeport = newValue!;
                                  });
                                }),
                          ),
                        ))),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 244, 86, 54),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 23),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 244, 86, 54))),
                          child: FutureBuilder(
                            future: RequestUtil.less30(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text("Critical Sites\n" +
                                    snapshot.data.toString());
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CriticalPage()))
                          },
                        ),
                      )),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 244, 133, 54),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 23),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 244, 133, 54))),
                          child: FutureBuilder(
                            future: RequestUtil.less100(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text("Urgrnt Sites\n" +
                                    snapshot.data.toString());
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UrgentPage()));
                          },
                        ),
                      ),
                    )),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 25, 169, 9),
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 23),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 25, 169, 9))),
                          child: FutureBuilder(
                            future: RequestUtil.less200(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    "Other Sites\n" + snapshot.data.toString());
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OtherPage()));
                          },
                        ),
                      ),
                    ))
              ]),
            )));
  }
}
