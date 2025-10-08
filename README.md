# Book Reader

A Flutter-based DOCX book reader application with advanced viewing features and proper formatting preservation.

## Features

✨ **Core Features:**
- 📄 **DOCX document viewing** with proper formatting preservation
- 🎨 **Full formatting support**: Bold, italic, underline, colors, font sizes
- 🖼️ **Images**: Embedded images from DOCX files are extracted and displayed
- 🔍 **Full-text search** within documents
- 🔎 **Zoom controls** (zoom in, zoom out, reset) - 0.5x to 3.0x
- 📱 **Responsive design** for different screen sizes
- 🖥️ **Fullscreen mode**
- ✅ **Text selection support** - select and copy text from documents
- 📑 **Scrollable content** - smooth reading experience

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
- **Menu Icon**: Navigate or view document info
- **Search Icon**: Search for text in the document
- **Zoom +/-**: Increase/decrease zoom level (0.5x - 3.0x)
- **Reset**: Reset zoom to default (1.0x)
- **Fullscreen**: Toggle fullscreen mode
- **Reload**: Reload the document

## How It Works

### DOCX Processing Pipeline
1. **Load DOCX**: Read DOCX file as ZIP archive from assets
2. **Extract Content**: Parse `word/document.xml` for text and formatting
3. **Extract Images**: Extract images from `word/media/` folder
4. **Convert to HTML**: Transform XML structure to HTML with CSS styling
5. **Render**: Display HTML with `flutter_widget_from_html` package

### Formatting Preserved
- ✅ **Text Styles**: Bold, italic, underline
- ✅ **Colors**: Text colors (RGB/Hex)
- ✅ **Font Sizes**: Customized font sizes
- ✅ **Paragraphs**: Proper paragraph spacing
- ✅ **Structure**: Document hierarchy maintained

## Dependencies

- `flutter_widget_from_html`: HTML rendering with CSS support
- `archive`: ZIP file handling for DOCX extraction
- `xml`: XML parsing for document.xml
- `flutter_inappwebview`: WebView support
- `path_provider`: File system access
- `flutter_colorpicker`: Color selection UI
- `shared_preferences`: Local data persistence

## Project Structure

```
lib/
├── main.dart           # Main application file with DOCX viewer
assets/
├── documents/
│   └── book.docx      # Default DOCX document
├── images/            # Image assets
└── book1.pdf          # Legacy PDF file (not used)
```

## Technical Details

### DOCX Format
DOCX files are ZIP archives containing:
- `word/document.xml`: Main document content
- `word/media/`: Embedded images
- `word/styles.xml`: Styling information
- `word/_rels/`: Relationship mappings

### HTML Conversion
The app converts DOCX XML to HTML:
- Paragraphs (`<w:p>`) → `<p>` tags
- Text runs (`<w:r>`) → Styled `<span>` tags
- Formatting properties (`<w:rPr>`) → CSS styles
- Bold (`<w:b>`) → `<strong>`
- Italic (`<w:i>`) → `<em>`
- Underline (`<w:u>`) → `<u>`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT License.
