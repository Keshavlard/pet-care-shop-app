import 'package:flutter/material.dart';
import 'package:pet_care_shop/screens/pet_type_screen.dart';
import 'package:pet_care_shop/screens/vet_hospital_screen.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (title == 'Vet Hospital') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VetHospitalScreen()),
          );
        } else if (title == 'Shop Products') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PetTypeScreen()),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:pet_care_shop/screens/pet_type_screen.dart';
// import 'package:pet_care_shop/screens/vet_hospital_screen.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class CategoryCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color color;
//
//   const CategoryCard({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         // TODO: Add navigation or action
//         if (title == 'Vet Hospital') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const VetHospitalScreen()),
//           );
//         }
//         if(title == 'Shop Products'){
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => PetTypeScreen()),
//           );
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           // Using .withValues() to adjust opacity
//           color: color.withValues(alpha: (color.a * 0.1)),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: color.withValues(alpha: (color.a * 0.5))),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: color),
//             const SizedBox(height: 12),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
