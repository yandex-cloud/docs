* `All files`: To scan all files saved in the buckets.
* `DOC/TXT`: To scan `.doc`, `.docx`, and `.txt` text files.
* `XLS/CSV`: To scan `.xls`, `.xlsx`, and `.csv` spreadsheet files.
* `PPT`: To scan `.ppt` and `.pptx` presentation files.
* `PDF`: To scan `.pdf` document files.
* `HTML/XML`: To scan `.html` and `.xml` files.
* `Images`: To scan `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`, and `.svg` image files.
* `Custom filter`: To scan all files whose names do or do not match the specified patterns:

    * **File name contains**: To scan files whose names match the specified pattern.
    * **File name does not contain**: To ignore files whose names match the specified pattern.

    Specify the patterns using the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression) syntax. You can specify patterns in both fields, in which case the scan will use the `AND` logic to select files.

You can select multiple filters at the same time; the system will use the `OR` logic to apply them.