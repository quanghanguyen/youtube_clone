import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class LoadRelativeVideoEvent extends DetailEvent {
  final String videoId;
  const LoadRelativeVideoEvent(this.videoId);

  @override
  List<Object?> get props => [videoId];
}

class LoadMoreVideoEvent extends DetailEvent {
  @override
  const LoadMoreVideoEvent();
  List<Object?> get props => throw UnimplementedError();
}