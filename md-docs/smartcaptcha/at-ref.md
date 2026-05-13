# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex SmartCaptcha. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.smartcaptcha.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCaptcha` | Создание капчи
`DeleteCaptcha` | Удаление капчи
`UpdateCaptcha` | Изменение капчи