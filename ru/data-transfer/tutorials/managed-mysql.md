# Миграция кластера {{ MY }}

С помощью сервиса {{ data-transfer-name }} вы можете перенести данные из стороннего кластера-источника в кластер-приемник {{ mmy-name }}.

Этот способ позволяет перенести базу целиком без остановки обслуживания пользователей. Для его использования необходимо разрешить подключение к кластеру-источнику из интернета.


{% include notitle [MySQL migration with Data Transfer](../../_tutorials/dataplatform/datatransfer/managed-mysql.md) %}

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mmy-full-name }}](../../managed-mysql/tutorials/data-migration.md).
