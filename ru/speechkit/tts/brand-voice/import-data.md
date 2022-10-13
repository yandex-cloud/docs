# Загрузка данных для {{ brand-voice-name }}

Технология {{ brand-voice-name }} позволяет создавать уникальные голоса для модели синтеза речи. Для обучения и последующей проверки модели необходимы аудиозаписи голоса диктора и расшифровки записанных фраз. Подробнее см. [{#T}](income-data-format.md).

Проверка и загрузка входных данных выполняется с помощью проекта [{{ ml-platform-full-name }}](../../../datasphere-old/):

1. [Создайте](../../../resource-manager/operations/folder/create.md) в своем облаке каталог, в котором вы будете хранить данные для обучения модели. В одном каталоге может быть только одна модель. 
   
1. В этом каталоге [создайте проект](../../../datasphere-old/operations/projects/create.md) {{ ml-platform-name }}.
   
1. Перейдите на вкладку **File Browser** ![File Browser](../../../_assets/datasphere/jupyterlab/folder.svg).

1. Загрузите в проект ZIP-архив с аудиофайлами и таблицу в формате [TSV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TSV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Tab-separated_values){% endif %} с текстовыми расшифровками аудиозаписей, перетащив файлы на вкладку **File Browser** ![File Browser](../../../_assets/datasphere/jupyterlab/folder.svg).
   
   Если вы записывали данные в течение нескольких дней, разбейте их на несколько архивов. Имя каждого архива должно соответствовать дате записи, например `12.12.2021.zip`. Если архив с аудиозаписями одного дня больше 2 ГБ, разделите данные и таблицу с расшифровками на несколько частей, сохранив дату в названии каждого архива, например `12.12.2021-1.zip` и `12.12.2021-2.zip`

1. Создайте новый ноутбук. Дождитесь загрузки архива и таблицы с расшифровками в проект. Запустите код в ячейке ноутбука.

   ```bash
   #!nirvana
   upload_tts_audio --dataset-name <дата записи> \
                    --audio-archive <имя архива>.zip \
                    --texts <имя файла с текстами>.tsv \ 
                    --report-path <имя файла с детализацией ошибок>.tsv \ 
                    --summary-path <имя файла с результатами>.txt \
                    --language ru
   ```
   
1. После выполнения ячейки результаты проверки данных будут записаны в файлы, указанные в параметрах `--summary-path` и `--report-path`.
   * Если исходные данные прошли проверку успешно, в файле результатов будет указано количество успешно загруженных файлов и доля ошибок `Errors rate 0.0`.
   * Если в исходных данных обнаружены ошибки, в файле результатов появится доля ошибок `Errors rate`, количество проблем и количество записей, успешно прошедших проверку. Подробное описание возникших проблем будет записано в файл детализации ошибок. Исправьте найденные ошибки, повторно загрузите данные и запустите ячейку с кодом еще раз.
   
1. Если вы разбиваете исходные данные на несколько архивов, давайте каждому файлу уникальное имя. Для каждой порции данных нужно будет отдельно запустить ячейку с кодом. При повторном запуске кода с теми же параметрами предыдущие результаты перезаписываются.

1. Чтобы проверить загруженные данные, выполните ячейку с кодом: 

   ```bash
   #!nirvana
   tts_dataset_list --list-path <имя файла с результатами>.json
   ```

1. Чтобы удалить лишние данные, выполните ячейку с кодом:

   ```python
   #!nirvana
   delete_tts_audio --dataset-name <дата записи>
   ```