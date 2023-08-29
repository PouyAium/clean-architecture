
import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';

typedef ResultFuture<Right> = Future<Either<Failure, Right>>;

typedef ResultVoid = ResultFuture<void>;