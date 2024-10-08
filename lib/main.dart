import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_view/audio_player_widget.dart';
import 'package:flutter_html_view/utils/color.dart';
import 'package:flutter_html_view/video_player_widget.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  runApp(const HtmlView());
}

class HtmlView extends StatefulWidget {
  const HtmlView({super.key});

  @override
  State<HtmlView> createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  String htmlTextContent = "";
  String linkContent = "";
  String imageContent = "";
  String videoContent = "";
  String youtubeVideoContent = "";
  String audioContent = "";
  String customTagsContent = "";
  Color selectedColor = greenColor;
  List<TypeModel> typesList = [];

  // Define a map to hold visibility states
  Map<String, bool> visibilityMap = {
    'textContentVisible': true,
    'linksVisible': false,
    'pictureVisible': false,
    'videoVisible': false,
    'youtubeVideoVisible': false,
    'audioVisible': false,
    'customTagsVisible': false,
  };

  @override
  void initState() {
    super.initState();
    htmlTextContent = _loadTextContentHtml();
    linkContent = _loadLinkHtml();
    imageContent = _loadImageHtml();
    videoContent = _loadVideoHtml();
    youtubeVideoContent = _loadYoutubeVideoHtml();
    audioContent = _loadAudioHtml();
    customTagsContent = _loadCustomTagsHtml();
    typesList = getData();
    typesList[0].backgroundColor = greenColor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary Color
        scaffoldBackgroundColor: Color(0xFFF3F4F6), // Light Gray Background
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          bodyLarge: TextStyle(color: Colors.blueGrey[600]), // Body Text Color
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: double.infinity,
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            leading: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return typesView(type: typesList[index].type, index: index);
              },
              itemCount: typesList.length,
            ),
          ),
          body: Container(
              color: primaryColor,
              height: MediaQuery.of(context).size.height,
              child: visibilityMap['videoVisible']!
                  ? loadVideoHtml()
                  : visibilityMap['audioVisible']!
                      ? loadAudioHtml()
                      : visibilityMap['youtubeVideoVisible']!
                          ? loadYoutubeVideoHtml()
                          : visibilityMap['customTagsVisible']!
                              ? loadCustomTagsHtml()
                              : SingleChildScrollView(
                                  child: Column(children: [
                                    loadTextHtml(),
                                    loadLinkHtml(),
                                    loadImageHtml(),
                                  ]),
                                )),
        ),
      ),
    );
  }

  String _loadTextContentHtml() {
    String htmlContent = '''
       <body>
        <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Healthy Eating Overview</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.54); /* Colors.black54 */
            color: white;
        }
        h1, h2 {
            color: #FFDD44; /* A bright yellow for contrast */
        }
        ul {
            margin: 10px 0;
            padding-left: 20px;
        }
        strong {
            color: #FFDD44; /* A bright yellow for emphasis */
        }
    </style>
</head>
<body>

    <h1>Healthy Eating Overview</h1>

    <p>Healthy eating is about consuming a balanced diet rich in essential nutrients to support your overall well-being.</p>

    <h2>Key Components</h2>
    <ul>
        <li><strong>Fruits & Vegetables:</strong> Eat a variety for vitamins and minerals.</li>
        <li><strong>Whole Grains:</strong> Choose whole over refined grains.</li>
        <li><strong>Lean Proteins:</strong> Include fish, poultry, beans, and nuts.</li>
        <li><strong>Dairy:</strong> Opt for low-fat or fat-free options.</li>
    </ul>

    <h2>Benefits</h2>
    <p>Proper nutrition can lead to increased energy, improved mood, and reduced risk of chronic diseases.</p>

    <h2>Get Started</h2>
    <p>Begin by making small, sustainable changes to your diet and seek guidance from a nutritionist if needed.</p>

</body>
    ''';
    return htmlContent;
  }

  String _loadLinkHtml() {
    String linkHtml = '''
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Komal Thakkar's Medium Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.54); /* Colors.black54 */
            color: white;
            text-align: center;
        }
        a {
            color: #FFDD44; /* Bright yellow for the link */
            text-decoration: none;
            font-size: 1.2em;
            padding: 10px 20px;
            border: 2px solid #FFDD44;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        <!--a:hover {
            background-color: #FFDD44;
            color: black;
        }-->
    </style>
</head>
<body>

    <h1>Explore Komal Thakkar's Writings on Medium</h1>
    <p>Read insightful articles and blogs by Komal Thakkar on Medium.</p>
    
    <a href="https://medium.com/@thakkarkomal009" target="_blank">Visit Komal Thakkar's Medium Profile</a>

</body>
''';
    return linkHtml;
  }

  String _loadImageHtml() {
    String imageHtml = '''
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.54); /* Colors.black54 */
            color: white;
            text-align: center;
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            border: 2px solid #FFDD44; /* Bright yellow border */
        }
        h1 {
            color: #FFDD44;
        }
    </style>
</head>
<body>

    <h1>Beautiful Nature Image</h1>
    <img src="https://images.unsplash.com/photo-1727775805114-a87c6bcaf9db?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
         alt="Beautiful Nature Image from Unsplash">

</body>
''';
    return imageHtml;
  }

  String _loadVideoHtml() {
    String videoHtml = '''

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.54); /* Colors.black54 */
            color: white;
            text-align: center;
        }
        video {
            max-width: 100%;
            height: auto;
            border: 2px solid #FFDD44; /* Bright yellow border */
            border-radius: 8px;
        }
        h1 {
            color: #FFDD44;
        }
    </style>
</head>
<body>

    <h1>Watch This Video</h1>
    <video controls>
        <source src="https://videos.pexels.com/video-files/3163534/3163534-uhd_2560_1440_30fps.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>

</body>
''';
    return videoHtml;
  }

  String _loadYoutubeVideoHtml() {
    String videoHtml = '''
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YouTube Video Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: rgba(0, 0, 0, 0.54); /* Colors.black54 */
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            overflow: hidden; /* Prevent scrolling */
        }
        iframe {
            width: 80%;
            height: 60%; /* Adjust height to maintain aspect ratio */
            border: 2px solid #FFDD44; /* Bright yellow border */
            border-radius: 8px;
        }
        h1 {
            color: #FFDD44;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>

    <h1>Watch This YouTube Video</h1>
    <iframe 
        src="https://www.youtube.com/embed/7_uT3VsRgsg" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
        allowfullscreen>
    </iframe>

</body>
''';
    return videoHtml;
  }

  _loadAudioHtml() {
    String audioHtml = '''
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Audio Display</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.54); /* Colors.black54 */
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            overflow: hidden; /* Prevent scrolling */
            text-align: center;
        }
        audio {
            width: 80%;
            border: 2px solid #FFDD44; /* Bright yellow border */
            border-radius: 8px;
        }
        h1 {
            color: #FFDD44;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <h1>Listen to This Audio</h1>
    <audio controls>
        <source src="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3" type="audio/mp3">
        Your browser does not support the audio tag.
    </audio>

</body>
''';
    return audioHtml;
  }

  _loadCustomTagsHtml() {
    String customTagsHtml = '''
<head>
    <title>Custom Tags in HTML</title>
</head>
<body>
    <h1>Custom Tags Example</h1>

    <!-- Highlight Tag -->
    <highlight>
        This text is highlighted with a yellow background.
    </highlight>

    <!-- stylized Text Tag -->
    <stylizedtext>
        This is fancy styled text.
    </stylizedtext>

    <!-- audio player Tag -->
    <audioplayer src="https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3">
        Click to play custom audio.
    </audioplayer>
</body>
''';
    return customTagsHtml;
  }

  Future openLinkWithCustomTab(BuildContext context, String url) async {
    try {
      await FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: const CustomTabsOptions(
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    } catch (e) {
      print('Cant launch the url');
      debugPrint(e.toString());
    }
  }

  static String getVimeoId(String videoUrl) {
    RegExp regExp = RegExp(
        r'(?:http|https)?:?\/?\/?(?:www\.)?(?:player\.)?vimeo\.com\/(?:channels\/(?:\w+\/)?|groups\/(?:[^\/]*)\/videos\/|video\/|)(\d+)(?:|\/\?)');
    return regExp.firstMatch(videoUrl)!.group(1).toString();
  }

  onClick({String? type, int? index}) {
    if (index == null) return; // Handle null index case

    // Reset all visibility values to false
    visibilityMap.updateAll((key, value) => false);

    // Set the visibility of the clicked view based on index
    switch (index) {
      case 0:
        visibilityMap['textContentVisible'] = true;
        break;
      case 1:
        visibilityMap['linksVisible'] = true;
        break;
      case 2:
        visibilityMap['pictureVisible'] = true;
        break;
      case 3:
        visibilityMap['videoVisible'] = true;
        break;
      case 4:
        visibilityMap['youtubeVideoVisible'] = true;
        break;
      case 5:
        visibilityMap['audioVisible'] = true;
        break;
      case 6:
        visibilityMap['customTagsVisible'] = true;
        break;
    }

    // Update colors based on the selected index
    for (int i = 0; i < typesList.length; i++) {
      typesList[i].backgroundColor = (i == index) ? greenColor : greyColor;
    }

    // Call setState once after updating
    setState(() {});
  }

  Widget typesView({String? type, int? index}) {
    return GestureDetector(
      onTap: () => onClick(type: type, index: index),
      child: Container(
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            alignment: Alignment.center,
            color: typesList[index!].backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$type', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  List<TypeModel> getData() {
    return [
      TypeModel(type: 'Text Content', backgroundColor: greyColor),
      TypeModel(type: 'Links', backgroundColor: greyColor),
      TypeModel(type: 'Picture', backgroundColor: greyColor),
      TypeModel(type: 'Video', backgroundColor: greyColor),
      TypeModel(type: 'Youtube Video Using Iframe', backgroundColor: greyColor),
      TypeModel(type: 'Audio', backgroundColor: greyColor),
      TypeModel(type: 'Custom Tags', backgroundColor: greyColor),
    ];
  }

  Widget loadTextHtml() {
    return Visibility(
      visible: visibilityMap['textContentVisible']!,
      child: Html(data: htmlTextContent, style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.all(10),
          lineHeight: const LineHeight(1.7),
          whiteSpace: WhiteSpace.normal,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        )
      }),
    );
  }

  Widget loadLinkHtml() {
    return Visibility(
      visible: visibilityMap['linksVisible']!,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black54,
        child: Html(
            data: linkContent,
            onLinkTap: (url, attributes, element) {
              openLinkWithCustomTab(context, url!);
            }),
      ),
    );
  }

  loadImageHtml() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black54,
      child: Visibility(
        visible: visibilityMap['pictureVisible']!,
        child: Html(
          data: imageContent,
          extensions: [
            TagExtension(
              tagsToExtend: {'img'},
              builder: (extensionContext) {
                String imageUrl = extensionContext.attributes['src'].toString();
                return Visibility(
                  visible: visibilityMap['pictureVisible']!,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      width: 45,
                      height: 60,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballBeat,
                        pathBackgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  loadVideoHtml() {
    return Container(
      color: Colors.black54,
      child: Visibility(
        visible: visibilityMap['videoVisible']!,
        child: Html(
          data: videoContent,
          extensions: [
            TagExtension(
              tagsToExtend: {'video'},
              builder: (extensionContext) {
                String? videoSrc;
                videoSrc = (extensionContext.node.nodes[1].attributes
                        .containsKey('src'))
                    ? extensionContext.node.nodes[1].attributes['src']
                    : '';
                return Visibility(
                  visible: visibilityMap['videoVisible']!,
                  child: VideoPlayerWidget(
                      videoUrl: videoSrc!, videoType: 'network'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  loadYoutubeVideoHtml() {
    return Container(
      color: Colors.black54,
      child: Visibility(
        visible: visibilityMap['youtubeVideoVisible']!,
        child: Html(
          data: youtubeVideoContent,
          extensions: [
            TagExtension(
              tagsToExtend: {'iframe'},
              builder: (extensionContext) {
                final String _videoSource =
                    extensionContext.element!.attributes['src'].toString();

                if (_videoSource.contains('youtube')) {
                  return VideoPlayerWidget(
                      videoUrl: _videoSource, videoType: 'youtube');
                } else if (_videoSource.contains('vimeo')) {
                  return VideoPlayerWidget(
                      videoUrl: getVimeoId(_videoSource), videoType: 'vimeo');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  loadAudioHtml() {
    return Container(
      color: Colors.black54,
      child: Visibility(
        visible: visibilityMap['audioVisible']!,
        child: Html(
          data: audioContent,
          extensions: [
            TagExtension(
              tagsToExtend: {'audio'},
              builder: (extensionContext) {
                final audioUrl = (extensionContext.node.nodes[1].attributes
                        .containsKey('src'))
                    ? extensionContext.node.nodes[1].attributes['src']
                    : '';
                return audioUrl != null
                    ? AudioPlayerWidget(audioUrl: audioUrl)
                    : Text("Audio source not found");
              },
            ),
          ],
        ),
      ),
    );
  }

  loadCustomTagsHtml() {
    return Container(
      color: Colors.black54,
      child: Visibility(
        visible: visibilityMap['customTagsVisible']!,
        child: Html(
          data: customTagsContent,
          extensions: [
            TagExtension(
              tagsToExtend: {'highlight'},
              builder: (extensionContext) {
                return Container(
                  color: Colors.yellow,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    extensionContext.element?.text ?? "",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
            TagExtension(
              tagsToExtend: {'stylizedtext'},
              builder: (extensionContext) {
                return Text(
                  extensionContext.element?.text ?? "",
                  style: const TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                );
              },
            ),
            TagExtension(
              tagsToExtend: {'audioplayer'},
              builder: (extensionContext) {
                final audioUrl = extensionContext.attributes['src'];
                return audioUrl != null
                    ? AudioPlayerWidget(audioUrl: audioUrl)
                    : Text("Audio source not found");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TypeModel {
  final String type;
  Color backgroundColor;

  TypeModel({required this.type, required this.backgroundColor});
}
