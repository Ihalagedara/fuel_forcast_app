import 'package:flutter/material.dart';
import 'package:gen_fuel_data/site.dart';

class siteList extends StatelessWidget {
  siteList(
      {@required this.siteId, @required this.name, @required this.priority});
  String? siteId;
  String? name;
  String? priority;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 5,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SitePage(
                            site_name: siteId,
                          )));
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: name.toString() +
                            "  (" +
                            siteId.toString() +
                            ")" +
                            "\n",
                        style: const TextStyle(fontSize: 20)),
                    TextSpan(
                        text: priority.toString(),
                        style: const TextStyle(fontSize: 17))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class CriticalPage extends StatefulWidget {
  const CriticalPage({Key? key}) : super(key: key);

  @override
  State<CriticalPage> createState() => _CriticalPageState();
}

class _CriticalPageState extends State<CriticalPage> {
  String dropdownEnCat = 'All';
  var encat = ['All', 'FTG', 'Hiring FTG', 'STBG'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Critical Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: DropdownButtonHideUnderline(
                  child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: DropdownButton(
                      value: dropdownEnCat,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(30),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: encat.map((String encat) {
                        return DropdownMenuItem(
                          value: encat,
                          child: Text(encat),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownEnCat = newValue!;
                        });
                      }),
                ),
              ))),
          siteList(
            name: "site",
            priority: "A+",
            siteId: 'KA0001',
          )
        ],
      ),
    );
  }
}
