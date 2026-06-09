# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex API Gateway. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.serverless.apigateway.<имя_события>
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