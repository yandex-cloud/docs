Currently, the following data write formats are supported:

|Data format|Name in {{ yq-name }}|
|--|--|
|[CSV](https://en.wikipedia.org/wiki/Comma-separated_values)|[csv_with_names](../sources-and-sinks/formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](../sources-and-sinks/formats.md#parquet)|

{{ yq-name }} supports the following compression algorithms for data writes:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Gzip](https://en.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://en.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm))|lz4|
|[Brotli](https://en.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://en.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://en.wikipedia.org/wiki/Lempel–Ziv–Markov_chain_algorithm#xz_and_7z_formats)|xz|

`Parquet` file format supports its own internal compression algorithms. {{ yq-name }} allows writing data in `parquet` format using the following compression algorithms:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Snappy](https://en.wikipedia.org/wiki/Snappy_(compression))| No name, by default |