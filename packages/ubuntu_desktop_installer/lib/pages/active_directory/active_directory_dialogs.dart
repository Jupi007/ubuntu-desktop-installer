import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ubuntu_wizard/constants.dart';
import 'package:ubuntu_wizard/utils.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../../l10n.dart';

Future<void> showActiveDirectoryErrorDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => const ActiveDirectoryErrorDialog(),
  );
}

class ActiveDirectoryErrorDialog extends StatelessWidget {
  const ActiveDirectoryErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return AlertDialog(
      title: YaruDialogTitleBar(
        title: Text(lang.activeDirectoryErrorTitle),
      ),
      titlePadding: EdgeInsets.zero,
      content: SizedBox(
        width: 600,
        child: Row(
          children: [
            const Icon(YaruIcons.error, size: 96),
            const SizedBox(width: kContentSpacing),
            Expanded(
              child: Html(
                data: lang.activeDirectoryErrorMessage,
                style: {
                  'body': Style(margin: Margins.zero),
                  'a': Style(color: context.linkColor),
                },
                onAnchorTap: (url, _, __, ___) => launchUrl(url!),
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          onPressed: Navigator.of(context).pop,
          child: Text(lang.okButtonText),
        ),
      ],
    );
  }
}