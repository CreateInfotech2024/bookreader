// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Book Reader',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: BookReaderScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class BookPage {
//   final String title;
//   final String content;
//   final String? videoUrl;
//   final List<String> images;
//
//   BookPage({
//     required this.title,
//     required this.content,
//     this.videoUrl,
//     this.images = const [],
//   });
// }
//
// class Highlight {
//   final String text;
//   final Color color;
//   final int startIndex;
//   final int endIndex;
//   final int pageIndex;
//
//   Highlight({
//     required this.text,
//     required this.color,
//     required this.startIndex,
//     required this.endIndex,
//     required this.pageIndex,
//   });
// }
//
// class StickyNote {
//   final String text;
//   final Offset position;
//   final int pageIndex;
//   final String id;
//
//   StickyNote({
//     required this.text,
//     required this.position,
//     required this.pageIndex,
//     required this.id,
//   });
// }
//
// class BookReaderScreen extends StatefulWidget {
//   @override
//   _BookReaderScreenState createState() => _BookReaderScreenState();
// }
//
// class _BookReaderScreenState extends State<BookReaderScreen> {
//   PageController _pageController = PageController();
//   int _currentPageIndex = 0;
//   bool _isFullscreen = false;
//   bool _showToolbar = true;
//   List<Highlight> _highlights = [];
//   List<StickyNote> _stickyNotes = [];
//   String _searchQuery = '';
//   bool _isSearching = false;
//   Color _selectedHighlightColor = Colors.yellow;
//
//   final List<BookPage> _pages = [
//     BookPage(
//       title: "ATPL(A) Air Law",
//       content: """A single wing bar is located on the left side of the runway abeam the runway aiming point. If wing bars are set on both sides of the runway then they are arranged to display in mirror image, as shown above.
//
// The PAPI System is designed for aircraft with wheel heights in the flare not exceeding 15 m.
//
// Abbreviated Precision Approach Path Indicator (APAPI)
//
// The APAPI system comprises two lights normally located on the left side of the runway, arranged to display (from left to right) as shown below:
//
//  • Above the approach slope
//  • On the approach slope
//  • Below the approach slope
//
// Figure 25.13 Abbreviated Precision Approach Path Indicator (APAPI) lighting
//
// The APAPI System.""",
//       images: [
//         'assets/images/download.jpg',
//         'assets/images/download (1).jpg'
//       ],
//     ),
//     BookPage(
//       title: "ATPL(A) Air Law",
//       content: """This movie shows how a dual wing bar PAPI system displays for three different glide path situations.
//
// Once the PAPIs are showing four reds you have no way of knowing whether you are just into the four-reds region or well below.
//
// ERROR
//
// Allowing the aircraft to sink into the four-red region on a visual approach leading to loss of visual approach path guidance resulting in unsafe separation from or collision with terrain.
//
// Countermeasure: Do not ever slip into the four-reds region. If you do, then take immediate corrective action to regain visual approach path guidance (at least one white showing) or go-around.""",
//       videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
//     ),
//   ];
//
//   late VideoPlayerController _videoController;
//   bool _isVideoInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   void _initializeVideo() {
//     if (_pages[1].videoUrl != null) {
//       _videoController = VideoPlayerController.asset(_pages[1].videoUrl!)
//         ..initialize().then((_) {
//           setState(() {
//             _isVideoInitialized = true;
//           });
//         });
//     }
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     if (_isVideoInitialized) {
//       _videoController.dispose();
//     }
//     super.dispose();
//   }
//
//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;
//     });
//
//     if (_isFullscreen) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     } else {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//           overlays: SystemUiOverlay.values);
//     }
//   }
//
//   void _addHighlight(String selectedText, int startIndex, int endIndex) {
//     setState(() {
//       _highlights.add(Highlight(
//         text: selectedText,
//         color: _selectedHighlightColor,
//         startIndex: startIndex,
//         endIndex: endIndex,
//         pageIndex: _currentPageIndex,
//       ));
//     });
//   }
//
//   void _addStickyNote(Offset position, String noteText) {
//     setState(() {
//       _stickyNotes.add(StickyNote(
//         text: noteText,
//         position: position,
//         pageIndex: _currentPageIndex,
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//       ));
//     });
//   }
//
//   void _showTableOfContents() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Table of Contents'),
//         content: Container(
//           width: double.maxFinite,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: _pages.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(_pages[index].title),
//                 subtitle: Text('Page ${index + 1}'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pageController.animateToPage(
//                     index,
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showSearchDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Search'),
//         content: TextField(
//           onChanged: (value) {
//             setState(() {
//               _searchQuery = value;
//             });
//           },
//           decoration: InputDecoration(
//             hintText: 'Enter search term...',
//             prefixIcon: Icon(Icons.search),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _performSearch();
//             },
//             child: Text('Search'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _performSearch() {
//     // Simple search implementation
//     for (int i = 0; i < _pages.length; i++) {
//       if (_pages[i].content.toLowerCase().contains(_searchQuery.toLowerCase())) {
//         _pageController.animateToPage(
//           i,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//         break;
//       }
//     }
//   }
//
//   Widget _buildHighlightColorPicker() {
//     final colors = [
//       Colors.yellow,
//       Colors.green,
//       Colors.blue,
//       Colors.pink,
//       Colors.orange,
//     ];
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: colors.map((color) =>
//           GestureDetector(
//             onTap: () => setState(() => _selectedHighlightColor = color),
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 4),
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 color: color,
//                 border: Border.all(
//                   color: _selectedHighlightColor == color ? Colors.black : Colors.grey,
//                   width: _selectedHighlightColor == color ? 2 : 1,
//                 ),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//       ).toList(),
//     );
//   }
//
//   Widget _buildToolbar() {
//     if (!_showToolbar) return SizedBox.shrink();
//
//     return Container(
//       height: 60,
//       color: Colors.grey[200],
//       child: Row(
//         children: [
//           IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: _showTableOfContents,
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _showSearchDialog,
//           ),
//           IconButton(
//             icon: Icon(Icons.highlight),
//             onPressed: () {
//               // _addHighlight(selectedText, startIndex, endIndex)
//               // Toggle highlight mode
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.note_add),
//             onPressed: () {
//               // Add sticky note
//               _showAddNoteDialog();
//             },
//           ),
//           _buildHighlightColorPicker(),
//           Spacer(),
//           Text('${_currentPageIndex + 1} / ${_pages.length}'),
//           IconButton(
//             icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
//             onPressed: _toggleFullscreen,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showAddNoteDialog() {
//     String noteText = '';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Add Sticky Note'),
//         content: TextField(
//           onChanged: (value) => noteText = value,
//           decoration: InputDecoration(hintText: 'Enter note...'),
//           maxLines: 3,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               if (noteText.isNotEmpty) {
//                 _addStickyNote(Offset(100, 100), noteText);
//               }
//             },
//             child: Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextPage(BookPage page, int pageIndex) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 page.title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SelectableText(
//                         page.content,
//                         style: TextStyle(fontSize: 16, height: 1.5),
//                         onSelectionChanged: (selection, cause) {
//                           if (selection.baseOffset != selection.extentOffset) {
//                             String selectedText = page.content.substring(
//                               selection.baseOffset,
//                               selection.extentOffset,
//                             );
//                             // Could add highlight here
//                           }
//                         },
//                       ),
//                       if (page.images.isNotEmpty) ...[
//                         SizedBox(height: 20),
//                         ...page.images.map((imagePath) =>
//                             Container(
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               child: Image.network(
//                                 imagePath,
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Container(
//                                       height: 200,
//                                       color: Colors.grey[300],
//                                       child: Center(
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Icon(Icons.image, size: 50, color: Colors.grey),
//                                             Text('Image placeholder'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                               ),
//                             ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Sticky notes overlay
//           ..._stickyNotes
//               .where((note) => note.pageIndex == pageIndex)
//               .map((note) => Positioned(
//             left: note.position.dx,
//             top: note.position.dy,
//             child: _buildStickyNote(note),
//           )),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildVideoPage(BookPage page, int pageIndex) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 page.title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Video player
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: _isVideoInitialized
//                     ? Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     AspectRatio(
//                       aspectRatio: _videoController.value.aspectRatio,
//                       child: VideoPlayer(_videoController),
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         _videoController.value.isPlaying
//                             ? Icons.pause
//                             : Icons.play_arrow,
//                         color: Colors.white,
//                         size: 50,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _videoController.value.isPlaying
//                               ? _videoController.pause()
//                               : _videoController.play();
//                         });
//                       },
//                     ),
//                   ],
//                 )
//                     : Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.play_circle_outline, size: 80, color: Colors.white54),
//                       SizedBox(height: 10),
//                       Text('Video Player', style: TextStyle(color: Colors.white54)),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: SelectableText(
//                     page.content,
//                     style: TextStyle(fontSize: 16, height: 1.5),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Sticky notes overlay
//           ..._stickyNotes
//               .where((note) => note.pageIndex == pageIndex)
//               .map((note) => Positioned(
//             left: note.position.dx,
//             top: note.position.dy,
//             child: _buildStickyNote(note),
//           )),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStickyNote(StickyNote note) {
//     return Container(
//       width: 150,
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.yellow[200],
//         border: Border.all(color: Colors.orange),
//         borderRadius: BorderRadius.circular(4),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 4,
//             offset: Offset(2, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(Icons.note, size: 16, color: Colors.orange[800]),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _stickyNotes.removeWhere((n) => n.id == note.id);
//                   });
//                 },
//                 child: Icon(Icons.close, size: 16, color: Colors.red),
//               ),
//             ],
//           ),
//           SizedBox(height: 4),
//           Text(
//             note.text,
//             style: TextStyle(fontSize: 12),
//             maxLines: 4,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           if (!_isFullscreen) _buildToolbar(),
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 if (_isFullscreen) {
//                   setState(() {
//                     _showToolbar = !_showToolbar;
//                   });
//                 }
//               },
//               child: PageView.builder(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentPageIndex = index;
//                   });
//                 },
//                 itemCount: _pages.length,
//                 itemBuilder: (context, index) {
//                   final page = _pages[index];
//
//                   if (page.videoUrl != null) {
//                     return _buildVideoPage(page, index);
//                   } else {
//                     return _buildTextPage(page, index);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Book Reader',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: BookReaderScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class BookPage {
//   final String title;
//   final String content;
//   final String? videoUrl;
//   final List<String> images;
//
//   BookPage({
//     required this.title,
//     required this.content,
//     this.videoUrl,
//     this.images = const [],
//   });
// }
//
// class Highlight {
//   final String text;
//   final Color color;
//   final int startIndex;
//   final int endIndex;
//   final int pageIndex;
//
//   Highlight({
//     required this.text,
//     required this.color,
//     required this.startIndex,
//     required this.endIndex,
//     required this.pageIndex,
//   });
// }
//
// class StickyNote {
//   final String text;
//   final Offset position;
//   final int pageIndex;
//   final String id;
//
//   StickyNote({
//     required this.text,
//     required this.position,
//     required this.pageIndex,
//     required this.id,
//   });
// }
//
// class BookReaderScreen extends StatefulWidget {
//   @override
//   _BookReaderScreenState createState() => _BookReaderScreenState();
// }
//
// class _BookReaderScreenState extends State<BookReaderScreen> {
//   PageController _pageController = PageController();
//   TransformationController _transformationController =
//       TransformationController();
//
//   int _currentPageIndex = 0;
//   bool _isFullscreen = false;
//   bool _showToolbar = true;
//   List<Highlight> _highlights = [];
//   List<StickyNote> _stickyNotes = [];
//   String _searchQuery = '';
//   bool _isSearching = false;
//   bool _isAddingNote = false;
//   Offset? _pendingNotePosition;
//   Color _selectedHighlightColor = Colors.yellow;
//
//   final List<BookPage> _pages = [
//     BookPage(
//       title: "ATPL(A) Air Law",
//       content:
//           """A single wing bar is located on the left side of the runway abeam the runway aiming point. If wing bars are set on both sides of the runway then they are arranged to display in mirror image, as shown above.
//
// The PAPI System is designed for aircraft with wheel heights in the flare not exceeding 15 m.
//
// Abbreviated Precision Approach Path Indicator (APAPI)
//
// The APAPI system comprises two lights normally located on the left side of the runway, arranged to display (from left to right) as shown below:
//
//  • Above the approach slope
//  • On the approach slope
//  • Below the approach slope
//
// Figure 25.13 Abbreviated Precision Approach Path Indicator (APAPI) lighting
//
// The APAPI System.""",
//       images: ['assets/images/download.jpg', 'assets/images/download (1).jpg'],
//     ),
//     BookPage(
//       title: "ATPL(A) Air Law",
//       content:
//           """This movie shows how a dual wing bar PAPI system displays for three different glide path situations.
//
// Once the PAPIs are showing four reds you have no way of knowing whether you are just into the four-reds region or well below.
//
// ERROR
//
// Allowing the aircraft to sink into the four-red region on a visual approach leading to loss of visual approach path guidance resulting in unsafe separation from or collision with terrain.
//
// Countermeasure: Do not ever slip into the four-reds region. If you do, then take immediate corrective action to regain visual approach path guidance (at least one white showing) or go-around.""",
//       videoUrl:
//           'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
//     ),
//   ];
//
//   late VideoPlayerController _videoController;
//   bool _isVideoInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   void _initializeVideo() {
//     if (_pages[1].videoUrl != null) {
//       _videoController = VideoPlayerController.asset(_pages[1].videoUrl!)
//         ..initialize().then((_) {
//           setState(() {
//             _isVideoInitialized = true;
//           });
//         });
//     }
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _transformationController.dispose();
//     if (_isVideoInitialized) {
//       _videoController.dispose();
//     }
//     super.dispose();
//   }
//
//   // Zoom functions
//   void _resetZoom() {
//     _transformationController.value = Matrix4.identity();
//   }
//
//   void _zoomIn() {
//     final Matrix4 matrix = _transformationController.value.clone();
//     matrix.scale(1.2);
//     _transformationController.value = matrix;
//   }
//
//   void _zoomOut() {
//     final Matrix4 matrix = _transformationController.value.clone();
//     matrix.scale(0.8);
//     _transformationController.value = matrix;
//   }
//
//   void _toggleFullscreen() {
//     setState(() {
//       _isFullscreen = !_isFullscreen;
//     });
//
//     if (_isFullscreen) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     } else {
//       SystemChrome.setEnabledSystemUIMode(
//         SystemUiMode.manual,
//         overlays: SystemUiOverlay.values,
//       );
//     }
//   }
//
//   void _addHighlight(String selectedText, int startIndex, int endIndex) {
//     setState(() {
//       _highlights.add(
//         Highlight(
//           text: selectedText,
//           color: _selectedHighlightColor,
//           startIndex: startIndex,
//           endIndex: endIndex,
//           pageIndex: _currentPageIndex,
//         ),
//       );
//     });
//   }
//
//   void _addStickyNote(Offset position, String noteText) {
//     setState(() {
//       _stickyNotes.add(
//         StickyNote(
//           text: noteText,
//           position: position,
//           pageIndex: _currentPageIndex,
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//         ),
//       );
//     });
//   }
//
//   void _showTableOfContents() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Table of Contents'),
//         content: Container(
//           width: double.maxFinite,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: _pages.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(_pages[index].title),
//                 subtitle: Text('Page ${index + 1}'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pageController.animateToPage(
//                     index,
//                     duration: Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showSearchDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Search'),
//         content: TextField(
//           onChanged: (value) {
//             setState(() {
//               _searchQuery = value;
//             });
//           },
//           decoration: InputDecoration(
//             hintText: 'Enter search term...',
//             prefixIcon: Icon(Icons.search),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _performSearch();
//             },
//             child: Text('Search'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _performSearch() {
//     // Simple search implementation
//     for (int i = 0; i < _pages.length; i++) {
//       if (_pages[i].content.toLowerCase().contains(
//         _searchQuery.toLowerCase(),
//       )) {
//         _pageController.animateToPage(
//           i,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//         break;
//       }
//     }
//   }
//
//   Widget _buildHighlightColorPicker() {
//     final colors = [
//       Colors.yellow,
//       Colors.green,
//       Colors.blue,
//       Colors.pink,
//       Colors.orange,
//     ];
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: colors
//           .map(
//             (color) => GestureDetector(
//               onTap: () => setState(() => _selectedHighlightColor = color),
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 4),
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: color,
//                   border: Border.all(
//                     color: _selectedHighlightColor == color
//                         ? Colors.black
//                         : Colors.grey,
//                     width: _selectedHighlightColor == color ? 2 : 1,
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
//
//   Widget _buildToolbar() {
//     if (!_showToolbar) return SizedBox.shrink();
//
//     return Container(
//       height: 60,
//       color: Colors.grey[200],
//       child: Row(
//         children: [
//           IconButton(icon: Icon(Icons.menu), onPressed: _showTableOfContents),
//           IconButton(icon: Icon(Icons.search), onPressed: _showSearchDialog),
//           IconButton(
//             icon: Icon(Icons.highlight),
//             onPressed: () {
//               // _addHighlight(selectedText, startIndex, endIndex)
//               // Toggle highlight mode
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.note_add),
//             onPressed: () {
//               // Add sticky note
//               // onPressed: () {
//                 setState(() {
//                   _isAddingNote = !_isAddingNote;
//                 });
//                 if (_isAddingNote) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Tap anywhere on the page to add a sticky note'),
//                       duration: Duration(seconds: 2),
//                     ),
//
//                   );
//                   // RenderBox renderBox = context.findRenderObject() as RenderBox;
//                   // Offset localPosition = details.localPosition;
//                   //
//                   // setState(() {
//                   //   _pendingNotePosition = localPosition;
//                   // });
//                   _showAddNoteDialog(Offset(100, 100));
//                 // }
//               }
//               // _showAddNoteDialog();
//             },
//           ),
//           // Zoom controls
//           IconButton(
//             icon: Icon(Icons.zoom_out),
//             onPressed: _zoomOut,
//             tooltip: 'Zoom Out',
//           ),
//           IconButton(
//             icon: Icon(Icons.zoom_in),
//             onPressed: _zoomIn,
//             tooltip: 'Zoom In',
//           ),
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _resetZoom,
//             tooltip: 'Reset Zoom',
//           ),
//           _buildHighlightColorPicker(),
//           Spacer(),
//           Text('${_currentPageIndex + 1} / ${_pages.length}'),
//           IconButton(
//             icon: Icon(
//               _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
//             ),
//             onPressed: _toggleFullscreen,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFloatingToolbar() {
//     if (!_isFullscreen || !_showToolbar) return SizedBox.shrink();
//
//     return Positioned(
//       top: 50,
//       right: 20,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.8),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.zoom_out, color: Colors.white),
//               onPressed: _zoomOut,
//               tooltip: 'Zoom Out',
//             ),
//             IconButton(
//               icon: Icon(Icons.zoom_in, color: Colors.white),
//               onPressed: _zoomIn,
//               tooltip: 'Zoom In',
//             ),
//             IconButton(
//               icon: Icon(Icons.refresh, color: Colors.white),
//               onPressed: _resetZoom,
//               tooltip: 'Reset Zoom',
//             ),
//             IconButton(
//               icon: Icon(Icons.fullscreen_exit, color: Colors.white),
//               onPressed: _toggleFullscreen,
//               tooltip: 'Exit Fullscreen',
//             ),
//             IconButton(
//               icon: Icon(Icons.menu, color: Colors.white),
//               onPressed: _showTableOfContents,
//               tooltip: 'Table of Contents',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddNoteDialog([Offset? position]) {
//     String noteText = '';
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Add Sticky Note'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (position != null)
//               // Text(
//               //   'Position: (${position.dx.toInt()}, ${position.dy.toInt()})',
//               //   style: TextStyle(fontSize: 12, color: Colors.grey),
//               // ),
//             SizedBox(height: 8),
//             TextField(
//               onChanged: (value) => noteText = value,
//               decoration: InputDecoration(hintText: 'Enter note...'),
//               maxLines: 3,
//               autofocus: true,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               setState(() {
//                 _isAddingNote = false;
//                 _pendingNotePosition = null;
//               });
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               if (noteText.isNotEmpty) {
//                 _addStickyNote(position ?? Offset(100, 100), noteText);
//               }
//               setState(() {
//                 _isAddingNote = false;
//                 _pendingNotePosition = null;
//               });
//             },
//             child: Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildZoomableContent(Widget child) {
//     return InteractiveViewer(
//       transformationController: _transformationController,
//       boundaryMargin: EdgeInsets.all(20),
//       minScale: 0.5,
//       maxScale: 4.0,
//       constrained: true,
//       child: GestureDetector(
//         onTapUp: (details) {
//           if (_isAddingNote) {
//             // Calculate relative position within the content
//             RenderBox renderBox = context.findRenderObject() as RenderBox;
//             Offset localPosition = details.localPosition;
//
//             setState(() {
//               _pendingNotePosition = localPosition;
//             });
//
//             _showAddNoteDialog(localPosition);
//           }
//         },
//         child: child,
//       ),
//     );
//   }
//
//   Widget _buildTextPage(BookPage page, int pageIndex) {
//     return _buildZoomableContent(
//       Container(
//         padding: EdgeInsets.all(16),
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   page.title,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[800],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SelectableText(
//                           page.content,
//                           style: TextStyle(fontSize: 16, height: 1.5),
//                           onSelectionChanged: (selection, cause) {
//                             if (selection.baseOffset !=
//                                 selection.extentOffset) {
//                               String selectedText = page.content.substring(
//                                 selection.baseOffset,
//                                 selection.extentOffset,
//                               );
//                               // Could add highlight here
//                             }
//                           },
//                         ),
//                         if (page.images.isNotEmpty) ...[
//                           SizedBox(height: 20),
//                           ...page.images.map(
//                             (imagePath) => Container(
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               child: Image.network(
//                                 imagePath,
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Container(
//                                       height: 200,
//                                       color: Colors.grey[300],
//                                       child: Center(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(
//                                               Icons.image,
//                                               size: 50,
//                                               color: Colors.grey,
//                                             ),
//                                             Text('Image placeholder'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Sticky notes overlay
//             ..._stickyNotes
//                 .where((note) => note.pageIndex == pageIndex)
//                 .map(
//                   (note) => Positioned(
//                     left: note.position.dx,
//                     top: note.position.dy,
//                     child: _buildStickyNote(note),
//                   ),
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVideoPage(BookPage page, int pageIndex) {
//     return _buildZoomableContent(
//       Container(
//         padding: EdgeInsets.all(16),
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   page.title,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue[800],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Video player
//                 Container(
//                   height: 300,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: _isVideoInitialized
//                       ? Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             AspectRatio(
//                               aspectRatio: _videoController.value.aspectRatio,
//                               child: VideoPlayer(_videoController),
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 _videoController.value.isPlaying
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                                 color: Colors.white,
//                                 size: 50,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _videoController.value.isPlaying
//                                       ? _videoController.pause()
//                                       : _videoController.play();
//                                 });
//                               },
//                             ),
//                           ],
//                         )
//                       : Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.play_circle_outline,
//                                 size: 80,
//                                 color: Colors.white54,
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 'Video Player',
//                                 style: TextStyle(color: Colors.white54),
//                               ),
//                             ],
//                           ),
//                         ),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: SelectableText(
//                       page.content,
//                       style: TextStyle(fontSize: 16, height: 1.5),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Sticky notes overlay
//             ..._stickyNotes
//                 .where((note) => note.pageIndex == pageIndex)
//                 .map(
//                   (note) => Positioned(
//                     left: note.position.dx,
//                     top: note.position.dy,
//                     child: _buildStickyNote(note),
//                   ),
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStickyNote(StickyNote note) {
//     return Container(
//       width: 150,
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.yellow[200],
//         border: Border.all(color: Colors.orange),
//         borderRadius: BorderRadius.circular(4),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 4,
//             offset: Offset(2, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Icon(Icons.note, size: 16, color: Colors.orange[800]),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _stickyNotes.removeWhere((n) => n.id == note.id);
//                   });
//                 },
//                 child: Icon(Icons.close, size: 16, color: Colors.red),
//               ),
//             ],
//           ),
//           SizedBox(height: 4),
//           Text(
//             note.text,
//             style: TextStyle(fontSize: 12),
//             maxLines: 4,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               if (!_isFullscreen) _buildToolbar(),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     if (_isFullscreen) {
//                       setState(() {
//                         _showToolbar = !_showToolbar;
//                       });
//                     }
//                   },
//                   child: PageView.builder(
//                     controller: _pageController,
//                     onPageChanged: (index) {
//                       setState(() {
//                         _currentPageIndex = index;
//                         _resetZoom(); // Reset zoom when changing pages
//                       });
//                     },
//                     itemCount: _pages.length,
//                     itemBuilder: (context, index) {
//                       final page = _pages[index];
//
//                       if (page.videoUrl != null) {
//                         return _buildVideoPage(page, index);
//                       } else {
//                         return _buildTextPage(page, index);
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           _buildFloatingToolbar(),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Reader',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PDFReaderScreen(),
    );
  }
}

class Annotation {
  final String id;
  final int pageNumber;
  final Offset position;
  final String type; // 'note' or 'highlight'
  final String content;
  final Color color;

  Annotation({
    required this.id,
    required this.pageNumber,
    required this.position,
    required this.type,
    required this.content,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'pageNumber': pageNumber,
    'positionX': position.dx,
    'positionY': position.dy,
    'type': type,
    'content': content,
    'color': color.value,
  };

  factory Annotation.fromJson(Map<String, dynamic> json) => Annotation(
    id: json['id'],
    pageNumber: json['pageNumber'],
    position: Offset(json['positionX'], json['positionY']),
    type: json['type'],
    content: json['content'],
    color: Color(json['color']),
  );
}

class PDFReaderScreen extends StatefulWidget {
  const PDFReaderScreen({Key? key}) : super(key: key);

  @override
  State<PDFReaderScreen> createState() => _PDFReaderScreenState();
}

class _PDFReaderScreenState extends State<PDFReaderScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  List<Annotation> annotations = [];
  String selectedTool = 'none'; // 'none', 'note', 'highlight'
  Color selectedColor = Colors.yellow;
  bool showAnnotations = true;

  @override
  void initState() {
    super.initState();
    _loadAnnotations();
  }

  Future<void> _loadAnnotations() async {
    final prefs = await SharedPreferences.getInstance();
    final String? annotationsJson = prefs.getString('annotations');
    if (annotationsJson != null) {
      final List<dynamic> decoded = json.decode(annotationsJson);
      setState(() {
        annotations = decoded.map((item) => Annotation.fromJson(item)).toList();
      });
    }
  }

  Future<void> _saveAnnotations() async {
    final prefs = await SharedPreferences.getInstance();
    final String annotationsJson = json.encode(
      annotations.map((a) => a.toJson()).toList(),
    );
    await prefs.setString('annotations', annotationsJson);
  }

  void _addAnnotation(Offset position, int pageNumber) {
    if (selectedTool == 'none') return;

    showDialog(
      context: context,
      builder: (context) {
        String noteText = '';
        return AlertDialog(
          title: Text(selectedTool == 'note' ? 'Add Note' : 'Add Highlight'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter your note...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) => noteText = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (noteText.isNotEmpty) {
                  setState(() {
                    annotations.add(
                      Annotation(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        pageNumber: pageNumber,
                        position: position,
                        type: selectedTool,
                        content: noteText,
                        color: selectedColor,
                      ),
                    );
                  });
                  _saveAnnotations();
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _deleteAnnotation(String id) {
    setState(() {
      annotations.removeWhere((a) => a.id == id);
    });
    _saveAnnotations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Reader'),
        actions: [
          IconButton(
            icon: Icon(
              showAnnotations ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                showAnnotations = !showAnnotations;
              });
            },
            tooltip: 'Toggle Annotations',
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              _pdfController.zoomLevel = _pdfController.zoomLevel + 0.25;
            },
            tooltip: 'Zoom In',
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _pdfController.zoomLevel = _pdfController.zoomLevel - 0.25;
            },
            tooltip: 'Zoom Out',
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              final currentPage = _pdfController.pageNumber;
              _addAnnotation(details.localPosition, currentPage);
            },
            child: SfPdfViewer.asset(
              'book1.pdf', // Replace with your PDF path
              key: _pdfViewerKey,
              controller: _pdfController,
              canShowScrollHead: true,
              canShowScrollStatus: true,
            ),
          ),
          if (showAnnotations)
            ...annotations
                .where((a) => a.pageNumber == _pdfController.pageNumber)
                .map(
                  (annotation) => Positioned(
                left: annotation.position.dx,
                top: annotation.position.dy,
                child: GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          annotation.type == 'note' ? 'Note' : 'Highlight',
                        ),
                        content: Text(annotation.content),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _deleteAnnotation(annotation.id);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: annotation.color.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          annotation.type == 'note'
                              ? Icons.note
                              : Icons.highlight,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: Text(
                            annotation.content,
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                .toList(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.touch_app,
                color: selectedTool == 'none' ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedTool = 'none';
                });
              },
              tooltip: 'Select',
            ),
            IconButton(
              icon: Icon(
                Icons.sticky_note_2,
                color: selectedTool == 'note' ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedTool = 'note';
                });
              },
              tooltip: 'Sticky Note',
            ),
            IconButton(
              icon: Icon(
                Icons.highlight,
                color: selectedTool == 'highlight' ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  selectedTool = 'highlight';
                });
              },
              tooltip: 'Highlighter',
            ),
            IconButton(
              icon: Icon(Icons.color_lens, color: selectedColor),
              onPressed: _showColorPicker,
              tooltip: 'Color',
            ),
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ListView.builder(
                    itemCount: annotations.length,
                    itemBuilder: (context, index) {
                      final annotation = annotations[index];
                      return ListTile(
                        leading: Icon(
                          annotation.type == 'note'
                              ? Icons.note
                              : Icons.highlight,
                          color: annotation.color,
                        ),
                        title: Text(annotation.content),
                        subtitle: Text('Page ${annotation.pageNumber}'),
                        onTap: () {
                          _pdfController.jumpToPage(annotation.pageNumber);
                          Navigator.pop(context);
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteAnnotation(annotation.id);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              tooltip: 'View All Notes',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
}



