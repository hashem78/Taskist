part of 'filtered_medium_cubit.dart';

abstract class FilteredMediumState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredMediumInitial extends FilteredMediumState {
  @override
  List<Object> get props => [];
}

class FilteredMediumLoading extends FilteredMediumState {
  @override
  List<Object> get props => [];
}

class FilteredMediumLoaded extends FilteredMediumState {
  final List<TaskModel> taskListModel;

  FilteredMediumLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class FilteredMediumEmpty extends FilteredMediumState {
  final String message;

  FilteredMediumEmpty({this.message});

  @override
  List<Object> get props => super.props;
}

class FilteredMediumFailure extends FilteredMediumState {
  final String message;
  FilteredMediumFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class FilteredMediumRemoveSuccess extends FilteredMediumState {
  final String message;

  FilteredMediumRemoveSuccess(this.message);
  @override
  List<Object> get props => [message];
}
