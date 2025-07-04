* `Все файлы` — чтобы при сканировании проверялись все файлы, сохраненные в бакетах.
* `DOC/TXT` — чтобы при сканировании проверялись текстовые файлы с расширениями `.doc`, `.docx` и `.txt`.
* `XLS/CSV` — чтобы при сканировании проверялись табличные файлы с расширениями `.xls`, `.xlsx` и `.csv`.
* `PPT` — чтобы при сканировании проверялись файлы презентаций с расширениями `.ppt` и `.pptx`.
* `PDF` — чтобы при сканировании проверялись документы с расширением `.pdf`.
* `HTML/XML` — чтобы при сканировании проверялись файлы с расширениями `.html` и `.xml`.
* `Изображения` — чтобы при сканировании проверялись изображения с расширениями `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp` и `.svg`.
* `Свой фильтр` — чтобы при сканировании проверялись файлы, имена которых соответствуют или не соответствуют заданным шаблонам:

    * **Имя файла содержит** — задайте шаблон, которому должны соответствовать имена файлов, проверяемые при сканировании.
    * **Имя файла не содержит** — задайте шаблон, которому должны соответствовать имена файлов, игнорируемые при сканировании.

    Шаблоны задаются в форме [регулярных выражений](https://ru.wikipedia.org/wiki/Регулярные_выражения) с использованием синтаксиса [RE2](https://github.com/google/re2/wiki/Syntax). Вы можете задать шаблоны в обоих полях, в этом случае выборка файлов при сканировании будет осуществляться с логикой `И`.

Вы можете выбрать одновременно несколько фильтров, при этом фильтры будут применяться с логикой `ИЛИ`.