# Usage Guide: Plain Text Multi-Page Book Reader

## Overview

This app now displays DOCX files as plain text split into multiple pages. Each page contains approximately 1000 characters, and users can navigate between pages using swipe gestures or navigation buttons.

## Features

### ✅ What's Included:
- **Multi-Page View**: Content is automatically split into pages (~1000 characters each)
- **Page Navigation**: Swipe left/right or use arrow buttons to navigate
- **Zoom Controls**: Zoom in/out (0.5x - 3.0x)
- **Text Selection**: Select and copy text from any page
- **Search**: Search for text across all pages
- **3D Page Flip**: Smooth animated page transitions
- **Fullscreen Mode**: Immersive reading experience

### ❌ What's Removed:
- HTML rendering and formatting
- Single scrollable page mode
- Bold, italic, underline formatting display
- Color and font size preservation

## How It Works

### 1. Document Loading
```
DOCX File → ZIP Extraction → XML Parsing → Plain Text Extraction → Page Splitting
```

The app:
1. Loads the DOCX file from `assets/documents/book.docx`
2. Extracts the ZIP archive
3. Parses `word/document.xml`
4. Extracts plain text from XML elements
5. Splits text into pages at paragraph boundaries

### 2. Page Splitting Algorithm

```dart
// Splits content into ~1000 character pages
// Respects paragraph boundaries to avoid mid-paragraph breaks
const int charsPerPage = 1000;

For each paragraph:
  If current page + paragraph > 1000 chars:
    Save current page
    Start new page with this paragraph
  Else:
    Add paragraph to current page
```

### 3. Display

Each page is displayed using a simple `Text` widget with:
- Font size: 16
- Line height: 1.6
- Color: Black87
- Selectable text enabled

## User Interface

### Toolbar (when not in fullscreen)
```
[Menu] [Search] [Zoom Out] [Zoom In] [Reset] [Reload] | book.docx | [Fullscreen]
```

### Floating Toolbar (in fullscreen mode)
```
[Zoom Out] [Zoom In] [Reset] [Exit Fullscreen] [Menu] | [◀️] [▶️]
```

### Gestures
- **Swipe Left**: Next page
- **Swipe Right**: Previous page
- **Pinch**: Zoom (via zoom buttons)
- **Tap (fullscreen)**: Toggle toolbar visibility

## Navigation

### Go to Specific Page
1. Click the Menu icon (☰)
2. Enter page number
3. Click "Go"

### Search
1. Click the Search icon (🔍)
2. Enter search term
3. Click "Search"
4. App navigates to the first page containing the term

## Code Structure

### Key Components

**State Variables:**
```dart
String _textContent = '';        // Full document text
List<String> _pages = [];        // Text split into pages
int _currentPageIndex = 0;       // Current page being viewed
double _zoomLevel = 1.0;         // Zoom level (0.5 - 3.0)
```

**Key Methods:**
```dart
_loadDocxFile()              // Load DOCX from assets
_extractDocxContent()        // Extract ZIP and parse XML
_extractPlainText()          // Convert XML to plain text
_splitIntoPages()            // Split text into pages
_buildPageView()             // Build PageView widget
```

## Customization

### Adjust Characters Per Page
Edit `_splitIntoPages()` method:
```dart
const int charsPerPage = 1000;  // Change this value
```

### Adjust Text Styling
Edit the `Text` widget in `_buildPageView()`:
```dart
Text(
  _pages[index],
  style: TextStyle(
    fontSize: 16,        // Font size
    height: 1.6,         // Line height
    color: Colors.black87,  // Text color
  ),
)
```

### Change Zoom Limits
Edit zoom methods:
```dart
void _zoomIn() {
  if (_zoomLevel < 3.0) {  // Max zoom
    _zoomLevel += 0.25;    // Zoom increment
  }
}

void _zoomOut() {
  if (_zoomLevel > 0.5) {  // Min zoom
    _zoomLevel -= 0.25;    // Zoom decrement
  }
}
```

## Testing

Run the app:
```bash
flutter run
```

Run tests:
```bash
flutter test
```

## Troubleshooting

### Document not loading
- Check that `assets/documents/book.docx` exists
- Verify `pubspec.yaml` includes the assets path
- Ensure DOCX file is not corrupted

### Pages appear empty
- DOCX might not contain text in standard `<w:p>` elements
- Check console for error messages
- Try a different DOCX file

### Text is too small/large
- Use zoom in/out buttons
- Or modify font size in code

## Example Flow

1. **App starts** → Shows "Loading DOCX document..."
2. **Document loads** → Text extracted and split into pages
3. **First page displays** → User sees page 1 with plain text
4. **User swipes left** → Animated transition to page 2
5. **User clicks Menu** → Dialog shows "Go to Page" option
6. **User enters "5"** → Navigates to page 5
7. **User clicks Search** → Searches for text across all pages
8. **User clicks Fullscreen** → Immersive reading mode

## Migration from Previous Version

### What Changed:
- Removed `flutter_widget_from_html` dependency
- Removed `flutter_inappwebview` dependency
- Removed HTML conversion logic
- Removed single-page scrollable mode
- Added multi-page splitting logic
- Simplified text rendering

### Data Format:
- **Before**: HTML string with tags
- **After**: Plain text string

### Page Count:
- **Before**: Always 1 page (single scroll)
- **After**: Multiple pages (varies by content)

## Performance

- **Memory**: Lower (no HTML rendering overhead)
- **Loading**: Faster (simpler text extraction)
- **Rendering**: Faster (native Text widget vs HTML parser)
- **Scrolling**: Smoother (PageView vs SingleChildScrollView)

## Limitations

1. No formatting preserved (bold, italic, colors)
2. No images displayed
3. No tables (rendered as plain text)
4. No hyperlinks
5. Page breaks are arbitrary (based on character count)

## Future Enhancements

Possible improvements:
- Add basic formatting (bold, italic) using TextSpan
- Display images extracted from DOCX
- Improve page splitting to respect sections
- Add bookmarks
- Add annotations
- Export to PDF with pages
