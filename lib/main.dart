import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Lab02App());
}

class Lab02App extends StatelessWidget {
  const Lab02App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Mobile App Dev - Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const Lab02HomePage(),
    );
  }
}

class Lab02HomePage extends StatefulWidget {
  const Lab02HomePage({super.key});

  @override
  State<Lab02HomePage> createState() => _Lab02HomePageState();
}

class _Lab02HomePageState extends State<Lab02HomePage> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  final List<String> _roles = const [
    'Student',
    'Developer',
    'Designer',
  ];

  // Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 280,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Done'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => _selectedDate = newDate);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cupertino House / Role Wheel Picker (Modal Sheet)
  void _showCupertinoRolePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 280,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Done'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 36,
                  scrollController: FixedExtentScrollController(
                    initialItem: _roles.contains(_selectedRole)
                        ? _roles.indexOf(_selectedRole)
                        : 0,
                  ),
                  onSelectedItemChanged: (int index) {
                    setState(() => _selectedRole = _roles[index]);
                  },
                  children: _roles
                      .map((role) => Center(child: Text(role)))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // Portrait Mode Layout (Stacked Vertically)
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const StudentDetailsSection(),
        const SizedBox(height: 16),
        const LocationCard(),
        const SizedBox(height: 16),
        const ImageSection(imagePath: 'assets/images/HoutongCatVillage.jpeg'),
        const SizedBox(height: 16),
        _buildPickersCard(),
      ],
    );
  }

  // Landscape Mode Layout (Side-by-Side)
  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: StudentDetailsSection(),
          ),
        ),
        Expanded(
          flex: 1,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const LocationCard(),
              const SizedBox(height: 16),
              const ImageSection(imagePath: 'assets/images/HoutongCatVillage.jpg'),
              const SizedBox(height: 16),
              _buildPickersCard(),
            ],
          ),
        ),
      ],
    );
  }

  // Interactive Pickers Section (Lab 2.2)
  Widget _buildPickersCard() {
    final String dateString =
        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Selected Date: $dateString',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Selected House / Role: $_selectedRole',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const Divider(height: 24),
            // Material Date Picker Button
            ElevatedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 8),
            // Cupertino Date Picker Button
            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(CupertinoIcons.calendar),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
            ),
            const SizedBox(height: 12),
            // Material Dropdown
            Row(
              children: [
                const Text(
                  'Material Dropdown: ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedRole,
                    items: _roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _selectedRole = newValue);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Cupertino Wheel Picker Button
            OutlinedButton.icon(
              onPressed: () => _showCupertinoRolePicker(context),
              icon: const Icon(CupertinoIcons.circle_grid_hex),
              label: const Text('Cupertino House Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }
}

// Student Details Section (Lab 01 Reused)
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/Me1.jpeg'),
            ),
            SizedBox(height: 16),
            Text(
              'AZARIENA BINTI ARIFIN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              'Student ID: BCS24090059',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            Divider(height: 28, thickness: 1),
            Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text(
              '"To develop impactful off-grid intelligent systems and empower technology in rural environments."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Exercise 2.1: Location Details Card wrapping TitleSection
class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 16),
            child: Text(
              'Location Details',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          TitleSection(
            name: 'Houtong Cat Village',
            location: '224, Taiwan, New Taipei City, Ruifang District, 龍山里 Fengjia Road',
            starCount: 41,
          ),
        ],
      ),
    );
  }
}

// Exercise 2.1: Deconstructed TitleSection Widget
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

// Image Section Widget
class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
