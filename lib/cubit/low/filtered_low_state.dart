part of 'filtered_low_cubit.dart';

abstract class FilteredLowState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilteredLowInitial extends FilteredLowState {
  @override
  List<Object> get props => [];
}

class FilteredLowLoading extends FilteredLowState {
  @override
  List<Object> get props => [];
}

class FilteredLowLoaded extends FilteredLowState {
  final List<TaskModel> taskListModel;

  FilteredLowLoaded(this.taskListModel);
  @override
  List<Object> get props => [taskListModel];
}

class FilteredLowEmpty extends FilteredLowState {
  final String message;

  FilteredLowEmpty({this.message});

  @override
  List<Object> get props => super.props;
}

class FilteredLowFailure extends FilteredLowState {
  final String message;
  FilteredLowFailure({
    this.message,
  });
  @override
  List<Object> get props => [message];
}

class FilteredLowRemoveSuccess extends FilteredLowState {
  final String message;

  FilteredLowRemoveSuccess(this.message);
  @override
  List<Object> get props => [message];
}
