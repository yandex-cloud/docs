# История изменений в {{ mch-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 01.06.2022 {#01.06.2022}

* Доступна новая версия {{ CH }} 22.5 ([список изменений](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md#225)).
* Добавлена возможность выдавать пользователям права на системные таблицы (`_system`).
* Включена настройка [force_remove_data_recursively_on_drop](https://github.com/ClickHouse/ClickHouse/pull/30054) для предотвращении ошибок `Directory not empty` при удалении баз данных.

## 01.04.2022 {#01.04.2022}

* Доступна новая версия {{ CH }} 22.3 LTS ([список изменений](https://github.com/ClickHouse/ClickHouse/blob/master/CHANGELOG.md)).
* Добавлена возможность восстановления шардированного кластера из резервной копии целиком. {{ tag-cli }} {{ tag-api }}
* Добавлена возможность изменения настройки публичного доступа для хоста. {{ tag-con }} {{ tag-cli }} {{ tag-api }}
