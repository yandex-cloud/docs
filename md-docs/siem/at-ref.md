[Документация Yandex Cloud](../index.md) > [Yandex SIEM](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex SIEM

В Audit Trails для Yandex SIEM поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.siem.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`queries.CreateSearch` | Создание [запроса](concepts/queries.md)
`queries.CreateSearchLaunch` | Запуск запроса
`queries.CreateSession` | Создание [расследования](concepts/investigations.md)