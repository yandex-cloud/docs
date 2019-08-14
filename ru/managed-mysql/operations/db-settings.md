# Настройка базы данных

Вы можете управлять некоторыми настройками ваших баз данных с помощью интерфейсов {{ mmy-name }}.

## Установка режима SQL (sql_mode) {#sql-mode}

Вы можете задать или изменить значение переменной [sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html), которая определяет режим SQL для базы данных. Эта операция вызовет перезапуск хостов кластера.  

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Задайте нужные режимы SQL в значении параметра `--set`, например:
  
  ```bash
  $ {{ yc-mdb-my }} cluster update-config
       --cluster-name=<имя кластера>
       --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```
  
  Обратите внимание на кавычки: значением параметра должна стать вся строка, включая часть `sql_mode=`.
  
  Имя кластера можно получить при запросе [списка кластеров в каталоге](cluster-list.md).
  
- API

  Передайте массив `sqlMode` в новой конфигурации {{ MY }}, отправляя запрос [update](../api-ref/Cluster/update.md). 

{% endlist %}
