# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} поддерживается отслеживание событий уровня конфигурации (Control Plane) для {{ container-registry-full-name }}. Подробнее см. [{#T}](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.containerregistry.<имя_события>
```

Имя события | Описание
--- | ---
`CreateImage` | Создание Docker-образа
`CreateImageTag` | Создание тега Docker-образа
`CreateLifecyclePolicy` | Создание политики автоматического удаления Docker-образов
`CreateRegistry` | Создание реестра
`CreateRepository` | Создание репозитория
`CreateScanPolicy` | Создание политики сканирования
`DeleteImage` | Удаление Docker-образа
`DeleteImageTag` | Удаление тега Docker-образа
`DeleteLifecyclePolicy` | Удаление политики автоматического удаления Docker-образов
`DeleteRegistry` | Удаление реестра
`DeleteRepository` | Удаление репозитория
`DeleteScanPolicy` | Удаление политики сканирования
`ScanImage` | Сканирование Docker-образа
`UpdateIpPermission` | Изменение политики доступа к реестру
`UpdateLifecyclePolicy` | Изменение политики автоматического удаления Docker-образов
`UpdateRegistry` | Изменение реестра
`UpdateScanPolicy` | Изменение политики сканирования
`UpdateRegistryAccessBindings` | Изменение прав доступа на реестр  
`UpdateRepositoryAccessBindings` | Изменение прав доступа на репозиторий
`SetRegistryAccessBindings`  | Назначение прав доступа на реестр
`SetRepositoryAccessBindings` | Назначение прав доступа на репозиторий