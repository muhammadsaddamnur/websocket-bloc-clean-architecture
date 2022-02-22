import 'package:coinapp/core/errors/failure.dart';
import 'package:coinapp/core/usecase/usecase.dart';
import 'package:coinapp/features/mini_ticker/domain/entities/mini_ticker.dart';
import 'package:coinapp/features/mini_ticker/domain/repoitory/mini_ticker_repository.dart';
import 'package:dartz/dartz.dart';

class StreamMiniTicker extends Usecase<Stream<MiniTicker>, NoParams> {
  final MiniTickerRepository repository;

  StreamMiniTicker(this.repository);

  @override
  Future<Either<Failure, Stream<MiniTicker>>> call(NoParams noParams) {
    return repository.streamMiniTicker();
  }
}
