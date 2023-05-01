import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/exception.dart';

import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/data/data_source/local/local_data_source.dart';
import 'package:elmuslim_app/data/mapper/mapper.dart';
import 'package:elmuslim_app/domain/models/adhkar/adhkar_model.dart';

import 'package:elmuslim_app/domain/models/hadith/hadith_model.dart';

import 'package:elmuslim_app/domain/models/quran/quran_model.dart';

import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<AdhkarModel>>> getAdhkarData() async {
    final data = await _localDataSource.getAdhkarData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<HadithModel>>> getHadithData() async {
    final data = await _localDataSource.getHadithData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<QuranModel>>> getQuranData() async {
    final data = await _localDataSource.getQuranData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(failure.message));
    }
  }
}
