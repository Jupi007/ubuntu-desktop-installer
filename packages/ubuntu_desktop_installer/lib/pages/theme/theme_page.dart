import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ubuntu_desktop_installer/l10n.dart';
import 'package:ubuntu_wizard/ubuntu_wizard.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'theme_model.dart';

class ThemePage extends ConsumerWidget {
  const ThemePage({super.key});

  static Future<bool> load(WidgetRef ref) {
    return ref.read(themeModelProvider).init();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = AppLocalizations.of(context);
    final width = MediaQuery.of(context).size.width;
    final model = ref.watch(themeModelProvider);
    return WizardPage(
      header: Text(lang.chooseYourLookPageHeader),
      bottomBar: WizardBar(
        leading: WizardButton.previous(context),
        trailing: [
          WizardButton.next(context),
        ],
      ),
      title: YaruWindowTitleBar(
        title: Text(lang.chooseYourLookPageTitle),
      ),
      content: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ThemeOptionCard(
              width: width / 3,
              assetName: 'assets/theme/light-theme.png',
              selected: Theme.of(context).brightness == Brightness.light,
              onTap: () => model.setBrightness(Brightness.light),
              preferenceName: lang.chooseYourLookPageLightSetting,
            ),
            SizedBox(
              width: width / 20,
            ),
            _ThemeOptionCard(
              width: width / 3,
              assetName: 'assets/theme/dark-theme.png',
              selected: Theme.of(context).brightness == Brightness.dark,
              onTap: () => model.setBrightness(Brightness.dark),
              preferenceName: lang.chooseYourLookPageDarkSetting,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  const _ThemeOptionCard({
    required this.width,
    required this.assetName,
    required this.selected,
    required this.onTap,
    required this.preferenceName,
  });

  final double width;
  final String assetName;
  final bool selected;
  final Function() onTap;
  final String preferenceName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width,
          child: YaruSelectableContainer(
            selected: selected,
            padding: EdgeInsets.zero,
            onTap: onTap,
            child: IntrinsicHeight(
              child: YaruBanner(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(assetName),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(preferenceName,
              style: Theme.of(context).textTheme.titleLarge),
        )
      ],
    );
  }
}
