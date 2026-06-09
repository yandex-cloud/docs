# SQL-запросы в Yandex WebSQL

Вы можете отправлять SQL-запросы к базам данных в кластере Managed Service for PostgreSQL с помощью сервиса [Yandex WebSQL](../../websql/index.md).

WebSQL — это сервис Yandex Cloud, который позволяет подключаться к кластерам управляемых баз данных, работать с БД, таблицами и схемами и выполнять запросы. Сервис работает в браузере, не требует дополнительной авторизации и предлагает удобные подсказки для работы с SQL-командами.

Для подключения из WebSQL в настройках кластера должна быть включена опция **Доступ из WebSQL**. Опцию можно включить при [создании](cluster-create.md) или [изменении](update.md#change-additional-settings) кластера.

В кластере Managed Service for PostgreSQL для каждого пользователя БД автоматически создается [подключение Connection Manager](../../metadata-hub/concepts/connection-manager.md), которое можно использовать для подключения к БД из WebSQL. При необходимости вы также можете [создать новое подключение](../../websql/operations/create-connection.md#connect-cluster).

Чтобы подключиться к БД из WebSQL:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог с нужным кластером.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **WebSQL**.
  1. Выберите нужное подключение.

      Откроется подключение в сервисе WebSQL. Чтобы перейти в редактор запросов, выберите нужную БД. 
      
      Справочник по поддерживаемым запросам можно найти в [документации PostgreSQL](https://www.postgresql.org/docs/current/sql.html).

      {% note info %}
      
      С помощью команд SQL нельзя выполнять действия, требующие прав суперпользователя.
      
      {% endnote %}
    
{% endlist %}

Подробнее о работе с WebSQL см. в [документации сервиса](../../websql/operations/index.md).