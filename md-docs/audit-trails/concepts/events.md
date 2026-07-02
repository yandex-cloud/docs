[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > Справочник событий уровня конфигурации

# Справочник событий уровня конфигурации

Значение поля `event_type` (_тип события_) аудитного лога уровня конфигурации определяется сервисом-источником события.

Общий вид значения:

```text
yandex.cloud.audit.<имя_сервиса>.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

Ниже описаны события для сервисов:

* [Yandex API Gateway](events.md#api-gateway)
* [Yandex Application Load Balancer](events.md#alb)
* [Yandex AI Studio](events.md#ai-studio)
* [Yandex Audit Trails](events.md#audit-trails)
* [Yandex BareMetal](events.md#baremetal)
* [Yandex Certificate Manager](events.md#certificate-manager)
* [Yandex Cloud Apps](events.md#cloud-apps)
* [Yandex Cloud Backup](events.md#backup)
* [Yandex Cloud Billing](events.md#billing)
* [Yandex Cloud CDN](events.md#cdn)
* [Yandex Cloud Desktop](events.md#clouddesktop)
* [Yandex Cloud DNS](events.md#dns)
* [Yandex Cloud Functions](events.md#functions)
* [Yandex Cloud Logging](events.md#cloud-logging)
* [Yandex Cloud Marketplace](events.md#marketplace)
* [Yandex Identity Hub](events.md#organization)
* [Yandex Cloud Postbox](events.md#postbox)
* [Yandex Cloud Registry](events.md#cloud-registry)
* [Yandex Cloud Video](events.md#video)
* [Yandex Compute Cloud](events.md#compute)
* [Yandex Container Registry](events.md#container-registry)
* [Yandex Data Processing](events.md#dataproc)
* [Yandex Data Transfer](events.md#datatransfer)
* [Yandex DataLens](events.md#datalens)
* [Yandex DataSphere](events.md#datasphere)
* [Yandex Identity and Access Management](events.md#iam)
* [Yandex IoT Core](events.md#iot)
* [Yandex Key Management Service](events.md#kms)
* [Yandex Lockbox](events.md#lockbox)
* [Yandex Managed Service for Apache Airflow™](events.md#managed-service-for-airflow)
* [Yandex Managed Service for Apache Kafka®](events.md#managed-service-for-kafka)
* [Yandex Managed Service for ClickHouse®](events.md#managed-service-for-clickhouse)
* [Yandex Managed Service for GitLab](events.md#managed-service-for-gitlab)
* [Yandex MPP Analytics for PostgreSQL](events.md#managed-service-for-greenplum)
* [Yandex Managed Service for Kubernetes](events.md#managed-service-for-kubernetes)
* [Yandex StoreDoc](events.md#managed-service-for-mongodb)
* [Yandex Managed Service for MySQL®](events.md#managed-service-for-mysql)
* [Yandex Managed Service for OpenSearch](events.md#managed-service-for-opensearch)
* [Yandex Managed Service for PostgreSQL](events.md#managed-service-for-postgresql)
* [Yandex Managed Service for Sharded PostgreSQL](events.md#managed-service-for-sharded-postgresql)
* [Yandex Managed Service for Trino](events.md#managed-service-for-trino)
* [Yandex Managed Service for Apache Spark™](events.md#managed-service-for-spark)
* [Yandex Managed Service for Valkey™](events.md#managed-service-for-redis)
* [Yandex Managed Service for YDB](events.md#ydb)
* [Yandex Message Queue](events.md#ymq)
* [Yandex MetaData Hub](events.md#metadata-hub)
* [Yandex Network Load Balancer](events.md#network-load-balancer)
* [Yandex Object Storage](events.md#objstorage)
* [Yandex Query](events.md#yq)
* [Yandex Managed Service for YTsaurus](events.md#ytsaurus)
* [Yandex Resource Manager](events.md#resmgr)
* [Yandex Search API](events.md#searchapi)
* [SourceCraft](events.md#sourcecraft)
* [Yandex Security Deck](events.md#security-deck)
* [Yandex Serverless Containers](events.md#serverless-containers)
* [Yandex SmartCaptcha](events.md#smartcaptcha)
* [Yandex Smart Web Security](events.md#smartwebsecurity)
* [Yandex SpeechSense](events.md#speechsense)
* [Yandex Virtual Private Cloud](events.md#vpc)
* [Yandex WebSQL](events.md#websql)

## Yandex API Gateway {#api-gateway}

Имя сервиса — `serverless.apigateway`.

Имя события | Описание
--- | ---
`AddDomain` | Подключение домена
`CreateApiGateway` | Создание API-шлюза
`DeleteApiGateway` | Удаление API-шлюза
`DeleteDomain` | Отключение домена
`ResumeApiGateway` | Возобновление работы API-шлюза
`SetApiGatewayAccessBindings` | Назначение прав доступа к API-шлюзу
`StopApiGateway` | Остановка API-шлюза
`UpdateApiGateway` | Изменение API-шлюза
`UpdateApiGatewayAccessBindings` | Изменение прав доступа к API-шлюзу

## Yandex Application Load Balancer {#alb}

Имя сервиса — `apploadbalancer`.

Имя события | Описание
--- | ---
`AddBackendGroupBackend` | Добавление бэкенда в группу бэкендов
`AddLoadBalancerListener` | Добавление обработчика в балансировщик
`AddLoadBalancerSniMatch` | Добавление SNI-обработчика в балансировщик
`AddTargetGroupTargets` | Добавление [ВМ](../../glossary/vm.md) в целевую группу
`CancelZonalShift` | Остановка процесса вывода трафика из какой-либо зоны доступности
`CreateBackendGroup` | Создание группы бэкендов
`CreateHttpRouter` | Создание HTTP-роутера
`CreateLoadBalancer` | Создание балансировщика
`CreateTargetGroup` | Создание целевой группы
`CreateVirtualHost` | Создание виртуального хоста
`DeleteBackendGroup` | Удаление группы бэкендов
`DeleteHttpRouter` | Удаление HTTP-роутера
`DeleteLoadBalancer` | Удаление балансировщика
`DeleteTargetGroup` | Удаление целевой группы
`DeleteVirtualHost` | Удаление виртуального хоста
`RemoveBackendGroupBackend` | Удаление бэкенда из группы бэкендов
`RemoveLoadBalancerListener` | Удаление обработчика из балансировщика
`RemoveLoadBalancerSniMatch` | Удаление SNI-обработчика из балансировщика
`RemoveTargetGroupTargets` | Удаление ВМ из целевой группы
`RemoveVirtualHostRoute` | Удаление маршрута виртуального хоста
`StartLoadBalancer` | Запуск балансировщика
`StartZonalShift` | Запуск процесса вывода трафика из какой-либо зоны доступности
`StopLoadBalancer` | Остановка балансировщика
`UpdateBackendGroup` | Изменение группы бэкендов
`UpdateBackendGroupBackend` | Изменение бэкенда в группе бэкендов
`UpdateHttpRouter` | Изменение HTTP-роутера
`UpdateLoadBalancer` | Изменение балансировщика
`UpdateLoadBalancerListener` | Изменение обработчика в балансировщике
`UpdateLoadBalancerSniMatch` | Изменение SNI-обработчика в балансировщике
`UpdateTargetGroup` | Изменение целевой группы
`UpdateVirtualHost` | Изменение виртуального хоста
`UpdateVirtualHostRoute` | Изменение маршрута виртуального хоста

## Yandex AI Studio {#ai-studio}

Имя сервиса — `ai`.

Имя события | Описание
--- | ---
`batch_inference.CancelBatchInference` | Остановка работы модели в пакетном режиме
`batch_inference.DeleteBatchInference` | Удаление результата обработки в пакетном режиме
`batch_inference.StartBatchInference` | Запуск модели в пакетном режиме
`dedicated_instance.CreateDedicatedInstance` | Создание [выделенного инстанса](https://aistudio.yandex.ru/docs/ru//ai-studio/concepts/generation/dedicated-instance)
`dedicated_instance.DeleteDedicatedInstance` | Удаление выделенного инстанса
`dedicated_instance.StartDedicatedInstance` | Запуск выделенного инстанса
`dedicated_instance.StopDedicatedInstance` | Остановка выделенного инстанса
`dedicated_instance.UpdateDedicatedInstance` | Изменение выделенного инстанса
`guardrails.CreateDictionary` | Создание [словаря](https://aistudio.yandex.ru/docs/ru//ai-studio/concepts/security/guardrails#dictionaries) фраз и регулярных выражений в [правиле модерации](https://aistudio.yandex.ru/docs/ru//ai-studio/concepts/security/guardrails#rules)
`guardrails.CreateGuardrail` | Создание правила модерации
`guardrails.DeleteDictionary` | Удаление словаря фраз и регулярных выражений из правила модерации
`guardrails.DeleteGuardrail` | Удаление правила модерации
`guardrails.SetBinding` | Применение правила модерации для инстанса
`guardrails.UnsetBinding` | Отключение правила модерации от инстанса
`guardrails.UpdateDictionary` | Изменение словаря фраз и регулярных выражений в правиле модерации
`guardrails.UpdateDictionaryItems` | Изменение состава элементов словаря фраз и регулярных выражений в правиле модерации
`guardrails.UpdateGuardrail` | Изменение правила модерации
`mcp_hub.CreateMcpGateway` | Создание MCP-сервера
`mcp_hub.DeleteMcpGateway` | Удаление MCP-сервера
`mcp_hub.SetMcpGatewayAccessBindings` | Назначение прав доступа для MCP-сервера
`mcp_hub.UpdateMcpGateway` | Изменение MCP-сервера
`mcp_hub.UpdateMcpGatewayAccessBindings` | Изменение прав доступа для MCP-сервера
`tuning.CancelTuning` | Остановка [дообучения](https://aistudio.yandex.ru/docs/ru//ai-studio/concepts/tuning/index) модели
`tuning.StartTuning` | Запуск дообучения модели

## Yandex Audit Trails {#audit-trails}

Имя сервиса — `audittrails`.

Имя события | Описание
--- | ---
`CreateTrail` | Создание трейла
`DeleteTrail` | Удаление трейла
`SetTrailAccessBindings` | Назначение прав доступа для трейла
`UpdateTrail` | Изменение трейла
`UpdateTrailAccessBindings` | Изменение прав доступа для трейла

## Yandex BareMetal {#baremetal}

Имя сервиса — `baremetal`.

Имя события | Описание
--- | ---
`ApplyUpdatePrivateCloudConnection` | Применение измений приватного соединения с подсетями в VPC или в on-prem инфраструктуре
`BatchCreateServer` | Аренда одновременно нескольких [серверов](../../baremetal/concepts/servers.md) BareMetal
`CreateImage` | Создание загрузочного образа
`CreatePrivateCloudConnection` | Создание [приватного соединения](../../baremetal/concepts/private-network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
`CreatePrivateSubnet` | Создание [приватной подсети](../../baremetal/concepts/private-network.md#private-subnet)
`CreatePublicPrefixPool` | Создание пула публичных префиксов
`CreatePublicSubnet` | Создание [публичной подсети](../../baremetal/concepts/public-network.md)
`CreateServer` | Аренда сервера BareMetal
`CreateVRF` | Создание [виртуального сегмента сети](../../baremetal/concepts/private-network.md#vrf-segment) (VRF)
`DeleteImage` | Удаление загрузочного образа
`DeletePrivateCloudConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
`DeletePrivateSubnet` | Удаление приватной подсети
`DeletePublicPrefixPool` | Удаление пула публичных префиксов
`DeletePublicSubnet` | Удаление публичной подсети
`DeleteServer` | Полное удаление сервера BareMetal, очистка дисков и всех пользовательских данных
`DeleteVRF` | Удаление виртуального сегмента сети (VRF)
`PowerOffServer` | Выключение питания сервера BareMetal
`PowerOnServer` | Включение питания сервера BareMetal
`RebootServer` | Перезапуск сервера BareMetal
`RegisterServerBackupAgent` | Регистрация [агента](../../backup/concepts/agent.md) Yandex Cloud Backup на сервере BareMetal
`ReinstallServer` | Переустановка операционной системы сервера BareMetal
`StartServerProlongation` | Включение автопродления аренды сервера BareMetal
`StopServerProlongation` | Выключение автопродления аренды сервера BareMetal
`UpdateImage` | Изменение загрузочного образа
`UpdatePrivateCloudConnection` | Изменение приватного соединения с подсетями в VPC или в on-prem инфраструктуре
`UpdatePrivateSubnet` | Изменение приватной подсети
`UpdatePublicPrefixPool` | Изменение пула публичных префиксов
`UpdatePublicSubnet` | Изменение публичной подсети
`UpdateServer` | Изменение сервера BareMetal
`UpdateVRF` | Изменение виртуального сегмента сети (VRF)

## Yandex Certificate Manager {#certificate-manager}

Имя сервиса — `certificatemanager`.

Имя события | Описание
--- | ---
`CreateCertificate` | Добавление сертификата
`CreateDomain` | Добавление домена
`DeleteCertificate` | Удаление сертификата
`DeleteDomain` | Удаление домена
`SetCertificateAccessBindings` | Назначение прав доступа для сертификата
`SetDomainPrimaryCertificate` | Назначение домену основного сертификата
`UpdateCertificate` | Изменение сертификата
`UpdateCertificateAccessBindings` | Изменение прав доступа для сертификата
`UpdateDomain` | Изменение домена
`UpdateDomainAccessBindings` | Изменение прав доступа для домена

## Yandex Cloud Apps {#cloud-apps}

Имя сервиса — `cloudapps`.

Имя события | Описание
--- | ---
`CreateCloudApplication` | Создание приложения
`DeleteCloudApplication` | Удаление приложения
`SetApplicationAccessBindings` | Назначение прав доступа для приложения
`UpdateApplicationAccessBindings` | Изменение прав доступа для приложения
`UpdateCloudApplication` | Изменение приложения

## Yandex Cloud Backup {#backup}

Имя сервиса — `backup`.

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

## Yandex Cloud Billing {#billing}

Имя сервиса — `billing`.

Имя события | Описание
--- | ---
`BillingAccountCreate` | Создание платежного аккаунта
`BillingAccountUpdate` | Изменение платежного аккаунта

## Yandex Cloud CDN {#cdn}

Имя сервиса — `cdn`.

Имя события | Описание
--- | ---
`gcore.CachePrefetch` | Предзагрузка кеша
`gcore.CachePurge` | Очистка кеша
`gcore.OriginCreate` | Создание источника
`gcore.OriginDelete` | Удаление источника
`gcore.OriginGroupCreate` | Создание группы источников
`gcore.OriginGroupDelete` | Удаление группы источников
`gcore.OriginGroupUpdate` | Изменение группы источников
`gcore.OriginUpdate` | Измнение источника
`gcore.ProviderActivate` | Активация провайдера
`gcore.RawLogsActivate` | Включение выгрузки логов
`gcore.RawLogsDeactivate` | Отключение выгрузки логов
`gcore.RawLogsUpdate` | Изменение параметров выгрузки логов
`gcore.ResourceCreate` | Создание ресурса
`gcore.ResourceDelete` | Удаление ресурса
`gcore.ResourceRuleCreate` | Создание правила Rewrite
`gcore.ResourceRuleDelete` | Удаление правила Rewrite
`gcore.ResourceRuleUpdate` | Изменение правила Rewrite
`gcore.ResourceUpdate` | Изменение ресурса

## Yandex Cloud Desktop {#clouddesktop}

Имя сервиса — `clouddesktop`.

Имя события | Описание
--- | ---
`CopyDesktopImage` | Создание образа рабочего стола с помощью копирования образа Compute Cloud
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

## Yandex Cloud DNS {#dns}

Имя сервиса — `dns`.

Имя события | Описание
--- | ---
`CreateDnsInboundEndpoint` | Создание входящего эндпоинта DNS
`CreateDnsZone` | Создание зоны [DNS](../../glossary/dns.md)
`DeleteDnsInboundEndpoint` | Удаление входящего эндпоинта DNS
`DeleteDnsZone` | Удаление зоны DNS
`SetDnsInboundEndpointAccessBindings` | Назначение прав доступа к входящему эндпоинту DNS
`SetDnsZoneAccessBindings` | Назначение прав доступа к зоне DNS
`UpdateDnsInboundEndpoint` | Изменение входящего эндпоинта DNS
`UpdateDnsInboundEndpointAccessBindings` | Изменение прав доступа к входящему эндпоинту DNS
`UpdateDnsZone` | Изменение зоны DNS
`UpdateDnsZoneAccessBindings` | Изменение прав доступа к зоне DNS
`UpdatePrivateNetworks` | Изменение приватных сетей
`UpdateRecordSets` | Изменение набора записей

## Yandex Cloud Functions {#functions}

Имя сервиса — `serverless`.

Имя события | Описание
--- | ---
`functions.CreateFunction` | Создание функции
`functions.CreateFunctionVersion` | Создание версии функции
`functions.DeleteFunction` | Удаление функции
`functions.DeleteFunctionVersion` | Удаление версии функции
`functions.RemoveFunctionTag` | Удаление тега функции
`functions.RemoveScalingPolicy` | Удаление настроек масштабирования функции
`functions.SetFunctionTag` | Добавление тега функции
`functions.SetFunctionAccessBindings` | Назначение прав доступа для функции
`functions.SetScalingPolicy` | Добавление настроек масштабирования функции
`functions.UpdateFunction` | Изменение функции
`functions.UpdateFunctionAccessBindings` | Изменение прав доступа для функции
`mdbproxy.CreateProxy` | Создание подключения к управляемой базе данных
`mdbproxy.DeleteProxy` | Удаление подключения к управляемой базе данных
`mdbproxy.SetProxyAccessBindings` | Назначение прав доступа к управляемой базе данных
`mdbproxy.UpdateProxy` | Изменение подключения к управляемой базе данных
`mdbproxy.UpdateProxyAccessBindings` | Изменение прав доступа к управляемой базе данных
`triggers.CreateTrigger` | Создание триггера
`triggers.DeleteTrigger` | Удаление триггера
`triggers.PauseTrigger` | Остановка триггера
`triggers.ResumeTrigger` | Запуск триггера
`triggers.UpdateTrigger` | Изменение триггера

## Yandex Cloud Logging {#cloud-logging}

Имя сервиса — `logging`.

Имя события | Описание
--- | ---
`ChangeLogGroupAccessBindings` | Изменение прав доступа для лог-группы
`CreateExport` | Создание выгрузки логов
`CreateLogGroup` | Создание лог-группы
`CreateSink` | Создание приемника логов
`DeleteExport` | Удаление выгрузки логов
`DeleteLogGroup` | Удаление лог-группы
`DeleteSink` | Удаление приемника логов
`SetExportAccessBindings` | Назначение прав доступа для выгрузки логов
`SetLogGroupAccessBindings` | Назначение прав доступа для лог-группы
`SetSinkAccessBindings` | Назначение прав доступа для приемника логов
`UpdateExport` | Изменение выгрузки логов 
`UpdateExportAccessBindings` | Изменение прав доступа для выгрузки логов
`UpdateLogGroup` | Изменение лог-группы
`UpdateLogGroupAccessBindings` | Изменение прав доступа для лог-группы
`UpdateSink` | Изменение приемника логов
`UpdateSinkAccessBindings` | Изменение прав доступа для приемника логов

## Yandex Cloud Marketplace {#marketplace}

Имя сервиса — `marketplace.licensemanager`.

Имя события | Описание
--- | ---
`ActivateSubscriptionAutoRenewal` | Активация автоматического продления подписки
`CancelSubscriptionAutoRenewal` | Отмена автоматического продления подписки
`CreateLicenseInstance` | Покупка подписки
`DeleteLicenseInstance` | Удаление подписки
`LockLicenseInstance` | Привязка подписки
`MoveLicenseInstance` | Перемещение подписки
`UnlockLicenseInstance` | Отмена привязки подписки

## Yandex Identity Hub {#organization}

Имя сервиса — `organizationmanager`.

Имя события | Описание
--- | ---
`AcceptInvitation` | Принятие приглашения
`ActivateMfaEnforcement` | Активация политики [MFA](../../organization/concepts/mfa.md)
`AttachRegion` | Подключение региона
`BindOrganizationAccessPolicy` | Привязка политики авторизации в организации
`CreateGroup` | Создание группы пользователей
`CreateGroupMapping` | Настройка сопоставления групп федеративных пользователей
`CreateInvitations` | Создание приглашения
`CreateMembership` | Добавление пользователя в организацию
`CreateMfaEnforcement` | Создание политики MFA
`CreateOrganization` | Создание организации
`CreateOsLoginProfile` | Создание профиля OS Login
`CreateUserSshKey` | Создание SSH-ключа пользователя
`DeactivateMfaEnforcement` | Деактивация политики MFA
`DeleteGroup` | Удаление группы пользователей
`DeleteGroupMapping` | Удаление сопоставления групп федеративных пользователей
`DeleteInvitation` | Удаление приглашения
`DeleteMembership` | Удаление пользователя из организации
`DeleteMfaEnforcement` | Удаление политики MFA
`DeleteOrganization` | Удаление организации
`DeleteOsLoginProfile` | Удаление профиля OS Login
`DeleteUserSshKey` | Удаление SSH-ключа пользователя
`idp.AddUserpoolDomain` | Привязка домена к пулу пользователей
`idp.branding.CreateAsset` | Загрузка ресурса для [брендирования](../../organization/concepts/branding.md)
`idp.branding.CreateBranding` | Создание брендирования
`idp.branding.DeleteAsset` | Удаление ресурса для брендирования
`idp.branding.DeleteBranding` | Удаление брендирования
`idp.branding.UpdateBranding` | Изменение настроек брендирования
`idp.ChangeOneTimePassword` | Изменение одноразового пароля
`idp.ConvertUserToExternal` | Назначение пользователю признака синхронизации из внешнего каталога
`idp.CreateUser` | Создание локального пользователя
`idp.CreateUserpool` | Создание пула пользователей
`idp.DeleteUser` | Удаление локального пользователя
`idp.DeleteUserpool` | Удаление пула пользователей
`idp.DeleteUserpoolDomain` | Удаление привязки домена к пулу пользователей
`idp.ReactivateUser` | Активация локального пользователя
`idp.RemoveUserBlock` | Удаление блокировки пользователя
`idp.SetUserPassword` | Установка пароля локального пользователя
`idp.SetUserpoolAccessBindings` | Назначение прав доступа к пулу пользователей
`idp.SuspendUser` | Деактивация локального пользователя
`idp.UpdateSubscriptionLimit` | Изменение лимита подписки
`idp.UpdateUser` | Изменение локального пользователя
`idp.UpdateUserpool` | Изменение пула пользователей
`idp.UpdateUserpoolAccessBindings` | Изменение прав доступа к пулу пользователей
`idp.ValidateUserpoolDomain` | Валидация домена, привязываемого к пулу пользователей
`oauth.CreateApplication` | Создание [OIDC](https://openid.net/developers/how-connect-works/)-приложения
`oauth.DeleteApplication` | Удаление OIDC-приложения
`oauth.ReactivateApplication` | Активация OIDC-приложения
`oauth.SetApplicationAccessBindings` | Назначение прав доступа к OIDC-приложению
`oauth.SuspendApplication` | Деактивация OIDC-приложения
`oauth.UpdateApplication` | Изменение OIDC-приложения
`oauth.UpdateApplicationAccessBindings` | Изменение прав доступа к OIDC-приложению
`oauth.UpdateApplicationAssignments` | Изменение списка пользователей OIDC-приложения
`RejectInvitation` | Отказ от приглашения
`ResendInvitation` | Повторная отправка приглашения
`SetDefaultProfile` | Назначение профиля по умолчанию
`SetGroupAccessBindings` | Назначение прав доступа к группе пользователей
`SetOrganizationAccessBindings` | Назначение прав доступа к организации
`saml.AddFederationDomain` | Привязка [домена](../../organization/concepts/domains.md) к федерации
`saml.AddFederatedUserAccounts` | Добавление пользователя в федерацию
`saml.CreateApplication` | Создание [SAML](../../organization/concepts/add-federation.md)-приложения
`saml.CreateFederation` | Создание федерации удостоверений
`saml.CreateSignatureCertificate` | Создание сертификата для подписи
`saml.DeleteApplication` | Удаление SAML-приложения
`saml.DeleteFederation` | Удаление федерации удостоверений
`saml.DeleteFederationDomain` | Удаление домена
`saml.DeleteFederatedUserAccounts` | Удаление пользователя из федерации
`saml.DeleteSignatureCertificate` | Удаление сертификата для подписи
`saml.ReactivateApplication` | Активация SAML-приложения
`saml.ReactivateFederatedUserAccounts` | Активация федеративного пользователя
`saml.SetApplicationAccessBindings` | Назначение прав доступа к SAML-приложению
`saml.SuspendApplication` | Деактивация SAML-приложения
`saml.SuspendFederatedUserAccounts` | Деактивация федеративного пользователя
`saml.UpdateApplication` | Изменение SAML-приложения
`saml.UpdateApplicationAccessBindings` | Изменение прав доступа к SAML-приложению
`saml.UpdateApplicationAssignments` | Изменение списка пользователей SAML-приложения
`saml.UpdateFederation` | Изменение федерации удостоверений
`saml.UpdateSignatureCertificate` | Изменение сертификата для подписи
`saml.UploadSignatureCertificate` | Загрузка сертификата для подписи
`saml.ValidateFederationDomain` | Валидация домена, привязываемого к федерации 
`UnbindOrganizationAccessPolicy` | Отмена привязки политики авторизации в организации
`UpdateGroup` | Изменение группы пользователей
`UpdateGroupAccessBindings` | Изменение прав доступа к группе пользователей
`UpdateGroupMapping` | Изменение сопоставления групп федеративных пользователей
`UpdateGroupMembers` | Изменение состава участников группы пользователей
`UpdateMfaEnforcement` | Изменение политики MFA
`UpdateMfaEnforcementAudience` | Изменение целевых пользователей политики MFA
`UpdateOrganization` | Изменение организации
`UpdateOrganizationAccessBindings` | Изменение прав доступа к организации
`UpdateOrganizationAccessPolicyBindingParameters` | Изменение параметров политики авторизации в организации
`UpdateOsLoginProfile` | Изменение профиля OS Login
`UpdateOsLoginSettings` | Изменение настроек OS Login
`UpdateSubscribers` | Изменение списка подписчиков
`UpdateUserSshKey` | Изменение SSH-ключа пользователя

## Yandex Cloud Postbox {#postbox}

Имя сервиса — `postbox`.

Имя события | Описание
--- | ---
`CreateConfigurationSet` | Создание [конфигурации](../../postbox/concepts/glossary.md#configuration)
`CreateIdentity` | Создание адреса
`DeleteConfigurationSet` | Удаление конфигурации
`DeleteIdentity` | Удаление адреса
`UpdateConfigurationSet` | Изменение конфигурации
`UpdateIdentity` | Изменение адреса

## Yandex Cloud Registry {#cloud-registry}

Имя сервиса — `cloudregistry`.

Имя события | Описание
--- | ---
`CreateArtifact` | Создание [артефакта](../../cloud-registry/concepts/artifacts/index.md)
`CreateRegistry` | Создание реестра
`DeleteArtifact` | Удаление артефактов
`DeleteRegistry` | Удаление реестра
`RevokeDelegation` | Отзыв прав делегирования у сервисного аккаунта для доступа к ресурсам облака
`SetArtifactAccessBindings` | Назначение прав доступа для артефакта
`SetIpPermissions` | Настройка доступа для IP-адресов
`SetRegistryAccessBindings` | Назначение прав доступа на реестр
`SetupDelegation` | Назначение прав делегирования сервисному аккаунту для доступа к ресурсам облака
`UpdateArtifact` | Изменение артефакта
`UpdateArtifactAccessBindings` | Изменение прав доступа для артефакта
`UpdateIpPermissions` | Изменение доступа для IP-адресов
`UpdateRegistry` | Изменение реестра
`UpdateRegistryAccessBindings` | Изменение прав доступа на реестр

## Yandex Cloud Video {#video}

Имя сервиса — `video`.

Имя события | Описание
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
`CreateStylePreset` | Создание шаблона плеера
`CreateSubtitle` | Создание субтитров
`CreateThumbnail` | Создание обложки
`CreateVideo` | Создание видео
`DeleteChannel` | Удаление канала
`DeleteEpisode` | Удаление эпизода
`DeletePlaylist` | Удаление плейлиста
`DeleteStream` | Удаление трансляции
`DeleteStreamLine` | Удаление линии трансляции
`DeleteStylePreset` | Удаление шаблона плеера
`DeleteWithReplaceStylePreset` | Удаление шаблона плеера с заменой на шаблон по умолчанию
`DeleteSubtitle` | Удаление субтитров
`DeleteThumbnail` | Удаление обложки
`DeleteVideo` | Удаление видео
`DownloadEpisode` | Скачивание эпизода
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
`UpdateStylePreset` | Изменение шаблона плеера
`UpdateVideo` | Изменение видео
`VideoPerformAction` | Выполнение действий с видео

## Yandex Compute Cloud {#compute}

Имя сервиса — `compute`.

Имя события | Описание
--- | ---
`AddInstanceOneToOneNat` | Добавление публичного IP-адреса виртуальной машине
`AttachInstanceDisk` | Подключение диска к ВМ
`AttachInstanceFilesystem` | Подключение файловой системы к ВМ
`AttachInstanceNetworkInterface` | Подключение сетевого интерфейса
`ChangeDiskStatus` | Изменение статуса нереплицируемого диска
`CrashInstance` | Аварийное отключение ВМ
`CreateDisk` | Создание диска
`CreateDiskPlacementGroup` | Создание группы размещения диска
`CreateFilesystem` | Создание файловой системы
`CreateGpuCluster` | Создание кластера GPU
`CreateHostGroup` | Создание группы выделенных хостов
`CreateImage` | Создание образа диска
`CreateInstance` | Создание ВМ
`CreatePlacementGroup` | Создание группы размещения
`CreateReservedInstancePool` | Создание пула резервов ВМ
`CreateSnapshot` | Создание снимка диска
`CreateSnapshotSchedule` | Создание расписания снимков диска
`DecommissionHost` | Вывод выделенного хоста в [обслуживание](../../compute/concepts/dedicated-host.md#maintenance)
`DeleteDisk` | Удаление диска
`DeleteDiskPlacementGroup` | Удаление группы размещения диска
`DeleteFilesystem` | Удаление файловой системы
`DeleteGpuCluster` | Удаление кластера GPU
`DeleteHostGroup` | Удаление группы выделенных хостов
`DeleteImage` | Удаление образа диска
`DeleteInstance` | Удаление ВМ
`DeletePlacementGroup` | Удаление группы размещения
`DeleteReservedInstancePool` | Удаление пула резервов ВМ
`DeleteSnapshot` | Удаление снимка диска
`DeleteSnapshotSchedule` | Удаление расписания снимков диска
`DetachInstanceDisk` | Отключение диска от ВМ
`DetachInstanceFilesystem` | Отключение файловой системы от ВМ
`DetachInstanceNetworkInterface` | Отключение сетевого интерфейса
`DisableSnapshotSchedule` | Отключение расписания снимков диска
`EnableSnapshotSchedule` | Включение расписания снимков диска
`GuestStopInstance` | Остановка ВМ по команде из этой ВМ
`PreemptInstance` | Прерывание работы ВМ
`RemoveInstanceOneToOneNat` | Удаление публичного IP-адреса ВМ
`RestartInstance` | Перезагрузка ВМ
`StartInstance` | Запуск ВМ
`StopInstance` | Остановка ВМ
`UpdateDisk` | Изменение диска
`UpdateDiskPlacementGroup` | Изменение группы размещения диска
`UpdateFilesystem` | Изменение файловой системы
`UpdateGpuCluster` | Изменение кластера GPU
`UpdateHost` | Обновление [даты автоматического освобождения](../../compute/concepts/dedicated-host.md#maintenance) выделенного хоста
`UpdateHostGroup` | Изменение группы выделенных хостов
`UpdateImage` | Изменение образа диска
`UpdateInstance` | Изменение ВМ
`UpdateInstanceMetadata` | Изменение метаданных ВМ
`UpdateInstanceNetworkInterface` | Изменение сетевых настроек ВМ
`UpdatePlacementGroup` | Изменение группы размещения
`UpdateReservedInstancePool` | Изменение пула резервов ВМ
`UpdateSnapshot` | Изменение снимка диска
`UpdateSnapshotSchedule` | Изменение параметров расписания снимков диска
`UpdateSnapshotScheduleDisks` | Изменение параметров расписания снимков дисков
`instancegroup` | Управление группой ВМ
`instancegroup.CreateInstanceGroup` | Создание группы ВМ
`instancegroup.DeleteInstanceGroup` | Удаление группы ВМ
`instancegroup.DeleteInstanceGroupInstances` | Удаление ВМ из группы
`instancegroup.DisableZones` | [Временное отключение](../../compute/concepts/instance-groups/disable-enable-zone.md) зон доступности
`instancegroup.EnableZones` | Включение зон доступности
`instancegroup.PauseInstanceGroup` | Приостановка процессов управления группой ВМ
`instancegroup.ResumeInstanceGroup` | Возобновление процессов управления группой ВМ
`instancegroup.RollingRestartInstanceGroupInstances` | Поочередная перезагрузка ВМ из группы
`instancegroup.SetInstanceGroupAccessBindings` | Назначение ролей на группу ВМ
`instancegroup.StartInstanceGroup` | Запуск группы ВМ
`instancegroup.StopInstanceGroup` | Остановка группы ВМ
`instancegroup.StopInstanceGroupInstances` | Остановка ВМ из группы
`instancegroup.UpdateInstanceGroup` | Изменение группы ВМ
`instancegroup.UpdateInstanceGroupAccessBindings` | Изменение ролей для группы ВМ

## Yandex Container Registry {#container-registry}

Имя сервиса — `containerregistry`.

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

## Yandex Data Processing {#dataproc}

Имя сервиса — `dataproc`.

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`CreateSubcluster` | Создание подкластера
`DeleteCluster` | Удаление кластера
`DeleteSubcluster` | Удаление подкластера
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateSubcluster` | Изменение подкластера

## Yandex Data Transfer {#datatransfer}

Имя сервиса — `datatransfer`.

Имя события | Описание
--- | ---
`ActivateTransfer` | Активация трансфера
`CreateEndpoint` | Создание эндпоинта
`CreateTransfer` | Создание трансфера
`DeactivateTransfer` | Деактивация трансфера
`DeleteEndpoint` | Удаление эндпоинта
`DeleteTransfer` | Удаление трансфера
`FreezeTransferVersion` | Фиксация для трансфера определенной версии data plane
`RestartTransfer` | Перезапуск трансфера
`UnfreezeTransferVersion` | Разрешение обновления трансфера до последней версии data plane
`UpdateEndpoint` | Изменение эндпоинта
`UpdateTransfer` | Изменение трансфера
`UpdateTransferVersion` | Обновление версии data plane трансфера

## Yandex DataLens {#datalens}

Имя сервиса — `datalens`.

Имя события | Описание
--- | ---
`CopyEntriesToWorkbook` | Копирование объекта в [воркбук](../../datalens/workbooks-collections/index.md). Объект (`Entry`) — общее обозначение для [подключений](../../datalens/concepts/connection/index.md), [датасетов](../../datalens/dataset/index.md), [чартов](../../datalens/concepts/chart/index.md), [дашбордов](../../datalens/concepts/dashboard.md), [отчетов](../../datalens/reports/index.md) и папок
`CopyEntry` | Копирование объекта
`CopyTemplate` | Разворачивание продукта
`CopyWorkbook` | Копирование воркбука
`CreateCollection` | Создание [коллекции](../../datalens/workbooks-collections/index.md)
`CreateColorPalette` | Создание [цветовой палитры](../../datalens/operations/chart/create-palette.md)
`CreateEmbed` | Создание встраивания
`CreateEmbeddingSecret` | Создание ключа для [встраивания](../../datalens/security/embedded-objects.md)
`CreateEntityBinding` | Создание привязки [общего объекта](../../datalens/security/workbooks-access-advanced.md) в воркбуке
`CreateEntry` | Создание объекта
`CreateWorkbook` | Создание воркбука
`DeleteCollections` | Удаление коллекций
`DeleteColorPalette` | Удаление цветовой палитры
`DeleteEmbed` | Удаление встраивания
`DeleteEmbeddingSecret` | Удаление ключа для встраивания
`DeleteEntityBinding` | Удаление привязки общего объекта из воркбука
`DeleteEntry` | Удаление объекта
`DeleteSharedEntry` | Удаление общего объекта
`DeleteWorkbooks` | Удаление одного или нескольких воркбуков
`DisableBillingInstanceService` | Получение сигнала от Yandex Cloud Billing о неактивности привязанного к DataLens платежного аккаунта
`DisableFolders` | [Отключение](../../datalens/settings/navigation.md#disable-folder-navigation) навигации по папкам
`DisableTenantBilling` | Планирование отключения тарифа Business пользователем в начале следующего месяца ^1^
`EnableBillingInstanceService` | Получение сигнала от Yandex Cloud Billing об активности привязанного к DataLens [платежного аккаунта](../../billing/concepts/billing-account.md)
`EnableTenantBilling` | Включение пользователем тарифа Business ^1^
`FolderEntryBatchModifyPermissions` | Массовое изменение настроек доступа к папочным объектам
`FolderEntryModifyPermissions` | Изменение настроек доступа к папочным объектам
`MigrateEntriesToWorkbook` | Миграция объектов в воркбук
`MoveCollections` | Перемещение коллекций
`MoveEntry` | Перемещение объекта
`MoveSharedEntry` | Перемещение общего объекта
`MoveWorkbooks` | Перемещение воркбуков
`RenameEntry` | Переименование объекта
`SetDefaultColorPalette` | Настройка цветовой палитры по умолчанию
`SwitchAiAssistantProhibition` | Изменение запрета на использование Нейроаналитика
`SwitchDataExportProhibition` | Изменение запрета на экспорт данных
`SwitchEntriesPublicationStatus` | Изменение статуса публикации объекта
`SwitchPublicationProhibition` | Изменение запрета на публикацию объектов
`SwitchWorkbookFileExportProhibition` | Изменение запрета на экспорт файлов из воркбука
`UpdateCollection` | Изменение коллекции
`UpdateCollectionAccessBindings` | Изменение настроек доступа к коллекции
`UpdateColorPalette` | Изменение цветовой палитры
`UpdateEmbed` | Изменение встраивания
`UpdateEntityBinding` | Редактирование привязки общего объекта в воркбуке
`UpdateEntry` | Изменение объекта
`UpdateSharedEntryAccessBindings` | Изменение настроек доступа к общему объекту
`UpdateWorkbook` | Изменение воркбука
`UpdateWorkbookAccessBindings` | Изменение настроек доступа к воркбуку

^1^ С 1 декабря 2025 года события больше не передаются в связи с прекращением действия [тарифа Business](../../datalens/pricing-changes.md).

## Yandex DataSphere {#datasphere}

Имя сервиса — `datasphere`.

Имя события | Описание
--- | ---
`ActivateDataset` | Активация датасета
`ActivateDocker` | Применение Docker-образа для проекта
`CancelJob` | Отмена задания
`CloneJob` | Клонирование задания
`CloseProject` | Закрытие проекта
`CreateCluster` | Создание кластера Apache Spark™
`CreateCommunity` | Создание сообщества
`CreateDataset` | Создание датасета
`CreateDocker` | Создание Docker-образа
`CreateFilestore` | Создание файлового хранилища
`CreateJob` | Создание задания
`CreateModel` | Создание [модели](../../datasphere/concepts/models/index.md)
`CreateNode` | Создание ноды
`CreateProject` | Создание проекта
`CreateS3Connector` | Создание [коннектора S3](../../datasphere/concepts/s3-connector.md)
`CreateSecret` | Создание [секрета](../../datasphere/concepts/secrets.md)
`CreateSparkConnector` | Создание [коннектора Spark](../../datasphere/concepts/spark-connector.md)
`CreateYandexDataProcessing` | Создание [шаблона Yandex Data Processing](../../datasphere/concepts/data-processing-template.md)
`DeactivateDataset` | Деактивация датасета
`DeleteAllJobData` | Удаление данных всех заданий
`DeleteCluster` | Удаление кластера Apache Spark™
`DeleteCommunity` | Удаление сообщества
`DeleteDataset` | Удаление датасета
`DeleteDocker` | Удаление Docker-образа
`DeleteFilestore` | Удаление файлового хранилища
`DeleteJobData` | Удаление данных задания
`DeleteModel` | Удаление модели
`DeleteNode` | Удаление ноды
`DeleteProject` | Удаление проекта
`DeleteS3Connector` | Удаление коннектора S3
`DeleteSecret` | Удаление секрета
`DeleteSparkConnector` | Удаление коннектора Apache Spark™
`DeleteYandexDataProcessing` | Удаление шаблона Yandex Data Processing
`ExecuteJob` | Запуск выполнения задания
`OpenProject` | Открытие проекта
`ResumeNode` | Возобновление работы ноды
`SetCommunityAccessBindings` | Назначение прав доступа для сообщества
`SetProjectAccessBindings` | Назначение прав доступа для проекта
`StartCluster` | Запуск кластера Apache Spark™
`StopCluster` | Остановка кластера Apache Spark™
`SuspendNode` | Приостановка работы ноды
`UpdateCluster` | Изменение кластера Apache Spark™
`UpdateCommunity` | Изменение сообщества
`UpdateCommunityAccessBindings` | Изменение прав доступа для сообщества
`UpdateFilestore` | Изменение файлового хранилища
`UpdateJobDataTtl` | Изменение времени жизни данных задания
`UpdateModel` | Изменение модели
`UpdateNode` | Изменение ноды
`UpdateProject` | Изменение проекта
`UpdateProjectAccessBindings` | Изменение прав доступа для проекта
`UpdateS3Connector` | Изменение коннектора S3
`UpdateSecret` | Изменение секрета
`UpdateSparkConnector` | Изменение коннектора Spark
`UpdateYandexDataProcessing` | Изменение шаблона Yandex Data Processing

## Yandex Identity and Access Management {#iam}

Имя сервиса — `iam`.

Имя события | Описание
--- | ---
`CreateAccessKey` | Создание статического ключа
`CreateApiKey` | Создание API-ключа
`CreateCertificate` | Добавление сертификата для федерации
`CreateIamCookieForSubject` | Вход федеративного пользователя ^*^
`CreateKey` | Создание пары ключей для сервисного аккаунта
`CreateServiceAccount` | Создание сервисного аккаунта
`DeleteAccessKey` | Удаление статического ключа
`DeleteApiKey` | Удаление API-ключа
`DeleteCertificate` | Удаление сертификата для федерации
`DeleteKey` | Удаление пары ключей для сервисного аккаунта
`DeleteServiceAccount` | Удаление сервисного аккаунта
`DetectLeakedCredential` | Обнаружение секрета в открытом источнике
`DisableService` | Отзыв у сервиса доступа к ресурсам других сервисов в облаке
`EnableService` | Выдача сервису доступа к ресурсам других сервисов в облаке
`mfa.CreateUserCredential` | Создание учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../../organization/concepts/mfa.md)
`mfa.DeleteUserCredential` | Удаление учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../../organization/concepts/mfa.md)
`mfa.UpdateUserCredential` | Изменение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../../organization/concepts/mfa.md)
`oauthclient.CreateOAuthClient` | Создание OAuth-клиента
`oauthclient.CreateOAuthClientSecret` | Создание секрета для OAuth-клиента
`oauthclient.DeleteOAuthClient` | Удаление OAuth-клиента
`oauthclient.DeleteOAuthClientSecret` | Удаление секрета для OAuth-клиента
`oauthclient.UpdateOAuthClient` | Обновление OAuth-клиента
`ReactivateServiceAccount` | Активация сервисного аккаунта
`RevokeLeakedCredential` | Отзыв скомпрометированного секрета
`SetServiceAccountAccessBindings` | Назначение прав доступа для сервисного аккаунта
`SuspendServiceAccount` | Деактивация сервисного аккаунта
`UpdateAccessKey` | Обновление статического ключа
`UpdateApiKey` | Обновление API-ключа
`UpdateCertificate` | Обновление сертификата
`UpdateKey` | Обновление пары ключей
`UpdateServiceAccount` | Обновление сервисного аккаунта
`UpdateServiceAccountAccessBindings` | Изменение прав доступа для сервисного аккаунта
`workload.CreateFederatedCredential` | Создание [привязки](../../iam/concepts/workload-identity.md#federated-credentials) в федерации сервисных аккаунтов
`workload.DeleteFederatedCredential` | Удаление привязки из федерации сервисных аккаунтов
`workload.oidc.CreateFederation` | Создание [федерации сервисных аккаунтов](../../iam/concepts/workload-identity.md)
`workload.oidc.DeleteFederation` | Удаление федерации сервисных аккаунтов
`workload.oidc.SetFederationAccessBindings` | Назначение прав доступа федерации сервисных аккаунтов
`workload.oidc.UpdateFederation` | Изменение федерации сервисных аккаунтов
`workload.oidc.UpdateFederationAccessBindings` | Изменение прав доступа федерации сервисных аккаунтов

\* Событие попадает в аудитный лог, только если [область сбора аудитных логов](trail.md#collecting-area) трейла — `Организация`.

## Yandex IoT Core {#iot}

Имя сервиса — `iot`.

Имя события | Описание
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
`devices.CreateDevice` | Создание устройства
`devices.CreateRegistry` | Создание реестра
`devices.DeleteDevice` | Удаление устройства
`devices.DeleteDeviceCertificate` | Удаление сертификата устройства
`devices.DeleteDevicePassword` | Удаление пароля устройства
`devices.DeleteRegistry` | Удаление реестра
`devices.DeleteRegistryCertificate` | Удаление сертификата реестра
`devices.DeleteRegistryPassword` | Удаление пароля реестра
`devices.UpdateDevice` | Изменение устройства
`devices.UpdateRegistry` | Изменение реестра

## Yandex Key Management Service {#kms}

Имя сервиса — `kms`.

Имя события | Описание
--- | ---
`CancelDeleteSymmetricKey` | Отмена ранее запланированного уничтожения ключа
`CancelSymmetricKeyVersionDestruction` | Отмена ранее запланированного уничтожения версии симметричного ключа
`CreateAsymmetricEncryptionKey` | Создание асимметричной ключевой пары шифрования
`CreateAsymmetricSignatureKey` | Создание ключевой пары электронной подписи
`CreateSymmetricKey` | Создание симметричного ключа
`DeleteAsymmetricEncryptionKey` | Изменение асимметричной ключевой пары шифрования
`DeleteAsymmetricSignatureKey` | Изменение ключевой пары электронной подписи
`DeleteSymmetricKey` | Удаление симметричного ключа
`RotateSymmetricKey` | Ротация симметричного ключа
`ScheduleSymmetricKeyVersionDestruction` | Назначение срока уничтожения версии симметричного ключа
`SetAsymmetricEncryptionKeyAccessBindings` | Назначение прав доступа для асимметричной ключевой пары шифрования
`SetAsymmetricSignatureKeyAccessBindings` | Назначение прав доступа для ключевой пары электронной подписи
`SetPrimarySymmetricKeyVersion` | Выбор основной версии симметричного ключа
`SetSymmetricKeyAccessBindings` | Назначение прав доступа для симметричного ключа
`UpdateAsymmetricEncryptionKey` | Изменение асимметричной ключевой пары шифрования
`UpdateAsymmetricSignatureKey` | Изменение ключевой пары электронной подписи
`UpdateSymmetricKey` | Изменение симметричного ключа
`UpdateSymmetricKeyAccessBindings` | Изменение прав доступа для симметричного ключа
`UpdateAsymmetricEncryptionKeyAccessBindings` | Изменение прав доступа для асимметричной ключевой пары шифрования
`asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Отмена удаления асимметричной ключевой пары шифрования
`asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Отмена удаления ключевой пары электронной подписи

## Yandex Lockbox {#lockbox}

Имя сервиса — `lockbox`.

Имя события | Описание
--- | ---
`AddVersion` | Добавление версии секрета
`ActivateSecret` | Активация секрета
`CancelVersionDestruction` | Отмена ранее запланированного уничтожения версии секрета
`CreateSecret` | Создание секрета
`DeactivateSecret` | Деактивация секрета
`DeleteSecret` | Удаление секрета
`RotateSecret` | Ротация секрета
`ScheduleVersionDestruction` | Распланирование уничтожения версии секрета
`SetSecretAccessBindings` | Назначение прав доступа для секрета
`UpdateSecret` | Изменение секрета
`UpdateSecretAccessBindings` | Изменение прав доступа для секрета

## Yandex Managed Service for Apache Airflow™ {#managed-service-for-airflow}

Имя сервиса — `airflow`.

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера

## Yandex Managed Service for Apache Kafka® {#managed-service-for-kafka}

Имя сервиса — `mdb.kafka`

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`CreateConnector` | Создание коннектора
`CreateTopic` | Создание топика
`CreateUser` | Создание пользователя кластера
`DeleteCluster` | Удаление кластера
`DeleteConnector` | Удаление коннектора
`DeleteTopic` | Удаление топика
`DeleteUser` | Удаление пользователя кластера
`GrantUserPermission` | Назначение прав пользователю кластера
`MoveCluster` | Перемещение кластера
`PauseConnector` | Приостановка коннектора
`ResumeConnector` | Возобновление работы коннектора
`RevokeUserPermission` | Отзыв прав у пользователя кластера
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateConnector` | Изменение коннектора
`UpdateTopic` | Изменение топика
`UpdateUser` | Изменение пользователя кластера

## Yandex Managed Service for ClickHouse® {#managed-service-for-clickhouse}

Имя сервиса — `mdb.clickhouse`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`AddClusterShards` | Добавление нескольких шардов в кластер
`AddClusterZookeeper` | Добавление подкластера ZooKeeper в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateClusterExtension` | Создание расширения
`CreateClusterExternalDictionary` | Создание внешнего словаря
`CreateShardGroup` | Создание группы шардов
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterExtension` | Удаление расширения
`DeleteClusterExternalDictionary` | Удаление внешнего словаря
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`DeleteClusterShards` | Удаление нескольких шардов из кластера
`DeleteShardGroup` | Удаление группы шардов
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestartClusterHosts` | Перезапуск хостов кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateClusterExtension` | Изменение расширения
`UpdateClusterExternalDictionary` | Изменение внешнего словаря
`UpdateClusterHosts` | Изменение хостов в кластере
`UpdateClusterShard` | Изменение шарда в кластере
`UpdateShardGroup` | Изменение группы шардов


## Yandex Managed Service for GitLab {#managed-service-for-gitlab}

Имя сервиса — `gitlab`.

Имя события | Описание
--- | ---
`BackupInstance` | Создание резервной копии
`CleanupRegistryInstance` | Очистка Docker Registry
`CreateInstance` | Создание инстанса
`CreateInstanceBackup` | Создание резервной копии инстанса
`CreateRunner` | Создание GitLab Runner
`DeleteInstance` | Удаление инстанса
`DeleteRunner` | Удаление GitLab Runner
`FinishMigration` | Завершение процесса миграции инстанса в другую зону доступности
`PrepareBackupUpload` | Подготовка к восстановлению из резервной копии
`ReconfigureGitlab` | Изменение конфигурации GitLab
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`ResizeInstance` | Изменение размера инстанса
`RollbackMigration` | Отмена процесса миграции инстанса в другую зону доступности
`ScheduleUpgrade` | Назначение времени обновления инстанса
`StartInstance` | Запуск инстанса
`StartMigration` | Запуск процесса миграции инстанса в другую зону доступности
`StartRunner` | Запуск GitLab Runner
`StopInstance` | Остановка инстанса
`StopRunner` | Остановка GitLab Runner
`UpdateInstance` | Изменение инстанса
`UpdateOmniauthInstance` | Изменение настроек OmniAuth
`UpdateRunner` | Изменение GitLab Runner
`UpgradeInstance` | Обновление версии GitLab

## Yandex MPP Analytics for PostgreSQL {#managed-service-for-greenplum}

Имя сервиса — `mdb.greenplum`.

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`ExpandCluster` | Расширение кластера
`MoveCluster` | Перемещение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера

## Yandex Managed Service for Kubernetes {#managed-service-for-kubernetes}

Имя сервиса — `k8s`.

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
`UpdateClusterCertificate` | Изменение [сертификата кластера](../../managed-kubernetes/concepts/release-channels-and-updates.md#certificates)
`UpdateHelmRelease` | Изменение версии Helm
`UpdateNodeGroup` | Изменение группы узлов

## Yandex StoreDoc {#managed-service-for-mongodb}

Имя сервиса — `mdb.mongodb`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`EnableClusterSharding` | Включение шардирования для кластера
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`ResetupHosts` | Ресинхронизация хоста
`RestartHosts` | Перезагрузка хоста
`RestoreCluster` | Создание нового кластера из резервной копии
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StepdownHosts` | Смена мастера хоста
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру

## Yandex Managed Service for MySQL® {#managed-service-for-mysql}

Имя сервиса — `mdb.mysql`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestoreCluster` | Создание нового кластера из резервной копии
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateClusterHosts` | Изменение хостов в кластере

## Yandex Managed Service for OpenSearch {#managed-service-for-opensearch}

Имя сервиса — `mdb.opensearch`.

Имя события | Описание
--- | ---
`AddDashboardsNodeGroup` | Добавление группы хостов типа `Dashboards`
`AddOpenSearchNodeGroup` | Добавление группы хостов типа `OpenSearch`
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`DeleteBackup` | Удаление резервной копии
`DeleteDashboardsNodeGroup` | Удаление группы хостов типа `Dashboards`
`DeleteOpenSearchNodeGroup` | Удаление группы хостов типа `OpenSearch`
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestartOpenSearch` | Перезапуск кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`SwitchMaster` | Смена лидера кворума хостов с ролью `MANAGER`
`UpdateCluster` | Изменение кластера
`UpdateDashboardsNodeGroup` |  Изменение группы хостов типа `Dashboards`
`UpdateOpenSearchNodeGroup` | Изменение группы хостов типа `OpenSearch`

## Yandex Managed Service for PostgreSQL {#managed-service-for-postgresql}

Имя сервиса — `mdb.postgresql`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`MoveCluster` | Перемещение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`SetClusterAccessBindings` | Назначение прав доступа к кластеру
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterAccessBindings` | Изменение прав доступа к кластеру
`UpdateClusterHosts` | Изменение хостов в кластере

## Yandex Managed Service for Sharded PostgreSQL {#managed-service-for-sharded-postgresql}

Имя сервиса — `mdb.spqr`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов в кластере

## Yandex Managed Service for Trino {#managed-service-for-trino}

Имя сервиса — `trino`.

Имя события | Описание
--- | ---
`CreateCatalog` | Создание каталога
`CreateCluster` | Создание кластера
`DeleteCatalog` | Удаление каталога
`DeleteCluster` | Удаление кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCatalog` | Изменение каталога
`UpdateCluster` | Изменение кластера

## Yandex Managed Service for Apache Spark™ {#managed-service-for-spark}

Имя сервиса — `spark`.

Имя события | Описание
--- | ---
`RescheduleMaintenance` | Перенос запланированного технического обслуживания

## Yandex Managed Service for Valkey™ {#managed-service-for-redis}

Имя сервиса — `mdb.redis`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`EnableClusterSharding` | Включение шардирования кластера
`MoveCluster` | Перемещение кластера
`RebalanceCluster` | Перебалансировка кластера
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов кластера

## Yandex Managed Service for YDB {#ydb}

Имя сервиса — `ydb`.

Имя события | Описание
--- | ---
`AlterTopic` | Изменение [топика](https://ydb.tech/docs/ru//concepts/glossary#topic)
`BackupDatabase` | Создание [бэкапа](../../glossary/backup.md) базы данных
`CreateDatabase` | Создание базы данных
`CreateTopic` | Создание топика
`DeleteBackup` | Удаление бэкапа базы данных
`DeleteDatabase` | Удаление базы данных
`DeleteTopic` | Удаление топика
`MoveDatabase` | Перемещение базы данных
`RestoreBackup` | Восстановление базы данных из бэкапа
`SetBackupAccessBindings` | Назначение прав доступа к бэкапу базы данных
`SetDatabaseAccessBindings` | Назначение прав доступа к базе данных
`StartDatabase` | Запуск базы данных
`StopDatabase` | Остановка базы данных
`UpdateBackupAccessBindings` | Изменение прав доступа к бэкапу базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateDatabaseAccessBindings` | Изменение прав доступа к базе данных

## Yandex Message Queue {#ymq}

Имя сервиса — `ymq`.

Имя события | Описание
--- | ---
`CreateMessageQueue` | Создание очереди сообщений
`DeleteMessageQueue` | Удаление очереди сообщений
`UpdateMessageQueue` | Изменение очереди сообщений

## Yandex MetaData Hub {#metadata-hub}

### Apache Hive™ Metastore {#hive-metastore}

Имя сервиса — `metastore`.

Имя события | Описание
--- | ---
`CreateCluster` | Создание [кластера](../../metadata-hub/concepts/metastore.md) Apache Hive™ Metastore
`DeleteCluster` | Удаление кластера Apache Hive™ Metastore
`RescheduleMaintenance` | Перенос запланированного технического обслуживания
`StartCluster` | Запуск кластера Apache Hive™ Metastore
`StopCluster` | Остановка кластера Apache Hive™ Metastore
`UpdateCluster` | Изменение кластера Apache Hive™ Metastore

## Yandex Network Load Balancer {#network-load-balancer}

Имя сервиса — `loadbalancer`.

Имя события | Описание
--- | ---
`AddNetworkLoadBalancerListener` | Добавление обработчика к сетевому балансировщику
`AddTargetGroupTargets` | Добавление ВМ к целевой группе
`AttachNetworkLoadBalancerTargetGroup` | Подключение целевой группы к сетевому балансировщику
`CreateNetworkLoadBalancer` | Создание сетевого балансировщика
`CreateTargetGroup` | Создание целевой группы
`DeleteNetworkLoadBalancer` | Удаление сетевого балансировщика
`DeleteTargetGroup` | Удаление целевой группы
`DetachNetworkLoadBalancerTargetGroup` | Отсоединение целевой группы от сетевого балансировщика
`DisableNetworkLoadBalancerZones` | Отключение зоны доступности 
`EnableNetworkLoadBalancerZones` | Включение зоны доступности
`RemoveNetworkLoadBalancerListener` | Удаление обработчика из сетевого балансировщика
`RemoveTargetGroupTargets` | Удаление ВМ из целевой группы
`StartNetworkLoadBalancer` | Запуск сетевого балансировщика
`StopNetworkLoadBalancer` | Остановка сетевого балансировщика
`UpdateNetworkLoadBalancer` | Изменение сетевого балансировщика
`UpdateTargetGroup` | Изменение целевой группы

## Yandex Object Storage {#objstorage}

Имя сервиса — `storage`.

Имя события | Описание
--- | ---
`BucketAccessBindingsUpdate` | Изменение механизма привязки доступа к бакету
`BucketAclUpdate` | Изменение ACL бакета
`BucketCorsUpdate` | Изменение конфигурации CORS бакета
`BucketCreate` | Создание бакета
`BucketDelete` | Удаление бакета
`BucketEncryptionUpdate` | Обновление настроек шифрования бакета
`BucketVersioningUpdate` | Обновление настроек версионирования бакета
`BucketHttpsUpdate` | Изменение HTTPS-конфигурации для бакета
`BucketLifecycleUpdate` | Изменение жизненного цикла объекта в бакете
`BucketLoggingUpdate` | Изменение механизма логирования действий с бакетом
`BucketObjectLockUpdate` | Изменение настроек блокировки версии объекта в бакете
`BucketPolicyUpdate` | Изменение политик доступа бакета
`BucketTagsUpdate` | Изменение тегов бакета
`BucketUpdate` | Изменение бакета
`BucketWebsiteUpdate` | Изменение конфигурации сайта

## Yandex Query {#yq}

Имя сервиса — `yq`.

Имя события | Описание
--- | ---
`ControlQuery` | Управление запросом
`CreateBinding` | Создание привязки к данным
`CreateConnection` | Создание соединения
`CreateQuery` | Создание запроса
`DeleteBinding` | Удаление привязки к данным
`DeleteConnection` | Удаление соединения
`DeleteQuery` | Удаление запроса
`UpdateBinding` | Изменение привязки к данным
`UpdateConnection` | Изменение соединения
`UpdateQuery` | Изменение запроса

## Yandex Managed Service for YTsaurus {#ytsaurus}

Имя сервиса — `ytsaurus`.

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterGroupMembers` | Изменение участников группы кластера

## Yandex Resource Manager {#resmgr}

Имя сервиса — `resourcemanager`.

Имя события | Описание
--- | ---
`AddCloudToOrganization` | Добавление облака в организацию
`BindCloudAccessPolicy` | Привязка политики авторизации в облаке
`BindFolderAccessPolicy` | Привязка политики авторизации в каталоге
`CreateCloud` | Создание облака
`CreateFolder` | Создание каталога
`DeleteCloud` | Удаление облака
`DeleteFolder` | Удаление каталога
`UnbindCloudAccessPolicy` | Отмена привязки политики авторизации в облаке
`UnbindFolderAccessPolicy` | Отмена привязки политики авторизации в каталоге
`UpdateCloud` | Изменение облака
`UpdateCloudAccessBindings` | Изменение прав доступа на облако
`UpdateCloudAccessPolicyBindingParameters` | Изменение параметров политики авторизации в облаке
`UpdateFolder` | Обновление каталога
`UpdateFolderAccessBindings` | Изменение прав доступа на каталог
`UpdateFolderAccessPolicyBindingParameters` | Изменение параметров политики авторизации в каталоге
`SetCloudAccessBindings` | Назначение прав доступа на облако
`SetFolderAccessBindings` | Назначение прав доступа на каталог

## Yandex Search API {#searchapi}

Имя сервиса — `searchapi`.

Имя события | Описание
--- | ---
`CreateCustomer` | Создание клиента
`DeleteCustomer` | Удаление клиента
`UpdateCustomer` | Изменение клиента

## Yandex Security Deck {#security-deck}

Имя сервиса — `securitydeck`.

### Модуль Контроль Kubernetes® (KSPM) {#sd-kspm}

Имя модуля — `securitydeck.kspm`.

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

### Модуль Контроль конфигурации (CSPM) {#sd-cspm}

Имя модуля — `securitydeck.cspm`.

Имя события | Описание
--- | ---
`CreateScanJob` | Создание задания сканирования
`CreateScopeFilter` | Создание фильтра области действия
`DeleteScanJob` | Удаление задания сканирования
`DeleteScopeFilter` | Удаление фильтра области действия
`UpdateScanJob` | Изменение задания сканирования
`UpdateScopeFilter` | Изменение фильтра области действия

### Модуль Алерты {#sd-alerts}

Имя модуля — `securitydeck.alerts`.

Имя события | Описание
--- | ---
`CreateAlertSink` | Создание приемника алертов
`DeleteAlertSink` | Удаление приемника алертов
`UpdateAlertSink` | Изменение приемника алертов

### Окружения Security Deck {#sd-orchestrator}

Имя модуля — `securitydeck.orchestrator`.

Имя события | Описание
--- | ---
`CreateConnector` | Создание [коннектора](../../security-deck/concepts/workspace.md#connectors)
`CreateScope` | Создание области действия
`CreateWorkspace` | Создание [окружения](../../security-deck/concepts/workspace.md)
`DeleteConnector` | Удаление коннектора
`DeleteScope` | Удаление области действия
`DeleteWorkspace` | Удаление окружения
`UpdateConnector` | Изменение коннектора
`UpdateScope` | Изменение области действия
`UpdateWorkspace` | Изменение окружения

## Yandex Serverless Containers {#serverless-containers}

Имя сервиса — `serverless.containers`.

Имя события | Описание
--- | ---
| `CreateContainer` | Создание контейнера |
| `DeleteContainer` | Удаление контейнера |
| `DeployContainerRevision` | Создание ревизии контейнера |
| `RollbackContainer` | Изменение активной ревизии контейнера |
| `SetContainerAccessBindings` | Назначение прав доступа к контейнеру |
| `UpdateContainer` | Изменение контейнера |
| `UpdateContainerAccessBindings` | Изменение прав доступа к контейнеру |

## Yandex SmartCaptcha {#smartcaptcha}

Имя сервиса — `smartcaptcha`.

Имя события | Описание
--- | ---
`CreateCaptcha` | Создание капчи
`DeleteCaptcha` | Удаление капчи
`UpdateCaptcha` | Изменение капчи

## Yandex Smart Web Security {#smartwebsecurity}

Имя сервиса — `smartwebsecurity`.

Имя события | Описание
--- | ---
`CreateArlProfile` | Создание профиля ARL
`CreateCustomPage` | Создание [шаблона страницы ответа](../../smartwebsecurity/concepts/response-templates.md)
`CreateDomain` | Создание домена
`CreateLoadBalancer` | Создание прокси-сервера
`CreateMatchList` | Создание списка адресов
`CreateSecurityProfile` | Создание профиля безопасности
`CreateWafProfile` | Создание профиля WAF
`DeleteArlProfile` | Удаление профиля ARL
`DeleteCustomPage` | Удаление шаблона страницы ответа
`DeleteDomain` | Удаление домена
`DeleteLoadBalancer` | Удаление прокси-сервера
`DeleteMatchList` | Удаление списка адресов
`DeleteSecurityProfile` | Удаление профиля безопасности
`DeleteWafProfile` | Удаление профиля WAF
`StartLoadBalancer` | Запуск прокси-сервера
`StopLoadBalancer` | Остановка прокси-сервера
`UpdateArlProfile` | Изменение профиля ARL
`UpdateCustomPage` | Изменение шаблона страницы ответа
`UpdateDomain` | Изменение домена
`UpdateLoadBalancer` | Изменение прокси-сервера
`UpdateMatchList` | Изменение списка адресов
`UpdateSecurityProfile` | Изменение профиля безопасности
`UpdateWafProfile` | Изменение профиля WAF

## Yandex SpeechSense {#speechsense}

Имя сервиса — `speechsense`.

Имя события | Описание
--- | ---
`CreateProject` | Создание проекта
`CreateSpace` | Создание пространства
`DeleteProject` | Удаление проекта
`DeleteSpace` | Удаление пространства
`SetProjectAccessBindings` | Назначение прав доступа к проекту
`SetSpaceAccessBindings` | Назначение прав доступа к пространству
`UpdateProject` | Изменение проекта
`UpdateProjectAccessBindings` | Изменение прав доступа к проекту
`UpdateSpace` | Изменение пространства
`UpdateSpaceAccessBindings` | Изменение прав доступа к пространству

## Yandex Virtual Private Cloud {#vpc}

Имя сервиса — `network`.

Имя события | Описание
--- | ---
`AddressAttached` | Привязка адреса к облачному ресурсу
`AddressDetached` | Отвязка адреса от облачного ресурса
`CreateAddress` | Создание адреса облачных ресурсов
`CreateGateway` | Создание шлюза
`CreateNetwork` | Создание облачной сети
`CreatePrivateEndpoint` | Создание сервисного подключения
`CreateRouteTable` | Создание таблицы маршрутизации
`CreateSecurityGroup` | Создание группы безопасности
`CreateSubnet` | Создание облачной подсети
`DeleteAddress` | Удаление адреса облачных ресурсов
`DeleteGateway` | Удаление шлюза
`DeleteNetwork` | Удаление облачной сети
`DeletePrivateEndpoint` | Удаление сервисного подключения
`DeleteRouteTable` | Удаление таблицы маршрутизации
`DeleteSecurityGroup` | Удаление группы безопасности
`DeleteSubnet` | Удаление облачной подсети
`GatewayAttached` | Добавление шлюза
`GatewayDetached` | Отсоединение шлюза
`MoveAddress` | Перемещение адреса облачных ресурсов в другой каталог
`MoveGateway` | Перемещение шлюза в другой каталог
`MoveNetwork` | Перемещение облачной сети в другой каталог
`MoveRouteTable` | Перемещение таблицы маршрутизации в другой каталог
`MoveSecurityGroup` | Перемещение группы безопасности в другой каталог
`MoveSubnet` | Перемещение облачной подсети в другой каталог
`RelocateSubnet` | Перемещение облачной подсети в другую [зону доступности](../../overview/concepts/geo-scope.md)
`RouteTableAttached` | Добавление таблицы маршрутизации к подсети
`RouteTableDetached` | Отсоединение таблицы маршрутизации от подсети
`UpdateAddress` | Изменение адреса облачных ресурсов
`UpdateGateway` | Изменение шлюза
`UpdateNetwork` | Изменение облачной сети
`UpdatePrivateEndpoint` | Изменение сервисного подключения
`UpdateRouteTable` | Изменение таблицы маршрутизации
`UpdateSecurityGroup` | Изменение группы безопасности
`UpdateSubnet` | Изменение облачной подсети

## Yandex WebSQL {#websql}

Имя сервиса — `websql`.

Имя события | Описание
--- | ---
`CreateSavedQuery` | Сохранение запроса
`DeleteExecutedQuery` | Удаление выполненного запроса
`DeleteSavedQuery` | Удаление сохраненного запроса
`EditSavedQuery` | Редактирование сохраненного запроса
`PublishExecutedQuery` | Публикация выполненного запроса
`PublishSavedQuery` | Публикация сохраненного запроса
`UpdateExecutedQueryAccessBindings` | Обновление прав доступа к выполненному запросу
`UpdateSavedQueryAccessBindings` | Обновление прав доступа к сохраненному запросу

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._