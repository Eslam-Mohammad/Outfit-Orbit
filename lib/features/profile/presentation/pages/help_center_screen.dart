import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.asset("assets/images/logo2.png")),
              const SizedBox(width: 8),
              const Text("Help Center",style: TextStyle(fontSize: 30),
                  ),
            ],
          ),
          const Text(
            "Get help with your account, orders, and more."
            ,style: TextStyle(fontSize: 16),

          ),
          const SizedBox(height: 24),
          const ExpansionTile(
            title: Text('How can I track my order?',style: TextStyle(fontSize: 18),),
            children: <Widget>[
              ListTile(
                title: Text(style: TextStyle(fontSize: 18),'Once your order is shipped, we’ll send you an email with a tracking link. You can also check the status of your order by logging into your account, navigating to "My Orders," and selecting the relevant order to see real-time updates.'),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What is your return policy?',style: TextStyle(fontSize: 18),),
            children: <Widget>[
              ListTile(
                title: Text(style: TextStyle(fontSize: 18),'We accept returns within 30 days of the delivery date. Items must be unused, with original tags and packaging. To initiate a return, go to "My Orders," select the item, and follow the return instructions. Please note that final sale items are non-refundable.'),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('How can I contact customer support?',style: TextStyle(fontSize: 18),),
            children: <Widget>[
              ListTile(
                title: Text(style: TextStyle(fontSize: 18),'You can reach our customer support team via live chat on our website, email at support@yourecommerce.com, or by calling (123) 456-7890. Our team is available Monday to Friday, 9 am - 6 pm EST.'),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What payment methods do you accept?',style: TextStyle(fontSize: 18),),
            children: <Widget>[
              ListTile(
                title: const Text(style: TextStyle(fontSize: 18),'We accept various payment methods, including major credit cards (Visa, MasterCard, American Express), PayPal, Apple Pay, and Google Pay. All payments are securely processed, and your details are protected with advanced encryption.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
