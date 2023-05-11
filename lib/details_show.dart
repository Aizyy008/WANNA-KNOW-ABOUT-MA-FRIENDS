import 'package:People/example_four.dart';
import 'package:flutter/material.dart';

class DetailShowing extends StatefulWidget {
  String? n, e, a, url;
  int? i;

  DetailShowing(
      {Key? key,
      required this.n,
      required this.e,
      required this.a,
      required this.i,
      required this.url})
      : super(key: key);

  @override
  _DetailShowingState createState() => _DetailShowingState();
}

class _DetailShowingState extends State<DetailShowing> {
  bool showText = false;
bool showLess = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Hlo, ${widget.n} here"),
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.url.toString()),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          if (!showText && showLess)
            Text(
              "Want to know more about me??",
              style: TextStyle(color: Colors.white60),
              textAlign: TextAlign.center,
            ),
          if (!showText && showLess)
            TextButton(
                onPressed: () {
                  setState(() {
                    showText = true;
                    showLess = false;
                  });
                },
                child: Text(
                  "CLICK ME",
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )),
          if (showText)
            Expanded(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        '''My name is ${widget.n}, and I was born and raised in a small town in the ${widget.a}. My parents were both educators, and they instilled in me a love of learning from an early age. As a child, I spent hours reading books and exploring the natural world around me. I was always curious about how things worked and loved to take things apart and put them back together again.

When I was in high school, I discovered a passion for science and decided to pursue a degree in biology. I attended a prestigious university in the Northeast, where I was able to study under some of the world's leading researchers. After completing my undergraduate degree, I went on to earn a PhD in neuroscience.

Today, I am a research scientist at a top-tier research institution, where I study the neural mechanisms underlying complex behavior. I am passionate about my work and feel fortunate to be able to pursue my interests every day. In my free time, I enjoy hiking, gardening, and spending time with my family and friends.

Looking back on my life so far, I am grateful for the opportunities that my parents and education have afforded me. I hope to continue learning and growing in the years to come and to make a meaningful impact in the world through my research.''')))

       ,
        ],
      ),
    );
  }
}

void showText() {}
