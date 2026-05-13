# Справочник аудитных логов Yandex Audit Trails

В Audit Trails для Yandex Security Deck поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.securitydeck.<имя_модуля><имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

### Модуль Контроль конфигурации (CSPM) {#sd-cspm}

Имя модуля — `cspm`.

Имя события | Описание
--- | ---
`CreateScanJob` | Создание задания сканирования
`CreateScopeFilter` | Создание фильтра области действия
`DeleteScanJob` | Удаление задания сканирования
`DeleteScopeFilter` | Удаление фильтра области действия
`UpdateScanJob` | Изменение задания сканирования
`UpdateScopeFilter` | Изменение фильтра области действия

### Модуль Контроль Kubernetes® (KSPM) {#sd-kspm}

Имя модуля — `kspm`.

Имя события | Описание
--- | ---
`CreateException` | Создание исключения
`CreateProject`   | Создание проекта
`DeleteException` | Удаление исключения
`DeleteProject`   | Удаление проекта
`EnableProject`   | Включение проекта
`EnableSDProject` | Включение проекта Security Deck
`UpdateException` | Изменение параметров исключения
`UpdateProject`   | Изменение параметров проекта

### Модуль Алерты {#sd-alerts}

Имя модуля — `alerts`.

Имя события | Описание
--- | ---
`CreateAlertSink` | Создание приемника алертов
`DeleteAlertSink` | Удаление приемника алертов
`UpdateAlertSink` | Изменение приемника алертов

### Окружения Security Deck {#sd-orchestrator}

Имя модуля — `orchestrator`.

Имя события | Описание
--- | ---
`CreateConnector` | Создание [коннектора](concepts/workspace.md#connectors)
`CreateScope` | Создание области действия
`CreateWorkspace` | Создание [окружения](concepts/workspace.md)
`DeleteConnector` | Удаление коннектора
`DeleteScope` | Удаление области действия
`DeleteWorkspace` | Удаление окружения
`UpdateConnector` | Изменение коннектора
`UpdateScope` | Изменение области действия
`UpdateWorkspace` | Изменение окружения

## Справочник событий уровня сервисов {#data-plane-events}

### Модуль Access Transparency {#sd-access-transparency-dp}

Имя модуля — `accesstransparency`.

Имя события | Описание
--- | ---
`ComputeNodeAccess` | Подключение [модуля](concepts/access-transparency.md) Access Transparency к [подкластеру](../data-proc/concepts/index.md#resources) Yandex Data Processing
`MDBClusterAccess` | Подключение модуля Access Transparency к кластеру базы данных

### Модуль Контроль конфигурации (CSPM) {#sd-cspm-dp}

Имя модуля — `cspm`.

Имя события | Описание
--- | ---
`AssetFailedRuleCheck` | Отчет [модуля](concepts/cspm.md) CSPM о неудачной проверке объекта
`AssetPassedRuleCheck` | Отчет модуля CSPM об успешной проверке объекта
`AssetRuleCheckCouldNotBeExecuted` | Отчет модуля CSPM об ошибке проверки объекта
`AssetRuleCheckNoLongerInScope` | Отчет модуля CSPM об исключении правила из области действия

### Модуль Контроль Kubernetes® (KSPM) {#sd-kspm-dp}

Имя модуля — `kspm`.

Имя события | Описание
--- | ---
`TriggerAdmissionControl` | Срабатывание [модуля](concepts/kspm.md) KSPM при проверке создаваемых и изменяемых ресурсов
`TriggerRuntimeControl` | Срабатывание модуля KSPM при контроле безопасности рабочих нагрузок
`TriggerRuntimeProcessInfo` | Срабатывание модуля KSPM при получении информации о процессе

### Модуль Алерты {#sd-alerts-dp}

Имя модуля — `alerts`.

Имя события | Описание
--- | ---
`CreateAlert` | Создание алерта