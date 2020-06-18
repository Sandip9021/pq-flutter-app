import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/view_models/home_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/ui/views/create_quiz_view.dart';
import 'package:pbquiz_app/ui/views/quiz_start_view.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel model = serviceLocator<HomeViewModel>();

  @override
  void initState() {
    model.getAllQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => model,
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  model.signOut().then((success) {
                    if (success) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    }
                  });
                },
                child: Text("Log out"),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          body: buildHomePage(context, model),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHomePage(BuildContext context, HomeViewModel model) {
    if (model.loading()) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (model.error()) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text('Error fetching quizes!!'),
        );
      } else {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: homePageCardList(context, model),
        );
      }
    }
  }

  Widget homePageCardList(BuildContext context, HomeViewModel model) {
    return ListView.builder(
      itemCount: model.quizList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: double.maxFinite,
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(Icons.movie),
              title: Text(
                '${model.quizList[index].quizName}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                '${model.quizList[index].quizDescription}',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizStartView(
                              quizId: model.quizList[index].quizId,
                            )));
              },
            ),
          ),
        );
      },
    );
  }

  Widget createQuiz() {
    return Container(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(Icons.movie),
              title: Text(
                'Create Quiz',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                ),
              ),
              subtitle: Text(
                'Create your own quiz and invite your firends.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.0,
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateQuizView()));
                    },
                    child: const Text("CREATE"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
