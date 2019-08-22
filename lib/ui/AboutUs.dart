import 'package:employees_benefits/models/Complaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

List<Complaint> complaints;

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
        backgroundColor: Color.fromRGBO(19, 46, 99, 10),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(
                child: Image.asset('assets/AboutUs.jpg'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'EVA Pharma is one of the leading branded generic pharmaceutical manufacturers in the EMEA region.\n '
              'With a CAGR of 30% over the past seven years, it has proudly earned the title of being the fastest growing pharmaceutical company in the region.\n'
              'EVA Pharma successfully operates in branded generics, OTC, food supplements, herbal medicines and veterinary products with 137 pharmaceutical products covering various therapeutic classes including; Neurology, Psychiatry, Cardiovascular, Orthopedics, GIT, Pediatrics, Urology, and Dermatology.\n'
              'The company is home to cutting edge facilities that are internationally recognized for innovation and the highest quality standards. \n'
              'Its exceptional facilities have earned the stamp of approval from international and regional authorities including European medicine agency, Health Canada, sFDA, & GCC enabling EVA Pharma to be a partner for some of the leading pharma companies in the globe ',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            Text(
              'Empower the fight for health and well-being as a Human Right.',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            Text(
              'To save and improve millions of lives in Africa and frontier markets by offering accessible, high quality branded medicines that meet specific local market needs through innovative research & product development, a passionate diverse top team and state of the art scale facilities. ',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'Website',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            GestureDetector(
                child: Text(
                  'http://www.evapharma.com',
                  style: TextStyle(
                      fontSize: 32,
                      decoration: TextDecoration.underline,
                      color: Colors.blue),
                ),
                onTap: _launchURL),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'Headquarters',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            Text(
              'Abdeen, Cairo',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'Year Founded',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            Text(
              '1997',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              'Specialties',
              style: TextStyle(
                fontSize: 36,
              ),
            ),
            Text(
              'Pharma, Pharmaceutical, Production, Quality, Sales, Research and Development, Medical Representative, Medical, Microbiology, HR, Engineer, Marketing, Sterile, Business Development, Supply Chain, Procurement, Sourcing, Planning',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'http://www.evapharma.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
