Currently, the following data write formats are supported:

|Data format|Name in {{ yq-name }}|
|--|--|
|[CSV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/CSV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Comma-separated_values){% endif %}|[csv_with_names](../sources-and-sinks/formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](../sources-and-sinks/formats.md#parquet)|

{{ yq-name }} supports the following compression algorithms for data writes:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Gzip]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Gzip){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Gzip){% endif %}|gzip|
|[LZ4]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/LZ4){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/LZ4_(compression_algorithm)){% endif %}|lz4|

`Parquet` file format supports its own internal compression algorithms. {{ yq-name }} allows writing data in `parquet` format using the following compression algorithms:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Snappy]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Snappy_(библиотека)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Snappy_(compression)){% endif %}|<No name, by default>|