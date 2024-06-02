part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initTask();
  final firebaseF = FirebaseFirestore.instance;

  serviceLocator.registerLazySingleton(() => firebaseF);
}

void _initTask() {
  //datasource
  serviceLocator
    ..registerFactory<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImplementation(
        serviceLocator(),
      ),
    )
    //repository
    ..registerFactory<TaskRepository>(
      () => TaskRepositoryImplementation(
        serviceLocator(),
      ),
    )
    //usecases
    ..registerFactory(
      () => UploadTask(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllTasks(
        serviceLocator(),
      ),
    )
    //bloc
    ..registerLazySingleton(
      () => TaskBlocBloc(
        uploadTask: serviceLocator(),
        getAllTasks: serviceLocator(),
      ),
    );
}
