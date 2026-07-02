[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > Решение проблем > Requested database column does not exist

# [Yandex DataLens] Requested database column does not exist

`ERR.DS_API.DB.COLUMN_DOES_NOT_EXIST`

Используется несуществующее поле.

Возможные причины ошибки:

* В источник данных добавлено новое поле, но датасет не обновлен. Чтобы обновить датасет, нажмите кнопку [Обновить поля](../../dataset/create-dataset.md#update-fields).

* При построении датасета на основе подключения к ClickHouse® используется SQL-подзапрос. В этом случае задайте алиас для выбираемых полей.

   Пример:

   ```sql
   SELECT DISTINCT
     id as offer_id,
     upper(proposed_meta)
     FROM
   ```

   DataLens может некорректно распознать поле `upper(proposed_meta)`, поэтому нужно задать для него алиас:

   ```sql
   SELECT DISTINCT
     id as offer_id,
     upper(proposed_meta) as upper_proposed_meta
     FROM
   ```

* При построении датасета в SQL-подзапросе неявно указаны выбираемые поля (`SELECT * FROM`). Чтобы избежать ошибки, явно перечислите нужные поля в секции `SELECT`.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._