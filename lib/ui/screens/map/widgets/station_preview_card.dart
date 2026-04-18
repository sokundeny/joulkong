// import 'package:flutter/material.dart';

// class StationCard extends StatelessWidget {
//   final String name;
//   final int available;
//   final int total;
//   final String distance;
//   final String time;
//   final VoidCallback onTap;

//   const StationCard({
//     super.key,
//     required this.name,
//     required this.available,
//     required this.total,
//     required this.distance,
//     required this.time,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double progress = available / total;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 8,
//               offset: Offset(0, 4),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Top Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Column(
//                   children: [
//                     Text("$available",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text("docks", style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               ],
//             ),

//             const SizedBox(height: 8),

//             /// Location Info
//             Row(
//               children: [
//                 Icon(Icons.location_on, size: 14, color: Colors.grey),
//                 SizedBox(width: 4),
//                 Text(distance, style: TextStyle(color: Colors.grey)),
//                 SizedBox(width: 12),
//                 Icon(Icons.directions_walk, size: 14, color: Colors.grey),
//                 SizedBox(width: 4),
//                 Text(time, style: TextStyle(color: Colors.grey)),
//               ],
//             ),

//             const SizedBox(height: 12),

//             /// Progress bar
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: LinearProgressIndicator(
//                 value: progress,
//                 minHeight: 6,
//                 backgroundColor: Colors.grey[300],
//                 color: Colors.black,
//               ),
//             ),

//             const SizedBox(height: 6),

//             Align(
//               alignment: Alignment.centerRight,
//               child: Text("$available/$total",
//                   style: TextStyle(color: Colors.grey)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }