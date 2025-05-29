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

    Provides the `_size` metadata field, which indexes the size (in bytes) of the original `_source` field.

* repository-azure

    Adds support for [Azure Blob Storage]({{ ms.docs }}/azure/storage/blobs/storage-blobs-introduction) as a repository for snapshots.

* repository-gcs

    Adds support for [Google Cloud Storage](https://cloud.google.com/storage/) as a repository for snapshots.

* repository-hdfs

    Adds support for the HDFS file system as a repository for snapshots.

* repository-s3

    Adds support for [AWS S3](https://aws.amazon.com/s3/) as a repository for snapshots.

* transport-nio

    Server/client non-blocking networking library built with Netty.

* yandex-lemmer

    Adds the [yandex-lemmer](#yandex-lemmer) filter that improves text search in Russian across {{ OS }} documents.

For more information, see the relevant [{{ OS }}]({{ os.docs }}/install-and-configure/install-opensearch/plugins/#additional-plugins) documentation.

### Why use the yandex-lemmer plugin {#yandex-lemmer}

The `yandex-lemmer` filter analyzes a search query in Russian in more detail and makes search more effective. Without this filter, you may get irrelevant results in the following cases:

* The forms of the same word vary widely. For example, a search for `пёс` (Russian for _dog_) will not find a document with `пса` (the genitive case of `пёс`). Similarly, a search for `идти` (Russian for _go_, _walk_, etc.) will fail to retrieve a document with `шли` (a past tense form for `идти`).

* Words with different meanings have the same or similar spelling. As a result, the search may retrieve irrelevant documents that do not match your query. For example, a search for `алая` (Russian for _scarlet_) will find documents that contain both adjectives (`алая`) and nouns (the genitive case of `Алай`, which is the name of a river, e.g., `на берегу Алая` or _on the bank of Alai_ in Russian).

* There are typos in the text which are not immediately obvious. For example, in `Cловарь` (`Slovar`, which is Russian for _dictionary_), the first letter is Latin `C`. If you enter the whole word in Cyrillic in your query, the search will not find the document with the misspelled word.

How search with `yandex-lemmer` works:

1. {{ OS }} parses the query text with the [Apache Lucene](https://lucene.apache.org) search library. During parsing, the tokenizer breaks the text down into individual tokens. A token usually consists of a word and its metadata. For example, a tokenizer can divide a sentence such as `Один в поле не воин` (a Russian proverb meaning _One man in the filed is no warrior_) into tokens based on the spaces between words: `Один`, `в`, `поле`, `не`, `воин`.

1. A sequence of tokens goes through a chain of filters. Each filter receives a token, analyzes it, and returns one or more tokens. For example, a filter converting text to lower case will return the same number of tokens as it received in the input: `один`, `в`, `поле`, `не`, `воин`. Also, a token may be removed from the output after applying a stop word filter.

1. When the `yandex_lemmer` filter gets a token, it searches for the root form of the word. If it finds one or more roots forms (e.g., for homonyms or homographs), the filter first returns the initial token and then those with the word’s root forms.

    {% cut "Example of output tokens for `идут дожди` (`it’s been raining`)" %}

    ```bash
    {
      "tokens": [
        {
          "token": "идут",
          "start_offset": 0,
          "end_offset": 4,
          "type": "<ALPHANUM>",
          "position": 0
        },
        {
          "token": "идти",
          "start_offset": 0,
          "end_offset": 4,
          "type": "<ALPHANUM>",
          "position": 0
        },
        {
          "token": "дожди",
          "start_offset": 5,
          "end_offset": 10,
          "type": "<ALPHANUM>",
          "position": 1
        },
        {
          "token": "дождь",
          "start_offset": 5,
          "end_offset": 10,
          "type": "<ALPHANUM>",
          "position": 1
        }
      ]
    }
    ```

    {% endcut %}

    In the example above, the search will find phrases with any form of `идти` (e.g., `шел`, `шли`, `идут`) and any form of `дождь` (e.g., `дожди` or `дождей`).

    Each output token is assigned a rank indicating the word’s position in the search phrase. If an input token has multiple associated tokens in the output, all of them will have the same rank. This helps to determine the distance between the words in a search query, e.g., if enclosed in quotes. Thus, a search for `"идут дожди"` (`it’s been raining`) will retrieve a document with `идет дождь` (`it’s raining`), but not the one with `идет сильный дождь` (`it’s raining hard`).

## Use cases {#examples}

* [{#T}](../tutorials/opensearch-yandex-lemmer.md)
* [{#T}](../tutorials/migration-to-opensearch.md)
