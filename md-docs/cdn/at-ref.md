# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ cdn-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.cdn.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

Имя события | Описание
--- | ---
`gcore.CachePrefetch` | Предзагрузка кеша
`gcore.CachePurge` | Очистка кеша
`gcore.OriginCreate` | Создание источника
`gcore.OriginDelete` | Удаление источника
`gcore.OriginGroupCreate` | Создание группы источников
`gcore.OriginGroupDelete` | Удаление группы источников
`gcore.OriginGroupUpdate` | Изменение группы источников
`gcore.OriginUpdate` | Измнение источника
`gcore.ProviderActivate` | Активация провайдера
`gcore.RawLogsActivate` | Включение выгрузки логов
`gcore.RawLogsDeactivate` | Отключение выгрузки логов
`gcore.RawLogsUpdate` | Изменение параметров выгрузки логов
`gcore.ResourceCreate` | Создание ресурса
`gcore.ResourceDelete` | Удаление ресурса
`gcore.ResourceRuleCreate` | Создание правила Rewrite
`gcore.ResourceRuleDelete` | Удаление правила Rewrite
`gcore.ResourceRuleUpdate` | Изменение правила Rewrite
`gcore.ResourceUpdate` | Изменение ресурса