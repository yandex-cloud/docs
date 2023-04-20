# Использование pgaudit в {{ mpg-name }}

Расширение [pgaudit](https://www.pgaudit.org/) предоставляет дополнительные инструменты для логирования и повышает возможности аудита.

## Установить расширение pgaudit в кластер {{ PG }} {#install}

1. [Подключите к кластеру библиотеку общего пользования](./cluster-extensions.md#libraries-connection) с именем `pgaudit`.
1. [Добавьте расширение](./cluster-extensions.md#update-extensions) `pgaudit` к базе данных.
1. Для пользователей, действия которых должны попадать в лог аудита, укажите необходимые значения настройки [Pg audit log](../../concepts/settings-list.md#setting-pg-audit-log). Подробнее в разделе [{#T}](../cluster-users.md#update-settings).

Логи аудита станут доступны при [просмотре логов кластера](../cluster-logs.md).


Подробнее о расширении `pgaudit` см. в [официальной документации](https://github.com/pgaudit/pgaudit/blob/master/README.md).
