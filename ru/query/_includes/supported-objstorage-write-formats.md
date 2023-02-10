В настоящий момент поддерживается запись в следующих форматах:

|Формат данных|Название в {{ yq-name }}|
|--|--|
|[CSV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/CSV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Comma-separated_values){% endif %}|[csv_with_names](../sources-and-sinks/formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](../sources-and-sinks/formats.md#parquet)|

В {{ yq-name }} поддерживаются следующие алгоритмы сжатия данных для записи:

|Формат сжатия|Название в {{ yq-name }}|
|--|--|
|[Gzip]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Gzip){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Gzip){% endif %}|gzip|
|[LZ4]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/LZ4){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)){% endif %}|lz4|

Формат файлов `parquet` поддерживает собственные внутренние алгоритмы сжатия. {{ yq-name }} позволяет записывать данные в формате `parquet` с использованием следующих алгоритмов сжатия:

|Формат сжатия|Название в {{ yq-name }}|
|--|--|
|[Snappy]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Snappy_(библиотека)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Snappy_(compression)){% endif %}|<Без названия, по умолчанию>|