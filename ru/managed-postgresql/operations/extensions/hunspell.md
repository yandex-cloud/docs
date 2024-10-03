---
title: Словари от Hunspell для полнотекстового поиска в {{ mpg-name }}
description: Узнайте, как начать работу со словарями в {{ mpg-name }}.
keywords:
  - полнотекстовый поиск
  - нормализация слов
  - лексемы
  - Hunspell
---

# Словари от Hunspell для полнотекстового поиска

[Словари]({{ pg-docs }}/textsearch-dictionaries.html) используются для настройки полнотекстового поиска в документах, хранящихся в {{ PG }}. В кластерах {{ mpg-name }} предустановлены словари от корректора орфографии [Hunspell](https://hunspell.github.io/) с поддержкой нескольких языков.

Ниже в качестве примеров приводятся инструкции по добавлению [русского](#ru) и [английского](#en) словаря.

## Добавить словарь {#add-dictionary}

1. [Подключитесь к базе данных](../connect.md#bash) с помощью утилиты `psql`.
1. Чтобы узнать, какие языки доступны, получите список предустановленных конфигураций для полнотекстового поиска:

   ```sql
   SELECT cfgname FROM pg_catalog.pg_ts_config;
   ```

   Результат содержит названия конфигураций, представленные в виде названий языков.

1. Создайте конфигурацию `public.my_config` для полнотекстового поиска:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_config ( COPY = pg_catalog.<конфигурация> );
   ```

   В SQL-запросе укажите конфигурацию с нужным языком, полученную на предыдущем шаге.

1. Создайте словарь `my_dictionary` в БД:

   ```sql
   CREATE TEXT SEARCH DICTIONARY my_dictionary (
      TEMPLATE = ispell,
      DictFile = <набор_слов_в_словаре>,
      AffFile = <набор_аффиксов>,
      Stopwords = <стоп-слова>
   );
   ```

   Параметры SQL-запроса:

   * `TEMPLATE` — шаблон, по которому создается словарь. [Подробнее о словарях Ispell]({{ pg-docs }}/textsearch-dictionaries.html#TEXTSEARCH-ISPELL-DICTIONARY).
   * `DictFile` — предустановленный файл с набором слов в виде словаря.
   * `AffFile` — предустановленный файл с набором аффиксов (приставок, суффиксов и окончаний), которые можно добавить к словам в словаре.
   * `Stopwords` — стоп-слова, которые не нужно учитывать при полнотекстовом поиске. К таким словам могут относиться, например, предлоги или междометия.

   Файлы со словарями и аффиксами, предустановленные в кластерах {{ mpg-name }}:

   | Язык | Словарь `DictFile` | Аффиксы `AffFile` |
   | ----------- | ----------- |----------- |
   | Английский | `en_gb.dict` | `en_GB.affix` |
   | Датский | `da_dk.dict` | `da_DK.affix` |
   | Испанский | `es_es.dict` | `es_ES.affix` |
   | Итальянский | `it_it.dict` | `it_IT.affix` |
   | Немецкий | `de_de_frami.dict` | `de_de_frami.affix` |
   | Польский | `pl_pl.dict` | `pl_PL.affix` |
   | Русский | `ru_ru.dict` | `ru_RU.affix` |
   | Украинский | `uk_ua.dict` | `uk_UA.affix` |
   | Чешский | `cs_cz.dict` | `cs_CZ.affix` |

   Также доступны [примеры словарей от {{ PG }}](https://github.com/postgres/postgres/tree/master/src/backend/tsearch/dicts):

   | Словарь `DictFile` | Аффиксы `AffFile` |
   | ----------- |----------- |
   | `hunspell_sample_long.dict` | `hunspell_sample_long.affix` |
   | `hunspell_sample_num.dict` | `hunspell_sample_num.affix` |
   | `ispell_sample.dict` | `ispell_sample.affix` |

   В SQL-запросе `CREATE TEXT SEARCH DICTIONARY` названия файлов указываются без расширений `.dict` и `.affix`.

1. Свяжите словарь `my_dictionary` и другие словари с типом токенов `word`.

   Токен — искомое слово или фраза. Задается в поисковом запросе и отображается в результатах полнотекстового поиска.

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_config
      ALTER MAPPING FOR word
      WITH my_dictionary,<список_словарей>;
   ```

   В строке `WITH` укажите общедоступные словари с более широким набором слов, например `english_ispell` или `english_stem`. Чем шире словарь, тем позднее он должен быть указан в строке `WITH`.

1. Сделайте `public.my_config` конфигурацией по умолчанию:

   ```sql
   SET default_text_search_config = 'public.my_config';
   ```

1. Проверьте, что конфигурация по умолчанию — это `public.my_config`:

   ```sql
   SHOW default_text_search_config;
   ```

   Результат:

   ```text
    default_text_search_config
   ----------------------------
    public.my_config
   (1 row)
   ```

1. Убедитесь, что полнотекстовый поиск выполняется:

   ```sql
   SELECT * FROM ts_debug('<токен>');
   ```

   В качестве токена укажите слово, которое можно найти в документах в БД.

   Результат:

   ```text
    alias |    description    |  token  |       dictionaries       |           dictionary           +   lexemes
   -------+-------------------+---------+--------------------------+--------------------------------+------------
    word  | Word, all letters | <токен> | {<используемые_словари>} | <словарь_с_найденной_лексемой> | {<лексемы>}
   (1 row)
   ```

   Здесь лексема — слово, которое заменяет однокоренные слова при полнотекстовом поиске. Например, если в документе в БД встречаются слова <q>облачный</q>, <q>облаками</q> и <q>облаку</q>, {{ PG }} может распознать их как одно слово — лексему <q>облако</q>.

## Примеры {#examples}


### Добавить русский словарь {#ru}

1. [Подключитесь к базе данных](../connect.md#bash) с помощью утилиты `psql`.
1. Создайте конфигурацию `public.my_russian_config` для полнотекстового поиска:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_russian_config ( COPY = pg_catalog.russian );
   ```

1. Создайте словарь в БД:

   ```sql
   CREATE TEXT SEARCH DICTIONARY russian_hunspell (
      TEMPLATE = ispell,
      DictFile = ru_ru,
      AffFile = ru_RU,
      Stopwords = russian
   );
   ```

1. Свяжите словари `russian_hunspell` и `russian_stem` с типом токенов `word`:

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_russian_config
      ALTER MAPPING FOR word
      WITH russian_hunspell, russian_stem;
   ```

1. Сделайте `public.my_russian_config` конфигурацией по умолчанию:

   ```sql
   SET default_text_search_config = 'public.my_russian_config';
   ```

1. Проверьте, что конфигурация по умолчанию — это `public.my_russian_config`:

   ```sql
   SHOW default_text_search_config;
   ```

   Результат:

   ```text
    default_text_search_config
   ----------------------------
    public.my_russian_config
   (1 row)
   ```

1. Убедитесь, что полнотекстовый поиск выполняется:

   ```sql
   SELECT * FROM ts_debug('<токен>');
   ```

   В качестве токена укажите слово, которое можно найти в документах в БД.

   Результат:

   ```text
    alias |    description    |  token  |          dictionaries           |    dictionary    +   lexemes
   -------+-------------------+---------+---------------------------------+------------------+------------
    word  | Word, all letters | <токен> | {russian_hunspell,russian_stem} | russian_hunspell | {<лексемы>}
   (1 row)
   ```


### Добавить английский словарь {#en}

1. [Подключитесь к базе данных](../connect.md#bash) с помощью утилиты `psql`.
1. Создайте конфигурацию `public.my_english_config` для полнотекстового поиска:

   ```sql
   CREATE TEXT SEARCH CONFIGURATION public.my_english_config ( COPY = pg_catalog.english );
   ```

1. Создайте словарь в БД:

   ```sql
   CREATE TEXT SEARCH DICTIONARY english_hunspell (
      TEMPLATE = ispell,
      DictFile = en_gb,
      AffFile = en_GB,
      Stopwords = english
   );
   ```

1. Свяжите словари `english_hunspell` и `english_stem` с типом токенов `word`:

   ```sql
   ALTER TEXT SEARCH CONFIGURATION public.my_english_config
      ALTER MAPPING FOR word
      WITH english_hunspell, english_stem;
   ```

1. Сделайте `public.my_english_config` конфигурацией по умолчанию:

   ```sql
   SET default_text_search_config = 'public.my_english_config';
   ```

1. Проверьте, что конфигурация по умолчанию — это `public.my_english_config`:

   ```sql
   SHOW default_text_search_config;
   ```

   Результат:

   ```text
    default_text_search_config
   ----------------------------
    public.my_english_config
   (1 row)
   ```

1. Убедитесь, что полнотекстовый поиск выполняется:

   ```sql
   SELECT * FROM ts_debug('<токен>');
   ```

   В качестве токена укажите слово, которое можно найти в документах в БД.

   Результат:

   ```text
    alias |    description    |  token  |          dictionaries           |    dictionary    +   lexemes
   -------+-------------------+---------+---------------------------------+------------------+------------
    word  | Word, all letters | <токен> | {english_hunspell,english_stem} | english_hunspell | {<лексемы>}
   (1 row)
   ```
