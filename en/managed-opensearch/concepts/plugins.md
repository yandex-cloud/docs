# {{ OS }} plugins

{{ mos-name }} has a number of [pre-installed plugins]({{ os.docs }}/install-and-configure/plugins/#bundled-plugins). When creating or updating a cluster in {{ mos-short-name }}, you can also specify a list of [additional plugins](#opensearch), which will be installed in the cluster automatically.

## Additional pre-installed plugins {#extra-preinstalled}

* repository-s3

    Adds support for [AWS S3](https://aws.amazon.com/s3/) as a repository for snapshots.

## Additional {{ OS }} plugins {#opensearch}

All supported additional plugins are listed here:

* analysis-icu

    Adds the Lucene ICU module with extended Unicode support using the [ICU](https://icu.unicode.org/) libraries. It improves analysis of Asian languages, Unicode normalization, Unicode-aware case folding, collation support, and transliteration.

* analysis-kuromoji

    Adds the Lucene kuromoji analysis module for the Japanese language.

* analysis-nori

    Adds the Lucene nori analysis module for the Korean language. Uses the [mecab-ko-dic](https://bitbucket.org/eunjeon/mecab-ko-dic/src/master/) dictionary.

* analysis-phonetic

    Provides lexeme filters that convert expressions to their phonetic representation using Soundex, Metaphone, and other algorithms.

* analysis-smartcn

    Adds the Lucene Smart Chinese analysis module for Chinese or mixed Chinese-English text.

* analysis-stempel

    Adds the Lucene Stempel analysis module for the Polish language.

* analysis-ukrainian

    Adds the Lucene UkrainianMorfologikAnalyzer analysis module providing stemming for the Ukrainian language. Uses the [Morfologik](https://github.com/morfologik/morfologik-stemming) project.

* ingest-attachment

    Extracts file attachments in common formats (such as PPT, XLS, and PDF) using the [Apache Tika™](https://tika.apache.org/) text extraction library.

* mapper-annotated-text

    Indexes plain text combined with a special markup. Such texts are typically used to identify items of interest, e.g., people or organizations.

* mapper-murmur3

    Computes hashes of field values at the index time and stores them in the index.

* mapper-size

    Provides the `_size` metadata field that indexes the size of the original `_source` field in bytes.

* repository-azure

    Adds support for [Azure Blob Storage]({{ ms.docs }}/azure/storage/blobs/storage-blobs-introduction) as a repository for snapshots.

* repository-gcs

    Adds support for [Google Cloud Storage](https://cloud.google.com/storage/) as a repository for snapshots.

* repository-hdfs

    Adds support for the HDFS file system as a repository for snapshots.

* transport-nio

    Server/client non-blocking networking library built with Netty. This plugin only supports [{{ OS }} 2.x]({{ os.docs }}/breaking-changes/#transport-nio-plugin).

* yandex-lemmer

    Adds the [yandex-lemmer](#yandex-lemmer) filter that improves text search in Russian across {{ OS }} documents.

For more information, see [this {{ OS }} article]({{ os.docs }}/install-and-configure/plugins/#additional-plugins).

### Why use the yandex-lemmer plugin {#yandex-lemmer}

The `yandex-lemmer` filter analyzes a search query in Russian in more detail and makes search more effective. Without this filter, you may get irrelevant results in the following cases:

* The forms of the same word vary widely. For example, a search for `pyos` (Russian for _dog_) will not find a document with `psa` (the genitive case of `pyos`). Similarly, a search for `idti` (Russian for _go_, _walk_, etc.) will fail to retrieve a document with `shli` (a past tense form for `idti`).

* Words with different meanings have the same or similar spelling. As a result, the search may retrieve irrelevant documents that do not match your query. For example, a search for `alaya` (Russian for _scarlet_) will find documents that contain both adjectives (`alaya`) and nouns (the genitive case of `Alai`, which is the name of a river, e.g., `na beregu Alaya` or _on the bank of Alai_ in Russian).

* There are typos in the text which are not immediately obvious. For example, in `Cловарь` (`Slovar`, which is Russian for _dictionary_), the first letter is Latin `C`. If you enter the whole word in Cyrillic in your query, the search will not find the document with the misspelled word.

How search with `yandex-lemmer` works:

1. {{ OS }} parses the query text with the [Apache Lucene](https://lucene.apache.org) search library. During parsing, the tokenizer breaks the text down into individual tokens. A token usually consists of a word and its metadata. For example, a tokenizer can divide a sentence such as `Odin v pole ne voin` (a Russian proverb meaning _One man in the filed is no warrior_) into tokens based on the spaces between words: `Odin`, `v`, `pole`, `ne`, `voin`.

1. A sequence of tokens goes through a chain of filters. Each filter receives a token, analyzes it, and returns one or more tokens. For example, a filter converting text to lower case will return the same number of tokens as it received in the input: `odin`, `v`, `pole`, `ne`, `voin`. Also, a token may be removed from the output after applying a stop word filter.

1. When the `yandex_lemmer` filter gets a token, it searches for the root form of the word. If it finds one or more roots forms (e.g., for homonyms or homographs), the filter first returns the initial token and then those with the word’s root forms.

    {% cut "Example of output tokens for `idut dozhdi` (`it’s been raining`)" %}

    ```bash
    {
      "tokens": [
        {
          "token": "idut",
          "start_offset": 0,
          "end_offset": 4,
          "type": "<ALPHANUM>",
          "position": 0
        },
        {
          "token": "idti",
          "start_offset": 0,
          "end_offset": 4,
          "type": "<ALPHANUM>",
          "position": 0
        },
        {
          "token": "dozhdi",
          "start_offset": 5,
          "end_offset": 10,
          "type": "<ALPHANUM>",
          "position": 1
        },
        {
          "token": "dozhd",
          "start_offset": 5,
          "end_offset": 10,
          "type": "<ALPHANUM>",
          "position": 1
        }
      ]
    }
    ```

    {% endcut %}

    In the example above, the search will find phrases with any form of `idti` (e.g., `shyol`, `shli`, or `idut`) and any form of `dozhd` (e.g., `dozhdi` or `dozhdey`).

    Each output token is assigned a rank indicating the word’s position in the search phrase. If an input token has multiple associated tokens in the output, all of them will have the same rank. This helps to determine the distance between the words in a search query, e.g., if enclosed in quotes. Thus, a search for `"idut dozhdi"` (`it’s been raining`) will retrieve a document with `idyot dozhd` (`it’s raining`), but not the one with `idyot silny dozhd` (`it’s raining hard`).

## Use cases {#examples}

* [{#T}](../tutorials/opensearch-yandex-lemmer.md)
* [{#T}](../tutorials/migration-to-opensearch.md)
