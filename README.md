# Book Reader

A Flutter-based DOCX book reader application with multi-page viewing and text navigation.

## Features

✨ **Core Features:**
- 📄 **DOCX document viewing** as plain text
- 📖 **Multi-page view**: Content split into pages (~1000 characters per page)
- 👉 **Page navigation**: Swipe left/right or use arrow buttons
- 🎬 **3D page flip animation**: Smooth page transitions with perspective effects
- 🔍 **Full-text search** within documents
- 🔎 **Zoom controls** (zoom in, zoom out, reset) - 0.5x to 3.0x
- 📱 **Responsive design** for different screen sizes
- 🖥️ **Fullscreen mode** with floating toolbar
- ✅ **Text selection support** - select and copy text from documents
- 🔢 **Go to page**: Jump to specific page numbers

## Getting Started

### Prerequisites
- Flutter SDK (3.8.0 or higher)
- Dart SDK

### Installation

1. Clone the repository:
```bash
git clone https://github.com/CreateInfotech2024/bookreader.git
cd bookreader
```

2. Install dependencies:
```bash
flutter pub get
```

3. Place your DOCX file in the assets folder:
   - Default path: `assets/documents/book.docx`
   - To use a different file, update `assetDocxPath` in `lib/main.dart`

4. Run the app:
```bash
flutter run
```

## Usage

### Adding Your Own DOCX Document
1. Place your DOCX file in the `assets/documents/` directory
2. Update the path in `lib/main.dart`:
```dart
final String assetDocxPath = 'assets/documents/your-book.docx';
```
3. Ensure the asset folder is listed in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/documents/
```

### Controls
- **Menu Icon**: Go to specific page number
- **Search Icon**: Search for text across all pages
- **Zoom +/-**: Increase/decrease zoom level (0.5x - 3.0x)
- **Reset**: Reset zoom to default (1.0x)
- **Fullscreen**: Toggle fullscreen mode with floating toolbar
- **Reload**: Reload the document
- **◀️ ▶️**: Navigate to previous/next page
- **Swipe**: Swipe left for next page, right for previous page

## How It Works

### DOCX Processing Pipeline
1. **Load DOCX**: Read DOCX file as ZIP archive from assets
2. **Extract Content**: Parse `word/document.xml` for text content
3. **Extract Plain Text**: Get text from XML without formatting tags
4. **Split into Pages**: Divide text into ~1000 character pages at paragraph boundaries
5. **Render**: Display pages with native Flutter `Text` widget in `PageView`

### Display Features
- ✅ **Plain Text**: Clean text display without HTML rendering
- ✅ **Multi-Page**: Automatic page splitting at paragraph boundaries
- ✅ **Page Navigation**: Smooth swipe or button navigation between pages
- ✅ **Text Selection**: Native text selection and copy support
- ✅ **3D Animation**: Page flip animation with perspective transforms
- ✅ **Search**: Find text across all pages with automatic navigation

## Dependencies

- `archive`: ZIP file handling for DOCX extraction
- `xml`: XML parsing for document.xml
- `path_provider`: File system access
- `flutter_colorpicker`: Color selection UI (for future features)
- `shared_preferences`: Local data persistence

## Project Structure

```
lib/
├── main.dart                      # Main application file with DOCX viewer
assets/
├── documents/
│   └── book.docx                  # Default DOCX document
└── images/                        # Image assets
docs/
├── USAGE_GUIDE.md                 # Complete usage guide
├── REMOVE_HTML_WIDGET_CHANGES.md  # Summary of recent changes
└── BEFORE_AFTER_COMPARISON.md     # Architecture comparison
```

## Documentation

For more detailed information, see:
- **[USAGE_GUIDE.md](USAGE_GUIDE.md)**: Complete guide on using the app, customization, and troubleshooting
- **[REMOVE_HTML_WIDGET_CHANGES.md](REMOVE_HTML_WIDGET_CHANGES.md)**: Summary of changes from HTML to plain text rendering
- **[BEFORE_AFTER_COMPARISON.md](BEFORE_AFTER_COMPARISON.md)**: Technical comparison of old vs new architecture

## Technical Details

### DOCX Format
DOCX files are ZIP archives containing:
- `word/document.xml`: Main document content (text extracted from here)
- `word/media/`: Embedded images (not currently displayed)
- `word/styles.xml`: Styling information (not currently used)
- `word/_rels/`: Relationship mappings

### Plain Text Extraction
The app extracts plain text from DOCX XML:
- Paragraphs (`<w:p>`) → Extract text + add `\n\n`
- Text runs (`<w:r>`) → Extract inner text
- Text elements (`<w:t>`) → Get text content
- Formatting tags are ignored (simplified display)

### Page Splitting Algorithm
Content is split into pages intelligently:
- Target: ~1000 characters per page
- Respects paragraph boundaries (no mid-paragraph breaks)
- Creates array of text pages for PageView
- Each page is independently scrollable and zoomable

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT License.
