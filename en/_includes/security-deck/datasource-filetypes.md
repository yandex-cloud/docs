* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_all }}`: To scan all files saved in the buckets.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_docx_txt }}`: To scan `.doc`, `.docx`, and `.txt` text files.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_xlsx_csv }}`: To scan `.xls`, `.xlsx`, and `.csv` spreadsheet files.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_pptx }}`: To scan `.ppt` and `.pptx` presentation files.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_pdf }}`: To scan `.pdf` document files.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_html_xml }}`: To scan `.html` and `.xml` files.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_images }}`: To scan `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp`, and `.svg` image files.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_custom }}`: To scan all files whose names do or do not match the specified patterns:

    * **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_field-includeRegex }}**: To scan files whose names match the specified pattern.
    * **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_field-excludeRegex }}**: To ignore files whose names match the specified pattern.

    Specify the patterns using the [RE2](https://github.com/google/re2/wiki/Syntax) [regular expression](https://en.wikipedia.org/wiki/Regular_expression) syntax. You can specify patterns in both fields, in which case the scan will use the `AND` logic to select files.

You can select multiple filters at the same time; the system will use the `OR` logic to apply them.