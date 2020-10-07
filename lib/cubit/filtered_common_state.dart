part of 'filtered_common_cubit.dart';

@immutable
abstract class FilteredCommonState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredCommonInitial extends FilteredCommonState {
  @override
  List<Object> get props => [];
}

class FilteredCommonLoading extends FilteredCommonState {
  @override
  List<Object> get props => [];
}

class FilteredCommonLoaded extends FilteredCommonState {
  final List<TaskModel> taskListModel;

  FilteredCommonLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class FilteredCommonEmpty extends FilteredCommonState {
  final String message;

  FilteredCommonEmpty({this.message});

  @override
  List<Object> get props => super.props;
}

class FilteredCommonFailure extends FilteredCommonState {
  final String message;
  FilteredCommonFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class FilteredCommonRemoveSuccess extends FilteredCommonState {
  final String message;

  FilteredCommonRemoveSuccess(this.message);
  @override
  List<Object> get props => [message];
}
