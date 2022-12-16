import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm_countries/views/components/page_header.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PageHeader(
            title: "About",
            iconData: Icons.question_mark,
            iconColor: Colors.green),
        const SizedBox(height: 20),
        Text("Cette application a été développée par",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: 40),
        Text("AMINE EL-Mehdi",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 40),
        Text(
          "C'est une application qui permet d'afficher tous les pays du monde, vous pouvez consulter les détails de chaque pays, et ajouter des pays à vos favoris.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4!.merge(
                const TextStyle(
                  height: 1.3,
                ),
              ),
        ),
        const SizedBox(height: 40),
        Text(
          "Pour plus d'informations, veuillez consulter le code source de l'application sur GitHub",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4!.merge(
                const TextStyle(
                  height: 1.3,
                ),
              ),
        ),
        const SizedBox(height: 40),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              if (!await launchUrl(
                  Uri.parse("https://github.com/amineMehdi/tm_countries"))) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Impossible d'ouvrir le lien"),
                  ),
                );
              }
            },
            child: SvgPicture.asset(
              "icons/github.svg",
              height: 50,
              width: 50,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "Pour plus de mes projets, veuillez consulter mon compte GitHub, ou mon compte LinkedIn",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4!.merge(
                const TextStyle(
                  height: 1.3,
                ),
              ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  if (!await launchUrl(
                      Uri.parse("https://github.com/amineMehdi"))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Impossible d'ouvrir le lien"),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset(
                  "icons/github.svg",
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            const SizedBox(width: 40),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  if (!await launchUrl(Uri.parse(
                      "https://www.linkedin.com/in/el-mehdi-amine-55153617b"))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Impossible d'ouvrir le lien"),
                      ),
                    );
                  }
                },
                child: SvgPicture.asset(
                  "icons/linkedin.svg",
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
