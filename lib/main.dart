import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toktok/config/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:toktok/infrastructure/datasources/pexel_video_datasource_impl.dart';
import 'package:toktok/infrastructure/repositories/video_post_repository_impl.dart';
import 'package:toktok/presentation/providers/discover_provider.dart';
import 'package:toktok/presentation/screens/discover/discover_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository = VideoPostRepositoryImpl(
      videosDataSource: PexelVideoDatasourceImpl()
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(videosRepository: videoPostRepository)
            ..loadNextPage()
        )
      ],
      child: MaterialApp(
        title: 'TokTok',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: const DiscoverScreen()
      ),
    );
  }
}
