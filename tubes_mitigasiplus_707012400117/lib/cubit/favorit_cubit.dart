
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(const <String>{});

  void tandai(String id) {
    emit(Set.unmodifiable({...state, id}));
  }

  void batalTandai(String id) {
    emit(
      Set.unmodifiable({...state}..remove(id)),
    );
  }

  void toggle(String id) {
    if (state.contains(id)) {
      batalTandai(id);
    } else {
      tandai(id);
    }
  }
}
