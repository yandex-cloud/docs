# Restrictions for the current version of text recognition

The service is currently running with a number of restrictions. Please read them before you start working:

* The recognition `confidence` value is only calculated for a `line`. The line's value is used both for words and for the recognized language.
* A single language is indicated for all recognized words, although they are recognized in all the languages from the supported [model](supported-languages.md). For example, if you specify `["en", " ar"]` and the text has mostly English words, then all the words are marked as `en`, including those in Arabic.
* The following is not recognized well:
  * Handwritten text.
  * Artistic fonts.
  * Vertical text (when a word is written from top to bottom).
  * Any set of letters and numbers, like a license plate number.
  * Forms where each character is typed in a separate cell.
  * Short words and numbers in table cells.
  * Very large text, for example, when one word takes up half of the image.

#### What's next

* [Try recognizing text in an image](../../operations/ocr/text-detection.md)
* [View the list of supported languages and models](supported-languages.md)

