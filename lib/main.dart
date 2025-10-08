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
//   final String? title;
//   final String content;
//   final String? videoUrl;
//   final List<String> images;
//
//   BookPage({
//     this.title,
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
//   TransformationController();
//
//   int _currentPageIndex = 0;
//   bool _isFullscreen = false;
//   bool _showToolbar = true;
//   bool _highlightMode = false;
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
//       title: "Chapter 1 GLOSSARY",
//       content:
//       """1.1 DEFINITIONS OF PRINCIPAL TERMS USED IN THIS MANUAL
//
// Note.- Other definitions will be found in the appropriate /CAO documents.
// Aerodrome control service. Air traffic control service for aerodrome traffic.
// Aerodrome traffic. All traffic on the manoeuvring area of an aerodrome and all aircraft flying in the vicinity of an aerodrome.
//
// Note.- An aircraft is in the vicinity of an aerodrome when it is in, entering or leaving an aerodrome traffic circuit.
// Aerodrome traffic circuit. The specified path to be flown by aircraft operating in the vicinity of an aerodrome.
// Aeronautical mobile service (RR S1.32). A mobile service between aeronautical stations and aircraft stations, or between aircraft stations, in which survival craft stations may participate; emergency position-indicating radiobeacon stations may also participate in this service on designated distress and emergency frequencies.
// Aeronautical station (RR S1.81). A land station in the aeronautical mobile service. In certain instances, an aeronautical station may be located, for example, on board ship or on a platform at sea.
// Air-ground communication. Two-way communication between aircraft and stations or locations on the surface of the earth.
// Air traffic. All aircraft in flight or operating on the manoeuvring area of an aerodrome.
// Air traffic control clearance. Authorization for an aircraft to proceed under conditions specified by an air traffic control unit.
//
//    Note 1.- For convenience, the term "air traffic control clearance" is frequently abbreviated to "clearance" when used in appropriate contexts.
//
//    Note 2.- The abbreviated term "clearance" may be prefixed by the words "taxi", "take-off", "departure", "en route'; "approach" or "landing" to indicate the particular portion of flight to which the air traffic control clearance relates.
//
// Air traffic service (ATS). A generic term meaning variously, flight information service, alerting service, air traffic advisory service, air traffic control service (area control service, approach control service or aerodrome control service).
//
// Air traffic services unit. A generic term meaning variously, air traffic control unit, flight information centre or air traffic services reporting office.""",
//       // images: ['assets/images/download.jpg', 'assets/images/download (1).jpg'],
//     ),
//     BookPage(
//       content:
//       """Airway. A control area or portion thereof established in the form of a corridor.
// Altitude. The vertical distance of a level, a point or an object considered as a point, measured from mean sea level (MSL).
// Approach control service. Air traffic control service for arriving or departing controlled flights.
// Apron. A defined area, on a land aerodrome, intended to accommodate aircraft for purposes of loading or unloading passengers, mail or cargo, fuelling, parking or maintenance.
// Area control centre (ACC). A unit established to provide air traffic control service to controlled flights in control areas under its jurisdiction.
// Automatic terminal information service (ATIS). The automatic provision of current, routine information to arriving and departing aircraft throughout 24 hours or a specified portion thereof:
// Data link-automatic terminal information service (D-ATIS). The provision of ATIS via data link.
// Voice-automatic terminal information service (Voice-ATIS). The provision of ATIS by means of continuous and repetitive voice broadcasts.
// Blind transmission. A transmission from one station to another station in circumstances where two-way communication cannot be established but where it is believed that the called station is able to receive the transmission.
// Broadcast. A transmission of information relating to air navigation that is not addressed to a specific station or stations.
// Clearance limit. The point to which an aircraft is granted an air traffic control clearance.
// Controlled airspace. An airspace of defined dimensions within which air traffic control service is provided in accordance with the airspace classification.
//
//    Note.- Controlled airspace is a generic term which covers ATS airspace Classes A, B, C, D and E as described in Annex 11.
// Control zone. A controlled airspace extending upwards from the surface of the earth to a specified upper limit.
// Expected approach time. The time at which ATC expects that an arriving aircraft, following a delay, will leave the holding fix to complete its approach for a landing.
//
// Note.- The actual time of leaving the holding fix will depend upon the approach clearance.
// Flight information centre. A unit established to provide flight information service and alerting service.
// Flight plan. Specified information provided to air traffic services units, relative to an intended flight or portion of a flight of an aircraft.	·
//
//    Note.- Specifications for flight plans are contained in Annex 2. A Model Flight Plan Form is contained in Appendix 2 to the PANS-ATM.
// Heading. The direction in which the longitudinal axis of an aircraft is pointed, usually expressed in degrees from North (true, magnetic, compass or grid).""",
//     ),
//     BookPage(content:
//     """Holding fix. A geographical location that serves as a reference for a holding procedure.
//   Holding procedure. A predetermined manoeuvre which keeps an aircraft within a specified airspace while awaiting further clearance.
//   /FR flight. A flight conducted in accordance with the instrument flight rules.
//   Instrument meteorological conditions (IMC). Meteorological conditions expressed in terms of visibility, distance from cloud, and ceiling, less than the minima specified for visual meteorological conditions.
//   Level. A generic term relating to the vertical position of an aircraft in flight and meaning variously, height, altitude or flight level.
//   Manoeuvring area. That part of an aerodrome to be used for the take-off, landing and taxiing of aircraft, excluding aprons.
//   Missed approach procedure. The procedure to be followed if the approach cannot be continued.
//   Movement area. That part of an aerodrome to be used for the take-off, landing and taxiing of aircraft, consisting of the manoeuvring area and the apron(s).
//   Radar approach. An approach in which the final approach phase is executed under the direction of a radar controller.
//   Radar identification. The situation which exists when the radar position of a particular aircraft is seen on a radar display and positively identified by the air traffic controller.
//   Reporting point. A specified geographical location in relation to which the position of an aircraft can be reported.
//   Runway visual range (RVR). The range over which the pilot of an aircraft on the centre line of a runway can see the runway surface markings or the lights delineating the runway or identifying its centre line.
//   Touchdown. The point where the nominal glide path intercepts the runway.
//
//   Note.- ''Touchdown" as defined above is only a datum and is not necessarily the actual point at which the aircraft will touch the runway.
//
//   Track. The projection on the earth's surface of the path of an aircraft, the direction of which path at any point is usually expressed in degrees from North (true, magnetic or grid).
//   Vectoring. Provision of navigational guidance to aircraft in the form of specific headings, based on the use of radar.
//   VFR flight. A flight conducted in accordance with the visual flight rules.
//   Visual approach. An approach by an IFR flight when either part or all of an instrument approach procedure is not completed and the approach is executed in visual reference to terrain.
//   Visual meteorological conditions. Meteorological conditions expressed in terms of visibility, distance from cloud, and ceiling, equal to or better than specified minima.
//
//   Note.- The specified minima are contained in Annex 2."""),
//     BookPage(
//         title: "1.2 COMMONLY USED ABBREVIATIONS",
//         content: """ Note.- The abbreviations listed below are normally spoken using the constituent letters, rather than the spelling alphabet, except that those indicated by an asterisk are normally spoken as complete words.
//
// ACC    Area control centre or area control
// ADF    Automatic direction-finding equipment
// AFIS    Aerodrome flight information service
// AGL    Above ground level
// AIP    Aeronautical information publication
// AIRAC*    Aeronautical information regulation and control
// AIS    Aeronautical information services
// AMSL    Above mean sea level
// ATC    Air traffic control (in general)
// ATD    Actual time of departure
// ATIS*    Automatic terminal information service
// ATS    Air traffic services
// ATZ    Aerodrome traffic zone
// CAVOK*    Visibility, cloud and present weather better than prescribed values or conditions
// CTR    Control zone
// DME    Distance measuring equipment
// EET    Estimated elapsed time
// ETA    Estimated time of arrival or estimating arrival
// ETD    Estimated time of departure or estimating departure
// FIC    Flight information centre
// FIR    Flight information region
// FIS    Flight information service
// GCA    Ground controlled approach system or ground controlled approach
// H24    Continuous day and night service"""),
//     BookPage(content: """
// HF	High frequency (3 to 30 MHz)
//
// IFR	Instrument flight rules
//
// ILS	Instrument landing system
//
// IMC	Instrument meteorological conditions
//
// INS	 Inertial navigation system LORAN*	Long range air navigation system MET*	Meteorological or meteorology
// MLS	Microwave landing system
//
// MNPS	 Minimum navigation performance specifications NOB	Non-directional radio beacon
// NIL*	None or I have nothing to send you
//
// NOTAM*		A notice distributed by means of telecommunication containing information concerning the establishment, condition or change in any aeronautical facility, service, procedure or hazard, the timely knowledge of which is essential to personnel concerned with flight operations
//
// PAPI*	Precision approach path indicator
//
// QFE	 Atmospheric pressure at aerodrome elevation (or at runway threshold) QNH	 Altimeter sub-scale setting to obtain elevation when on the ground RCC	Rescue coordination centre
// RNAV*	Area navigation
//
// RVR	Runway visual range
//
// SELCAL*  A system which permits the selective calling of individual aircraft over radiotelephone channels linking a ground station with the aircraft
//
// SID*	Standard instrument departure
//
// SIGMET*  Information issued by a meteorological watch office concerning the occurrence or expected occurrence of specified en-route weather phenomena which may affect the safety of aircraft operations
//
// SNOWTAM* A special series NOTAM notifying the presence or removal of hazardous conditions due to snow, ice, slush or standing water associated with snow, slush and ice on the movement area, by means of a specific format
//
// SSR    Secondary surveillance radar"""),
//     BookPage(content: """SST STAR* TACAN* TAF* TMA UHF UIR UTA UTC VASIS* VDF VFR VHF VIP VMC
// VOLMET*
//
// VOR VORTAC*
//
// Supersonic transport Standard (instrument) arrival UHF tactical air navigation aid Aerodrome forecast
// Terminal control area
//
// Ultra-high frequency (300 to 3 000 MHz) Upper flight information region
// Upper control area Coordinated universal time
// Visual approach slope indicator system Very high frequency direction-finding station Visual flight rules
// Very high frequency (30 to 300 MHz) Very important person
// Visual meteorological conditions Meteorological information for aircraft in flight VHF omnidirectional radio range
// VOR and TAGAN combination
//
//
//
// 1.3 EXPLANATION OF SCENARIO
//
//
//    1.3.1 In order for the reader to understand the context in which specific phrases are used, most of the examples of phraseology in this manual relate to typical situations, using fictitious call signs and locations. Any similarity with actual aircraft and ground station call signs is coincidental.
//
//    1.3.2 In the examples, the aircraft or ground station transmitting is shown by the symbol in Table 1. The station initiating the exchange of messages is in bold type. To facilitate following the sequence of the messages each subsequent message commences below the previous one throughout the exchange.
//
//    1.3.3 The scenario for the phraseologies throughout this manual is based on an imaginary country using the non-SI alternative units of measurement. Users of the manual in States which have adopted the SI units of measurement should substitute the correct units as appropriate."""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(
//         title: """Chapter 2
//         GENERAL OPERATING PROCEDURES""",
//         content: """2.1 INTRODUCTION
// Radiotelephony (RTF) provides the means by which pilots and ground personnel communicate with each other. The information and instructions transmitted are of vital importance in the safe and expeditious operation of aircraft. Incidents and accidents have occurred in which a contributing factor has been the use of non-standard procedures and phraseology. The importance of using correct and precise standardized phraseology cannot be overemphasized.
//
// 2.2 TRANSMITTING TECHNIQUE
//
//     2.2.1 The following transmitting techniques will assist in ensuring that transmitted speech is clear and satisfactorily received:
//
// a) before transmitting, listen out on the frequency to be used to ensure that there will be no interference with a transmission from another station;
//
// b) be familiar with good microphone operating techniques;
//
// c) use a normal conversational tone, and speak clearly and distinctly;
//
// d) maintain an even rate of speech not exceeding 100 words per minute. When it is known that elements of the message will be written down by the recipient, speak at a slightly slower rate;
//
// e) maintain the speaking volume at a constant level;
//
// f) a slight pause before and after numbers will assist in making them easier to understand;
//
// g) avoid using hesitation sounds such as "er";
//
// h) be familiar with the microphone operating techniques, particularly in relation to the maintenance of a constant distance from the microphone if a modulator with a constant level is not used;
//
// i) suspend speech temporarily if it becomes necessary to turn the head away from the microphone;
//
// j) depress the transmit switch fully before speaking and do not release it until the message is completed. This will ensure that the entire message is transmitted;
//
// k) the transmission of long messages should be interrupted momentarily from time to time to permit the transmitting operator to confirm that the frequency in use is clear and, if necessary, to permit the receiving operator to request repetition of parts not received.
//     """),
//     BookPage(content: """
//     2-1
//
//
//     2.2.2 An irritating and potentially dangerous situation in radiotelephony is a "stuck" microphone button. Operators should always ensure that the button is released after a transmission and the microphone placed in an appropriate place ensuring that it will not inadvertently be switched on.
//
//
//
// 2.3 TRANSMISSION OF LETTERS
//
//     2.3.1 To expedite communications, the use of phonetic spelling should be dispensed with if there is no risk of this affecting correct reception and intelligibility of the message.
//
//     2.3.2 With the exception of the telephony designator and the type of aircraft, each letter in the aircraft call sign shall be spoken separately using the phonetic spelling.
//
// 2.3.3 The words in the table below shall be used when using the phonetic spelling.
//
// Note.- Syllables to be emphasized are underlined.
//
//
//                                                 Letter                        Word                        Pronunciation
//
//
//                                                 A                                  Alpha                            ALFAH
//                                                 B                                  Bravo                            BRAH VOH
//                                                 C                                  Charlie                          CHAR LEE or SHAR LEE
//                                                 D                                  Delta                             DELL TAH
//                                                 E                                  Echo                              ECK OH
//                                                 F                                  Foxtrot                          FOKS TROT
//                                                 G                                  Golf                              GOLF
//                                                 H                                  Hotel                            HO TELL
//                                                 I                                   India                             lli. DEE AH
//                                                 J                                  Juliett                          JEW LEE ETT
//                                                 K                                  Kilo                               KEY LOH
//                                                 L                                  Lima                             LEE MAH
//                                                 M                                  Mike                             MIKE
//                                                 N                                  November                         NOVEMBER
//                                                 0                                  Oscar                            OSSCAH
//                                                 p                                  Papa                             PAH PAH
//                                                 Q                                  Quebec                           KEH BECK
//                                                 R                                  Romeo                            ROW ME OH
//                                                 s                                  Sierra                           SEE AIR RAH
//                                                 T                                  Tango                            TANG GO
//                                                 u                                  Uniform                          YOU NEE FORM or 00  NEE FORM
//     """),
//     BookPage(content: """
//                                                 Letter                        Word                        Pronunciation
//
//                                                 V                                  Victor                           VIK TAH
//                                                 w                                  Whiskey                          WISS KEY
//                                                 X                                  X-ray                            ECKS RAY
//                                                 y                                  Yankee                           YANG KEY
//                                                 z                                  Zulu                             ZOO LOO
//
//
//
// """),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
//     BookPage(content: """"""),
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
//     if (_pages.length > 1 && _pages[1].videoUrl != null) {
//       _videoController = VideoPlayerController.network(_pages[1].videoUrl!)
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
//   void _toggleHighlightMode() {
//     setState(() {
//       _highlightMode = !_highlightMode;
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(_highlightMode
//             ? 'Highlight mode ON - Select text to highlight'
//             : 'Highlight mode OFF'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   void _addHighlight(String selectedText, int startIndex, int endIndex) {
//     if (!_highlightMode) return;
//
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
//                 title: Text(_pages[index].title ?? ""),
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
//           onTap: () => setState(() => _selectedHighlightColor = color),
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 4),
//             width: 30,
//             height: 30,
//             decoration: BoxDecoration(
//               color: color,
//               border: Border.all(
//                 color: _selectedHighlightColor == color
//                     ? Colors.black
//                     : Colors.grey,
//                 width: _selectedHighlightColor == color ? 2 : 1,
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//           ),
//         ),
//       )
//           .toList(),
//     );
//   }
//
//   Widget _buildToolbar() {
//     if (!_showToolbar) return SizedBox.shrink();
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenWidth = constraints.maxWidth;
//         final isSmallScreen = screenWidth < 360;
//         final toolbarHeight = isSmallScreen ? 50.0 : 60.0;
//         final iconSize = isSmallScreen ? 20.0 : 24.0;
//         final fontSize = isSmallScreen ? 10.0 : 14.0;
//
//         return Container(
//           height: toolbarHeight,
//           color: Colors.grey[200],
//           child: Row(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.menu, size: iconSize),
//                         onPressed: _showTableOfContents,
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.search, size: iconSize),
//                         onPressed: _showSearchDialog,
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.highlight,
//                           color: _highlightMode ? Colors.orange : null,
//                           size: iconSize,
//                         ),
//                         onPressed: _toggleHighlightMode,
//                         tooltip: 'Toggle Highlight Mode',
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.note_add, size: iconSize),
//                         onPressed: () {
//                           setState(() {
//                             _isAddingNote = !_isAddingNote;
//                           });
//                           if (_isAddingNote) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Tap anywhere on the page to add a sticky note'),
//                                 duration: Duration(seconds: 2),
//                               ),
//                             );
//                             _showAddNoteDialog(Offset(100, 100));
//                           }
//                         },
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.zoom_out, size: iconSize),
//                         onPressed: _zoomOut,
//                         tooltip: 'Zoom Out',
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.zoom_in, size: iconSize),
//                         onPressed: _zoomIn,
//                         tooltip: 'Zoom In',
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.refresh, size: iconSize),
//                         onPressed: _resetZoom,
//                         tooltip: 'Reset Zoom',
//                         padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//                       ),
//                       _buildHighlightColorPicker(),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 4),
//                 child: Text(
//                   '${_currentPageIndex + 1}/${_pages.length}',
//                   style: TextStyle(fontSize: fontSize),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(
//                   _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
//                   size: iconSize,
//                 ),
//                 onPressed: _toggleFullscreen,
//                 padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//               ),
//             ],
//           ),
//         );
//       },
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
//               icon: Icon(
//                 Icons.highlight,
//                 color: _highlightMode ? Colors.orange : Colors.white,
//               ),
//               onPressed: _toggleHighlightMode,
//               tooltip: 'Toggle Highlight Mode',
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
//   List<TextSpan> _buildHighlightedTextSpans(String text, int pageIndex) {
//     return _buildHighlightedTextSpansWithSize(text, pageIndex, 8.0);
//   }
//
//   List<TextSpan> _buildHighlightedTextSpansWithSize(String text, int pageIndex, double fontSize) {
//     List<TextSpan> spans = [];
//     List<Highlight> pageHighlights =
//     _highlights.where((h) => h.pageIndex == pageIndex).toList();
//
//     pageHighlights.sort((a, b) => a.startIndex.compareTo(b.startIndex));
//
//     int currentIndex = 0;
//
//     for (Highlight highlight in pageHighlights) {
//       if (currentIndex < highlight.startIndex) {
//         spans.add(TextSpan(
//           text: text.substring(currentIndex, highlight.startIndex),
//           style: TextStyle(fontSize: fontSize, height: 1.2, color: Colors.black),
//         ));
//       }
//
//       spans.add(TextSpan(
//         text: text.substring(highlight.startIndex, highlight.endIndex),
//         style: TextStyle(
//           fontSize: fontSize,
//           height: 1.2,
//           color: Colors.black,
//           backgroundColor: highlight.color.withOpacity(0.3),
//         ),
//       ));
//
//       currentIndex = highlight.endIndex;
//     }
//
//     if (currentIndex < text.length) {
//       spans.add(TextSpan(
//         text: text.substring(currentIndex),
//         style: TextStyle(fontSize: fontSize, height: 1.2, color: Colors.black),
//       ));
//     }
//
//     return spans;
//   }
//
//   Widget _buildTextPage(BookPage page, int pageIndex) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenWidth = constraints.maxWidth;
//         final screenHeight = constraints.maxHeight;
//
//         // Responsive values based on screen size
//         final isSmallScreen = screenWidth < 360;
//         final isMediumScreen = screenWidth >= 360 && screenWidth < 600;
//         final isLargeScreen = screenWidth >= 600;
//
//         final titleFontSize = isSmallScreen ? 14.0 : isMediumScreen ? 16.0 : 20.0;
//         final contentFontSize = isSmallScreen ? 6.0 : isMediumScreen ? 7.0 : 8.0;
//         final padding = isSmallScreen ? 8.0 : isMediumScreen ? 12.0 : 16.0;
//         final spacing = isSmallScreen ? 4.0 : isMediumScreen ? 6.0 : 10.0;
//         final imageHeight = isSmallScreen ? 100.0 : isMediumScreen ? 120.0 : 150.0;
//
//         return _buildZoomableContent(
//           Container(
//             padding: EdgeInsets.all(padding),
//             color: Colors.white,
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       page.title ?? "",
//                       style: TextStyle(
//                         fontSize: titleFontSize,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[800],
//                       ),
//                     ),
//                     SizedBox(height: spacing),
//                     Expanded(
//                       child: LayoutBuilder(
//                         builder: (context, contentConstraints) {
//                           return SingleChildScrollView(
//                             child: ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 minHeight: contentConstraints.maxHeight,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SelectableText.rich(
//                                     TextSpan(
//                                       children: _buildHighlightedTextSpansWithSize(
//                                           page.content, pageIndex, contentFontSize),
//                                     ),
//                                     onSelectionChanged: (selection, cause) {
//                                       if (selection.baseOffset !=
//                                           selection.extentOffset &&
//                                           _highlightMode) {
//                                         String selectedText =
//                                         page.content.substring(
//                                           selection.baseOffset,
//                                           selection.extentOffset,
//                                         );
//                                         _addHighlight(selectedText,
//                                             selection.baseOffset, selection.extentOffset);
//                                       }
//                                     },
//                                   ),
//                                   if (page.images.isNotEmpty) ...[
//                                     SizedBox(height: spacing),
//                                     ...page.images.map(
//                                           (imagePath) => Container(
//                                         margin: EdgeInsets.symmetric(vertical: spacing),
//                                         height: imageHeight,
//                                         child: Image.asset(
//                                           imagePath,
//                                           fit: BoxFit.contain,
//                                           errorBuilder:
//                                               (context, error, stackTrace) =>
//                                               Container(
//                                                 height: imageHeight,
//                                                 color: Colors.grey[300],
//                                                 child: Center(
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                     children: [
//                                                       Icon(
//                                                         Icons.image,
//                                                         size: isSmallScreen ? 30 : 40,
//                                                         color: Colors.grey,
//                                                       ),
//                                                       Text(
//                                                         'Image placeholder',
//                                                         style: TextStyle(
//                                                           fontSize: isSmallScreen ? 10 : 12,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 ..._stickyNotes
//                     .where((note) => note.pageIndex == pageIndex)
//                     .map(
//                       (note) => Positioned(
//                     left: note.position.dx,
//                     top: note.position.dy,
//                     child: _buildStickyNote(note),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildVideoPage(BookPage page, int pageIndex) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenWidth = constraints.maxWidth;
//         final screenHeight = constraints.maxHeight;
//
//         // Responsive values based on screen size
//         final isSmallScreen = screenWidth < 360;
//         final isMediumScreen = screenWidth >= 360 && screenWidth < 600;
//         final isLargeScreen = screenWidth >= 600;
//
//         final titleFontSize = isSmallScreen ? 14.0 : isMediumScreen ? 16.0 : 20.0;
//         final contentFontSize = isSmallScreen ? 6.0 : isMediumScreen ? 7.0 : 8.0;
//         final padding = isSmallScreen ? 8.0 : isMediumScreen ? 12.0 : 16.0;
//         final spacing = isSmallScreen ? 6.0 : isMediumScreen ? 8.0 : 12.0;
//         final videoHeight = isSmallScreen ? 120.0 : isMediumScreen ? 160.0 : 200.0;
//         final iconSize = isSmallScreen ? 35.0 : isMediumScreen ? 40.0 : 50.0;
//
//         return _buildZoomableContent(
//           Container(
//             padding: EdgeInsets.all(padding),
//             color: Colors.white,
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       page.title ?? "",
//                       style: TextStyle(
//                         fontSize: titleFontSize,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue[800],
//                       ),
//                     ),
//                     SizedBox(height: spacing),
//                     Container(
//                       height: videoHeight,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: _isVideoInitialized
//                           ? Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           AspectRatio(
//                             aspectRatio: _videoController.value.aspectRatio,
//                             child: VideoPlayer(_videoController),
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               _videoController.value.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: Colors.white,
//                               size: iconSize,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _videoController.value.isPlaying
//                                     ? _videoController.pause()
//                                     : _videoController.play();
//                               });
//                             },
//                           ),
//                         ],
//                       )
//                           : Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.play_circle_outline,
//                               size: iconSize + 10,
//                               color: Colors.white54,
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Video Player',
//                               style: TextStyle(
//                                 color: Colors.white54,
//                                 fontSize: isSmallScreen ? 10 : 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: spacing),
//                     Expanded(
//                       child: LayoutBuilder(
//                         builder: (context, contentConstraints) {
//                           return SingleChildScrollView(
//                             child: SelectableText.rich(
//                               TextSpan(
//                                 children: _buildHighlightedTextSpansWithSize(
//                                     page.content, pageIndex, contentFontSize),
//                               ),
//                               onSelectionChanged: (selection, cause) {
//                                 if (selection.baseOffset != selection.extentOffset &&
//                                     _highlightMode) {
//                                   String selectedText = page.content.substring(
//                                     selection.baseOffset,
//                                     selection.extentOffset,
//                                   );
//                                   _addHighlight(selectedText, selection.baseOffset,
//                                       selection.extentOffset);
//                                 }
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 ..._stickyNotes
//                     .where((note) => note.pageIndex == pageIndex)
//                     .map(
//                       (note) => Positioned(
//                     left: note.position.dx,
//                     top: note.position.dy,
//                     child: _buildStickyNote(note),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildStickyNote(StickyNote note) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Get screen width from MediaQuery
//         final screenWidth = MediaQuery.of(context).size.width;
//         final isSmallScreen = screenWidth < 360;
//         final isMediumScreen = screenWidth >= 360 && screenWidth < 600;
//
//         final noteWidth = isSmallScreen ? 120.0 : isMediumScreen ? 140.0 : 150.0;
//         final fontSize = isSmallScreen ? 10.0 : 12.0;
//         final iconSize = isSmallScreen ? 14.0 : 16.0;
//         final padding = isSmallScreen ? 6.0 : 8.0;
//
//         return Container(
//           width: noteWidth,
//           padding: EdgeInsets.all(padding),
//           decoration: BoxDecoration(
//             color: Colors.yellow[200],
//             border: Border.all(color: Colors.orange),
//             borderRadius: BorderRadius.circular(4),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.3),
//                 blurRadius: 4,
//                 offset: Offset(2, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(Icons.note, size: iconSize, color: Colors.orange[800]),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _stickyNotes.removeWhere((n) => n.id == note.id);
//                       });
//                     },
//                     child: Icon(Icons.close, size: iconSize, color: Colors.red),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4),
//               Text(
//                 note.text,
//                 style: TextStyle(fontSize: fontSize),
//                 maxLines: 4,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey,
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 if (!_isFullscreen) _buildToolbar(),
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       if (_isFullscreen) {
//                         setState(() {
//                           _showToolbar = !_showToolbar;
//                         });
//                       }
//                     },
//                     child: Center(
//                       child: PageView.builder(
//                         controller: _pageController,
//                         onPageChanged: (index) {
//                           setState(() {
//                             _currentPageIndex = index;
//                             _resetZoom();
//                           });
//                         },
//                         itemCount: _pages.length,
//                         itemBuilder: (context, index) {
//                           final page = _pages[index];
//
//                           if (page.videoUrl != null) {
//                             return _buildVideoPage(page, index);
//                           } else {
//                             return _buildTextPage(page, index);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             _buildFloatingToolbar(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:archive/archive.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:typed_data';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookReaderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BookReaderScreen extends StatefulWidget {
  @override
  _BookReaderScreenState createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  int _currentPageIndex = 0;
  bool _isFullscreen = false;
  bool _showToolbar = true;
  String _searchQuery = '';
  bool _isLoading = true;
  String? _loadedFileName;
  
  // DOCX path in assets
  final String assetDocxPath = 'assets/documents/book.docx';
  
  // Document content
  String _textContent = '';
  List<String> _pages = [];
  
  // Controllers
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  double _zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _loadDocxFile();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadDocxFile() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Load DOCX file from assets
      final ByteData data = await rootBundle.load(assetDocxPath);
      final Uint8List bytes = data.buffer.asUint8List();
      
      // Extract and convert DOCX to HTML
      await _extractDocxContent(bytes);
      
      setState(() {
        _loadedFileName = assetDocxPath.split('/').last;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document loaded successfully: $_loadedFileName'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error loading document: $e');
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading DOCX. Please check assets path.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _extractDocxContent(Uint8List bytes) async {
    try {
      // Decode the DOCX file (which is a ZIP archive)
      final archive = ZipDecoder().decodeBytes(bytes);
      
      // Extract document.xml which contains the main content
      final documentXml = archive.findFile('word/document.xml');
      if (documentXml == null) {
        throw Exception('document.xml not found in DOCX file');
      }
      
      final documentContent = utf8.decode(documentXml.content as List<int>);
      final document = xml.XmlDocument.parse(documentContent);
      
      // Extract plain text from XML
      _textContent = _extractPlainText(document);
      
      // Split content into pages (approximately 1000 characters per page)
      _pages = _splitIntoPages(_textContent);
      
    } catch (e) {
      print('Error extracting DOCX content: $e');
      _textContent = 'Error loading document content';
      _pages = [_textContent];
    }
  }

  String _extractPlainText(xml.XmlDocument document) {
    StringBuffer text = StringBuffer();
    
    // Find all paragraphs in the document
    final paragraphs = document.findAllElements('w:p');
    
    for (var paragraph in paragraphs) {
      // Find all text runs in the paragraph
      final runs = paragraph.findAllElements('w:r');
      
      for (var run in runs) {
        // Get text content
        final textElements = run.findAllElements('w:t');
        for (var textElement in textElements) {
          text.write(textElement.innerText);
        }
      }
      
      // Add newline after each paragraph
      text.write('\n\n');
    }
    
    return text.toString().trim();
  }

  List<String> _splitIntoPages(String text) {
    // Split content into pages of approximately 1000 characters each
    List<String> pages = [];
    const int charsPerPage = 1000;
    
    if (text.isEmpty) {
      return ['No content available'];
    }
    
    // Split by paragraphs first to avoid breaking in the middle of a paragraph
    List<String> paragraphs = text.split('\n\n');
    StringBuffer currentPage = StringBuffer();
    int currentLength = 0;
    
    for (var paragraph in paragraphs) {
      // If adding this paragraph would exceed the page limit and we already have content
      if (currentLength + paragraph.length > charsPerPage && currentLength > 0) {
        pages.add(currentPage.toString().trim());
        currentPage.clear();
        currentLength = 0;
      }
      
      currentPage.write(paragraph);
      currentPage.write('\n\n');
      currentLength += paragraph.length + 2;
    }
    
    // Add the last page if there's any content
    if (currentPage.isNotEmpty) {
      pages.add(currentPage.toString().trim());
    }
    
    return pages.isEmpty ? ['No content available'] : pages;
  }



  // Zoom functions
  void _resetZoom() {
    setState(() {
      _zoomLevel = 1.0;
    });
  }

  void _zoomIn() {
    setState(() {
      if (_zoomLevel < 3.0) {
        _zoomLevel += 0.25;
      }
    });
  }

  void _zoomOut() {
    setState(() {
      if (_zoomLevel > 0.5) {
        _zoomLevel -= 0.25;
      }
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });

    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.animateToPage(
        _currentPageIndex - 1,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPageIndex + 1,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }





  void _showTableOfContents() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Go to Page'),
        content: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter page number to navigate:'),
              SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Page number',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  int? pageNum = int.tryParse(value);
                  if (pageNum != null && pageNum > 0 && pageNum <= _pages.length) {
                    Navigator.pop(context);
                    _pageController.animateToPage(
                      pageNum - 1,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOutCubic,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search'),
        content: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Enter search term...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performSearch();
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    if (_searchQuery.isEmpty) return;

    // Simple search in text content
    String searchLower = _searchQuery.toLowerCase();
    bool found = false;
    
    for (int i = 0; i < _pages.length; i++) {
      if (_pages[i].toLowerCase().contains(searchLower)) {
        _pageController.animateToPage(
          i,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        found = true;
        break;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(found 
          ? 'Found "$_searchQuery"' 
          : 'No results for "$_searchQuery"'),
        duration: Duration(seconds: 2),
        backgroundColor: found ? Colors.green : Colors.orange,
      ),
    );
  }



  Widget _buildToolbar() {
    if (!_showToolbar) return SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < 360;
        final toolbarHeight = isSmallScreen ? 50.0 : 60.0;
        final iconSize = isSmallScreen ? 20.0 : 24.0;
        final fontSize = isSmallScreen ? 10.0 : 14.0;

        return Container(
          height: toolbarHeight,
          color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu, size: iconSize),
                        onPressed: _showTableOfContents,
                        tooltip: 'Table of Contents',
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, size: iconSize),
                        onPressed: _showSearchDialog,
                        tooltip: 'Search',
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      ),

                      IconButton(
                        icon: Icon(Icons.zoom_out, size: iconSize),
                        onPressed: _zoomOut,
                        tooltip: 'Zoom Out',
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      ),
                      IconButton(
                        icon: Icon(Icons.zoom_in, size: iconSize),
                        onPressed: _zoomIn,
                        tooltip: 'Zoom In',
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, size: iconSize),
                        onPressed: _resetZoom,
                        tooltip: 'Reset Zoom',
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh_outlined, size: iconSize),
                        onPressed: _loadDocxFile,
                        tooltip: 'Reload Document',
                        padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                      ),
                      if (_pages.length > 1) ...[
                        VerticalDivider(width: 1, thickness: 1),
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: iconSize),
                          onPressed: _currentPageIndex > 0 ? _goToPreviousPage : null,
                          tooltip: 'Previous Page',
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: iconSize),
                          onPressed: _currentPageIndex < _pages.length - 1 ? _goToNextPage : null,
                          tooltip: 'Next Page',
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (_loadedFileName != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    _loadedFileName!.length > 12
                        ? '${_loadedFileName!.substring(0, 12)}...'
                        : _loadedFileName!,
                    style: TextStyle(fontSize: fontSize - 2),
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  _pages.isNotEmpty
                      ? _pages.length > 1 
                        ? '${_currentPageIndex + 1}/${_pages.length}'
                        : 'Zoom: ${(_zoomLevel * 100).toInt()}%'
                      : 'Loading...',
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(
                  _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  size: iconSize,
                ),
                onPressed: _toggleFullscreen,
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingToolbar() {
    if (!_isFullscreen || !_showToolbar) return SizedBox.shrink();

    return Positioned(
      top: 50,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.zoom_out, color: Colors.white),
              onPressed: _zoomOut,
              tooltip: 'Zoom Out',
            ),
            IconButton(
              icon: Icon(Icons.zoom_in, color: Colors.white),
              onPressed: _zoomIn,
              tooltip: 'Zoom In',
            ),
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: _resetZoom,
              tooltip: 'Reset Zoom',
            ),
            IconButton(
              icon: Icon(Icons.fullscreen_exit, color: Colors.white),
              onPressed: _toggleFullscreen,
              tooltip: 'Exit Fullscreen',
            ),
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: _showTableOfContents,
              tooltip: 'Table of Contents',
            ),
            Container(
              width: 1,
              height: 40,
              color: Colors.white.withOpacity(0.3),
              margin: EdgeInsets.symmetric(horizontal: 4),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: _currentPageIndex > 0 ? _goToPreviousPage : null,
              tooltip: 'Previous Page',
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              onPressed: _currentPageIndex < _pages.length - 1 ? _goToNextPage : null,
              tooltip: 'Next Page',
            ),
          ],
        ),
      ),
    );
  }







  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Column(
              children: [
                if (!_isFullscreen) _buildToolbar(),
                Expanded(
                  child: _isLoading
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Loading DOCX document...'),
                      ],
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      if (_isFullscreen) {
                        setState(() {
                          _showToolbar = !_showToolbar;
                        });
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      child: _pages.isEmpty
                          ? Center(
                        child: Text('No content to display'),
                      )
                          : _buildPageView(),
                    ),
                  ),
                ),
              ],
            ),
            _buildFloatingToolbar(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 0.0;
            if (_pageController.position.haveDimensions) {
              value = (_pageController.page ?? 0.0) - index;
              value = (value * 0.5).clamp(-1, 1);
            }
            
            // Create 3D page flip effect
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(value * 3.14159 / 6), // rotate around Y-axis
              alignment: value > 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: Transform.scale(
                scale: _zoomLevel,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: SelectableRegion(
                      focusNode: FocusNode(),
                      selectionControls: MaterialTextSelectionControls(),
                      child: Text(
                        _pages[index],
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}