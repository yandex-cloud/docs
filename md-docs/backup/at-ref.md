[Документация Yandex Cloud](../index.md) > [Yandex Cloud Backup](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Cloud Backup. Подробнее в разделе [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.backup.<имя_события>
```

Имя события | Описание
--- | ---
`ApplyPolicy` | Применение политики резервного копирования
`CreateBackup` | Создание резервной копии
`CreateDirectory` | Создание новой директории внутри ВМ или сервера Yandex BareMetal
`CreatePolicy` | Создание политики резервного копирования
`DeleteArchive` | Удаление архива резервной копии
`DeleteBackup` | Удаление резервной копии
`DeletePolicy` | Удаление политики резервного копирования
`DeleteResource` | Удаление [защищаемого ресурса](concepts/index.md#protected-resources) из сервиса Cloud Backup
`ExecutePolicy` | Выполнение политики резервного копирования
`InitResource` | Инициализация подключения защищаемого ресурса к сервису Cloud Backup
`RegisterResource` | Подключение защищаемого ресурса к сервису Cloud Backup завершено
`RevokePolicy` | Отзыв политики резервного копирования
`StartRecoverBackup` | Запуск восстановления защищаемого ресурса из резервной копии
`UpdatePolicy` | Изменение политики резервного копирования
`UpdateResource` | Обновление статуса подключения защищаемого ресурса к сервису Cloud Backup