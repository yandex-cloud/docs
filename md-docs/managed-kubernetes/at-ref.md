# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ managed-k8s-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.k8s.<имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

Имя события | Описание
--- | ---
`AutoUpgradeCluster` | Автообновление кластера
`AutoUpgradeNodeGroup` | Автообновление группы узлов
`CreateCluster` | Создание кластера
`CreateNodeGroup` | Создание группы узлов
`DeleteCluster` | Удаление кластера
`DeleteNodeGroup` | Удаление группы узлов
`DeleteStoppedCluster` | Удаление остановленного кластера
`InstallHelmRelease` | Установка версии Helm
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UninstallHelmRelease` | Удаление версии Helm
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateClusterCertificate` | Изменение [сертификата кластера](concepts/release-channels-and-updates.md#certificates)
`UpdateHelmRelease` | Изменение версии Helm
`UpdateNodeGroup` | Изменение группы узлов

## Справочник событий уровня сервисов {#data-plane-events}

Имя события | Описание
--- | ---
`apiserver.ApiServerApprove` | Подтверждение запроса
`apiserver.ApiServerBind` | Привязка роли
`apiserver.ApiServerCreate` | Создание ресурса
`apiserver.ApiServerDelete` | Удаление ресурса
`apiserver.ApiServerDeleteCollection` | Удаление коллекции ресурсов
`apiserver.ApiServerEscalate` | Повышение привилегий
`apiserver.ApiServerGet` | Получение информации о ресурсе
`apiserver.ApiServerHead` | Получение метаданных ресурса
`apiserver.ApiServerImpersonate` | Имперсонация
`apiserver.ApiServerList` | Получение информации о коллекции ресурсов
`apiserver.ApiServerNonstandardVerb` | Событие генерируется, если аудитный лог {{ managed-k8s-name }} содержит нестандартное значение в поле `verb`
`apiserver.ApiServerOptions` | Настройка ресурса
`apiserver.ApiServerPatch` | Изменение ресурса
`apiserver.ApiServerPost` | Создание ресурса
`apiserver.ApiServerPut` | Обновление ресурса
`apiserver.ApiServerUpdate` | Изменение запроса
`apiserver.ApiServerWatch` | Отслеживание ресурсов