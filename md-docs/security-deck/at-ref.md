# Справочник аудитных логов {{ at-full-name }}

В {{ at-name }} для {{ sd-full-name }} поддерживается отслеживание [событий уровня конфигурации](../audit-trails/concepts/format.md) (Control Plane) и [событий уровня сервисов](../audit-trails/concepts/format-data-plane.md) (Data Plane).

Общий вид значения поля `event_type` (_тип события_):

```text
{{ at-event-prefix }}.audit.securitydeck.<имя_модуля><имя_события>
```

## Справочник событий уровня конфигурации {#control-plane-events}

### Модуль Контроль конфигурации ({{ cspm-name }}) {#sd-cspm}

Имя модуля — `cspm`.

Имя события | Описание
--- | ---
`CreateScanJob` | Создание задания сканирования
`CreateScopeFilter` | Создание фильтра области действия
`DeleteScanJob` | Удаление задания сканирования
`DeleteScopeFilter` | Удаление фильтра области действия
`UpdateScanJob` | Изменение задания сканирования
`UpdateScopeFilter` | Изменение фильтра области действия

### Модуль Контроль {{ k8s }}® ({{ kspm-name }}) {#sd-kspm}

Имя модуля — `kspm`.

Имя события | Описание
--- | ---
`CreateException` | Создание исключения
`CreateProject`   | Создание проекта
`DeleteException` | Удаление исключения
`DeleteProject`   | Удаление проекта
`EnableProject`   | Включение проекта
`EnableSDProject` | Включение проекта {{ sd-name }}
`UpdateException` | Изменение параметров исключения
`UpdateProject`   | Изменение параметров проекта

### Модуль {{ alerts-name }} {#sd-alerts}

Имя модуля — `alerts`.

Имя события | Описание
--- | ---
`CreateAlertSink` | Создание приемника алертов
`DeleteAlertSink` | Удаление приемника алертов
`UpdateAlertSink` | Изменение приемника алертов

### Окружения {{ sd-name }} {#sd-orchestrator}

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

### Модуль {{ atr-name }} {#sd-access-transparency-dp}

Имя модуля — `accesstransparency`.

Имя события | Описание
--- | ---
`ComputeNodeAccess` | Подключение [модуля](concepts/access-transparency.md) {{ atr-name }} к [подкластеру](../data-proc/concepts/index.md#resources) {{ dataproc-name }}
`MDBClusterAccess` | Подключение модуля {{ atr-name }} к кластеру базы данных

### Модуль Контроль конфигурации ({{ cspm-name }}) {#sd-cspm-dp}

Имя модуля — `cspm`.

Имя события | Описание
--- | ---
`AssetFailedRuleCheck` | Отчет [модуля](concepts/cspm.md) {{ cspm-name }} о неудачной проверке объекта
`AssetPassedRuleCheck` | Отчет модуля {{ cspm-name }} об успешной проверке объекта
`AssetRuleCheckCouldNotBeExecuted` | Отчет модуля {{ cspm-name }} об ошибке проверки объекта
`AssetRuleCheckNoLongerInScope` | Отчет модуля {{ cspm-name }} об исключении правила из области действия

### Модуль Контроль {{ k8s }}® ({{ kspm-name }}) {#sd-kspm-dp}

Имя модуля — `kspm`.

Имя события | Описание
--- | ---
`TriggerAdmissionControl` | Срабатывание [модуля](concepts/kspm.md) {{ kspm-name }} при проверке создаваемых и изменяемых ресурсов
`TriggerRuntimeControl` | Срабатывание модуля {{ kspm-name }} при контроле безопасности рабочих нагрузок
`TriggerRuntimeProcessInfo` | Срабатывание модуля {{ kspm-name }} при получении информации о процессе

### Модуль {{ alerts-name }} {#sd-alerts-dp}

Имя модуля — `alerts`.

Имя события | Описание
--- | ---
`CreateAlert` | Создание алерта