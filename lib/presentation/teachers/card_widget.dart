import "package:flutter/material.dart";

Widget CardWidget(BuildContext context, IconData icon, String title,
    String value, Color color, Color iconColor,
    {required Function() onTap}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(9),
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 160,
            height: 120,
            child: Container(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(59, 60, 61, 0.094),
                    blurRadius: 5,
                    offset: Offset(-2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            color, // Change the color of the circle background
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(62, 0, 0, 0),
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(icon,
                          color: iconColor // Change the color of the chart icon
                          ),
                    ),
                  ),
                  const Spacer(), // Adjust the spacing between the chart icon and the text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 126, 127, 135),
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 126, 127, 135),

                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
      ),
    ),
  );
}
