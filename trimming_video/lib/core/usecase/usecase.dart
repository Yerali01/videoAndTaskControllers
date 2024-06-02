import 'package:fpdart/fpdart.dart';
import 'package:trimming_video/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
