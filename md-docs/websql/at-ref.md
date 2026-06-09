# Справочник аудитных логов {{ websql-full-name }}

В {{ at-name }} для {{ websql-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.websql.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CreateSavedQuery` | Сохранение запроса
`DeleteExecutedQuery` | Удаление выполненного запроса
`DeleteSavedQuery` | Удаление сохраненного запроса
`EditSavedQuery` | Редактирование сохраненного запроса
`PublishExecutedQuery` | Публикация выполненного запроса
`PublishSavedQuery` | Публикация сохраненного запроса
`UpdateExecutedQueryAccessBindings` | Обновление прав доступа к выполненному запросу
`UpdateSavedQueryAccessBindings` | Обновление прав доступа к сохраненному запросу

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`Execute` | Выполнение запроса
`GenerateSql` | Генерация запроса
`GetDatabaseStructure` | Получение структуры базы данных