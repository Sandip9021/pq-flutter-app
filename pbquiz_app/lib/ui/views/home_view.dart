import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/business_logic/view_models/home_viewmodel.dart';
import 'package:pbquiz_app/ui/shared/ui_helper.dart';
import 'package:pbquiz_app/ui/views/base_view.dart';
import 'package:pbquiz_app/ui/widgets/main_menu.dart';
import 'package:provider/provider.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.getAllQuiz(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  model.signOut().then((success) {
                    if (success) {
                      Navigator.pushNamed(context, initialRoute);
                    }
                  });
                },
                child: Text("Log out"),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Welcome ${Provider.of<User>(context).name},',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Here are all the quizes for you',
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Expanded(
                      child: quizList(context, model),
                    ),
                  ],
                ),
          drawer: MainMenu(),
        );
      },
    );
  }

  Widget quizList(BuildContext context, HomeViewModel model) {
    return ListView.builder(
      itemCount: model.quizList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 15.0),
          child: Card(
            elevation: 3,
            color: Colors.white,
            shadowColor: Theme.of(context).primaryColor,
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
                Navigator.pushNamed(
                  context,
                  startQuizRoute,
                  arguments: model.quizList[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
