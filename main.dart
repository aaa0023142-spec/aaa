import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const AdhkarApp());
}

class AdhkarApp extends StatefulWidget {
  const AdhkarApp({Key? key}) : super(key: key);

  @override
  State<AdhkarApp> createState() => _AdhkarAppState();
}

class _AdhkarAppState extends State<AdhkarApp> {
  bool isDarkMode = false;
  double fontSize = 20.0;
  bool enableVibration = true;
  Color textColor = Colors.black87;
  Color backgroundColor = const Color(0xFFF7F9FC);
  bool autoTransition = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      backgroundColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF7F9FC);
      textColor = isDarkMode ? Colors.white : Colors.black87;
    });
  }

  void updateFontSize(double size) {
    setState(() {
      fontSize = size;
    });
  }

  void toggleVibration(bool val) {
    setState(() {
      enableVibration = val;
    });
  }

  void toggleAutoTransition(bool val) {
    setState(() {
      autoTransition = val;
    });
  }

  void updateColors(Color text, Color bg) {
    setState(() {
      textColor = text;
      backgroundColor = bg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أذكار الصباح والمساء',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'sans-serif',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: isDarkMode ? const Color(0xFF121212) : backgroundColor,
        fontFamily: 'sans-serif',
      ),
      home: SplashScreen(
        isDarkMode: isDarkMode,
        fontSize: fontSize,
        enableVibration: enableVibration,
        textColor: textColor,
        backgroundColor: backgroundColor,
        autoTransition: autoTransition,
        onToggleTheme: toggleTheme,
        onUpdateFontSize: updateFontSize,
        onToggleVibration: toggleVibration,
        onToggleAutoTransition: toggleAutoTransition,
        onUpdateColors: updateColors,
      ),
    );
  }
}

// ------------------- شاشة الافتتاحية (Splash Screen) -------------------
class SplashScreen extends StatefulWidget {
  final bool isDarkMode;
  final double fontSize;
  final bool enableVibration;
  final Color textColor;
  final Color backgroundColor;
  final bool autoTransition;
  final VoidCallback onToggleTheme;
  final Function(double) onUpdateFontSize;
  final Function(bool) onToggleVibration;
  final Function(bool) onToggleAutoTransition;
  final Function(Color, Color) onUpdateColors;

