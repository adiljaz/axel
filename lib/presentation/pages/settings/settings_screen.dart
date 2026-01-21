import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/color_palette.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../bloc/theme/theme_event.dart';
import '../../bloc/theme/theme_state.dart';
import '../../bloc/settings/settings_bloc.dart';
import '../../bloc/settings/settings_event.dart';
import '../../bloc/settings/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose Theme Color'),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: ColorPalette.colorList.length,
            itemBuilder: (context, index) {
              final colorData = ColorPalette.colorList[index];
              final color = colorData['color'] as Color;
              final name = colorData['name'] as String;
              
              return GestureDetector(
                onTap: () {
                  context.read<ThemeBloc>().add(ChangeColorEvent(name));
                  Navigator.pop(ctx);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _clearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached to-dos. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsBloc>().add(ClearCacheEvent());
              Navigator.pop(ctx);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is CacheCleared) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cache cleared successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return ListView(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme'),
                  value: themeState.isDarkMode,
                  secondary: Icon(
                    themeState.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ToggleThemeEvent(value));
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.color_lens,
                    color: themeState.primaryColor,
                  ),
                  title: const Text('Theme Color'),
                  subtitle: Text(themeState.colorName),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: themeState.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () => _showColorPicker(context),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete_sweep),
                  title: const Text('Clear Cache'),
                  subtitle: const Text('Remove all cached data'),
                  onTap: () => _clearCache(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
