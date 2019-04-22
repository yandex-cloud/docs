# Restrictions for the current version of text recognition

The service is currently running with a number of restrictions. Please read them before you start working:

* The recognition `confidence` value is only calculated for a `line`. The line's value is used both for words and for the recognized language.
* A single language is indicated for all recognized words, although they are recognized in all the languages from the supported [model](supported-languages.md). For example, if you specify `["en", " ar"]` and the text has mostly English words, then all the words are marked as `en`, including those in Arabic.
* For good recognition quality, text shouldn't be too slanted. Ideally, the angle should be less than 10-15 degrees.
* The following is not recognized well:
  * Handwritten text.
  * Artistic fonts.
  * Vertical text (when a word is written from top to bottom).
  * Very large text, for example, when one word takes up half of the image.

#### What's next

* [Try out text recognition with an image](../../operations/ocr/text-detection.md)
* [View the list of supported languages and models](supported-languages.md)

