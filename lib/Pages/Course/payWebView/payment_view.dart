import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:learningapplication/Pages/Course/payWebView/Bloc/payview_blocs.dart';
import 'package:learningapplication/Pages/Course/payWebView/Bloc/payview_events.dart';
import 'package:learningapplication/Pages/Course/payWebView/Bloc/payview_states.dart';



class PayWebView extends StatefulWidget {
  const PayWebView({super.key});

  @override
  State<PayWebView> createState() => _PayWebViewState();
}

class _PayWebViewState extends State<PayWebView> {


  @override
  void initState(){
    super.initState();

  }

  void didChangeDependencies(){
    super.didChangeDependencies();
    final args=ModalRoute.of(context)!.settings.arguments as Map;
    context.read<PayWebViewBlocs>().add(TriggerWebView(args["url"]));



  }

  @override
  Widget build(BuildContext context) {



    return BlocBuilder<PayWebViewBlocs,PayWebViewStates>(builder: (context,state)
    {
      return Scaffold(
          appBar: AppBar(title: Text("Payment", style: TextStyle(color: Colors.blue),),),
          body:state.url ==""?Container (child: CircularProgressIndicator(),):InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(state.url)

    )
      )
      );
    }
    );
  }
}
