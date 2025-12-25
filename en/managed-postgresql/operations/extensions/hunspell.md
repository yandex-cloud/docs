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

{{ PG }} uses [Dictionaries]({{ pg-docs }}/textsearch-dictionaries.html) to configure full-text search in its documents. {{ mpg-name }} clusters come with pre-installed [Hunspell](https://hunspell.github.io/) spell checker dictionaries supporting multiple languages.

The following examples show how to add an [English](#en) dictionary.

## Adding a dictionary {#add-dictionary}

1. [Connect to the database](../connect.md#bash) via `psql`.
1. To see which languages are available, get a list of pre-installed full-text search configurations:

   ```sql
   SELECT cfgname FROM pg_catalog.pg_ts_config;
   ```

   The result will show configurations named after their respective languages.

1. Create the `public.my_config` full-text search configuration:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_config ( COPY = pg_catalog.<configuration> );
   ```

   In your SQL query, specify the language configuration from the previous step.

1. Create a dictionary called `my_dictionary` in your database:

   ```sql
   CREATE TEXT SEARCH DICTIONARY my_dictionary (
      TEMPLATE = ispell,
      DictFile = <dictionary_words>,
      AffFile = <affixes>,
      Stopwords = <stop_words>
   );
   ```

   SQL query parameters:

   * `TEMPLATE`: Dictionary template. Learn more about Ispell dictionaries [here]({{ pg-docs }}/textsearch-dictionaries.html#TEXTSEARCH-ISPELL-DICTIONARY).
   * `DictFile`: Pre-installed dictionary file.
   * `AffFile`: Pre-installed affix file containing prefixes, suffixes, and endings for expanding dictionary words.
   * `Stopwords`: Words to ignore in full-text searches, such as articles, prepositions, and interjections.

   Dictionary and affix files pre-installed in {{ mpg-name }} clusters:

   | Language | Dictionary (`DictFile`) | Affixes (`AffFile`) |
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

   | Dictionary (`DictFile`) | Affixes (`AffFile`) |
   | ----------- |----------- |
   | `hunspell_sample_long.dict` | `hunspell_sample_long.affix` |
   | `hunspell_sample_num.dict` | `hunspell_sample_num.affix` |
   | `ispell_sample.dict` | `ispell_sample.affix` |

   Do not specify the `.dict` and `.affix` file extensions in the `CREATE TEXT SEARCH DICTIONARY` SQL query.

1. Link `my_dictionary` and other dictionaries to the `word` token type.

   A token is a search word or phrase. You specify it in the search query and it appears in the full-text search results.

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_config
      ALTER MAPPING FOR word
      WITH my_dictionary,<dictionary_list>;
   ```

   Use the `WITH` clause to specify publicly available dictionaries with more extensive vocabulary, such as `english_ispell` or `english_stem`. Dictionaries should be ordered in the `WITH` clause from more specific to more general.

1. Set `public.my_config` as the default configuration:

   ```sql
   SET default_text_search_config = 'public.my_config';
   ```

1. Verify that the default configuration is `public.my_config`:

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

1. Verify that the full-text search is working:

   ```sql
   SELECT * FROM ts_debug('<token>');
   ```

   For the token, specify the word that can be found in the documents within your database.

   Result:

   ```text
    alias |    description    |  token  |       dictionaries       |           dictionary           +   lexemes
   -------+-------------------+---------+--------------------------+--------------------------------+------------
    word  | Word, all letters | <token> | {<dictionaries_used>} | <dictionary_with_the_lexem_found> | {<lexemes>}
   (1 row)
   ```

   Here, a lexeme is a word that replaces all its morphological variants in full-text searches. For example, if a document in your database contains the words <q>flying</q>, <q>flies</q>, and <q>flew</q>, {{ PG }} will recognize them as a single lexeme, <q>fly</q>.

## Examples {#examples}


### Adding an English dictionary {#en}

1. [Connect to the database](../connect.md#bash) via `psql`.
1. Create the `public.my_english_config` full-text search configuration:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_english_config ( COPY = pg_catalog.english );
   ```

1. Create a dictionary in your database:

   ```sql
   CREATE TEXT SEARCH DICTIONARY english_hunspell (
      TEMPLATE = ispell,
      DictFile = en_gb,
      AffFile = en_GB,
      Stopwords = english
   );
   ```

1. Link `english_hunspell` and `english_stem` dictionaries to the `word` token type:

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_english_config
      ALTER MAPPING FOR word
      WITH english_hunspell, english_stem;
   ```

1. Set `public.my_english_config` as the default configuration:

   ```sql
   SET default_text_search_config = 'public.my_english_config';
   ```

1. Verify that the default configuration is `public.my_english_config`:

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

1. Verify that the full-text search is working:

   ```sql
   SELECT * FROM ts_debug('<token>');
   ```

   For the token, specify the word that can be found in the documents within your database.

   Result:

   ```text
    alias |    description    |  token  |          dictionaries           |    dictionary    +   lexemes
   -------+-------------------+---------+---------------------------------+------------------+------------
    word  | Word, all letters | <token> | {english_hunspell,english_stem} | english_hunspell | {<lexemes>}
   (1 row)
   ```
