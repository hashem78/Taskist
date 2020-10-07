part of 'filtered_high_cubit.dart';

abstract class FilteredHighState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredHighInitial extends FilteredHighState {
  @override
  List<Object> get props => [];
}

class FilteredHighLoading extends FilteredHighState {
  @override
  List<Object> get props => [];
}

class FilteredHighLoaded extends FilteredHighState {
  final List<TaskModel> taskListModel;

  FilteredHighLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class FilteredHighEmpty extends FilteredHighState {
  final String message;

  FilteredHighEmpty({this.message});

  @override
  List<Object> get props => super.props;
}

class FilteredHighFailure extends FilteredHighState {
  final String message;
  FilteredHighFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class FilteredHighRemoveSuccess extends FilteredHighState {
  final String message;

  FilteredHighRemoveSuccess(this.message);
  @override
  List<Object> get props => [message];
}
