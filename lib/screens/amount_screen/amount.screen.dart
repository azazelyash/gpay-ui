import 'package:flutter/material.dart';
import 'package:gpay_ui/constants.dart';
import 'package:gpay_ui/screens/amount_screen/components/avatar.image.dart';
import 'package:gpay_ui/screens/amount_screen/provider/dropdown.service.dart';
import 'package:provider/provider.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({super.key});

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            color: Colors.black54,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 48,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarImage(
                      urlPath: 'assets/images/user1.jpg',
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black54,
                      size: 28,
                    ),
                    SizedBox(width: 4),
                    AvatarImage(
                      urlPath: 'assets/images/user2.jpg',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Payment to Yash Vishwakarma",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text("(sample@upiid)"),
                const SizedBox(height: 32),
                // Text("\$501", style: TextStyle(fontSize: 40)),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "₹ 0",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Text("Payment via UPI"),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add a note",
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, -2),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Consumer<DropdownService>(
                  builder: (context, value, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: value.selectedAccount,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 4,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          onChanged: (String? v) {
                            value.setBankAccount(v!);
                          },
                          items: value.accountDropdownList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    child: const Text("Proceed to Pay"),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Made with ❤️ by Yash Vishwakarma",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
