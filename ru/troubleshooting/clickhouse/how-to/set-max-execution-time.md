# Как указать `max_execution_time`


## Описание сценария {#case-description}

По умолчанию значение параметра `max_execution_time` в {{ mch-short-name }} равно 60. Необходимо указать другое значение.

## Решение {#case-resolution}

Пересоздайте внешнюю таблицу, добавив в `LOCATION` (`pxf:строка-коннекта`) `ON ALL` `&query_timeout=3600`, чтобы получилось: `pxf:строка-коннекта&query_timeout=3600`.
​
После этого запустите запрос. Таймаут его исполнения должен увеличиться.

Подробнее — в [официальной документации](https://docs.vmware.com/en/VMware-Greenplum-Platform-Extension-Framework/6.6/greenplum-platform-extension-framework/jdbc_pxf.html).

