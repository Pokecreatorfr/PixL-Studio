import 'package:flutter/material.dart';
import 'package:pixlstudio/defines/colors.dart';
import 'package:pixlstudio/services/tileset_service.dart';

class TilesetEditor extends StatefulWidget {
  const TilesetEditor({Key? key}) : super(key: key);

  @override
  _TilesetEditorState createState() => _TilesetEditorState();
}

class _TilesetEditorState extends State<TilesetEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.primary,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: TilesetService().tilesets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(TilesetService().tilesets[index].name!),
                    onTap: () {
                      // open tileset editor
                    },
                  );
                },
              ),
            ),
            Container(
              width: 300,
              color: AppColor.secondary,
              child: Column(
                children: [
                  Text('Tileset Editor'),
                  ElevatedButton(
                    onPressed: () {
                      // add tileset
                    },
                    child: const Text('Add Tileset'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
