* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_all }}` — чтобы при сканировании проверялись все файлы, сохраненные в бакетах.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_docx_txt }}` — чтобы при сканировании проверялись текстовые файлы с расширениями `.doc`, `.docx` и `.txt`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_xlsx_csv }}` — чтобы при сканировании проверялись табличные файлы с расширениями `.xls`, `.xlsx` и `.csv`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_pptx }}` — чтобы при сканировании проверялись файлы презентаций с расширениями `.ppt` и `.pptx`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_pdf }}` — чтобы при сканировании проверялись документы с расширением `.pdf`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_html_xml }}` — чтобы при сканировании проверялись файлы с расширениями `.html` и `.xml`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_images }}` — чтобы при сканировании проверялись изображения с расширениями `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp` и `.svg`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_custom }}` — чтобы при сканировании проверялись файлы, имена которых соответствуют или не соответствуют заданным шаблонам:

    * **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_field-includeRegex }}** — задайте шаблон, которому должны соответствовать имена файлов, проверяемые при сканировании.
    * **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_field-excludeRegex }}** — задайте шаблон, которому должны соответствовать имена файлов, игнорируемые при сканировании.

    Шаблоны задаются в форме [регулярных выражений](https://ru.wikipedia.org/wiki/Регулярные_выражения) с использованием синтаксиса [RE2](https://github.com/google/re2/wiki/Syntax). Вы можете задать шаблоны в обоих полях, в этом случае выборка файлов при сканировании будет осуществляться с логикой `И`.

Вы можете выбрать одновременно несколько фильтров, при этом фильтры будут применяться с логикой `ИЛИ`.