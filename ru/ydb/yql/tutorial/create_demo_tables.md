# Создание таблицы

Для начала создадим таблицы и наполним их данными.

[CREATE TABLE](../reference/syntax/create_table.md) создаст пустую таблицу в текущей базе данных в текущей директории. Имя таблицы должно быть уникальным в пределах текущей директории. Таблица описывается парой: имя и тип колонки. Указание первичного ключа (PRIMARY KEY) является обязательным.

```sql
 CREATE TABLE series        -- series — имя таблицы
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    PRIMARY KEY (series_id) -- Первичный ключ — это столбец или
                            -- комбинация столбцов, однозначно идентифицирующих
                            -- каждую строку в таблице (может содержать только
                            -- не повторяющиеся значения). Для таблицы может быть
                            -- указан только один первичный ключ. Для каждой таблицы
                            -- YDB указание первичного ключа является обязательным.
);

CREATE TABLE seasons
(
    series_id Uint64,
    season_id Uint64,
    title Utf8,
    first_aired Uint64,
    last_aired Uint64,
    PRIMARY KEY (series_id, season_id)
);

CREATE TABLE episodes
(
    series_id Uint64,
    season_id Uint64,
    episode_id Uint64,
    title Utf8,
    air_date Uint64,
    PRIMARY KEY (series_id, season_id, episode_id)
);

COMMIT;
```

Все ключевые слова в данном примере написаны с большой буквы для наглядности — они не являются чувствительными к регистру.
