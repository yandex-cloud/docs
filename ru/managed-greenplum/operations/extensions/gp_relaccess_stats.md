---
title: Использование gp_relaccess_stats в {{ mgp-name }}
description: Как использовать расширение gp_relaccess_stats в {{ mgp-full-name }}.
---

# Использование gp_relaccess_stats в {{ mgp-name }}

`gp_relaccess_stats` — это расширение от {{ yandex-cloud }}, которое собирает статистику обращений к таблицам и представлениям. Оно отслеживает операции чтения, вставки, обновления и удаления, а также время последнего обращения пользователя к объекту. Собранные данные помогают находить объекты, которые больше не используются или используются неправильно.

## Настройки расширения {#extension-settings}

| Настройка | Тип | Значение по умолчанию | Описание |
|-----------|-----|-----------------------|----------|
| `gp_relaccess_stats.enabled` | `bool` | `false` | Включает сбор статистики. Настройку можно включить на уровне кластера или конкретной базы данных. Рекомендуется включать на уровне базы данных. |
| `gp_relaccess_stats.max_tables` | `integer` | `65536` | Максимальное количество таблиц для кеширования статистики. |
| `gp_relaccess_stats.dump_on_overflow` | `bool` | `false` | Определяет поведение при превышении `gp_relaccess_stats.max_tables`. Если `true`, кеш статистики очищается через `relaccess_stats_dump()` автоматически. Если `false`, выводится предупреждение о нехватке места. |

Подробнее о расширении см. в [документации gp_relaccess_stats](https://github.com/open-gpdb/gp_relaccess_stats).

## Установить расширение gp_relaccess_stats в кластер {{ GP }} {#extension-install}

1. [Подключитесь](../connect/index.md) к базе данных от имени владельца или пользователя, имеющего в базе данных разрешение `CREATE`, и выполните команду:

    ```sql
    CREATE EXTENSION gp_relaccess_stats;
    ```

1. Проверьте, что расширение было установлено:

    ```sql
    SELECT extname FROM pg_extension;
    ```

    Будет выведен список расширений, установленных в БД.

## Примеры использования {#examples}

1. Подготовьте таблицу для сбора статистики:

    ```sql
    SELECT relaccess_stats_init();
    ```

    В таблице `relaccess_stats` будут созданы пустые записи для каждой таблицы и партиции выбранной базы данных.

1. Обновите статистику:

    ```sql
    SELECT relaccess_stats_update();
    ```

    В таблицу `relaccess_stats` будут добавлены статистические данные из кеша и каталога `pg_stat`.

1. Проверьте текущее использование кеша статистики:

    ```sql
    SELECT relaccess.relaccess_stats_fillfactor();
    ```

    Будет выведен процент заполнения кеша статистики.

1. Получите статистические данные из таблицы `relaccess_stats`:

    ```sql
    SELECT * FROM relaccess_stats;
    ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}