import 'package:flutter/material.dart';
import 'package:showbox/widgets/coming_soon_movie_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text(
              'New & Hot',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.cast,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: Colors.blue,
                  height: 27,
                  width: 27,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: false,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: '  🍿 Coming Soon  ',
                ),
                Tab(
                  text: "  🔥 Everyone's watching  ",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ComingSoonMovieWidget(
                      imageUrl: 'https://www.heavenofhorror.com/wp-content/uploads/2024/07/The-Platform-2-horror.jpg',
                      overview: 'In a dystopian world, the inhabitants of a mysterious platform must fight for their survival as they confront the horrors of their reality.',
                      logoUrl: 'https://occ-0-2186-2164.1.nflxso.net/dnm/api/v6/tx1O544a9T7n8Z_G12qaboulQQE/AAAABTQ2IELim8-Pm4BY_vc6EBGHPO-Je-yQYu392YV4gFcSCDV-wX82EhWNYI55ZroSW7ATrcNoiUcH8LZq_zZkZw3VpxR4JwE-ndyFzv1M9fsx4J2jdQRyCIId4gDteNUlriYMUfpGF3SlUF5FsegyGZWzY1w7ARFWpeigaPEpvLuZRGkisGvc.webp?r=151', // Updated logo
                      month: 'Sep',
                      day: '30',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://static.wikia.nocookie.net/blue-box/images/d/d9/Blue_Box_Anime_KV_1.jpg/revision/latest/smart/width/386/height/259?cb=20231119195901',
                      overview: 'A group of friends discover a blue box that grants them their deepest desires, but they soon learn that wishes come with a price.',
                      logoUrl: 'https://occ-0-2186-2164.1.nflxso.net/dnm/api/v6/tx1O544a9T7n8Z_G12qaboulQQE/AAAABQKVMm6uyhFEwQz66fGV7u0-WioSoNoHcEM2siByUJb9KTfNGscD_TBjaz0h8oWR3i56IoaY3MMjDl-hrvsavEPL4k3ZRnCxz2ty6XwTRo79XBqBIpZXCR-odTMZVqifSW9aU_cjxSl1ECdYtB7VhSRjNnl6-eJY4kSzcoD1OwVKTUemgJ7q.webp?r=753', // Updated logo
                      month: 'Oct',
                      day: '15',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBVKKdiJ6oUWDmT95laNvFVeDpdOqdTdFERkWC-C_qQfpZSCGhrP7CV6H5&s=10',
                      overview: 'A group of teenagers cheats death, only to find that it is relentless in its pursuit, leading to a terrifying game of survival.',
                      logoUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Final_Destination_3_logo.png',
                      month: 'Jan',
                      day: '20',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSopScwvHS74EyNw7ANXpCa2YV_eOJrR10RJP2rZESe5WQ4MUIxV5V9j5UY&s=10',
                      overview: 'A quiet town experiences a series of bizarre events on Christmas Eve, leading to a shocking revelation about their past.',
                      logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1pF2tGJJ-AmML2exXsWCRXu6kQcVUMgKcV8UrDJ21Y-c8AV78wDNuWhHt&s=10', // Updated logo
                      month: 'Dec',
                      day: '24',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCBmw1DG2fIBYeSfB0ulCNLj4NJWrzDRL2xpZ-T4adBoCMCg--1JmXBBA&s=10',
                      overview: 'When a high-flying investor falls from grace, he must navigate the dark underbelly of the financial world to redeem himself.',
                      logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREzapFiXgFWakHzeX14MdihgDPlatCnN7NGDH6kFhWSRqvxHfzzojcHL4&s=10', // Updated logo
                      month: 'Aug',
                      day: '30',
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ComingSoonMovieWidget(
                      imageUrl: 'https://www.thebatman.com/images/banner_img_mobile.jpg',
                      overview: 'Batman ventures into Gotham City\'s underworld when a sadistic killer leaves behind a trail of cryptic clues.',
                      logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrlgjGQdXJzPxtJKkh9H03EGVQpxQu6Ds-Zw&usqp=CAU', // Logo for The Batman
                      month: 'Mar',
                      day: '4',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ--T5e1_I4r8cDJNoT8Mu8TZ2KTmIa9cJSQg&usqp=CAU',
                      overview: 'Peter Parker faces new threats as he navigates the multiverse with the help of Doctor Strange.',
                      logoUrl: 'https://cdn.marvel.com/content/prod/2x/serenitynowtitle_mas_mob.jpg', // Logo for Spider-Man: No Way Home
                      month: 'Dec',
                      day: '17',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdJqmuagXYx0KDh2lh9hQAOJHeG3jxFVV0PA&usqp=CAU',
                      overview: 'A noble family becomes embroiled in a battle for control over the galaxy\'s most valuable asset while its heir becomes troubled by visions of a dark future.',
                      logoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1pB202l6uqQB3s6xJnNER1Tp7IMi0KihfJuAPMO6YgCKc2q5iWzB3V8w&s=10', // Logo for Dune
                      month: 'Oct',
                      day: '22',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://occ-0-8407-2219.1.nflxso.net/dnm/api/v6/Qs00mKCpRvrkl3HZAN5KwEL1kpE/AAAABY6otnD2sqmfxJQoQ6BhKU4W5KZSV8pyJIcfNaQy5C_1DiKLZkVvgjQSOhTlnG23w4VwU14ERZLShMysmN_X0hV2FqMTduVAlbgb.jpg?r=793',
                      overview: 'Ed and Lorraine Warren lock Annabelle away, but when their daughter Judy accidentally releases her, they must face the unleashed evil.',
                      logoUrl: 'https://occ-0-8407-2219.1.nflxso.net/dnm/api/v6/LmEnxtiAuzezXBjYXPuDgfZ4zZQ/AAAABSsdhvclZ38BstAtHhzzlJ4JzOwU50YOHQHay-8wD7o4nyY_X6aZz62fGya9d6LZJDOYnpToAujUdET0vIeT6VEvdMrnqmBDPCvBaGYz6fuB.png?r=2d9', // Logo for Black Widow
                      month: 'Jul',
                      day: '9',
                    ),
                    SizedBox(height: 20),
                    ComingSoonMovieWidget(
                      imageUrl: 'https://occ-0-8407-999.1.nflxso.net/dnm/api/v6/6AYY37jfdO6hpXcMjf9Yu5cnmO0/AAAABS6v2gvwesuRN6c28ZykPq_fpmnQCJwELBU-kAmEcuC9HhWX-DfuDbtA-bfo-IrfgNtxl0qwJJlhI6DENsGFXknKkjhxPGTV-qhp.jpg?r=608',
                      overview: 'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                      logoUrl: "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                      month: "Jun",
                      day: "19",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}