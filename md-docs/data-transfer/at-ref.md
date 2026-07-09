[Документация Yandex Cloud](../index.md) > [Yandex Data Transfer](index.md) > Аудитные логи Audit Trails

# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Data Transfer. Подробнее на странице [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.datatransfer.<имя_события>
```

Имя события | Описание
--- | ---
`AddTablesToTransfer` | Добавление таблиц в трансфер
`ActivateTransfer` | Активация трансфера
`CreateEndpoint` | Создание эндпоинта
`CreateTransfer` | Создание трансфера
`DeactivateTransfer` | Деактивация трансфера
`DeleteEndpoint` | Удаление эндпоинта
`DeleteTransfer` | Удаление трансфера
`FreezeTransferVersion` | Фиксация для трансфера определенной версии
`RestartTransfer` | Перезапуск трансфера
`PauseTransfer` | Приостановка трансфера
`RemoveTablesFromTransfer` | Удаление таблиц из трансфера
`ReUploadTransfer` | Повторная загрузка трансфера
`StartTransfer` | Запуск трансфера
`TestTransfer` | Тестирование трансфера
`UnfreezeTransferVersion` | Разрешение обновления трансфера до последней версии
`UpdateEndpoint` | Изменение эндпоинта
`UpdateTransfer` | Изменение трансфера
`UpdateTransferVersion` | Обновление версии трансфера
`UploadTransfer` | Загрузка трансфера