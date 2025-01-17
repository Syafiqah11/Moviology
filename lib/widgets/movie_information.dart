import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/watch_later.dart';
import 'package:movie_app/states/bookmarks.dart';
import 'package:movie_app/widgets/alert.dart' as alert;

//display movie information
class MovieInformation extends StatelessWidget {
  const MovieInformation({required this.movieModel, Key? key})
      : super(key: key);

  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 20);
    const rowSpacer = SizedBox(width: 10);

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  _moviePhoto(movieModel),
                  const SizedBox(width: 25),
                  _cardDetails(movieModel, spacer)
                ],
              ),
              _playButton(context, movieModel),
              Row(
                children: [_moreDetails(movieModel, spacer, rowSpacer)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardDetails(MovieModel movieModel, SizedBox spacer) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
              ),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.video_camera_back,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      movieModel.genre,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Genre',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          spacer,
          SizedBox(
            width: 100.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
              ),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.watch_later,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      movieModel.runtime,
                    ),
                    const Text(
                      'Duration',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          spacer,
          SizedBox(
            width: 100.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
              ),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      movieModel.ratings.first.value,
                    ),
                    const Text(
                      'Rating',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviePhoto(MovieModel movieModel) {
    return Expanded(
      flex: 4,
      child: Hero(
        tag: movieModel.poster,
        child: Container(
          width: 200,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            backgroundBlendMode: BlendMode.color,
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: NetworkImage(movieModel.poster),
            ),
          ),
        ),
      ),
    );
  }

  Widget _playButton(context, MovieModel movieModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: 400,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purpleAccent),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 20)),
              elevation: MaterialStateProperty.all(10),
              shadowColor: MaterialStateProperty.all(Colors.white),
              alignment: Alignment.center,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                // side: BorderSide(color: Colors.red)
              ))),
          onPressed: () {
            bookMovies(context);
            BlocProvider.of<BookmarkCubit>(context).addBookmark(movieModel);
          },
          // onPressed: () {
          //   BlocProvider.of<BookmarkCubit>(context).addBookmark(movieModel);
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => WatchLater(
          //                 movieName: movieModel.title,
          //               )));
          // },
          icon: const Icon(Icons.play_arrow, size: 30),
          label: const Text(
            'Watch Later',
            style: TextStyle(fontWeight: FontWeight.bold),
            //   // alert.toastAlert(
            //   //   message: "Movie added to Favorites",
            //   //   themeColor: widget.themeColor,
            //   // );
          ),
        ),
      ),
    );
  }

  void bookMovies(BuildContext context) {
    var alertDialog = CupertinoAlertDialog(
      // backgroundColor: Colors.blue,
      title: Text("Movie has been added to Favourite list."),
      content: Text("Enjoy your movies 😀"),
      actions: [
        MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Okay'),
            )),
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }

  Widget _moreDetails(
      MovieModel movieModel, SizedBox spacer, SizedBox rowSpacer) {
    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spacer,
          Text(
            movieModel.title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          spacer,
          const Text(
            'Plot Summary',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            movieModel.plot,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          spacer,
          const Text(
            'Cast',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            movieModel.actors,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          spacer,
          const Text(
            'Award',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            movieModel.awards,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
