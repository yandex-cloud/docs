# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ cloud-desktop-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.clouddesktop.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`CopyDesktopImage` | Создание образа рабочего стола с помощью копирования образа {{ compute-name }}
`CopyDesktopImageFromDesktop` | Создание образа рабочего стола с помощью копирования образа существующего рабочего стола
`CreateDesktop` | Создание рабочего стола
`CreateDesktopGroup` | Создание группы рабочих столов
`DeleteDesktop` | Удаление рабочего стола
`DeleteDesktopGroup` | Удаление группы рабочих столов
`DeleteDesktopImage` | Удаление образа рабочего стола
`RestartDesktop` | Перезагрузка рабочего стола
`SetDesktopGroupAccessBindings` | Назначение прав доступа к группе рабочих столов
`StartDesktop` | Запуск рабочего стола
`StopDesktop` | Остановка рабочего стола
`UpdateDesktop` | Изменение рабочего стола
`UpdateDesktopGroup` | Изменение группы рабочих столов
`UpdateDesktopGroupAccessBindings` | Изменение прав доступа к группе рабочих столов
`UpdateDesktopImage` | Изменение образа рабочего стола
`UpdateDesktopProperties ` | Изменение свойств рабочего стола

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`GenerateDesktopRDPFile` | Генерация RDP-файла для подключения к рабочему столу
`ResetDesktopPassword` | Сброс пароля рабочего стола