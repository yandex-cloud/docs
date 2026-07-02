[Документация Yandex Cloud](../index.md) > [Yandex Audit Trails](index.md) > История изменений

# История изменений в Yandex Audit Trails

## I квартал 2026 {#q1-2026}

* Добавлены новые события для сервисов:

  {% cut "Yandex AI Studio" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `guardrails.ChangeDefaultGuardrail` | Изменение системного правила модерации
  `mcp_hub.CreateMcpGateway` | Создание MCP-сервера
  `mcp_hub.DeleteMcpGateway` | Удаление MCP-сервера
  `mcp_hub.SetMcpGatewayAccessBindings` | Назначение прав доступа для MCP-сервера
  `mcp_hub.UpdateMcpGateway` | Изменение MCP-сервера
  `mcp_hub.UpdateMcpGatewayAccessBindings` | Изменение прав доступа для MCP-сервера

  {% endcut %}

  {% cut "BareMetal" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `flowlogs.ExternalFlow` | Информация о сетевом трафике

  {% endcut %}

  {% cut "Cloud Registry" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SetArtifactAccessBindings` | Назначение прав доступа для артефакта
  `UpdateArtifactAccessBindings` | Изменение прав доступа для артефакта

  {% endcut %}

  {% cut "Compute Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateDiskPlacementGroup` | Создание группы размещения диска
  `CreatePlacementGroup` | Создание группы размещения
  `DeleteDiskPlacementGroup` | Удаление группы размещения диска
  `DeletePlacementGroup` | Удаление группы размещения
  `UpdateDiskPlacementGroup` | Изменение группы размещения диска
  `UpdatePlacementGroup` | Изменение группы размещения

  {% endcut %}
  
  {% cut "Identity and Access Management" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `awscompatibility.CreateEphemeralAccessKey` | Создание эфемерного статического ключа доступа
  `awscompatibility.CreateTemporaryAccessKey` | Создание временного ключа доступа

  {% endcut %}

  {% cut "Managed Service for Apache Kafka®" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `AlterConfigAdminApi` | Изменение конфигурации Admin API
  `CreateTopicAdminApi` | Создание топика Admin API
  `DeleteTopicAdminApi` | Удаление топика Admin API

  {% endcut %}

  {% cut "Managed Service for ClickHouse®" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных
  `DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных

  {% endcut %}

  {% cut "Managed Service for OpenSearch" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ComplianceReadEvent` | Чтение данных в рамках контроля соответствия
  `ComplianceWriteEvent` | Запись данных в рамках контроля соответствия
  `FailedLoginRestEvent` | Неудачная попытка входа через REST API
  `GrantedPrivilegesRestEvent` | Предоставление привилегий для запросов через REST API
  `GrantedPrivilegesTransportEvent` | Предоставление привилегий на транспортном уровне
  `MissingPrivilegesRestEvent` | Потеря привилегий для запросов через REST API
  `MissingPrivilegesTransportEvent` | Потеря привилегий на транспортном уровне
  `SecurityIndexAttemptTransportEvent` | Попытка доступа к индексу безопасности на транспортном уровне

  {% endcut %}

  {% cut "Apache Hive™ Metastore" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания

  {% endcut %}

  {% cut "Managed Service for Sharded PostgreSQL" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `AddClusterHosts` | Добавление новых хостов в кластер
  `BackupCluster` | Создание резервной копии
  `CreateCluster` | Создание кластера
  `DeleteBackup` | Удаление резервной копии
  `DeleteCluster` | Удаление кластера
  `DeleteClusterHosts` | Удаление хостов из кластера
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания
  `RestoreCluster` | Создание нового кластера из резервной копии
  `StartCluster` | Запуск кластера
  `StopCluster` | Остановка кластера
  `UpdateCluster` | Изменение кластера
  `UpdateClusterHosts` | Изменение хостов в кластере

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `AddClusterShards` | Добавление шардов в кластер
  `CreateDatabase` | Создание базы данных
  `CreateUser` | Создание пользователя базы данных
  `DeleteClusterShards` | Удаление шардов из кластера
  `DeleteDatabase` | Удаление базы данных
  `DeleteUser` | Удаление пользователя базы данных
  `UpdateUser` | Изменение пользователя базы данных

  {% endcut %}

  {% cut "Object Storage" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `BucketAccessBindingsUpdate` | Изменение механизма привязки доступа к бакету

  {% endcut %}

  {% cut "Security Deck" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateAlertSink` | Создание приемника алертов
  `DeleteAlertSink` | Удаление приемника алертов
  `UpdateAlertSink` | Изменение приемника алертов

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `AssetFailedRuleCheck` | Отчет [модуля](../security-deck/concepts/cspm.md) CSPM о неудачной проверке объекта
  `AssetPassedRuleCheck` | Отчет модуля CSPM об успешной проверке объекта
  `AssetRemovedFromScope` | Отчет модуля CSPM о прекращении проверок объекта
  `AssetRuleCheckCouldNotBeExecuted` | Отчет модуля CSPM об ошибке проверки объекта
  `AssetRuleCheckNoLongerInScope` | Отчет модуля CSPM об исключении правила из области действия
  `TriggerRuntimeProcessInfo` | Срабатывание модуля KSPM при получении информации о процессе

  {% endcut %}

  {% cut "Smart Web Security" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `StartLoadBalancer` | Запуск прокси-сервера
  `StopLoadBalancer` | Остановка прокси-сервера

  {% endcut %}

  {% cut "Yandex StoreDoc" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `AuthCheck` | Проверка аутентификации
  `GenericAuditEvent` | Запуск проверки базы данных
  `UserAuthentication` | Аутентификация пользователя
  `UserLogout` | Отключение пользователя от базы данных

  {% endcut %}

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `idp.branding.CreateAsset` | Загрузка ресурса для [брендирования](../organization/concepts/branding.md)
  `idp.branding.CreateBranding` | Создание брендирования
  `idp.branding.DeleteAsset` | Удаление ресурса для брендирования
  `idp.branding.DeleteBranding` | Удаление брендирования
  `idp.branding.UpdateBranding` | Изменение настроек брендирования

  {% endcut %}

  {% cut "WebSQL" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `UpdateExecutedQueryAccessBindings` | Обновление прав доступа к выполненному запросу
  `UpdateSavedQueryAccessBindings` | Обновление прав доступа к сохраненному запросу

  {% endcut %}

  {% cut "Managed Service for YDB" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `AlterTopic` | Изменение [топика](https://ydb.tech/docs/ru//concepts/glossary#topic)
  `CreateTopic` | Создание топика
  `DeleteTopic` | Удаление топика

  {% endcut %}

* Удалены события для сервисов:

  {% cut "Cloud Registry" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SetRegistryFolderAccessBindings` | Назначение прав доступа на каталог реестра
  `UpdateRegistryFolderAccessBindings` | Изменение прав доступа на каталог реестра

  {% endcut %}

## IV квартал 2025 {#q4-2025}

* Добавлена настройка сжатия потока событий при записи событий в Data Streams. Рекомендуется включать сжатие, если скорость записи более 1 МБ/с.

  Настройка сжатия доступна при [создании](operations/create-trail.md) или [изменении](operations/manage-trail.md) трейла через интерфейсы CLI, API или Terraform. Можно указать метод сжатия `GZIP` или `ZSTD`, по умолчанию сжатия нет (`RAW`).

* Добавлены новые события для сервисов:

  {% cut "Yandex AI Studio" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `tuning.StartTuning` | Запуск дообучения модели

  {% endcut %}

  {% cut "API Gateway" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `ResumeApiGateway` | Возобновление работы API-шлюза
  `StopApiGateway` | Остановка API-шлюза

  {% endcut %}

  {% cut "Cloud Registry" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RevokeDelegation` | Отзыв делегирования
  `SetupDelegation` | Настройка делегирования

  {% endcut %}

  {% cut "Cloud Video" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteWithReplaceStylePreset` | Удаление пресета плеера с заменой

  {% endcut %}

  {% cut "Compute Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `instancegroup.DisableZones` | Временное отключение зон доступности
  `instancegroup.EnableZones` | Включение зон доступности

  {% endcut %}

  {% cut "DataLens" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SetDefaultColorPalette` | Настройка цветовой палитры по умолчанию

  {% endcut %}

  {% cut "Identity and Access Management" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `credential.ApplicationLoginEvent` | Аутентификация OAuth-приложения
  `credential.RevokeSsoSession` | Завершение SSO-сессии

  {% endcut %}

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `ActivateMfaEnforcement` | Активация политики MFA
  `BindOrganizationAccessPolicy` | Привязка политики авторизации в организации
  `CreateMfaEnforcement` | Создание политики MFA
  `DeactivateMfaEnforcement` | Деактивация политики MFA
  `DeleteMfaEnforcement` | Удаление политики MFA
  `idp.RemoveUserBlock` | Удаление блокировки пользователя
  `idp.UpdateSubscriptionLimit` | Изменение лимита подписки
  `saml.UploadSignatureCertificate` | Загрузка сертификата для подписи
  `UnbindOrganizationAccessPolicy` | Отмена привязки политики авторизации в организации
  `UpdateMfaEnforcement` | Изменение политики MFA
  `UpdateMfaEnforcementAudience` | Изменение целевых пользователей политики MFA
  `UpdateOrganizationAccessPolicyBindingParameters` | Изменение параметров политики авторизации в организации
  
  {% endcut %}

  {% cut "Yandex IoT Core" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `broker.AddBrokerCertificate` | Добавление сертификата брокера
  `broker.AddBrokerPassword` | Добавление пароля брокера
  `broker.CreateBroker` | Создание брокера
  `broker.DeleteBroker` | Удаление брокера
  `broker.DeleteBrokerCertificate` | Удаление сертификата брокера
  `broker.DeleteBrokerPassword` | Удаление пароля брокера
  `broker.UpdateBroker` | Изменение брокера
  `devices.AddDeviceCertificate` | Добавление сертификата устройства
  `devices.AddDevicePassword` | Добавление пароля устройства
  `devices.AddRegistryCertificate` | Добавление сертификата реестра
  `devices.AddRegistryPassword` | Добавление пароля реестра
  `devices.DeleteDeviceCertificate` | Удаление сертификата устройства
  `devices.DeleteDevicePassword` | Удаление пароля устройства
  `devices.DeleteRegistryCertificate` | Удаление сертификата реестра
  `devices.DeleteRegistryPassword` | Удаление пароля реестра

  {% endcut %}


  {% cut "Managed Service for Apache Airflow™" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания

  {% endcut %}

  {% cut "Managed Service for Apache Spark™" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания

  {% endcut %}

  {% cut "Managed Service for ClickHouse®" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetDatabase` | Получение информации о базе данных
  `GetUser` | Получение информации о пользователе
  `ListDatabases` | Получение списка баз данных
  `ListUsers` | Получение списка пользователей

  {% endcut %}

  {% cut "Yandex MPP Analytics for PostgreSQL" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateResourceGroup` | Создание ресурсной группы
  `CreateUser` | Создание пользователя базы данных
  `DeleteResourceGroup` | Удаление ресурсной группы
  `DeleteUser` | Удаление пользователя базы данных
  `UpdateResourceGroup` | Изменение ресурсной группы
  `UpdateUser` | Изменение пользователя базы данных

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateHBARule` | Создание правила аутентификации
  `CreatePXFDatasource` | Создание подключения к внешней таблице
  `DeleteHBARule` | Удаление правила аутентификации
  `DeletePXFDatasource` | Удаление подключения к внешней таблице
  `ListPXFDatasources` | Получение списка подключений к внешней таблице
  `ListUsers` | Получение списка пользователей базы данных
  `UpdateHBARule` | Изменение правила аутентификации
  `UpdatePXFDatasource` | Изменение подключения к внешней таблице

  {% endcut %}

  {% cut "Managed Service for MySQL®" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetDatabase` | Получение информации о базе данных
  `GetUser` | Получение информации о пользователе
  `ListDatabases` | Получение списка баз данных
  `ListUsers` | Получение списка пользователей

  {% endcut %}

  {% cut "Managed Service for PostgreSQL" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetDatabase` | Получение информации о базе данных
  `GetUser` | Получение информации о пользователе базы данных
  `ListDatabases` | Получение списка баз данных
  `ListUsers` | Получение списка пользователей базы данных

  {% endcut %}

  {% cut "Managed Service for Trino" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания

  {% endcut %}

  {% cut "Yandex Managed Service for Valkey™" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseConnectionClose` | Закрытие подключения к базе данных
  `DatabaseConnectionOpen` | Открытие подключения к базе данных
  `DatabaseUserLogin` | Вход пользователя в базу данных

  {% endcut %}

  {% cut "Message Queue" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateMessageQueue` | Создание очереди сообщений
  `DeleteMessageQueue` | Удаление очереди сообщений
  `UpdateMessageQueue` | Изменение очереди сообщений

  {% endcut %}

  {% cut "Resource Manager" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `BindCloudAccessPolicy` | Привязка политики авторизации в облаке
  `BindFolderAccessPolicy` | Привязка политики авторизации в каталоге
  `UnbindCloudAccessPolicy` | Отмена привязки политики авторизации в облаке
  `UnbindFolderAccessPolicy` | Отмена привязки политики авторизации в каталоге
  `UpdateCloudAccessPolicyBindingParameters` | Изменение параметров политики авторизации в облаке
  `UpdateFolderAccessPolicyBindingParameters` | Изменение параметров политики авторизации в каталоге

  {% endcut %}

  {% cut "Security Deck" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `CreateAlert` | Создание алерта
  `TriggerAdmissionControl` | Срабатывание [модуля](../security-deck/concepts/kspm.md) KSPM при проверке создаваемых и изменяемых ресурсов
  `TriggerRuntimeControl` | Срабатывание модуля KSPM при контроле безопасности рабочих нагрузок

  [События уровня конфигурации](concepts/format.md):

  Имя события | Описание
  --- | ---
  `CreateConnector` | Создание коннектора
  `CreateException` | Создание исключения
  `CreateProject` | Создание проекта
  `CreateScanJob` | Создание задания сканирования
  `CreateScope` | Создание области действия
  `CreateScopeFilter` | Создание фильтра области
  `CreateWorkspace` | Создание окружения
  `DeleteConnector` | Удаление коннектора
  `DeleteException` | Удаление исключения
  `DeleteProject` | Удаление проекта
  `DeleteScanJob` | Удаление задания сканирования
  `DeleteScope` | Удаление области действия
  `DeleteScopeFilter` | Удаление фильтра области действия
  `DeleteWorkspace` | Удаление окружения
  `EnableProject` | Включение проекта
  `EnableSDProject` | Включение проекта Security Deck
  `UpdateConnector` | Изменение коннектора
  `UpdateException` | Изменение параметров исключения
  `UpdateProject` | Изменение параметров проекта
  `UpdateScanJob` | Изменение задания сканирования
  `UpdateScope` | Изменение области действия
  `UpdateScopeFilter` | Изменение фильтра области действия
  `UpdateWorkspace` | Изменение окружения

  {% endcut %}

  {% cut "Yandex StoreDoc" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetDatabase` | Получение информации о базе данных
  `GetUser` | Получение информации о пользователе
  `ListDatabases` | Получение списка баз данных
  `ListUsers` | Получение списка пользователей

  {% endcut %}

  {% cut "YTsaurus" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateCluster` | Создание кластера
  `DeleteCluster` | Удаление кластера
  `StartCluster` | Запуск кластера
  `StopCluster` | Остановка кластера
  `UpdateCluster` | Изменение кластера
  `UpdateClusterGroupMembers` | Изменение участников группы кластера

  {% endcut %}

* Переименованы события для сервисов:

  {% cut "Message Queue" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateQueue` стало `CreateMessageQueue` | Создание очереди сообщений
  `DeleteQueue` стало `DeleteMessageQueue` | Удаление очереди сообщений
  `UpdateQueue` стало `UpdateMessageQueue` | Изменение очереди сообщений

  {% endcut %}

С 1 декабря 2025 года события `DisableTenantBilling` и `EnableTenantBilling` сервиса DataLens не доставляются в связи с прекращением действия [тарифа Business](../datalens/pricing.md).

## III квартал 2025 {#q3-2025}

Добавлены новые события для сервисов:

  {% cut "AI Studio" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CancelBatchInference` | Остановка работы модели в пакетном режиме
  `DeleteBatchInference` | Удаление результата обработки в пакетном режиме
  `StartBatchInference` | Запуск модели в пакетном режиме

  {% endcut %}
  
  {% cut "BareMetal" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteServer` | Полное удаление сервера BareMetal, очистка дисков и всех пользовательских данных

  {% endcut %}
  
  {% cut "Cloud CDN" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `gcore.RawLogsActivate` | Включение выгрузки логов
  `gcore.RawLogsDeactivate` | Отключение выгрузки логов
  `gcore.RawLogsUpdate` | Изменение параметров выгрузки логов

  {% endcut %}

  {% cut "Cloud Desktop" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CopyDesktopImage` | Создание образа рабочего стола с помощью копирования образа Compute Cloud
  `CopyDesktopImageFromDesktop` | Создание образа рабочего стола с помощью копирования образа существующего рабочего стола
  `DeleteDesktopImage` | Удаление образа рабочего стола
  `SetDesktopGroupAccessBindings` | Назначение прав доступа к группе рабочих столов
  `StartDesktop` | Запуск рабочего стола
  `StopDesktop` | Остановка рабочего стола
  `UpdateDesktop` | Изменение рабочего стола
  `UpdateDesktopGroup` | Изменение группы рабочих столов
  `UpdateDesktopGroupAccessBindings` | Изменение прав доступа к группе рабочих столов
  `UpdateDesktopImage` | Изменение образа рабочего стола
  `UpdateDesktopProperties ` | Изменение свойств рабочего стола

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GenerateDesktopRDPFile` | Генерация RDP-файла для подключения к рабочему столу
  `ResetDesktopPassword` | Сброс пароля рабочего стола

  {% endcut %}

  {% cut "DataLens" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SwitchAiAssistantProhibition` | Изменение запрета на использование Нейроаналитика

  {% endcut %}
  
  {% cut "DataSphere" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateCluster` | Создание кластера Apache Spark™
  `DeleteCluster` | Удаление кластера Apache Spark™
  `StartCluster` | Запуск кластера Apache Spark™
  `StopCluster` | Остановка кластера Apache Spark™
  `UpdateCluster` | Изменение кластера Apache Spark™
  
  {% endcut %}

  {% cut "Identity and Access Management" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `mfa.CreateUserCredential` | Создание учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)
  `mfa.DeleteUserCredential` | Удаление учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)
  `mfa.UpdateUserCredential` | Изменение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `mfa.VerifyUserCredential` | Подтверждение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../organization/concepts/mfa.md)

  {% endcut %}

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `idp.ChangeOneTimePassword` | Изменение одноразового пароля
  `idp.ConvertUserToExternal` | Назначение пользователю признака синхронизации из внешнего каталога
  `saml.ReactivateFederatedUserAccounts` | Активация федеративного пользователя
  `saml.SuspendFederatedUserAccounts` | Деактивация федеративного пользователя

  {% endcut %}

  {% cut "Network Load Balancer" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DisableNetworkLoadBalancerZones` | Отключение зоны доступности 
  `EnableNetworkLoadBalancerZones` | Включение зоны доступности

  {% endcut %}

  {% cut "Object Storage" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `BucketLoggingUpdate` | Изменение механизма логирования действий с бакетом
  `BucketObjectLockUpdate` | Изменение настроек блокировки версии объекта в бакете

  {% endcut %}

  {% cut "Smart Web Security" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateMatchList` | Создание списка адресов
  `DeleteMatchList` | Удаление списка адресов
  `UpdateMatchList` | Изменение списка адресов

  {% endcut %}

  {% cut "Virtual Private Cloud" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateIpfix` | Резервирование фиксированного IP-адреса
  `DeleteIpfix` | Удаление фиксированного IP-адреса
  `ExternalFlow` | Исходящий сетевой трафик

  {% endcut %}

## II квартал 2025 {#q2-2025}

* Добавлены новые события для сервисов:

  {% cut "Application Load Balancer" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CancelZonalShift` | Остановка процесса вывода трафика из какой-либо зоны доступности
  `StartZonalShift` | Запуск процесса вывода трафика из какой-либо зоны доступности

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `LoadbalancerHTTPAccessLog` | Логирование HTTP-запросов
  `LoadbalancerTCPAccessLog` | Логирование TCP-запросов

  {% endcut %}

  {% cut "BareMetal" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `ApplyUpdatePrivateCloudConnection` | Применение изменений приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `CreateImage` | Создание загрузочного образа
  `CreatePrivateCloudConnection` | Создание [приватного соединения](../baremetal/concepts/private-network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
  `CreatePublicSubnet` | Создание [публичной подсети](../baremetal/concepts/public-network.md)
  `DeleteImage` | Удаление загрузочного образа
  `DeletePrivateCloudConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `DeletePublicSubnet` | Удаление публичной подсети
  `UpdateImage` | Изменение загрузочного образа
  `UpdatePrivateCloudConnection` | Изменение приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `UpdatePublicSubnet` | Изменение публичной подсети

  {% endcut %}

  {% cut "Certificate Manager" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetExCertificateContent` | Получение содержимого истекшего SSL-сертификата

  {% endcut %}

  {% cut "Cloud Video" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateStylePreset` | Создание пресета плеера
  `DeleteStylePreset` | Удаление пресета плеера
  `UpdateStylePreset` | Изменение пресета плеера

  {% endcut %}

  {% cut "Compute Cloud" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса
  `MigrateInstance` | [Динамическая миграция](../compute/concepts/live-migration.md) ВМ ^*^

  \* В аудитный лог попадают события только для ВМ с настроенной [политикой обслуживания](../compute/concepts/maintenance-policies.md).

  {% endcut %}

  {% cut "DataLens" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SwitchDataExportProhibition` | Изменение запрета на экспорт данных
  `SwitchWorkbookFileExportProhibition` | Изменение запрета на экспорт файлов из воркбука

  {% endcut %}

  {% cut "AI Studio" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `TextProcessing` | Обработка текста
  `GetTextProcessingResult` | Получение результатов обработки текста

  {% endcut %}

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `idp.AddUserpoolDomain` | Привязка домена к пулу пользователей
  `idp.CreateUser` | Создание локального пользователя
  `idp.CreateUserpool` | Создание пула пользователей
  `idp.DeleteUser` | Удаление локального пользователя
  `idp.DeleteUserpool` | Удаление пула пользователей
  `idp.DeleteUserpoolDomain` | Удаление привязки домена к пулу пользователей
  `idp.ReactivateUser` | Активация локального пользователя
  `idp.SetUserPassword` | Установка пароля локального пользователя
  `idp.SetUserpoolAccessBindings` | Назначение прав доступа к пулу пользователей
  `idp.SuspendUser` | Деактивация локального пользователя
  `idp.UpdateUser` | Изменение локального пользователя
  `idp.UpdateUserpool` | Изменение пула пользователей
  `idp.UpdateUserpoolAccessBindings` | Изменение прав доступа к пулу пользователей
  `idp.ValidateUserpoolDomain` | Валидация домена, привязываемого к пулу пользователей
  `oauth.CreateApplication` | Создание OIDC-приложения
  `oauth.DeleteApplication` | Удаление OIDC-приложения
  `oauth.ReactivateApplication` | Активация OIDC-приложения
  `oauth.SetApplicationAccessBindings` | Назначение прав доступа к OIDC-приложению
  `oauth.SuspendApplication` | Деактивация OIDC-приложения
  `oauth.UpdateApplication` | Изменение OIDC-приложения
  `oauth.UpdateApplicationAccessBindings` | Изменение прав доступа к OIDC-приложению
  `oauth.UpdateApplicationAssignments` | Изменение списка пользователей OIDC-приложения
  `saml.CreateApplication` | Создание SAML-приложения
  `saml.CreateSignatureCertificate` | Создание сертификата для подписи
  `saml.DeleteApplication` | Удаление SAML-приложения
  `saml.DeleteFederationDomain` | Удаление домена
  `saml.DeleteSignatureCertificate` | Удаление сертификата для подписи
  `saml.ReactivateApplication` | Активация SAML-приложения
  `saml.SetApplicationAccessBindings` | Назначение прав доступа к SAML-приложению
  `saml.SuspendApplication` | Приостановка SAML-приложения
  `saml.UpdateApplication` | Изменение SAML-приложения
  `saml.UpdateApplicationAccessBindings` | Изменение прав доступа к SAML-приложению
  `saml.UpdateApplicationAssignments` | Изменение списка пользователей SAML-приложения
  `saml.UpdateSignatureCertificate` | Изменение сертификата для подписи

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `idp.AuthenticateByPassword` | Аутентификация по паролю

  {% endcut %}

  {% cut "Identity and Access Management" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `credential.CreateRefreshTokenForSubject` | Создание [refresh-токена](../iam/concepts/authorization/refresh-token.md) для пользователя
  `credential.RevokeRefreshTokenForSubject` | Отзыв refresh-токена у пользователя

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `oauthclient.CreateOAuthClient` | Создание OAuth-клиента
  `oauthclient.CreateOAuthClientSecret` | Создание секрета для OAuth-клиента
  `oauthclient.DeleteOAuthClient` | Удаление OAuth-клиента
  `oauthclient.DeleteOAuthClientSecret` | Удаление секрета для OAuth-клиента
  `oauthclient.UpdateOAuthClient` | Обновление OAuth-клиента

  {% endcut %}

  {% cut "Managed Service for ClickHouse®" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateClusterExtension` | Создание расширения
  `DeleteClusterExtension` | Удаление расширения
  `UpdateClusterExtension` | Изменение расширения

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `SetClusterExtensions` | Установка расширений для кластера

  {% endcut %}
  
  {% cut "Managed Service for Kubernetes" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateClusterCertificate` | Изменение [сертификата кластера](../managed-kubernetes/concepts/release-channels-and-updates.md#certificates)

  {% endcut %}

  {% cut "Managed Service for Trino" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  `CreateCatalog` | Создание каталога
  `CreateCluster` | Создание кластера
  `DeleteCatalog` | Удаление каталога
  `DeleteCluster` | Удаление кластера
  `StartCluster` | Запуск кластера
  `StopCluster` | Остановка кластера
  `UpdateCatalog` | Изменение каталога
  `UpdateCluster` | Изменение кластера

  {% endcut %}
  
  {% cut "Message Queue" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateQueue` | Создание очереди сообщений
  `DeleteQueue` | Удаление очереди сообщений
  `UpdateQueue` | Изменение очереди сообщений

  {% endcut %}

  {% cut "SpeechKit" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `stt.GetRecognition` | Запрос на получение результатов асинхронного распознавания речи
  `stt.RecognizeSpeechAsync` | Запрос на асинхронное для распознавание речи
  `stt.RecognizeSpeechStream` | Запрос на потоковое распознавание речи
  `tts.UtteranceSynthesis` | Запрос на синтез речи

  {% endcut %}

  {% cut "Smart Web Security" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateDomain` | Создание домена
  `CreateLoadBalancer` | Создание прокси-сервера
  `DeleteDomain` | Удаление домена
  `DeleteLoadBalancer` | Удаление прокси-сервера
  `UpdateDomain` | Изменение домена
  `UpdateLoadBalancer` | Изменение прокси-сервера

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `SWSMatchedRequest` | Срабатывание правила профиля безопасности

  {% endcut %}

  {% cut "Translate" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `TranslateText` | Запрос на перевод текста

  {% endcut %}
  
  {% cut "Vision OCR" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `RecognizeText` | Запрос на распознавание текста
  `GetRecognition` | Запрос на получение распознанного результата

  {% endcut %}

  {% cut "Вики" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `InviteActivate` | Активация приглашения
  `InviteDelete` | Удаление приглашения
  `InviteReactivate` | Повторная отправка приглашения
  `InviteRemoveAccess` | Отмена доступа по приглашению
  `InviteRemoveAllAccesses` | Отмена доступа по всем приглашениям
  `InviteUse` | Использование приглашения

  {% endcut %}

* Переименованы события для сервисов:

  {% cut "BareMetal" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateExternalConnection` стало `CreatePrivateCloudConnection` | Создание [приватного соединения](../baremetal/concepts/private-network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
  `DeleteExternalConnection` стало `DeletePrivateCloudConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  
  {% endcut %}

  {% cut "Message Queue" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateQueue` стало `CreateMessageQueue` | Создание очереди сообщений
  `DeleteQueue` стало `DeleteMessageQueue` | Удаление очереди сообщений
  `UpdateQueue` стало `UpdateMessageQueue` | Изменение очереди сообщений

  {% endcut %}

## I квартал 2025 {#q1-2025}

* Добавлены новые события для сервисов:

  {% cut "BareMetal" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `BatchCreateServer` | Аренда одновременно нескольких [серверов](../baremetal/concepts/servers.md) BareMetal
  `CreateExternalConnection` | Создание [приватного соединения](../baremetal/concepts/private-network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
  `CreatePrivateSubnet` | Создание [приватной подсети](../baremetal/concepts/private-network.md#private-subnet)
  `CreateServer` | Аренда сервера BareMetal
  `CreateVRF` | Создание [виртуального сегмента сети](../baremetal/concepts/private-network.md#vrf-segment) (VRF)
  `DeleteExternalConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `DeletePrivateSubnet` | Удаление приватной подсети
  `DeleteVRF` | Удаление виртуального сегмента сети (VRF)
  `PowerOffServer` | Выключение питания сервера BareMetal
  `PowerOnServer` | Включение питания сервера BareMetal
  `RebootServer` | Перезапуск сервера BareMetal
  `RegisterServerBackupAgent` | Регистрация [агента](../backup/concepts/agent.md) Yandex Cloud Backup на сервере BareMetal
  `ReinstallServer` | Переустановка операционной системы сервера BareMetal
  `StartServerProlongation` | Включение автопродления аренды сервера BareMetal
  `StopServerProlongation` | Выключение автопродления аренды сервера BareMetal
  `UpdatePrivateSubnet` | Изменение приватной подсети
  `UpdateServer` | Изменение сервера BareMetal
  `UpdateVRF` | Изменение виртуального сегмента сети (VRF)

  {% endcut %}

  {% cut "Cloud Backup" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteArchive` | Удаление архива резервной копии

  {% endcut %}

  {% cut "Cloud CDN" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `gcore.ResourceDelete` | Удаление ресурса
  `gcore.ResourceRuleCreate` | Создание правила Rewrite
  `gcore.ResourceRuleDelete` | Удаление правила Rewrite
  `gcore.ResourceRuleUpdate` | Изменение правила Rewrite

  {% endcut %}

  {% cut "DataSphere" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateFilestore` | Создание файлового хранилища
  `CreateModel` | Создание [модели](../datasphere/concepts/models/index.md)
  `CreateS3Connector` | Создание [коннектора S3](../datasphere/concepts/s3-connector.md)
  `CreateSecret` | Создание [секрета](../datasphere/concepts/secrets.md)
  `CreateSparkConnector` | Создание [коннектора Spark](../datasphere/concepts/spark-connector.md)
  `CreateYandexDataProcessing` | Создание [шаблона Yandex Data Processing](../datasphere/concepts/data-processing-template.md)
  `DeleteFilestore` | Удаление файлового хранилища
  `DeleteModel` | Удаление модели
  `DeleteS3Connector` | Удаление коннектора S3
  `DeleteSecret` | Удаление секрета
  `DeleteSparkConnector` | Удаление коннектора Spark
  `DeleteYandexDataProcessing` | Удаление шаблона Yandex Data Processing
  `UpdateFilestore` | Изменение файлового хранилища
  `UpdateModel` | Изменение модели
  `UpdateS3Connector` | Изменение коннектора S3
  `UpdateSecret` | Изменение секрета
  `UpdateSparkConnector` | Изменение коннектора Spark
  `UpdateYandexDataProcessing` | Изменение шаблона Yandex Data Processing

  {% endcut %}

  {% cut "Cloud Desktop" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateDesktop` | Создание рабочего стола
  `CreateDesktopGroup` | Создание группы рабочих столов
  `DeleteDesktop` | Удаление рабочего стола
  `DeleteDesktopGroup` | Удаление группы рабочих столов
  `RestartDesktop` | Перезагрузка рабочего стола

  {% endcut %}

  {% cut "Cloud Video" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `BatchDeleteChannels` | Удаление группы каналов
  `BatchDeleteEpisodes` | Удаление группы эпизодов
  `BatchDeletePlaylists` | Удаление группы плейлистов
  `BatchDeleteStreamLines` | Удаление группы линий трансляций
  `BatchDeleteStreams` | Удаление группы трансляций
  `BatchDeleteVideos` | Удаление группы видео
  `CreateChannel` | Создание канала
  `CreateEpisode` | Создание эпизода
  `CreatePlaylist` | Создание плейлиста
  `CreateStream` | Создание трансляции
  `CreateStreamLine` | Создание линии трансляции
  `CreateSubtitle` | Создание субтитров
  `CreateThumbnail` | Создание обложки
  `CreateVideo` | Создание видео
  `DeleteChannel` | Удаление канала
  `DeleteEpisode` | Удаление эпизода
  `DeletePlaylist` | Удаление плейлиста
  `DeleteStream` | Удаление трансляции
  `DeleteStreamLine` | Удаление линии трансляции
  `DeleteSubtitle` | Удаление субтитров
  `DeleteThumbnail` | Удаление обложки
  `DeleteVideo` | Удаление видео
  `EpisodePerformAction` | Выполнение действий с эпизодом
  `SetChannelAccessBindings` | Назначение прав доступа на канал
  `StreamLinePerformAction` | Выполнение действий с линией трансляции
  `StreamLineUpdateStreamKey` | Изменение ключа потока линии трансляции
  `StreamPerformAction` | Выполнение действий с трансляцией
  `TranscodeVideo` | Транскодирование видео
  `UpdateChannel` | Изменение канала
  `UpdateChannelAccessBindings` | Изменение прав доступа на канал
  `UpdateEpisode` | Изменение эпизода
  `UpdatePlaylist` | Изменение плейлиста
  `UpdateStream` | Изменение трансляции
  `UpdateStreamLine` | Изменение линии трансляции
  `UpdateVideo` | Изменение видео
  `VideoPerformAction` | Выполнение действий с видео

  {% endcut %}

  {% cut "Compute Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateReservedInstancePool` | Создание пула резервов ВМ
  `DeleteReservedInstancePool` | Удаление пула резервов ВМ
  `UpdateReservedInstancePool` | Изменение пула резервов ВМ

  {% endcut %}

  {% cut "Identity and Access Management" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `RevokeLeakedCredential` | Отзыв скомпрометированного секрета
  `workload.oidc.SetFederationAccessBindings` | Назначение прав доступа федерации сервисных аккаунтов
  `workload.oidc.UpdateFederationAccessBindings` | Изменение прав доступа федерации сервисных аккаунтов

  {% endcut %}
  
  {% cut "Managed Service for ClickHouse®" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RestartClusterHosts` | Перезапуск хостов кластера

  {% endcut %}

  {% cut "Managed Service for GitLab" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateRunner` | Создание GitLab Runner
  `DeleteRunner` | Удаление GitLab Runner
  `StartRunner` | Запуск GitLab Runner
  `StopRunner` | Остановка GitLab Runner
  `UpdateRunner` | Изменение GitLab Runner

  {% endcut %}

  {% cut "Managed Service for Kubernetes" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
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
  `UpdateHelmRelease` | Изменение версии Helm
  `UpdateNodeGroup` | Изменение группы узлов

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
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
  `apiserver.ApiServerNonstandardVerb` | Событие генерируется, если аудитный лог Managed Service for Kubernetes содержит нестандартное значение в поле `verb`
  `apiserver.ApiServerOptions` | Настройка ресурса
  `apiserver.ApiServerPatch` | Изменение ресурса
  `apiserver.ApiServerPost` | Создание ресурса
  `apiserver.ApiServerPut` | Обновление ресурса
  `apiserver.ApiServerUpdate` | Изменение запроса
  `apiserver.ApiServerWatch` | Отслеживание ресурсов
  
  {% endcut %}

  {% cut "Managed Service for OpenSearch" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RestartOpenSearch` | Перезапуск кластера
  `SwitchMaster` | Смена лидера кворума хостов с ролью `MANAGER`

  {% endcut %}

  {% cut "Yandex Managed Service for Valkey™" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateUser` | Создание пользователя в кластере
  `DeleteUser` | Удаление пользователя из кластера
  `UpdateUser` | Обновление пользователя в кластере

  {% endcut %}

  {% cut "Virtual Private Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreatePrivateEndpoint` | Создание сервисного подключения
  `DeletePrivateEndpoint` | Удаление сервисного подключения
  `UpdatePrivateEndpoint` | Изменение сервисного подключения

  {% endcut %}

  {% cut "Yandex Cloud Billing" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `BillingAccountCreate` | Создание платежного аккаунта
  `BillingAccountUpdate` | Изменение платежного аккаунта

  {% endcut %}

  {% cut "Yandex Lockbox" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetPayload` | Факт доступа к содержимому секрета
  `GetPayloadEx` | Факт доступа к содержимому секрета по каталогу или имени

  {% endcut %}

  {% cut "Yandex MetaData Hub" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateCluster` | Создание [кластера](../metadata-hub/concepts/metastore.md) Apache Hive™ Metastore
  `DeleteCluster` | Удаление кластера Apache Hive™ Metastore
  `StartCluster` | Запуск кластера Apache Hive™ Metastore
  `StopCluster` | Остановка кластера Apache Hive™ Metastore
  `UpdateCluster` | Изменение кластера Apache Hive™ Metastore

  {% endcut %}

* Удалены события для сервисов:

  {% cut "Managed Service for Kubernetes" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ApiServerAuditEvent` | Событие аудита кластера Managed Service for Kubernetes

  {% endcut %}

## IV квартал 2024 {#q4-2024}

Добавлены новые события для сервисов:

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `AttachRegion` | Подключение региона

  {% endcut %}

  {% cut "DataSphere" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `ActivateDataset` | Активация датасета
  `ActivateDocker` | Применение Docker-образа для проекта
  `CreateDataset` | Создание датасета
  `CreateDocker` | Создание Docker-образа
  `DeactivateDataset` | Деактивация датасета
  `DeleteDataset` | Удаление датасета
  `DeleteDocker` | Удаление Docker-образа

  {% endcut %}

  {% cut "Managed Service for OpenSearch" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "Object Storage " %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `PresignURLCreate` | Создание подписанной ссылки

  {% endcut %}


## III квартал 2024 {#q3-2024}

* Добавлена возможность фильтрации по типам событий. Подробнее в разделе [Настройки трейла](concepts/trail.md#trail-settings).
* Добавлены новые события для сервисов:

  {% cut "Certificate Manager" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `GetCertificateContent` | Получение содержимого SSL-сертификата

  {% endcut %}

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteFederatedUserAccounts` | Удаление пользователя из федерации

  {% endcut %}

  {% cut "DataSphere" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CloseProject` | Закрытие проекта
  `CreateNode` | Создание ноды
  `DeleteNode` | Удаление ноды
  `OpenProject` | Открытие проекта
  `ResumeNode` | Возобновление работы ноды
  `SuspendNode` | Приостановка работы ноды
  `UpdateNode` | Изменение ноды

  {% endcut %}

  {% cut "Identity and Access Management" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `workload.CreateFederatedCredential` | Создание [привязки](../iam/concepts/workload-identity.md#federated-credentials) в федерации сервисных аккаунтов
  `workload.DeleteFederatedCredential` | Удаление привязки из федерации сервисных аккаунтов
  `workload.oidc.CreateFederation` | Создание [федерации сервисных аккаунтов](../iam/concepts/workload-identity.md)
  `workload.oidc.DeleteFederation` | Удаление федерации сервисных аккаунтов
  `workload.oidc.UpdateFederation` | Изменение федерации сервисных аккаунтов

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `RevokeIamToken` | Отзыв IAM-токена

  {% endcut %}

  {% cut "Load Testing" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateRegressionDashboard` | Создание дашборда регрессий
  `DeleteRegressionDashboard` | Удаление дашборда регрессий
  `UpdateRegressionDashboard` | Изменение дашборда регрессий

  {% endcut %}

  {% cut "Managed Service for Apache Airflow™" %}

  [События уровня конфигурации](concepts/format.md):

  Имя события | Описание
  --- | ---
  `CreateCluster` | Создание кластера
  `DeleteCluster` | Удаление кластера
  `StartCluster` | Запуск кластера
  `StopCluster` | Остановка кластера
  `UpdateCluster` | Изменение кластера

  {% endcut %}

  {% cut "Managed Service for ClickHouse®" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `AddClusterShard` | Добавление шарда в кластер
  `DeleteClusterShard` | Удаление шарда из кластера

  {% endcut %}

  {% cut "Yandex MPP Analytics for PostgreSQL" %}

  [События уровня конфигурации](concepts/format.md):

  Имя события | Описание
  --- | ---
  `MoveCluster` | Перемещение кластера

  {% endcut %}

  {% cut "Managed Service for Kubernetes" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ApiServerAuditEvent` | Событие аудита кластера Managed Service for Kubernetes

  {% endcut %}

  {% cut "Managed Service for MySQL®" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных

  {% endcut %}

  {% cut "Security Deck" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ComputeNodeAccess` | Подключение [модуля](../security-deck/concepts/access-transparency.md) Access Transparency к [подкластеру](../data-proc/concepts/index.md#resources) Yandex Data Processing
  `MDBClusterAccess` | Подключение модуля Access Transparency к кластеру базы данных

  {% endcut %}

  {% cut "Smart Web Security" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateArlProfile` | Создание профиля ARL
  `CreateSecurityProfile` | Создание профиля безопасности
  `CreateWafProfile` | Создание профиля WAF
  `DeleteArlProfile` | Удаление профиля ARL
  `DeleteSecurityProfile` | Удаление профиля безопасности
  `DeleteWafProfile` | Удаление профиля WAF
  `UpdateArlProfile` | Изменение профиля ARL
  `UpdateSecurityProfile` | Изменение профиля безопасности
  `UpdateWafProfile` | Изменение профиля WAF

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `ArlMatchedRequest` | Запрос по правилам ARL
  `WafMatchedExclusionRule` | Примененное правило исключения WAF
  `WafMatchedRule` | Примененное правило WAF

  {% endcut %}

  {% cut "Yandex Cloud Postbox" %}

  [События уровня конфигурации](concepts/format.md):

  Имя события | Описание
  --- | ---
  `CreateConfigurationSet` | Создание [конфигурации](../postbox/concepts/glossary.md#configuration)
  `CreateIdentity` | Создание адреса
  `DeleteConfigurationSet` | Удаление конфигурации
  `DeleteIdentity` | Удаление адреса
  `UpdateConfigurationSet` | Изменение конфигурации
  `UpdateIdentity` | Изменение адреса

  {% endcut %}

## II квартал 2024 {#q2-2024}

* Добавлены новые события для сервисов:

  {% cut "API Gateway" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SetApiGatewayAccessBindings` | Назначение привязок прав доступа к API-шлюзу
  `UpdateApiGatewayAccessBindings` | Изменение привязок прав доступа к API-шлюзу

  {% endcut %}

  {% cut "Cloud Backup" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `InitResource` | Инициализация подключения ВМ к сервису Cloud Backup
  `UpdateResource`| Обновление статуса подключения ВМ к сервису Cloud Backup

  {% endcut %}

  {% cut "Certificate Manager" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SetCertificateAccessBindings` | Назначение привязок прав доступа для сертификата
  `SetDomainPrimaryCertificate` | Назначение домену основного сертификата

  {% endcut %}

  {% cut "Compute Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `AttachInstanceNetworkInterface` | Подключение сетевого интерфейса
  `DetachInstanceNetworkInterface` | Отключение сетевого интерфейса

  {% endcut %}

  {% cut "DataSphere" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CloneJob` | Клонирование задания
  `UpdateJobDataTtl` | Изменение времени жизни данных задания

  {% endcut %}

  {% cut "Cloud Functions" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `mdbproxy.SetProxyAccessBindings` | Назначение привязок прав доступа к управляемой базе данных
  `mdbproxy.UpdateProxyAccessBindings` | Изменение привязок прав доступа к управляемой базе данных
  `triggers.PauseTrigger` | Остановка триггера
  `triggers.ResumeTrigger` | Запуск триггера

  {% endcut %}

  {% cut "Identity and Access Management" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `SetServiceAccountAccessBindings` | Назначение привязок прав доступа для сервисного аккаунта

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateIamToken` | Создание IAM-токена
  `oslogin.CheckSshPolicy` | Проверка прав на подключение по SSH при доступе по OS Login
  `oslogin.GenerateSshCertificate` | Генерация SSH-сертификата для доступа по OS Login

  {% endcut %}

  {% cut "Managed Service for ClickHouse®" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "Managed Service for GitLab" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `FinishMigration` | Завершение процесса миграции инстанса в другую зону доступности
  `PrepareBackupUpload` | Подготовка к восстановлению из резервной копии
  `RollbackMigration` | Отмена процесса миграции инстанса в другую зону доступности
  `StartMigration` | Запуск процесса миграции инстанса в другую зону доступности

  {% endcut %}

  {% cut "Managed Service for PostgreSQL" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserSQLRequest`| SQL-запрос пользователя к базе данных

  {% endcut %}

  {% cut "Yandex Managed Service for Valkey™" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `EnableClusterSharding` | Включение шардирования кластера

  {% endcut %}

  {% cut "Cloud Marketplace" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `ActivateSubscriptionAutoRenewal` | Активация автоматического продления подписки
  `CancelSubscriptionAutoRenewal` | Отмена автоматического продления подписки

  {% endcut %}

  {% cut "SpeechSense" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateProject` | Создание проекта
  `CreateSpace` | Создание пространства
  `DeleteProject` | Удаление проекта
  `DeleteSpace` | Удаление пространства
  `SetProjectAccessBindings` | Назначение привязок прав доступа к проекту
  `SetSpaceAccessBindings` | Назначение привязок прав доступа к пространству
  `UpdateProject` | Изменение проекта
  `UpdateProjectAccessBindings` | Изменение привязок прав доступа к проекту
  `UpdateSpace` | Изменение пространства
  `UpdateSpaceAccessBindings` | Изменение привязок прав доступа к пространству

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateTalksReport` | Создание отчета о диалоге
  `GetTalk` | Получение диалога
  `GetTalkAudio` | Получение аудиозаписи диалога
  `SearchTalks` | Поиск диалога
  `UploadTalkToConnection` | Загрузка диалога в подключение

  {% endcut %}

  {% cut "WebSQL" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateSavedQuery` | Сохранение запроса
  `DeleteExecutedQuery` | Удаление выполненного запроса
  `DeleteSavedQuery` | Удаление сохраненного запроса
  `EditSavedQuery` | Редактирование сохраненного запроса
  `PublishExecutedQuery` | Публикация выполненного запроса
  `PublishSavedQuery` | Публикация сохраненного запроса

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `Execute` | Выполнение запроса
  `GenerateSql` | Генерация запроса
  `GetDatabaseStructure` | Получение структуры базы данных

  {% endcut %}

  {% cut "Вики" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `AccessRequestCreate` | Создание запроса доступа к странице
  `AccessRequestProcess` | Обработка запроса доступа к странице
  `AttachmentCreate` | Загрузка файла на страницу
  `AttachmentDelete` | Удаление файла со страницы
  `AuthorRoleRequestCreate` | Создание запроса на добавление в авторы страницы
  `AuthorRoleRequestProcess` | Обработка запроса на добавление в авторы страницы
  `BookmarkCreate` | Добавление в избранное
  `BookmarkDelete` | Удаление из избранного
  `BookmarkTagsCreate` | Создание тегов для избранного
  `BookmarkTagsDelete` | Удаление тегов для избранного
  `BookmarkUpdate` | Обновление тегов для страницы в избранном
  `ClusterMove` | Перемещение кластера страниц
  `CommentCreate` | Создание комментария
  `CommentDelete` | Удаление комментария
  `CommentUpdate` | Обновление комментария
  `GridAddColumns` | Добавление столбцов в динамическую таблицу
  `GridAddRows` | Добавление строк в динамическую таблицу
  `GridClone` | Создание копии динамической таблицы
  `GridCreate` | Создание новой динамической таблицы
  `GridDelete` | Удаление динамической таблицы
  `GridImport` | Импорт динамической таблицы из файла
  `GridMoveColumns` | Перемещение столбца динамической таблицы
  `GridMoveRows` | Перемещение строки динамической таблицы
  `GridRemoveColumns` | Удаление столбцов динамической таблицы
  `GridRemoveRows` | Удаление строк в динамической таблице
  `GridRollback` | Отмена изменений в динамической таблице
  `GridUpdate` | Обновление динамической таблицы
  `GridUpdateCells` | Обновление ячеек в динамической таблице
  `GridUpdateColumn` | Обновление столбца в динамической таблице
  `GridUpdateRow` | Обновление строки в динамической таблице
  `PageChangeOrder` | Изменение порядка страницы
  `PageChangeToYFM` | Конвертирование страницы в новый редактор
  `PageClone` | Создание копии страницы
  `PageCreate` | Создание страницы
  `PageDelete` | Удаление страницы
  `PageImport` | Импорт страницы из файла
  `PageRecover` | Восстановление удаленной страницы
  `PageUpdate`| Обновление страницы
  `RecoveryTokenDelete` | Удаление токена для восстановления страницы
  `SubscriberDelete` | Удаление подписчика
  `SubscribersAdd` | Добавление подписчиков
  `SubscriptionAdd` | Добавление подписки
  `SubscriptionDelete` | Удаление подписки

  {% endcut %}

* Поле `impersonator_info` в блоке `authentication` было заменено на поле `token_info`.

## I квартал 2024 {#q1-2024}

* Добавлены новые события для сервисов:

  {% cut "Certificate Manager" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateDomainAccessBindings` | Изменение прав доступа для домена

  {% endcut %}

  {% cut "Cloud Apps" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateCloudApplication` | Создание приложения
  `DeleteCloudApplication` | Удаление приложения
  `UpdateCloudApplication` | Изменение приложения

  {% endcut %}

  {% cut "Cloud DNS" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdatePrivateNetworks` | Изменение приватных сетей

  {% endcut %}

  {% cut "Cloud Logging" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `ChangeLogGroupAccessBindings` | Изменение прав доступа для лог-группы
  `CreateExport` | Создание выгрузки логов
  `CreateLogGroup` | Создание лог-группы
  `CreateSink` | Создание приемника логов
  `UpdateLogGroup` | Изменение лог-группы
  `DeleteExport` | Удаление выгрузки логов
  `DeleteLogGroup` | Удаление лог-группы
  `DeleteSink` | Удаление приемника логов
  `SetExportAccessBindings` | Назначение прав доступа для выгрузки логов
  `SetLogGroupAccessBindings` | Назначение прав доступа для лог-группы
  `SetSinkAccessBindings` | Назначение прав доступа для приемника логов
  `UpdateExport` | Изменение выгрузки логов
  `UpdateExportAccessBindings` | Изменение прав доступа для выгрузки логов
  `UpdateLogGroupAccessBindings` | Изменение прав доступа для лог-группы
  `UpdateSink` | Изменение приемника логов
  `UpdateSinkAccessBindings` | Изменение прав доступа для приемника логов

  {% endcut %}

  {% cut "Yandex Identity Hub" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateOsLoginProfile` | Создание профиля OS Login
  `CreateUserSshKey` | Создание SSH-ключа пользователя
  `UpdateOsLoginProfile` | Изменение профиля OS Login
  `UpdateOsLoginSettings` | Изменение настроек OS Login
  `UpdateUserSshKey` | Изменение SSH-ключа пользователя
  `SetDefaultProfile` | Назначение профиля по умолчанию
  `DeleteOsLoginProfile` | Удаление профиля OS Login
  `DeleteUserSshKey` | Удаление SSH-ключа пользователя

  {% endcut %}

  {% cut "Compute Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateHostGroup` | Создание группы выделенных хостов
  `DeleteHostGroup` | Удаление группы выделенных хостов
  `UpdateHostGroup` | Изменение группы выделенных хостов
  `serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса

  {% endcut %}

  {% cut "Key Management Service" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Отмена удаления асимметричной ключевой пары шифрования
  `asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Отмена удаления ключевой пары электронной подписи

  {% endcut %}

  {% cut "Load Testing" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateAgent` | Создание агента
  `CreateConfig` | Создание конфигурации
  `CreateMigration` | Создание миграции
  `CreateTest` | Создание теста
  `DeleteAgent` | Удаление агента
  `DeleteConfig` | Удаление конфигурации
  `DeleteTest` | Удаление теста
  `RestartAgent` | Перезапуск агента
  `StartAgent` | Запуск агента
  `StopAgent` | Остановка агента
  `StopTest` | Остановка теста
  `UpdateAgent` | Изменение агента
  `UpdateTest` | Изменение теста
  `UpgradeImageAgent` | Обновление образа агента

  {% endcut %}

  {% cut "Managed Service for GitLab" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateInstanceBackup` | Создание резервной копии инстанса
  `ReconfigureGitlab` | Изменение конфигурации GitLab
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания
  `ScheduleUpgrade` | Назначение времени обновления инстанса

  {% endcut %}

  {% cut "Managed Service for ClickHouse®" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateClusterExternalDictionary` | Изменение внешнего словаря

  {% endcut %}


  {% cut "Yandex MPP Analytics for PostgreSQL" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateHBARule` | Создание правила аутентификации пользователей
  `CreatePXFDatasource` | Создание подключения к внешней таблице
  `DeleteBackup` | Удаление резервной копии
  `DeleteHBARule` | Удаление правила аутентификации пользователей
  `DeletePXFDatasource` | Удаление подключения к внешней таблице
  `UpdateHBARule` | Изменение правила аутентификации пользователей
  `UpdatePXFDatasource` | Изменение подключения к внешней таблице

  {% endcut %}

  {% cut "Yandex StoreDoc" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "Managed Service for MySQL®" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных

  {% endcut %}

  {% cut "Managed Service for OpenSearch" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `MoveCluster` | Перемещение кластера
  `UpdateDashboardsNodeGroup` | Изменение группы хостов типа `Dashboards`

  {% endcut %}

  {% cut "Managed Service for PostgreSQL" %}

  [События уровня сервисов](concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных
  `StartClusterFailover` | Запуск переключения мастера для кластера

  {% endcut %}

  {% cut "Trino" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateCatalog` | Создание каталога
  `CreateCluster` | Создание кластера
  `DeleteCatalog` | Удаление каталога
  `DeleteCluster` | Удаление кластера
  `StartCluster` | Запуск кластера
  `StopCluster` | Остановка кластера
  `UpdateCatalog` | Изменение каталога
  `UpdateCluster` | Изменение кластера

  {% endcut %}

  {% cut "Virtual Private Cloud" %}

  [События уровня конфигурации](concepts/format.md):

  Событие | Описание
  --- | ---
  `RelocateSubnet` | Перемещение облачной подсети в другую зону доступности

  {% endcut %}

* Исправлена ошибка, из-за которой события поставлялись с задержкой, когда трейл находился в статусе `Error`.

* Изменен механизм доставки событий управления базами данных и пользователями внутри баз данных от сервисов Yandex Managed Service for PostgreSQL, Yandex Managed Service for MySQL® и Yandex StoreDoc. Теперь они относятся к [событиям уровня сервисов](concepts/format-data-plane.md).