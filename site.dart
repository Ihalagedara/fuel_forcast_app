import 'package:flutter/material.dart';
import 'package:gen_fuel_data/request.dart';
import 'package:gen_fuel_data/class.dart';

class contain extends StatelessWidget {
  String first;
  String second;
  contain({required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListTile(
        title: Text(
          first.toString(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          second.toString(),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class SitePage extends StatefulWidget {
  //String? site_name;
  String? site_name;
  SitePage({this.site_name});

  //const SitePage({Key? key}) : super(key: key);

  @override
  State<SitePage> createState() => new _SitePageState();
}

class _SitePageState extends State<SitePage> {
  @override
  Widget build(BuildContext context) {
    String site_name = widget.site_name.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Site Page'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: RequestUtil.sitedetails(site_name),
        builder: (context, snapshot) {
          if (snapshot.hasData == null) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.toString().length,
              itemBuilder: (BuildContext context, index) {
                print(snapshot);
                return ListTile(
                  title: Text(snapshot.data.toString()[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
