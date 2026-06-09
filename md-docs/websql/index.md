# Yandex WebSQL

Yandex WebSQL — это сервис Yandex Cloud, который позволяет вам подключаться к кластерам управляемых БД, работать с БД, таблицами и схемами и выполнять запросы. Сервис работает в браузере и предлагает удобные подсказки для работы с SQL-командами.

Yandex WebSQL поддерживает интеграцию с сервисом Yandex MetaData Hub на уровне каталога пользователя. Созданные в WebSQL подключения автоматически появляются в Connection Manager сервиса MetaData Hub и наоборот.

Yandex WebSQL поддерживает работу со следующими версиями БД: <ul> <li>PostgreSQL: 12 и выше.</li> <li>MySQL: 5 и выше.</li> <li>ClickHouse®: 23 и выше.</li> <li>Redis/Valkey™ (только нешардированные кластеры): 6 и выше.</li> <li>MongoDB/Yandex StoreDoc: 6 и выше.</li> <li>Yandex Managed Service for Trino: 454 и выше.</li> <li>Greenplum®: 6.28 и выше.</li>     </ul>

# Yandex WebSQL

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создание подключения](operations/create-connection.md)

### Управление подключениями

 - [Все инструкции](operations/connect.md)

 - [Просмотр информации о ресурсах](operations/view-resources-info.md)

 - [Просмотр информации об объектах в базе данных](operations/view-db-objects-info.md)

 - [Изменение настроек подключения](operations/change-connection-settings.md)

 - [Обновление подключения](operations/update-connection.md)

 - [Добавление подключения к БД в кластере](operations/add-connection-to-db-in-cluster.md)

 - [Удаление подключения](operations/delete-connection.md)

 - [Работа с редактором запросов](operations/query-executor.md)

 - [Аналитика и оптимизация с помощью AI-ассистента](operations/ai-assistant.md)

 - [Работа с сохраненными запросами](operations/templates.md)

 - [Работа с историей запросов](operations/history.md)

## Концепции

 - [О сервисе {{ websql-full-name }}](concepts/index.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)

## История изменений

 - [Все изменения](release-notes/index.md)