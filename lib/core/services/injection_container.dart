// service locator
import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_tutorial/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_tutorial/src/authentication/domains/repositories/authentication_repository.dart';
import 'package:tdd_tutorial/src/authentication/domains/usecases/create_user.dart';
import 'package:tdd_tutorial/src/authentication/domains/usecases/get_users.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logics
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))

    // Usecases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))

    // DataSources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // External dependencies
    ..registerLazySingleton(() => http.Client());
}
