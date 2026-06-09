# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Backup. Подробнее см. [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.backup.<имя_события>
```

Имя события | Описание
--- | ---
`ApplyPolicy` | Применение политики резервного копирования
`CreateDirectory` | Создание новой директории внутри ВМ или сервера Yandex BareMetal
`CreatePolicy` | Создание политики резервного копирования
`DeleteArchive` | Удаление архива резервной копии
`DeleteBackup` | Удаление резервной копии
`DeletePolicy` | Удаление политики резервного копирования
`DeleteResource` | Удаление ВМ или сервера BareMetal из сервиса Cloud Backup
`ExecutePolicy` | Выполнение политики резервного копирования
`InitResource` | Инициализация подключения ВМ или сервера BareMetal к сервису Cloud Backup
`RegisterResource` | Подключение ВМ или сервера BareMetal к сервису Cloud Backup завершено
`RevokePolicy` | Отзыв политики резервного копирования
`StartRecoverBackup` | Запуск восстановления ВМ или сервера BareMetal из резервной копии
`UpdatePolicy` | Изменение политики резервного копирования
`UpdateResource` | Обновление статуса подключения ВМ или сервера BareMetal к сервису Cloud Backup