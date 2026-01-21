import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../core/network/network_info.dart';
import '../../core/services/hive_service.dart';
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/datasources/local/todo_local_datasource.dart';
import '../../data/datasources/local/settings_local_datasource.dart';
import '../../data/datasources/remote/todo_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/check_auth_usecase.dart';
import '../../domain/usecases/todo/get_todos_usecase.dart';
import '../../domain/usecases/todo/toggle_favorite_usecase.dart';
import '../../domain/usecases/todo/search_todos_usecase.dart';
import '../../domain/usecases/settings/update_theme_usecase.dart';
import '../../domain/usecases/settings/clear_cache_usecase.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/todo/todo_bloc.dart';
import '../../presentation/bloc/profile/profile_bloc.dart';
import '../../presentation/bloc/settings/settings_bloc.dart';
import '../../presentation/bloc/theme/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  final hiveService = HiveService();
  await hiveService.init();

  // Blocs
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl(),
    registerUseCase: sl(),
    logoutUseCase: sl(),
    checkAuthUseCase: sl(),
  ));
  
  sl.registerFactory(() => TodoBloc(
    getTodosUseCase: sl(),
    toggleFavoriteUseCase: sl(),
    searchTodosUseCase: sl(),
  ));
  
  sl.registerFactory(() => ProfileBloc(authRepository: sl()));
  
  sl.registerFactory(() => SettingsBloc(
    updateThemeUseCase: sl(),
    clearCacheUseCase: sl(),
    settingsRepository: sl(),
  ));
  
  sl.registerFactory(() => ThemeBloc(settingsRepository: sl()));

  // Use Cases - Auth
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  
  // Use Cases - Todo
  sl.registerLazySingleton(() => GetTodosUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => SearchTodosUseCase(sl()));
 
  // Use Cases - Settings
  sl.registerLazySingleton(() => UpdateThemeUseCase(sl()));
  sl.registerLazySingleton(() => ClearCacheUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(hiveService: sl()),
  );
  
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(hiveService: sl()),
  );

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(hiveService: sl()),
  );
  
  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(client: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );

  // External
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Core services
  sl.registerLazySingleton<HiveService>(() => hiveService);
}