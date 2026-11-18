[Документация Yandex Cloud](../index.md) > [Yandex Query](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

{% note warning %}

Сервис Yandex Query будет отключен 1 декабря 2026 года и станет недоступен. Подробнее о закрытии сервиса и переходе на другие решения читайте в разделе [Закрытие сервиса Yandex Query](sunset.md).

{% endnote %}

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Query. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.yq.<имя_события>
```

Имя события | Описание
--- | ---
`ControlQuery` | Управление запросом
`CreateBinding` | Создание привязки к данным
`CreateConnection` | Создание соединения
`CreateQuery` | Создание запроса
`DeleteBinding` | Удаление привязки к данным
`DeleteConnection` | Удаление соединения
`DeleteQuery` | Удаление запроса
`UpdateBinding` | Изменение привязки к данным
`UpdateConnection` | Изменение соединения
`UpdateQuery` | Изменение запроса