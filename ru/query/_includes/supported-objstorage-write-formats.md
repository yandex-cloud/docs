В настоящий момент поддерживается запись в следующих форматах:

|Формат данных|Название в {{ yq-short-name }}|
|--|--|
|[CSV](https://en.wikipedia.org/wiki/Comma-separated_values)|[csv_with_names](../sources-and-sinks/formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](../sources-and-sinks/formats.md#parquet)|

В {{yq-full-name}} поддерживаются следующие алгоритмы сжатия данных для записи:

|Формат сжатия|Название в {{ yq-short-name }}|
|--|--|
|[Gzip](https://ru.wikipedia.org/wiki/Gzip)|gzip|
|[LZ4](https://ru.wikipedia.org/wiki/LZ4)|lz4|

Формат файлов parquet поддерживает собственные внутренние алгоритмы сжатия. {{yq-full-name}} позволяет записывать данные в формате parquet с использованием следующих алгоритмов сжатия:

|Формат сжатия|Название в {{ yq-short-name }}|
|--|--|
|[Snappy](https://en.wikipedia.org/wiki/Snappy_(compression))|<Без названия, по умолчанию>|