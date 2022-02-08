import 'package:mightyweb/utils/images.dart';

class Example {
  final String? title;
  List<ExampleModel>? contents = [];

  Example({
    this.title,
    this.contents,
  });
}

List<Example> mExample = [
  Example(
    title: 'Bus Booking',
    contents: [
      ExampleModel("Makemytrip", "https://www.makemytrip.com/", ic_demo1),
      ExampleModel("cleartrip", "https://www.cleartrip.com/", ic_demo2),
      ExampleModel("redbus", "https://www.redbus.in/", ic_demo10),
    ],
  ),
  Example(
    title: 'News',
    contents: [
      ExampleModel("nytimes", "https://www.nytimes.com/international/", ic_demo11),
      ExampleModel('India Today', "https://www.indiatoday.in/", ic_demo4),
      ExampleModel('cnn', "https://edition.cnn.com/", ic_demo7),
    ],
  ),
  Example(
    title: 'Fly Booking',
    contents: [
      ExampleModel("skyscanner", "https://www.skyscanner.co.in/", ic_demo12),
      ExampleModel("kiwi", "https://www.kiwi.com/us/", ic_demo13),
      ExampleModel("momondo", "https://www.momondo.in/", ic_demo14),
    ],
  ),
  Example(
    title: 'Appointment',
    contents: [
      ExampleModel('practo', "https://www.practo.com/", ic_demo15),
    ],
  ),
  Example(
    title: 'Food',
    contents: [
      ExampleModel('zomato', "https://www.zomato.com/", ic_demo16),
      ExampleModel('Dominos', "https://www.dominos.co.in/", ic_demo6),
      ExampleModel('swiggy', "https://www.swiggy.com/", ic_demo17),
    ],
  ),
  Example(
    title: 'E-Commerce',
    contents: [
      ExampleModel('Flipkart', "https://www.flipkart.com/", ic_demo5),
      ExampleModel('amazon', "https://www.amazon.in/", ic_demo18),
      ExampleModel('zara', "https://www.zara.com/", ic_demo19),
    ],
  ),
  Example(
    title: 'Media',
    contents: [
      ExampleModel('youtube', "https://www.youtube.com/", ic_demo20),
      ExampleModel('netflix', "https://www.netflix.com/in/", ic_demo21),
      ExampleModel('mx player', "https://www.mxplayer.in/", ic_demo3),
    ],
  ),
  Example(
    title: 'HTML 5 Game',
    contents: [
      ExampleModel('ARCHERY WORLD TOUR', "https://play.famobi.com/archery-world-tour", ic_demo22),
      ExampleModel('TRAIN 2048', "https://play.famobi.com/train-2048", ic_demo23),
    ],
  ),
];

class ExampleModel {
  final String title;
  final String url;
  final String img;

  ExampleModel(
    this.title,
    this.url,
    this.img,
  );
}
