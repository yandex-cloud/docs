# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ api-gw-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.serverless.apigateway.<имя_события>
```

Имя события | Описание
--- | ---
`AddDomain` | Подключение домена
`CreateApiGateway` | Создание API-шлюза
`DeleteApiGateway` | Удаление API-шлюза
`DeleteDomain` | Отключение домена
`ResumeApiGateway` | Возобновление работы API-шлюза
`SetApiGatewayAccessBindings` | Назначение прав доступа к API-шлюзу
`StopApiGateway` | Остановка API-шлюза
`UpdateApiGateway` | Изменение API-шлюза
`UpdateApiGatewayAccessBindings` | Изменение прав доступа к API-шлюзу