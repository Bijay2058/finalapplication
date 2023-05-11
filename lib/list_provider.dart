

import 'package:flutter/cupertino.dart';
class laterMovieListProvider extends ChangeNotifier{
  List names = [];
  List watchedseasons=[];
  List watchedepisodes=[];
  List totalepisodes=[];
  List posters=[];



  add(String name,String watchedseason,String watchedpisode,String poster,String totalepisode)
  {
    if(names.contains(name)==false)
    {
      names.add(name);
      watchedseasons.add(watchedseason);
      watchedepisodes.add(watchedpisode);
      totalepisodes.add(totalepisode);
      posters.add(poster);
    }}


    pop(String name,String watchedseason,String watchedpisode,String poster,String totalepisode) {
      names.remove(name);
      watchedseasons.remove(watchedseason);
      watchedepisodes.remove(watchedpisode);
      posters.remove(poster);
      totalepisodes.remove(totalepisode);
    }



  }


class completedMovieListProvider extends ChangeNotifier{
  List names = [];
  List watchedseasons=[];
  List watchedepisodes=[];
  List totalepisodes=[];
  List posters=[];


  add(String name,String watchedseason,String watchedpisode,String poster,String totalepisode)
  {
    if(names.contains(name)==false)
    {
      names.add(name);
      watchedseasons.add(watchedseason);
      watchedepisodes.add(watchedpisode);
      totalepisodes.add(totalepisode);
      posters.add(poster);
    }
    print(names);
    print(watchedseasons);
    print(watchedepisodes);
    print(totalepisodes);
  }
  pop(String name,String watchedseason,String watchedpisode,String poster,String totalepisode) {
    names.remove(name);
    watchedseasons.remove(watchedseason);
    watchedepisodes.remove(watchedpisode);
    posters.remove(poster);
    totalepisodes.remove(totalepisode);
  }
}

class MovieListProvider extends ChangeNotifier{
  List names = [];
  List watchedseasons=[];
  List watchedepisodes=[];
  List totalepisodes=[];
  List posters=[];


  add(String name,String watchedseason,String watchedpisode,String poster,String totalepisode)
  {
    if(names.contains(name)==false)
    {
      names.add(name);
      watchedseasons.add(watchedseason);
      watchedepisodes.add(watchedpisode);
      totalepisodes.add(totalepisode);
      posters.add(poster);
    }
    print(names);
    print(watchedseasons);
    print(watchedepisodes);
    print(totalepisodes);
  }
  pop(String name,String watchedseason,String watchedpisode,String poster,String totalepisode) {
    names.remove(name);
    watchedseasons.remove(watchedseason);
    watchedepisodes.remove(watchedpisode);
    posters.remove(poster);
    totalepisodes.remove(totalepisode);
  }
}




