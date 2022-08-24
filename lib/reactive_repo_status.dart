import 'package:collection/collection.dart';

enum ReactiveRepoStatus {
  initial,
  initialLoading,
  initialFailure,
  initialSuccess,
  updateLoading,
  updateFailure,
  updateSuccess,
}

extension ReactiveRepoStatusX on ReactiveRepoStatus {
  bool get expectData => [
    ReactiveRepoStatus.initialSuccess,
    ReactiveRepoStatus.updateLoading,
    ReactiveRepoStatus.updateFailure,
    ReactiveRepoStatus.updateSuccess,
  ].contains(this);

  bool get isInitial => this == ReactiveRepoStatus.initial;

  bool get isLoading => [ReactiveRepoStatus.initialLoading, ReactiveRepoStatus.updateLoading].contains(this);

  bool get isFailure => [ReactiveRepoStatus.initialFailure, ReactiveRepoStatus.updateFailure].contains(this);

  bool get isSuccess => [ReactiveRepoStatus.initialSuccess, ReactiveRepoStatus.updateSuccess].contains(this);

  static ReactiveRepoStatus? getDependencyImpliedStatus(List<ReactiveRepoStatus> statusOfDependencies) {
    return [
      ReactiveRepoStatus.initialFailure,
      // ReactiveRepoStatus.updateFailure,
      ReactiveRepoStatus.initial,
      ReactiveRepoStatus.initialLoading,
      ReactiveRepoStatus.updateLoading,
      // ReactiveRepoStatus.initialSuccess,
      // ReactiveRepoStatus.updateSuccess,
    ].firstWhereOrNull((s1) => statusOfDependencies.any((s2) => s1 == s2));
  }
}
