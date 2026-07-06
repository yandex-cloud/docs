# Vision

## OCR

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.result.**OCRResult**{#yandex_ai_studio_sdk._vision.ocr.result.OCRResult}

Recognition result containing all recognized pages.

**pages**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[TextAnnotation](#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation)*]... ,{#yandex_ai_studio_sdk._vision.ocr.result.OCRResult.pages}

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._vision.ocr.result.OCRResult.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._vision.ocr.result.OCRResult.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**PageContext**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.PageContext}

Context carrying the page number for a single-page recognition response.

**page**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.PageContext.page}

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**TextAnnotation**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation}

Full text recognition result for a single page.

**page**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.page}

Page number (0-indexed) in a multi-page document (e.g. PDF). Always 0 for images.

**width**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.width}

Page width in pixels.

**height**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.height}

Page height in pixels.

**rotate**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.rotate}

Page rotation angle in degrees (0, 90, 180, 270).

**full\_text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.full_text}

Full recognized text of the page.

**markdown**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.markdown}

Full text in Markdown format (available for **markdown** and **math-markdown** models).

**blocks**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Block](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.blocks}

Recognized text blocks.

**entities**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Entity](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Entity)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.entities}

Recognized named entities.

**tables**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Table](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.tables}

Recognized tables.

**pictures**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Picture](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Picture)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TextAnnotation.pictures}

Detected pictures.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**EntitiesContext**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.EntitiesContext}

Context carrying recognized entities for entity-index resolution.

**entities**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Entity](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Entity)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.EntitiesContext.entities}

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Vertex**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex}

A point on the image in pixels.

**x**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex.x}

Alias for field number 0

**y**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex.y}

Alias for field number 1

*static* **\_\_new\_\_**(*\_cls*, *x*, *y*){#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex.__new__i}

Create new instance of Vertex(x, y)

#|
|| Parameters | 

- **x** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **y** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**count**(*value*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex.count}

Return number of occurrences of value.

**index**(*value*, *start=0*, *stop=9223372036854775807*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex.index}

Return first index of value.

Raises ValueError if the value is not present.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Entity**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Entity}

A named entity recognized in the text.

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Entity.name}

Entity type name (e.g. **"name"**, **"date"**).

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Entity.text}

Recognized entity text.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Word**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Word}

A single recognized word.

**bounding\_box**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Vertex](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Word.bounding_box}

Bounding polygon of the word as an ordered tuple of vertices.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Word.text}

Recognized word text.

**entity**\: *[Entity](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Entity) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Word.entity}

Named entity this word belongs to, or **None**.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Line**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line}

A line of recognized text. Iterates over its words.

**bounding\_box**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Vertex](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line.bounding_box}

Bounding polygon of the line as an ordered tuple of vertices.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line.text}

Recognized text of the line.

**words**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Word](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Word)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line.words}

Words in this line.

**orientation**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line.orientation}

Rotation angle of the line in degrees (0, 90, 180, 270).

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Block**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block}

A block of recognized text. Iterates over its lines.

**bounding\_box**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Vertex](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.bounding_box}

Bounding polygon of the block as an ordered tuple of vertices.

**lines**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Line](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Line)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.lines}

Lines in this block.

**languages**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.languages}

Languages detected in this block.

**layout\_type**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.layout_type}

Layout type of this block as a lowercase string (e.g. **'text'**, **'header'**).

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.text}

Full text of the block as a concatenation of its lines.

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Block.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**TableCell**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell}

A cell in a recognized table.

**bounding\_box**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Vertex](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell.bounding_box}

Bounding polygon of the cell as an ordered tuple of vertices.

**row\_index**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell.row_index}

Row index (0-based).

**column\_index**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell.column_index}

Column index (0-based).

**column\_span**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell.column_span}

Number of columns this cell spans.

**row\_span**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell.row_span}

Number of rows this cell spans.

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell.text}

Text content of the cell.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Table**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table}

A recognized table. Iterates over its cells.

**bounding\_box**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Vertex](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table.bounding_box}

Bounding polygon of the table as an ordered tuple of vertices.

**row\_count**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table.row_count}

Number of rows.

**column\_count**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table.column_count}

Number of columns.

**cells**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[TableCell](#yandex_ai_studio_sdk._vision.ocr.text_annotation.TableCell)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table.cells}

Table cells.

**count**(*value*) → integer -- return number of occurrences of value{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table.count}

**index**(*value*[, *start*[, *stop*]]) → integer -- return first index of value.{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Table.index}

Raises ValueError if the value is not present.

Supporting start and stop arguments is optional, but recommended.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.text\_annotation.**Picture**{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Picture}

A picture location detected in the document.

**bounding\_box**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[Vertex](#yandex_ai_studio_sdk._vision.ocr.text_annotation.Vertex)*]... ,{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Picture.bounding_box}

Bounding polygon of the picture as an ordered tuple of vertices.

**score**\: *[float](https://docs.python.org/3/library/functions.html#float)*{#yandex_ai_studio_sdk._vision.ocr.text_annotation.Picture.score}

Confidence score of the detection.

### *class* yandex\_ai\_studio\_sdk.\_vision.ocr.config.**OCRConfig**{#yandex_ai_studio_sdk._vision.ocr.config.OCRConfig}

Object to hold OCR run configuration.

**language\_codes**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[str](https://docs.python.org/3/library/stdtypes.html#str), ...] | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._vision.ocr.config.OCRConfig.language_codes}

List of languages to recognize text, in ISO 639-1 format (e.g. **"ru"**, **"en"**). See [supported languages](https://aistudio.yandex.ru/docs/vision/concepts/ocr/supported-languages.html).

**model**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)* = *None*{#yandex_ai_studio_sdk._vision.ocr.config.OCRConfig.model}

Model to use for text recognition.

General recognition models:

- **"page"** (default): Single-column text, any number of lines.
- **"page-column-sort"**\: Multi-column text.
- **"handwritten"**\: Combination of typed and handwritten text (Russian and English only).
- **"table"**\: Tables (Russian and English only).
- **"markdown"**\: Returns results in Markdown format.
- **"math-markdown"**\: Math formulas; results include LaTeX-formatted expressions.

Document template recognition models:

- **"passport"**\: Main passport spread.
- **"driver-license-front"**\: Driver’s license, front side.
- **"driver-license-back"**\: Driver’s license, back side.
- **"vehicle-registration-front"**\: Vehicle registration certificate, front side.
- **"vehicle-registration-back"**\: Vehicle registration certificate, back side.
- **"license-plates"**\: All license plates visible in the image.

See [models](https://aistudio.yandex.ru/docs/vision/concepts/ocr/#models) and [document recognition](https://aistudio.yandex.ru/docs/vision/concepts/ocr/template-recognition) for more details.