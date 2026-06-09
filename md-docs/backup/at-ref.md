# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ backup-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.backup.<имя_события>
```

Имя события | Описание
--- | ---
`ApplyPolicy` | Применение политики резервного копирования
`CreateDirectory` | Создание новой директории внутри ВМ или сервера {{ baremetal-full-name }}
`CreatePolicy` | Создание политики резервного копирования
`DeleteArchive` | Удаление архива резервной копии
`DeleteBackup` | Удаление резервной копии
`DeletePolicy` | Удаление политики резервного копирования
`DeleteResource` | Удаление ВМ или сервера {{ baremetal-name }} из сервиса {{ backup-name }}
`ExecutePolicy` | Выполнение политики резервного копирования
`InitResource` | Инициализация подключения ВМ или сервера {{ baremetal-name }} к сервису {{ backup-name }}
`RegisterResource` | Подключение ВМ или сервера {{ baremetal-name }} к сервису {{ backup-name }} завершено
`RevokePolicy` | Отзыв политики резервного копирования
`StartRecoverBackup` | Запуск восстановления ВМ или сервера {{ baremetal-name }} из резервной копии
`UpdatePolicy` | Изменение политики резервного копирования
`UpdateResource` | Обновление статуса подключения ВМ или сервера {{ baremetal-name }} к сервису {{ backup-name }}