import 'package:flutter/material.dart';

class SchoolDetailsPage extends StatefulWidget {
  const SchoolDetailsPage({super.key});

  @override
  State<SchoolDetailsPage> createState() => _SchoolDetailsPageState();
}

class _SchoolDetailsPageState extends State<SchoolDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'School Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.indigo, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: const Text(
                'Welcome to SM School',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.white,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
              'https://smiuakuebenglishschoolclub.wordpress.com/wp-content/uploads/2021/03/img_20201118_074752.jpg?w=750', // Replace with your image URL
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About SM School',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'SM School is dedicated to fostering a supportive and inclusive learning environment. Established in 1990, we aim to provide exceptional education through modern facilities, a passionate faculty, and a holistic approach to student development. We believe in nurturing every student’s academic and personal growth in a safe and engaging environment.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Our mission is to empower students to reach their full potential by providing a comprehensive education and fostering an environment that promotes lifelong learning and responsible citizenship.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    'https://www.smiu.edu.pk/themes/smiu/images/smiu-pic01.jpg', // Replace with your image URL
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFacilityItem(
                        'Library',
                        'A well-stocked library with a vast collection of books, journals, and digital resources.',
                        'https://static.vecteezy.com/system/resources/previews/004/720/296/non_2x/school-library-scene-with-happy-children-free-vector.jpg', // Replace with your image URL
                      ),
                      const SizedBox(height: 10),
                      _buildFacilityItem(
                        'Sports Complex',
                        'Modern sports facilities including a gymnasium, swimming pool, and playground for various sports activities.',
                        'https://l450v.alamy.com/450v/2e6ff2m/high-school-educational-facility-building-with-outdoor-sport-complex-and-school-bus-isometric-banner-abstract-vector-illustration-2e6ff2m.jpg', // Replace with your image URL
                      ),
                      const SizedBox(height: 10),
                      _buildFacilityItem(
                        'Science Labs',
                        'Advanced science laboratories equipped with the latest technology for experiments and research.',
                        'https://static.vecteezy.com/system/resources/previews/023/976/543/original/school-kids-study-chemistry-children-pupils-studying-science-and-writing-at-laboratory-class-blackboard-cartoon-illustration-vector.jpg', // Replace with your image URL
                      ),
                      const SizedBox(height: 10),
                      _buildFacilityItem(
                        'Art Room',
                        'Creative space for students to explore and develop their artistic talents with various art supplies and tools.',
                        'https://img.freepik.com/premium-vector/kids-painting-set-with-cartoon-young-artists-drawing-art-work-with-painting-tool_88272-2474.jpg', // Replace with your image URL
                      ),
                      _buildFacilityItem(
                        'Computer Lab',
                        'A state-of-the-art computer lab with internet access and software to support IT education and digital learning.',
                        'https://static.vecteezy.com/system/resources/thumbnails/003/531/902/small/classroom-scene-with-many-computers-on-desks-free-vector.jpg', // Replace with your image URL
                      ),
                      const SizedBox(height: 10),
                      _buildFacilityItem(
                        'Cafeteria',
                        'A clean and well-maintained cafeteria offering a variety of nutritious meals and snacks for students and staff.',
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiGF6XdJvMN3WGoAIb5J7hGSsGbLfa1Xr8Sg&s', // Replace with your image URL
                      ),
                      const SizedBox(height: 10),
                      _buildFacilityItem(
                        'Auditorium',
                        'An auditorium for school events, performances, and assemblies, providing a space for students to showcase their talents and for community gatherings.',
                        'https://thumbs.dreamstime.com/b/college-students-listening-to-professor-auditorium-vector-illustration-42666086.jpg', // Replace with your image URL
                      ),
                      const SizedBox(height: 10),
                      _buildFacilityItem(
                        'Playground',
                        'A safe and engaging playground area for younger students to play and develop physical skills.',
                        'https://static.vecteezy.com/system/resources/thumbnails/007/563/488/small_2x/hopscotch-on-playground-background-free-vector.jpg', // Replace with your image URL
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.deepOrange,
                          Colors.indigo,
                          Colors.deepOrange,
                          Colors.indigo
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const Text(
                        'Welcome to SM School, where learning and growth go hand in hand!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 8.0,
                              color: Colors.black,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityItem(String title, String description, String imageUrl) {
    return Row(
      children: [
        Expanded(
          child: Image.network(
            imageUrl,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.indigo.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
