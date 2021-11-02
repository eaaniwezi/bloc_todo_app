import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(LanguageState initialState) : super(initialState);

  LanguageState get initialState => LanguageState.initial();
  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is LoadLanguage) {
      yield LanguageState(locale: event.locale);
    }
  }

  @override
  void onChange(Change<LanguageState> change) {
    print(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(LanguageEvent event) {
    print(event);
    super.onEvent(event);
  }
}
