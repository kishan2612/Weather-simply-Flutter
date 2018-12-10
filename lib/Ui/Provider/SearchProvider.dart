import 'package:weatherapp/Ui/Bloc/SearchViewBloc.dart';
import 'package:flutter/material.dart';

class SearchProvider extends InheritedWidget {
  final SearchActivityBloc searchActivityBloc;

  SearchProvider({Key key, SearchActivityBloc searchActivityBloc, Widget child})
      : this.searchActivityBloc = searchActivityBloc,
        super(child: child, key: key);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static SearchActivityBloc of(BuildContext context) => 
  (context.inheritFromWidgetOfExactType(SearchProvider) as SearchProvider).searchActivityBloc;
}
