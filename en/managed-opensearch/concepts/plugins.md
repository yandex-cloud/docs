# {{ OS }} plugins

{{ mos-name }} has a number of [pre-installed plugins]({{ os.docs }}/install-and-configure/install-opensearch/plugins/#bundled-plugins). When creating or updating a cluster in {{ mos-short-name }}, you can also specify a list of [additional plugins](#opensearch), which will be installed in the cluster automatically.

## Additional {{ OS }} plugins {#opensearch}

All supported additional plugins are listed here:

* analysis-icu

   Adds the Lucene ICU module with extended Unicode support using the [ICU](https://icu.unicode.org/) libraries. It enables better analysis of Asian languages, Unicode normalization, Unicode-aware case folding, collation support, and transliteration.

* analysis-kuromoji

   Adds the Lucene kuromoji analysis module for Japanese.

* analysis-nori

   Adds the Lucene nori analysis module for Korean. Uses the [mecab-ko-dic](https://bitbucket.org/eunjeon/mecab-ko-dic/src/master/) dictionary.

* analysis-phonetic

   Provides lexeme filters that convert expressions to their phonetic representation using Soundex, Metaphone, and other algorithms.

* analysis-smartcn

   Adds the Lucene's Smart Chinese analysis module for Chinese or mixed Chinese-English text.

* analysis-stempel

   Adds the Lucene's Stempel analysis module for Polish.

* analysis-ukrainian

   Adds the Lucene's UkrainianMorfologikAnalyzer analysis module providing stemming for Ukrainian. Uses the [Morfologik](https://github.com/morfologik/morfologik-stemming) project.

* ingest-attachment

   Extracts file attachments in common formats (such as PPT, XLS, and PDF) using the [Apache Tika™](https://tika.apache.org/) text extraction library.

* mapper-annotated-text

   Indexes text that is a combination of free-text and special markup. Such combinations are typically used to identify items of interest such as people or organizations.

* mapper-murmur3

   Computes hashes of field values at index-time and stores them in the index.

* mapper-size

   Provides the `_size` metadata field, which indexes the size in bytes of the original `_source` field.

* repository-azure

   Adds support for [Azure Blob storage]({{ ms.docs }}/azure/storage/blobs/storage-blobs-introduction) as a repository for snapshots.

* repository-gcs

   Adds support for [Google Cloud Storage](https://cloud.google.com/storage/) as a repository for snapshots.

* repository-hdfs

   Adds support for the HDFS file system as a repository for snapshots.

* repository-s3

   Adds support for [AWS S3](https://aws.amazon.com/s3/) as a repository for snapshots.

* transport-nio

   Server/client non-blocking networking library built with Netty.

For more information, see the [{{ OS }} documentation]({{ os.docs }}/install-and-configure/install-opensearch/plugins/#additional-plugins).
