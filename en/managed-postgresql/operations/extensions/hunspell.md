---
title: Hunspell dictionaries for full-text search in {{ mpg-name }}
description: Learn how to get started with dictionaries in {{ mpg-name }}.
keywords:
  - full-text search
  - word normalization
  - lexemes
  - Hunspell
---

# Hunspell dictionaries for full-text search

[Dictionaries]({{ pg-docs }}/textsearch-dictionaries.html) are used to configure full-text search in documents stored in {{ PG }}. {{ mpg-name }} clusters have pre-installed [Hunspell](https://hunspell.github.io/) spell checker dictionaries supporting multiple languages.

Below, we provide instructions on how to add an [English](#en) dictionary, as an example.

## Adding a dictionary {#add-dictionary}

1. [Connect to the database](../connect.md#bash) using `psql`.
1. To find out which languages are available, get a list of preset configurations for full-text search:

   ```sql
   SELECT cfgname FROM pg_catalog.pg_ts_config;
   ```

   The result includes the configuration names represented as language names.

1. Create the `public.my_config` configuration for full-text search:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_config ( COPY = pg_catalog.<configuration> );
   ```

   In your SQL query, specify the language configuration obtained in the previous step.

1. Create a dictionary named `my_dictionary` in the DB:

   ```sql
   CREATE TEXT SEARCH DICTIONARY my_dictionary (
      TEMPLATE = ispell,
      DictFile = <words_in_dictionary>,
      AffFile = <affixes>,
      Stopwords = <stopwords>
   );
   ```

   SQL query properties:

   * `TEMPLATE`: Template used to create a dictionary. You can learn more about Ispell dictionaries [here]({{ pg-docs }}/textsearch-dictionaries.html#TEXTSEARCH-ISPELL-DICTIONARY).
   * `DictFile`: Preset file with words organized in a dictionary.
   * `AffFile`: Preset file with affixes (prefixes, suffixes, and endings) you can add to words in the dictionary.
   * `Stopwords`: Stopwords to disregard in full-text searches. Such words may include articles, prepositions and interjections.

   Files with dictionaries and affixes preset in {{ mpg-name }} clusters:

   | Language | `DictFile` dictionary | `AffFile` affixes |
   | ----------- | ----------- |----------- |
   | English | `en_gb.dict` | `en_GB.affix` |
   | Danish | `da_dk.dict` | `da_DK.affix` |
   | Spanish | `es_es.dict` | `es_ES.affix` |
   | Italian | `it_it.dict` | `it_IT.affix` |
   | German | `de_de_frami.dict` | `de_de_frami.affix` |
   | Polish | `pl_pl.dict` | `pl_PL.affix` |
   | Russian | `ru_ru.dict` | `ru_RU.affix` |
   | Ukrainian | `uk_ua.dict` | `uk_UA.affix` |
   | Czech | `cs_cz.dict` | `cs_CZ.affix` |

   There are also [examples of {{ PG }} dictionaries](https://github.com/postgres/postgres/tree/master/src/backend/tsearch/dicts):

   | `DictFile` dictionary | `AffFile` affixes |
   | ----------- |----------- |
   | `hunspell_sample_long.dict` | `hunspell_sample_long.affix` |
   | `hunspell_sample_num.dict` | `hunspell_sample_num.affix` |
   | `ispell_sample.dict` | `ispell_sample.affix` |

   In the `CREATE TEXT SEARCH DICTIONARY` SQL query, do not use the `.dict` and `.affix` extensions in the file names.

1. Link the dictionary named `my_dictionary` and other dictionaries with the `word` token type.

   Token is a word or phrase being searched for. It is specified in the search query and displayed in the full-text search results.

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_config
      ALTER MAPPING FOR word
      WITH my_dictionary,<list of_dictionaries>;
   ```

   In the `WITH` row, specify the publicly available dictionaries with a broader range of words, e.g., `english_ispell` or `english_stem`. The broader the dictionary, the further down it should be listed in the `WITH` row.

1. Set `public.my_config` as the default configuration:

   ```sql
   SET default_text_search_config = 'public.my_config';
   ```

1. Make sure the default configuration is set to `public.my_config`:

   ```sql
   SHOW default_text_search_config;
   ```

   Result:

   ```text
    default_text_search_config
   ----------------------------
    public.my_config
   (1 row)
   ```

1. Make sure the full-text search works:

   ```sql
   SELECT * FROM ts_debug('<token>');
   ```

   Specify a word that can be found in the DB documents as the token.

   Result:

   ```text
    alias |    description    |  token  |       dictionaries       |           dictionary           +   lexemes
   -------+-------------------+---------+--------------------------+--------------------------------+------------
    word  | Word, all letters | <token> | {<used_dictionaries>} | <dictionary_with_found_lexeme> | {<lexemes>}
   (1 row)
   ```

   Here, a lexeme is a word that replaces cognate words in full-text searches. For example, if a DB document contains such words as _cloud_, _clouds_, and _cloud's_, {{ PG }} can recognize them as a single lexeme, "cloud".

## Examples {#examples}


### Adding an English dictionary {#en}

1. [Connect to the database](../connect.md#bash) using `psql`.
1. Create the `public.my_english_config` configuration for full-text search:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_english_config ( COPY = pg_catalog.english );
   ```

1. Create a dictionary in the DB:

   ```sql
   CREATE TEXT SEARCH DICTIONARY english_hunspell (
      TEMPLATE = ispell,
      DictFile = en_gb,
      AffFile = en_GB,
      Stopwords = english
   );
   ```

1. Link dictionaries named `english_hunspell` and `english_stem` with the `word` token type:

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_english_config
      ALTER MAPPING FOR word
      WITH english_hunspell, english_stem;
   ```

1. Set `public.my_english_config` as the default configuration:

   ```sql
   SET default_text_search_config = 'public.my_english_config';
   ```

1. Make sure the default configuration is set to `public.my_english_config`:

   ```sql
   SHOW default_text_search_config;
   ```

   Result:

   ```text
    default_text_search_config
   ----------------------------
    public.my_english_config
   (1 row)
   ```

1. Make sure the full-text search works:

   ```sql
   SELECT * FROM ts_debug('<token>');
   ```

   Specify a word that can be found in the DB documents as the token.

   Result:

   ```text
    alias |    description    |  token  |          dictionaries           |    dictionary    +   lexemes
   -------+-------------------+---------+---------------------------------+------------------+------------
    word  | Word, all letters | <token> | {english_hunspell,english_stem} | english_hunspell | {<lexemes>}
   (1 row)
   ```
