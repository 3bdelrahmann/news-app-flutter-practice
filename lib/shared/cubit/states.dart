abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBotNavState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppGetTechnologyLoadingState extends AppStates {}

class AppGetTechnologySuccessState extends AppStates {}

class AppGetTechnologyErrorState extends AppStates {
  final String error;

  AppGetTechnologyErrorState(this.error);
}

class AppGetSportsLoadingState extends AppStates {}

class AppGetSportsSuccessState extends AppStates {}

class AppGetSportsErrorState extends AppStates {
  final String error;

  AppGetSportsErrorState(this.error);
}

class AppGetHealthLoadingState extends AppStates {}

class AppGetHealthSuccessState extends AppStates {}

class AppGetHealthErrorState extends AppStates {
  final String error;

  AppGetHealthErrorState(this.error);
}

class AppGetSearchLoadingState extends AppStates {}

class AppGetSearchSuccessState extends AppStates {}

class AppGetSearchErrorState extends AppStates {
  final String error;

  AppGetSearchErrorState(this.error);
}
