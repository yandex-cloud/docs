# Настройка базы данных

Вы можете управлять некоторыми настройками ваших баз данных с помощью интерфейсов {{ mmy-name }}.

## Установить режим SQL (sql_mode) {#sql-mode}

Вы можете задать или изменить значение переменной [sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html), которая определяет режим SQL для базы данных. Эта операция вызовет перезапуск хостов кластера.  

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Задайте нужные режимы SQL в значении параметра `--set`, например:
  
  ```bash
  $ yc managed-mysql cluster update-config
       --cluster-name=<имя кластера>
       --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```
  
  Обратите внимание на кавычки: значением параметра должна стать вся строка, включая часть `sql_mode=`.
  
  Имя кластера можно получить при запросе [списка кластеров в каталоге](cluster-list.md).
  
- API

  Передайте массив `sqlMode` в новой конфигурации {{ MY }}, отправляя запрос [update](../api-ref/Cluster/update.md). 

{% endlist %}


## Изменить набор символов и правила их сравнения (CHARACTER SET, COLLATE) {#charset-collate}

Настройки символов можно установить для базы данных командой [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html). Для этого нужно выполнить запрос от лица пользователя с привилегией `ALL` или `ALTER` для нужной БД, например:

```sql
ALTER DATABASE dbname CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
```

Чтобы настройки изменились не только для самой базы данных, но и для таблиц в ней, сконвертируйте таблицы с теми же настройками:

```sql
ALTER TABLE dbname.tablename CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
```
