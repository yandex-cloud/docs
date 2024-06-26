В настоящий момент поддерживается запись в следующих форматах:

|Формат данных|Название в {{ yq-name }}|
|--|--|
|[CSV](https://ru.wikipedia.org/wiki/CSV)|[csv_with_names](../sources-and-sinks/formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](../sources-and-sinks/formats.md#parquet)|

В {{ yq-name }} поддерживаются следующие алгоритмы сжатия данных для записи:

|Формат сжатия|Название в {{ yq-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://ru.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|
|[Brotli](https://ru.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://ru.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://ru.wikipedia.org/wiki/XZ)|xz|

Формат файлов `parquet` поддерживает собственные внутренние алгоритмы сжатия. {{ yq-name }} позволяет записывать данные в формате `parquet` с использованием следующих алгоритмов сжатия:

|Формат сжатия|Название в {{ yq-name }}|
|--|--|
|[Snappy](https://ru.wikipedia.org/wiki/Snappy_(библиотека))| Без названия, по умолчанию |
