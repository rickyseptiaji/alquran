import 'package:alquran/app/data/models/detailsurah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({super.key});
  final Surah surah = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SURAH ${surah.name.transliteration.id.toUpperCase()}'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${surah.name.transliteration.id}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      '( ${surah.name.translation.id} )',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${surah.numberOfVerses} Ayat | ${surah.revelation.id}',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text('TIDAK ADA DATA'));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.verses?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.verses!.isEmpty) {
                          return SizedBox();
                        }
                        detail.Verse? ayat = snapshot.data?.verses?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(child: Text('${index + 1}')),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.bookmark_add_outlined)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.play_arrow)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.right,
                              '${ayat?.text.arab}',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.right,
                              '${ayat?.text.transliteration.en}',
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${ayat?.translation.id}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        );
                      });
                })
          ],
        ));
  }
}
