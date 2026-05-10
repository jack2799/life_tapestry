import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:provider/provider.dart';
import '../models/entry.dart';
import '../providers/entry_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/entry_list_item.dart';
import '../widgets/filter_button.dart';
import '../widgets/empty_state.dart';
import 'entry_editor_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mindful moments.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'A quiet space for the three things that shape a life — your health, your work, and the people you love.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EntryEditorScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('New entry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<EntriesNotifier>(
        builder: (context, entriesNotifier, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category cards
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: Category.values.map((category) {
                    return CategoryCard(
                      category: category,
                      count: entriesNotifier.getCategoryCount(category),
                      onTap: () {
                        if (entriesNotifier.selectedCategory == category) {
                          entriesNotifier.setSelectedCategory(null);
                        } else {
                          entriesNotifier.setSelectedCategory(category);
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // Filter buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterButton(
                        label: 'All',
                        isSelected: entriesNotifier.selectedCategory == null,
                        onPressed: () =>
                            entriesNotifier.setSelectedCategory(null),
                      ),
                      ...Category.values.map((category) {
                        return FilterButton(
                          label: category.label,
                          isSelected:
                              entriesNotifier.selectedCategory == category,
                          onPressed: () {
                            if (entriesNotifier.selectedCategory == category) {
                              entriesNotifier.setSelectedCategory(null);
                            } else {
                              entriesNotifier.setSelectedCategory(category);
                            }
                          },
                        );
                      }).toList(),
                      FilterButton(
                        label: '✦ Flow',
                        isSelected: false,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Flow mode coming soon!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Entries list or empty state
                if (entriesNotifier.filteredEntries.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: EmptyState(),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entriesNotifier.filteredEntries.length,
                    itemBuilder: (context, index) {
                      final entry = entriesNotifier.filteredEntries[index];
                      return EntryListItem(
                        entry: entry,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EntryEditorScreen(entry: entry),
                            ),
                          );
                        },
                        onDelete: () {
                          entriesNotifier.deleteEntry(entry.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Entry deleted')),
                          );
                        },
                      );
                    },
                  ),
                const SizedBox(height: 32),

                // Footer
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Saved locally on this device.',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '·',
                        style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
