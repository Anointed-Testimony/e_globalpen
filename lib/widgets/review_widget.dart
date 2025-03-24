import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Top Review", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: Text("View all")),
          ],
        ),
        Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage("https://via.placeholder.com/50")),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jane Cooper", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: 16))),
                Text("1 Dec 2023", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            )
          ],
        ),
        SizedBox(height: 5),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
