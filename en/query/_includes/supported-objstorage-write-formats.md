The service currently supports the following formats for writing data:

|Data format|Name in {{ yq-name }}|
|--|--|
|[CSV](https://en.wikipedia.org/wiki/Comma-separated_values)|[csv_with_names](../sources-and-sinks/formats.md#csv_with_names)|
|[Parquet](https://en.wikipedia.org/wiki/Apache_Parquet)|[parquet](../sources-and-sinks/formats.md#parquet)|

{{ yq-name }} supports the following compression algorithms for writing data:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Gzip](https://en.wikipedia.org/wiki/Gzip)|gzip|
|[Zstd](https://en.wikipedia.org/wiki/Zstandard)|zstd|
|[LZ4](https://en.wikipedia.org/wiki/LZ4_(compression_algorithm))|lz4|
|[Brotli](https://en.wikipedia.org/wiki/Brotli)|brotli|
|[Bzip2](https://en.wikipedia.org/wiki/Bzip2)|bzip2|
|[Xz](https://en.wikipedia.org/wiki/Lempel–Ziv–Markov_chain_algorithm#xz_and_7z_formats)|xz|

While the `parquet` format supports built-in compression algorithms, {{ yq-name }} also enables you to write `parquet` data using these:

|Compression format|Name in {{ yq-name }}|
|--|--|
|[Snappy](https://en.wikipedia.org/wiki/Snappy_(compression))| None (used by default) |