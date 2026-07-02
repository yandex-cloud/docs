[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for MySQL®](../index.md) > [Пошаговые инструкции](index.md) > Базы данных > SQL-запросы в Yandex WebSQL

# SQL-запросы в Yandex WebSQL

Вы можете отправлять SQL-запросы к базам данных в кластере Managed Service for MySQL® с помощью сервиса [Yandex WebSQL](../../websql/index.md).

WebSQL — это сервис Yandex Cloud, который позволяет подключаться к кластерам управляемых баз данных, работать с БД, таблицами и схемами и выполнять запросы. Сервис работает в браузере, не требует дополнительной авторизации и предлагает удобные подсказки для работы с SQL-командами.

Для подключения из WebSQL в настройках кластера должна быть включена опция **Доступ из WebSQL**. Опцию можно включить при [создании](cluster-create.md) или [изменении](update.md#change-additional-settings) кластера.

В кластере Managed Service for MySQL® для каждого пользователя БД автоматически создается [подключение Connection Manager](../../metadata-hub/concepts/connection-manager.md), которое можно использовать для подключения к БД из WebSQL. При необходимости вы также можете [создать новое подключение](../../websql/operations/create-connection.md#connect-cluster).

Чтобы подключиться к БД из WebSQL:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
  1. Перейдите в сервис **Managed Service for&nbsp;MySQL**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **WebSQL**.
  1. Выберите нужное подключение.

      Откроется подключение в сервисе WebSQL. Чтобы перейти в редактор запросов, выберите нужную БД.

      Справочник по поддерживаемым запросам можно найти в [документации MySQL®](https://dev.mysql.com/doc/refman/9.0/en/sql-statements.html).
    
{% endlist %}

Подробнее о работе с WebSQL читайте в [документации сервиса](../../websql/operations/index.md).