  const SplashScreen({
    Key? key,
    required this.isDarkMode,
    required this.fontSize,
    required this.enableVibration,
    required this.textColor,
    required this.backgroundColor,
    required this.autoTransition,
    required this.onToggleTheme,
    required this.onUpdateFontSize,
    required this.onToggleVibration,
    required this.onToggleAutoTransition,
    required this.onUpdateColors,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            isDarkMode: widget.isDarkMode,
            fontSize: widget.fontSize,
            enableVibration: widget.enableVibration,
            textColor: widget.textColor,
            backgroundColor: widget.backgroundColor,
            autoTransition: widget.autoTransition,
            onToggleTheme: widget.onToggleTheme,
            onUpdateFontSize: widget.onUpdateFontSize,
            onToggleVibration: widget.onToggleVibration,
            onToggleAutoTransition: widget.onToggleAutoTransition,
            onUpdateColors: widget.onUpdateColors,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/logo.png', width: 75, height: 75, errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.wb_sunny_rounded, size: 75, color: Color(0xFFB8860B));
                  }),
                ),
                const SizedBox(height: 25),
                const Text(
                  'أذكار الصباح والمساء',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'حصنك الحصين لكل يوم',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------- الشاشة الرئيسية -------------------
class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final double fontSize;
  final bool enableVibration;
  final Color textColor;
  final Color backgroundColor;
  final bool autoTransition;
  final VoidCallback onToggleTheme;
  final Function(double) onUpdateFontSize;
  final Function(bool) onToggleVibration;
  final Function(bool) onToggleAutoTransition;
  final Function(Color, Color) onUpdateColors;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.fontSize,
    required this.enableVibration,
    required this.textColor,
    required this.backgroundColor,
    required this.autoTransition,
    required this.onToggleTheme,
    required this.onUpdateFontSize,
    required this.onToggleVibration,
    required this.onToggleAutoTransition,
    required this.onUpdateColors,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double> sectionProgress = {
    'أذكار الصباح': 0.0,
    'أذكار المساء': 0.0,
    'أدعية بعد الصلاة': 0.0,
    'أذكار النوم': 0.0,
    'أدعية الاستيقاظ': 0.0,
    'أدعية المنزل': 0.0,
    'أدعية الطعام': 0.0,
    'أدعية الوضوء والسوق': 0.0,
  };

  void updateSectionProgress(String title, double progress) {
    setState(() {
      sectionProgress[title] = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(85),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/logo.png', width: 28, height: 28, errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.wb_sunny_rounded, color: Color(0xFFB8860B), size: 24);
                        }),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'أذكار الصباح والمساء',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'يوم مبارك بذكر الله',
                            style: TextStyle(color: Colors.amberAccent, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          showSearch(context: context, delegate: GlobalSearchDelegate(fontSize: widget.fontSize, textColor: widget.textColor, backgroundColor: widget.backgroundColor, enableVibration: widget.enableVibration));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SettingsScreen(
                                isDarkMode: widget.isDarkMode,
                                fontSize: widget.fontSize,
                                enableVibration: widget.enableVibration,
                                textColor: widget.textColor,
                                backgroundColor: widget.backgroundColor,
                                autoTransition: widget.autoTransition,
                                onToggleTheme: widget.onToggleTheme,
                                onUpdateFontSize: widget.onUpdateFontSize,
                                onToggleVibration: widget.onToggleVibration,
                                onToggleAutoTransition: widget.onToggleAutoTransition,
                                onUpdateColors: widget.onUpdateColors,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF11998e), Color(0xFF38ef7d)]),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  const Icon(Icons.wb_sunny, color: Colors.white, size: 36),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'أهلاً بك يا عبد الرحمن',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'التدبر في ذكر الله يحيي القلوب ويطمئنها.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.05,
                children: [
                  _buildCategoryCard(context, title: 'أذكار الصباح', icon: Icons.wb_sunny, color: Colors.orange, progress: sectionProgress['أذكار الصباح'] ?? 0.0, adhkarList: morningAdhkar),
                  _buildCategoryCard(context, title: 'أذكار المساء', icon: Icons.nights_stay, color: Colors.indigo, progress: sectionProgress['أذكار المساء'] ?? 0.0, adhkarList: eveningAdhkar),
                  _buildCategoryCard(context, title: 'أدعية بعد الصلاة', icon: Icons.mosque, color: Colors.teal, progress: sectionProgress['أدعية بعد الصلاة'] ?? 0.0, adhkarList: afterPrayerAdhkar),
                  _buildCategoryCard(context, title: 'أذكار النوم', icon: Icons.bedtime, color: Colors.deepPurple, progress: sectionProgress['أذكار النوم'] ?? 0.0, adhkarList: sleepAdhkar),
                  _buildCategoryCard(context, title: 'أدعية الاستيقاظ', icon: Icons.alarm, color: Colors.amber.shade800, progress: sectionProgress['أدعية الاستيقاظ'] ?? 0.0, adhkarList: wakeupAdhkar),
                  _buildCategoryCard(context, title: 'أدعية المنزل', icon: Icons.home, color: Colors.brown, progress: sectionProgress['أدعية المنزل'] ?? 0.0, adhkarList: homeAdhkar),
                  _buildCategoryCard(context, title: 'أدعية الطعام', icon: Icons.restaurant, color: Colors.deepOrange, progress: sectionProgress['أدعية الطعام'] ?? 0.0, adhkarList: foodAdhkar),
                  _buildCategoryCard(context, title: 'أدعية الوضوء والسوق', icon: Icons.water_drop, color: Colors.blue, progress: sectionProgress['أدعية الوضوء والسوق'] ?? 0.0, adhkarList: ablutionAndMarketAdhkar),
                  _buildCategoryCard(context, title: 'المسبحة الإلكترونية', icon: Icons.fingerprint, color: Colors.green, progress: 1.0, isTasbeeh: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, {required String title, required IconData icon, required Color color, required double progress, List<DhikrItem>? adhkarList, bool isTasbeeh = false}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () {
          if (isTasbeeh) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => TasbeehScreen(enableVibration: widget.enableVibration)));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdhkarListScreen(
                  title: title,
                  adhkarList: adhkarList!,
                  fontSize: widget.fontSize,
                  enableVibration: widget.enableVibration,
                  textColor: widget.textColor,
                  backgroundColor: widget.backgroundColor,
                  autoTransition: widget.autoTransition,
                  onProgressUpdated: (newProgress) {
                    updateSectionProgress(title, newProgress);
                  },
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.85), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 34, color: Colors.white),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (!isTasbeeh) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(progress * 100).toInt()}% منجز',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ] else ...[
                const Text(
                  'مسبحة تفاعلية',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- شاشة قراءة الأذكار -------------------
class AdhkarListScreen extends StatefulWidget {
  final String title;
  final List<DhikrItem> adhkarList;
  final double fontSize;
  final bool enableVibration;
  final Color textColor;
  final Color backgroundColor;
  final bool autoTransition;
  final Function(double) onProgressUpdated;

  const AdhkarListScreen({
    Key? key,
    required this.title,
    required this.adhkarList,
    required this.fontSize,
    required this.enableVibration,
    required this.textColor,
    required this.backgroundColor,
    required this.autoTransition,
    required this.onProgressUpdated,
  }) : super(key: key);

  @override
  State<AdhkarListScreen> createState() => _AdhkarListScreenState();
}

class _AdhkarListScreenState extends State<AdhkarListScreen> {
  late List<int> counters;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    counters = widget.adhkarList.map((e) => e.targetCount).toList();
  }

  void decrementCounter(int index) {
    if (counters[index] > 0) {
      setState(() {
        counters[index]--;
      });
      if (widget.enableVibration) {
        HapticFeedback.lightImpact();
      }
      
      int totalItems = widget.adhkarList.length;
      int completedItems = 0;
      for (int i = 0; i < totalItems; i++) {
        if (counters[i] == 0) completedItems++;
      }
      double progress = completedItems / totalItems;
      widget.onProgressUpdated(progress);

      if (counters[index] == 0 && widget.autoTransition && index < totalItems - 1) {
        _scrollController.animateTo(
          (index + 1) * 180.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }

      if (counters.every((element) => element == 0)) {
        _showCompletionDialog();
      }
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: const [
            Icon(Icons.emoji_events, color: Colors.amber, size: 70),
            SizedBox(height: 10),
            Text('أحسنت وبارك الله فيك!', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
          ],
        ),
        content: const Text('لقد أتممت قراءة جميع أذكار هذا القسم بنجاح تام.', textAlign: TextAlign.center),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('حسناً / الخروج', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F2027),
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: widget.adhkarList.length,
        itemBuilder: (context, index) {
          final item = widget.adhkarList[index];
          final currentCount = counters[index];
          final bool isDone = currentCount == 0;

          return GestureDetector(
            onTap: () => decrementCounter(index),
            child: Card(
              color: isDone ? (widget.backgroundColor == Colors.white ? Colors.grey.shade100 : Colors.grey.shade900) : null,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      item.text,
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                        color: isDone ? Colors.grey : widget.textColor,
                      ),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDone ? Colors.green : Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isDone ? 'تم القراءة ✓' : 'المتبقي للعد: $currentCount',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isDone ? Colors.white : Colors.teal,
                            ),
                          ),
                        ),
                        Text(
                          'اضغط بأي مكان للعد',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ------------------- شاشة السبحة الإلكترونية -------------------
class TasbeehScreen extends StatefulWidget {
  final bool enableVibration;

  const TasbeehScreen({Key? key, required this.enableVibration}) : super(key: key);

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _counter = 0;
  String selectedDhikr = 'سُبْحَانَ اللَّهِ';

  final List<String> tasbeehList = [
    'سُبْحَانَ اللَّهِ',
    'الْحَمْدُ لِلَّهِ',
    'لَا إِلَهَ إِلَّا اللَّهُ',
    'اللَّهُ أَكْبَرُ',
    'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
    'أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ',
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    if (widget.enableVibration) {
      HapticFeedback.lightImpact();
    }
  }

  void _resetCounter() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إعادة ضبط العداد'),
        content: const Text('هل أنت متأكد من تصفير العداد؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              setState(() => _counter = 0);
              Navigator.pop(context);
            },
            child: const Text('تأكيد', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المسبحة الإلكترونية'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F2027),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedDhikr,
              decoration: InputDecoration(
                labelText: 'اختر الذكر',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true,
              ),
              items: tasbeehList.map((dhikr) {
                return DropdownMenuItem(value: dhikr, child: Text(dhikr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => selectedDhikr = val);
              },
            ),
            const SizedBox(height: 20),
            Text(
              selectedDhikr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_counter',
                        style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const Text(
                        'اضغط للتسبيح',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: _resetCounter,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text('إعادة الضبط', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ------------------- شاشة الإعدادات الشاملة -------------------
class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final double fontSize;
  final bool enableVibration;
  final Color textColor;
  final Color backgroundColor;
  final bool autoTransition;
  final VoidCallback onToggleTheme;
  final Function(double) onUpdateFontSize;
  final Function(bool) onToggleVibration;
  final Function(bool) onToggleAutoTransition;
  final Function(Color, Color) onUpdateColors;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.fontSize,
    required this.enableVibration,
    required this.textColor,
    required this.backgroundColor,
    required this.autoTransition,
    required this.onToggleTheme,
    required this.onUpdateFontSize,
    required this.onToggleVibration,
    required this.onToggleAutoTransition,
    required this.onUpdateColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F2027),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('الوضع الليلي (Dark Mode)'),
            value: isDarkMode,
            onChanged: (val) => onToggleTheme(),
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('اهتزاز عند الضغط للعد'),
            value: enableVibration,
            onChanged: onToggleVibration,
            secondary: const Icon(Icons.vibration),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('الانتقال التلقائي للذكر التالي'),
            value: autoTransition,
            onChanged: onToggleAutoTransition,
            secondary: const Icon(Icons.swipe_vertical),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('حجم خط الأذكار: ${fontSize.toInt()}', style: const TextStyle(fontSize: 16)),
                Slider(
                  value: fontSize,
                  min: 16.0,
                  max: 32.0,
                  divisions: 8,
                  label: fontSize.round().toString(),
                  onChanged: onUpdateFontSize,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('تغيير لون خلفية ونصوص القراءة'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => onUpdateColors(Colors.black87, Colors.white),
                  child: Container(
                    width: 25, 
                    height: 25, 
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      shape: BoxShape.circle, 
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => onUpdateColors(const Color(0xFF2C3E50), const Color(0xFFFFF8E7)),
                  child: Container(
                    width: 25, 
                    height: 25, 
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF8E7), 
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => onUpdateColors(Colors.white, const Color(0xFF1E272C)),
                  child: Container(
                    width: 25, 
                    height: 25, 
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E272C), 
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('إصدار التطبيق'),
            subtitle: Text('1.0.0 - نسخة مخصصة لعبد الرحمن'),
          ),
        ],
      ),
    );
  }
}

// ------------------- محرك البحث الشامل -------------------
class GlobalSearchDelegate extends SearchDelegate {
  final double fontSize;
  final Color textColor;
  final Color backgroundColor;
  final bool enableVibration;

  GlobalSearchDelegate({required this.fontSize, required this.textColor, required this.backgroundColor, required this.enableVibration});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    List<DhikrItem> allItems = [
      ...morningAdhkar,
      ...eveningAdhkar,
      ...afterPrayerAdhkar,
      ...sleepAdhkar,
      ...wakeupAdhkar,
      ...homeAdhkar,
      ...foodAdhkar,
      ...ablutionAndMarketAdhkar
    ];

    final results = allItems.where((item) => item.text.contains(query)).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          title: Text(item.text, style: TextStyle(fontSize: fontSize), maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text('التكرار: ${item.targetCount}', style: const TextStyle(color: Colors.teal)),
        );
      },
    );
  }
}

// ------------------- الأذكار الأصلية كاملة وبدقة 100% -------------------
class DhikrItem {
  final String text;
  final int targetCount;

  DhikrItem({required this.text, required this.targetCount});
}

List<DhikrItem> morningAdhkar = [
  DhikrItem(text: 'الْحَمْدُ لِلَّهِ وَحْدَهُ، وَالصَّلاَةُ وَالسَّلَامُ عَلَى مَنْ لاَ نَبِيَّ بَعْدَهُ.', targetCount: 1),
  DhikrItem(text: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيطَانِ الرَّجِيمِ {اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَوَاتِ وَالْأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ}.', targetCount: 1),
  DhikrItem(text: 'ﭑ ﭒ ﭓ {قُلْ هُوَ اللَّهُ أَحَدٌ* اللَّهُ الصَّمَدُ* لَمْ يَلِدْ وَلَمْ يُولَدْ* وَلَمْ يَكُن لَّهُ كُفُواً أَحَدٌ}. ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ* مِن شَرِّ مَا خَلَقَ* وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ* وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ* وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ}. ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ النَّاسِ* مَلِكِ النَّاسِ* إِلَهِ النَّاسِ* مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ* الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ* مِنَ الْجِنَّةِ وَ النَّاسِ}', targetCount: 3),
  DhikrItem(text: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنوبَ إِلاَّ أَنْتَ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلاَئِكَتِكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.', targetCount: 4),
  DhikrItem(text: 'اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لاَ شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لاَ إِلَهَ إِلاَّ أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ القَبْرِ، لاَ إِلَهَ إِلاَّ أَنْتَ.', targetCount: 3),
  DhikrItem(text: 'حَسْبِيَ اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ عَلَيهِ تَوَكَّلتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.', targetCount: 7),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ: فِي دِينِي وَدُنْيَايَ وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَينِ يَدَيَّ، وَمِنْ خَلْفِي، وَعَنْ يَمِينِي، وَعَنْ شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَشَرَكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.', targetCount: 1),
  DhikrItem(text: 'بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلاَ فِي السّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.', targetCount: 3),
  DhikrItem(text: 'رَضِيتُ بِاللَّهِ رَبَّاً، وَبِالْإِسْلاَمِ دِيناً، وَبِمُحَمَّدٍ - صلى الله عليه وسلم - نَبِيّاً.', targetCount: 3),
  DhikrItem(text: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغيثُ أَصْلِحْ لِي شَأْنِيَ كُلَّهُ وَلاَ تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ.', targetCount: 1),
  DhikrItem(text: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُـمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذَا الْيَوْمِ: فَتْحَهُ، وَنَصْرَهُ، وَنورَهُ، وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ.', targetCount: 1),
  DhikrItem(text: 'أَصْبَحْنا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ - صلى الله عليه وسلم -، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشرِكِينَ.', targetCount: 1),
  DhikrItem(text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.', targetCount: 100),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', targetCount: 10),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ، وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', targetCount: 100),
  DhikrItem(text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ: عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ.', targetCount: 3),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نَافِعاً، وَرِزْقاً طَيِّباً، وَعَمَلاً مُتَقَبَّلاً.', targetCount: 1),
  DhikrItem(text: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ.', targetCount: 100),
  DhikrItem(text: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبَيِّنَا مُحَمَّدٍ.', targetCount: 10),
];

List<DhikrItem> eveningAdhkar = [
  DhikrItem(text: 'الْحَمْدُ لِلَّهِ وَحْدَهُ، وَالصَّلاَةُ وَالسَّلَامُ عَلَى مَنْ لاَ نَبِيَّ بَعْدَهُ.', targetCount: 1),
  DhikrItem(text: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيطَانِ الرَّجِيمِ {اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَوَاتِ وَالْأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ}.', targetCount: 1),
  DhikrItem(text: 'ﭑ ﭒ ﭓ {قُلْ هُوَ اللَّهُ أَحَدٌ* اللَّهُ الصَّمَدُ* لَمْ يَلِدْ وَلَمْ يُولَدْ* وَلَمْ يَكُن لَّهُ كُفُواً أَحَدٌ}. ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ* مِن شَرِّ مَا خَلَقَ* وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ* وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ* وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ}. ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ النَّاسِ* مَلِكِ النَّاسِ* إِلَهِ النَّاسِ* مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ* الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ* مِنَ الْجِنَّةِ وَ النَّاسِ}', targetCount: 3),
  DhikrItem(text: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ الْمَصِيرُ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلاَّ أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لاَ يَغْفِرُ الذُّنوبَ إِلاَّ أَنْتَ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلاَئِكَتِكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ.', targetCount: 4),
  DhikrItem(text: 'اللَّهُمَّ مَا أَمْسَى بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لاَ شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لاَ إِلَهَ إِلاَّ أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ القَبْرِ، لاَ إِلَهَ إِلاَّ أَنْتَ.', targetCount: 3),
  DhikrItem(text: 'حَسْبِيَ اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ عَلَيهِ تَوَكَّلتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ.', targetCount: 7),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ: فِي دِينِي وَدُنْيَايَ وَأَهْلِي، وَمَالِي، اللَّهُمَّ اسْتُرْ عَوْرَاتِي، وَآمِنْ رَوْعَاتِي، اللَّهُمَّ احْفَظْنِي مِنْ بَينِ يَدَيَّ، وَمِنْ خَلْفِي، وَعَنْ يَمِينِي، وَعَنْ شِمَالِي، وَمِنْ فَوْقِي، وَأَعُوذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِي.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَشَرَكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.', targetCount: 1),
  DhikrItem(text: 'بِسْمِ اللَّهِ الَّذِي لاَ يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلاَ فِي السّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ.', targetCount: 3),
  DhikrItem(text: 'رَضِيتُ بِاللَّهِ رَبَّاً، وَبِالْإِسْلاَمِ دِيناً، وَبِمُحَمَّدٍ - صلى الله عليه وسلم - نَبِيّاً.', targetCount: 3),
  DhikrItem(text: 'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغيثُ أَصْلِحْ لِي شَأْنِيَ كُلَّهُ وَلاَ تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ.', targetCount: 1),
  DhikrItem(text: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُـمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذِهِ اللَّيْلَةِ: فَتْحَهَا، وَنَصْرَهَا، وَنُورَهَا، وَبَرَكَتَهَا، وَهُدَاهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهَا وَشَرِّ مَا بَعْدَهَا.', targetCount: 1),
  DhikrItem(text: 'أَمْسَيْنَا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ - صلى الله عليه وسلم -، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشرِكِينَ.', targetCount: 1),
  DhikrItem(text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ.', targetCount: 100),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', targetCount: 10),
  DhikrItem(text: 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ.', targetCount: 100),
  DhikrItem(text: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ.', targetCount: 3),
  DhikrItem(text: 'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبَيِّنَا مُحَمَّدٍ.', targetCount: 10),
];

List<DhikrItem> afterPrayerAdhkar = [
  DhikrItem(text: 'أَسْتَغْفِرُ اللَّهَ', targetCount: 3),
  DhikrItem(text: 'اللَّهُمَّ أَنْتَ السَّلاَمُ، وَمِنْكَ السَّلاَمُ، تَبَارَكْتَ يَا ذَا الْجَلاَلِ وَالْإِكْرَامِ.', targetCount: 1),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، اللَّهُمَّ لاَ مَانِعَ لِمَا أَعْطَيْتَ، وَلاَ مُعْطِيَ لِمَا مَنَعْتَ، وَلاَ يَنْفَعُ ذَا الْجَدِّ مِنْكَ الجَدُّ.', targetCount: 3),
  DhikrItem(text: 'لَا إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ، وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ. لاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ، لاَ إِلَهَ إِلاَّ اللَّهُ، وَلاَ نَعْبُدُ إِلاَّ إِيَّاهُ, لَهُ النِّعْمَةُ وَلَهُ الْفَضْلُ وَلَهُ الثَّنَاءُ الْحَسَنُ، لَا إِلَهَ إِلاَّ اللَّهُ مُخْلِصِينَ لَهُ الدِّينَ وَلَوْ كَرِهَ الكَافِرُونَ.', targetCount: 1),
  DhikrItem(text: 'سُبْحَانَ اللَّهِ، وَالْحَمْدُ لِلَّهِ، وَاللَّهُ أَكْبَرُ', targetCount: 33),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', targetCount: 1),
  DhikrItem(text: 'ﭑ ﭒ ﭓ {قُلْ هُوَ اللَّهُ أَحَدٌ* اللَّهُ الصَّمَدُ* لَمْ يَلِدْ وَلَمْ يُولَدْ* وَلَمْ يَكُن لَّهُ كُفُواً أَحَدٌ}، ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ* مِن شَرِّ مَا خَلَقَ* وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ* وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ* وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ}، ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ النَّاسِ* مَلِكِ النَّاسِ* إِلَهِ النَّاسِ* مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ* الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ* مِنَ الْجِنَّةِ وَ النَّاسِ}بَعْدَ كُلِّ صَلاَةٍ.', targetCount: 1),
  DhikrItem(text: '{اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ}عَقِبَ كلِّ صَلاَةٍ.', targetCount: 1),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِي وَيُمِيتُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ', targetCount: 10),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْماً نافِعاً، وَرِزْقاً طَيِّباً، وَعَمَلاً مُتَقَبَّلاً', targetCount: 1),
];

List<DhikrItem> sleepAdhkar = [
  DhikrItem(text: 'يَجْمَعُ كَفَّيْهِ ثُمَّ يَنْفُثُ فِيهِمَا فَيَقْرَأُ فِيهِمَا: ﭑ ﭒ ﭓ {قُلْ هُوَ اللَّهُ أَحَدٌ * اللَّهُ الصَّمَدُ* لَمْ يَلِدْ وَلَمْ يُولَدْ* وَلَمْ يَكُن لَّهُ كُفُواً أَحَدٌ}. ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ* مِن شَرِّ مَا خَلَقَ* وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ* وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ* وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ}. ﭑ ﭒ ﭓ {قُلْ أَعُوذُ بِرَبِّ النَّاسِ* مَلِكِ النَّاسِ* إِلَهِ النَّاسِ* مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ* الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ* مِنَ الْجِنَّةِ وَ النَّاسِ}ثُمَّ يَمْسَحُ بِهِمَا مَا اسْتَطَاعَ مِنْ جَسَدِهِ يَبْدَأُ بِهِمَا عَلَى رَأْسِهِ وَوَجْهِهِ وَمَا أَقبَلَ مِنْ جَسَدِهِ', targetCount: 3),
  DhikrItem(text: '{اللَّهُ لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْـــــــــــدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ}.', targetCount: 1),
  DhikrItem(text: '{آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ كُلٌّ آمَنَ بِاللَّهِ وَمَلآئِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لاَ نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ وَقَالُواْ سَمِعْنَا وَأَطَعْنَا غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ* لاَ يُكَلِّفُ اللَّهُ نَفْساً إِلاَّ وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لاَ تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا رَبَّنَا وَلاَ تَحْمِلْ عَلَيْنَا إِصْراً كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا رَبَّنَا وَلاَ تُحَمِّلْنَا مَا لاَ طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَآ أَنتَ مَوْلاَنَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ}.', targetCount: 1),
  DhikrItem(text: 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، فَإِن أَمْسَكْتَ نَفْسِي فارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا، بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ إِنَّكَ خَلَقْتَ نَفْسِي وَأَنْتَ تَوَفَّاهَا، لَكَ مَمَاتُهَا وَمَحْياهَا، إِنْ أَحْيَيْتَهَا فَاحْفَظْهَا، وَإِنْ أَمَتَّهَا فَاغْفِرْ لَهَا. اللَّهُمَّ إِنِّي أَسْأَلُكَ العَافِيَةَ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ قِنِي عَذَابَكَ يَوْمَ تَبْعَثُ عِبَادَكَ.', targetCount: 1),
  DhikrItem(text: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا.', targetCount: 1),
  DhikrItem(text: 'سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ وَاللَّهُ أَكْبَرُ', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ رَبَّ السَّمَوَاتِ السَّبْعِ وَرَبَّ الأَرْضِ، وَرَبَّ الْعَرْشِ الْعَظِيمِ، رَبَّنَا وَرَبَّ كُلِّ شَيْءٍ، فَالِقَ الْحَبِّ وَالنَّوَى، وَمُنْزِلَ التَّوْرَاةِ وَالْإِنْجِيلِ، وَالْفُرْقَانِ، أَعُوذُ بِكَ مِنْ شَرِّ كُلِّ شَيْءٍ أَنْتَ آخِذٌ بِنَاصِيَتِهِ. اللَّهُمَّ أَنْتَ الأَوَّلُ فَلَيْسَ قَبْلَكَ شَيْءٌ، وَأَنْتَ الآخِرُ فَلَيسَ بَعْدَكَ شَيْءٌ، وَأَنْتَ الظَّاهِرُ فَلَيْسَ فَوْقَكَ شَيْءٌ، وَأَنْتَ الْبَاطِنُ فَلَيْسَ دُونَكَ شَيْءٌ، اقْضِ عَنَّا الدَّيْنَ وَأَغْنِنَا مِنَ الْفَقْرِ.', targetCount: 1),
  DhikrItem(text: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا، وَكَفَانَا، وَآوَانَا، فَكَمْ مِمَّنْ لاَ كَافِيَ لَهُ وَلاَ مُؤْوِيَ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ عَالِمَ الغَيْبِ وَالشَّهَادَةِ فَاطِرَ السَّمَوَاتِ وَالْأَرْضِ، رَبَّ كُلِّ شَيْءٍ وَمَلِيكَهُ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ، أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي، وَمِنْ شَرِّ الشَّيْطانِ وَشِرْكِهِ، وَأَنْ أَقْتَرِفَ عَلَى نَفْسِي سُوءاً، أَوْ أَجُرَّهُ إِلَى مُسْلِمٍ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ أَسْلَمْتُ نَفْسِي إِلَيْكَ، وَفَوَّضْتُ أَمْرِي إِلَيْكَ، وَوَجَّهْتُ وَجْهِي إِلَيْكَ، وَأَلْجَأْتُ ظَهْرِي إِلَيْكَ، رَغْبَةً وَرَهْبَةً إِلَيْكَ، لاَ مَلْجَأَ وَلاَ مَنْجَا مِنْكَ إِلاَّ إِلَيْكَ، آمَنْتُ بِكِتَابِكَ الَّذِي أَنْزَلْتَ، وَبِنَبِيِّكَ الَّذِي أَرْسَلْتَ.', targetCount: 1),
];

List<DhikrItem> wakeupAdhkar = [
  DhikrItem(text: 'الْحَمْدُ للَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا، وَإِلَيْهِ النُّشُورُ.', targetCount: 1),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، سُبْحَانَ اللَّهِ، وَالْحَمْدُ للَّهِ، وَلاَ إِلَهَ إِلاَّ اللَّهُ، وَاللَّهُ أَكْبَرُ، وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ الْعَلِيِّ الْعَظِيمِ، رَبِّ اغْفرْ لِي.', targetCount: 1),
  DhikrItem(text: 'الْحَمْدُ لِلَّهِ الَّذِي عَافَانِي فِي جَسَدِي، وَرَدَّ عَلَيَّ رُوحِي، وَأَذِنَ لي بِذِكْرِهِ.', targetCount: 1),
  DhikrItem(text: '{إِنَّ فِي خَلْقِ السَّمَوَاتِ وَالأَرْضِ وَاخْتِلاَفِ اللَّيْلِ وَالنَّهَارِ لَآيَاتٍ لأُوْلِي الألْبَابِ * الَّذِينَ يَذْكُرُونَ اللَّهَ قِيَاماً وَقُعُوداً وَعَلَىَ جُنُوبِهِمْ وَيَتَفَكَّرُونَ فِي خَلْقِ السَّمَوَاتِ وَالأَرْضِ رَبَّنَا مَا خَلَقْتَ هَذا بَاطِلاً سُبْحَانَكَ فَقِنَا عَذَابَ النَّارِ...}', targetCount: 1),
];

List<DhikrItem> homeAdhkar = [
  DhikrItem(text: 'بِسْمِ اللَّهِ، تَوَكَّلْتُ عَلَى اللَّهِ، وَلَاَ حَوْلَ وَلَا قُوَّةَ إِلاَّ بِاللَّهِ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ أَنْ أَضِلَّ، أَوْ أُضَلَّ، أَوْ أَزِلَّ، أَوْ أُزَلَّ، أَوْ أَظْلِمَ، أَوْ أُظْلَمَ، أَوْ أَجْهَلَ، أَوْ يُجْهَلَ عَلَيَّ.', targetCount: 1),
  DhikrItem(text: 'بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِِّنَا تَوَكَّلْنَا، ثُمَّ لِيُسَلِّمْ عَلَى أَهْلِهِ', targetCount: 1),
];

List<DhikrItem> foodAdhkar = [
  DhikrItem(text: 'ذَهَبَ الظَّمَأُ وَابْتَلَّتِ العُرُوقُ، وَثَبَتَ الْأَجْرُ إِنْ شَاءَ اللَّهُ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ بِرَحْمَتِكَ الَّتِي وَسِعَتْ كُلَّ شَيْءٍ أَنْ تَغْفِرَ لِي.', targetCount: 1),
  DhikrItem(text: 'إِذَا أَكَلَ أَحَدُكُمْ طَعَاماً فَلْيَقُلْ بِسْمِ اللَّهِ، فَإِنْ نَسِيَ فِي أَوَّلِهِ فَلْيَقُلْ بسمِ اللَّهِ فِي أَوَّلِهِ وَآخِرِهِ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ بَارِكْ لَنَا فِيهِ وَأَطْعِمْنَا خَيْراً مِنْهُ.', targetCount: 1),
  DhikrItem(text: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا، وَرَزَقَنِيهِ، مِنْ غَيْرِ حَوْلٍ مِنِّي وَلاَ قُوَّةٍ.', targetCount: 1),
  DhikrItem(text: 'الْحَمْدُ لِلَّهِ حَمْداً كَثِيراً طَيِّباً مُبَارَكاً فِيهِ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ بَارِكْ لَهُمْ فِيمَا رَزَقْتَهُم، وَاغْفِرْ لَهُمْ وَارْحَمْهُمْ.', targetCount: 1),
  DhikrItem(text: 'أَفْطَرَ عِنْدَكُمُ الصَّائِمُونَ، وَأَكَلَ طَعَامَكُمُ الْأَبْرَارُ، وَصَلَّتْ عَلَيْكُمُ الْمَلاَئِكَةُ.', targetCount: 1),
];

List<DhikrItem> ablutionAndMarketAdhkar = [
  DhikrItem(text: 'بِسْمِ اللَّهِ.', targetCount: 1),
  DhikrItem(text: 'أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّداً عَبْدُهُ وَرَسُولُهُ.', targetCount: 1),
  DhikrItem(text: 'اللَّهُمَّ اجْعَلْنِي مِنَ التَّوَّابِينَ وَاجْعَلْنِي مِنَ الْمُتَطَهِّرِينَ.', targetCount: 1),
  DhikrItem(text: 'سُبْحانَكَ اللَّهُمَّ وَبِحَمْدِكَ، أَشْهَدُ أَنْ لاَ إِلَهَ إِلاَّ أَنْتَ، أَسْتَغْفِرُكَ وَأَتوبُ إِلَيْكَ.', targetCount: 1),
  DhikrItem(text: 'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ، وَلَهُ الْحَمْدُ، يُحْيِي وَيُمِيتُ، وَهُوَ حَيٌّ لاِ يَمُوتُ، بِيَدِهِ الْخَيْرُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.', targetCount: 1),
];
