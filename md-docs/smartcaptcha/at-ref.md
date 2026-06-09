# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ captcha-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.smartcaptcha.<имя_события>
```

Имя события | Описание
--- | ---
`CreateCaptcha` | Создание капчи
`DeleteCaptcha` | Удаление капчи
`UpdateCaptcha` | Изменение капчи