import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../services/api_services.dart';
import '../services/notification_service.dart';
import '../widgets/joke_card.dart';
import 'joke_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final NotificationService notificationService = NotificationService();
  List<String> jokeTypes = [];
  List<Joke> favoriteJokes = [];

  @override
  void initState() {
    super.initState();
    notificationService.initialize();
    notificationService.showNotification('Шега на денот', 'Погледнете ја денешната шега!');
    _loadJokeTypes();
  }

  Future<void> _loadJokeTypes() async {
    try {
      jokeTypes = await apiService.getJokeTypes();
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes App 211193'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.pushNamed(context, '/randomJoke');
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: jokeTypes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: jokeTypes.length,
        itemBuilder: (context, index) {
          return JokeCard(
            type: jokeTypes[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JokeListScreen(type: jokeTypes[index]),
                ),
              );
            },
            onFavorite: () {
              setState(() {
                favoriteJokes.add(Joke(
                  type: jokeTypes[index],
                  setup: 'Example Setup',
                  punchline: 'Example Punchline',
                ));
              });
            },
          );
        },
      ),
    );
  }
}
