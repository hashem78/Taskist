part of 'filtered_none_cubit.dart';

abstract class FilteredNoneState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredNoneInitial extends FilteredNoneState {
  @override
  List<Object> get props => [];
}

class FilteredNoneLoading extends FilteredNoneState {
  @override
  List<Object> get props => [];
}

class FilteredNoneLoaded extends FilteredNoneState {
  final List<TaskModel> taskListModel;

  FilteredNoneLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class FilteredNoneEmpty extends FilteredNoneState {
  final String message;

  FilteredNoneEmpty({this.message});

  @override
  List<Object> get props => super.props;
}

class FilteredNoneFailure extends FilteredNoneState {
  final String message;
  FilteredNoneFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class FilteredNoneRemoveSuccess extends FilteredNoneState {
  final String message;

  FilteredNoneRemoveSuccess(this.message);
  @override
  List<Object> get props => [message];
}
