# Справочник событий уровня конфигурации

Значение поля `event_type` (_тип события_) аудитного лога уровня конфигурации (Control Plane) определяется сервисом-источником события.

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Ниже описаны события для сервисов:

* [{{ api-gw-name }}](#api-gateway)
* [{{ alb-name }}](#alb)
* [{{ at-name }}](#audit-trails)
* [{{ certificate-manager-name }}](#certificate-manager)
* [{{ dns-name }}](#dns)
* [{{ sf-name }}](#functions)
* [{{ backup-name }}](#backup)
* [{{ cdn-name }}](#cdn)
* [{{ cloud-logging-name }}](#cloud-logging)
* [{{ compute-name }}](#compute)
* [{{ container-registry-name }}](#container-registry)
* [{{ dataproc-name }}](#dataproc)
* [{{ data-transfer-name }}](#datatransfer)
* [{{ iam-name }}](#iam)
* [{{ iot-name }}](#iot)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ mkf-short-name }}](#managed-service-for-kafka)
* [{{ mch-short-name }}](#managed-service-for-clickhouse)
* [{{ mgl-full-name }}](#managed-service-for-gitlab)
* [{{ mgp-short-name }}](#managed-service-for-greenplum)
* [{{ mmg-short-name }}](#managed-service-for-mongodb)
* [{{ managed-k8s-name }}](#managed-service-for-kubernetes)
* [{{ mmy-short-name }}](#managed-service-for-mysql)
* [{{ mpg-short-name }}](#managed-service-for-postgresql)
* [{{ mrd-short-name }}](#managed-service-for-redis)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ serverless-containers-name }}](#serverless-containers)
* [{{ org-name }}](#organization)
* [{{ resmgr-name }}](#resmgr)
* [{{ captcha-name }}](#smartcaptcha)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#ydb)
* [{{ yq-short-name }}](#yq)

## {{ api-gw-name }} {#api-gateway}

Имя сервиса — `serverless.apigateway`.

Имя события | Описание
--- | ---
`CreateApiGateway` | Создание шлюза
`DeleteApiGateway` | Удаление шлюза
`UpdateApiGateway` | Изменение шлюза


## {{ alb-name }} {#alb}

Имя сервиса — `apploadbalancer`.

Имя события | Описание
--- | ---
`AddBackendGroupBackend` | Добавление бэкенда в группу бэкендов
`AddLoadBalancerListener` | Добавление обработчика в балансировщик
`AddLoadBalancerSniMatch` | Добавление SNI-обработчика в балансировщик
`AddTargetGroupTargets` | Добавление [ВМ](../../glossary/vm.md) в целевую группу
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

## {{ at-name }} {#audit-trails}

Имя сервиса — `audittrails`.

Имя события | Описание
--- | ---
`CreateTrail` | Создание трейла
`DeleteTrail` | Удаление трейла
`SetTrailAccessBindings` | Назначение привязок прав доступа для трейла
`UpdateTrail` | Изменение трейла
`UpdateTrailAccessBindings` | Изменение привязок прав доступа для трейла

## {{ sf-name }} {#functions}

Имя сервиса — `serverless`.

Имя события | Описание
--- | ---
`functions.CreateFunction` | Создание функции
`functions.CreateFunctionVersion` | Создание версии функции
`functions.DeleteFunction` | Удаление функции
`functions.DeleteFunctionVersion` | Удаление версии функции
`functions.RemoveFunctionTag` | Удаление тега функции
`functions.RemoveScalingPolicy` | Удаление политики масштабирования функции
`functions.SetFunctionTag` | Назначение тега функции
`functions.SetFunctionAccessBindings` | Назначение привязок прав доступа для функции
`functions.SetScalingPolicy` | Назначение политики масштабирования функции
`functions.UpdateFunction` | Изменение функции
`functions.UpdateFunctionAccessBindings` | Изменение привязок прав доступа для функции
`mdbproxy.CreateProxy` | Создание прокси
`mdbproxy.DeleteProxy` | Удаление прокси
`mdbproxy.UpdateProxy` | Изменение прокси
`triggers.CreateTrigger` | Создание триггера
`triggers.DeleteTrigger` | Удаление триггера
`triggers.UpdateTrigger` | Изменение триггера


## {{ backup-name }} {#backup}

Имя сервиса — `backup`.

Имя события | Описание
--- | ---
`ApplyPolicy` | Применение политики резервного копирования
`CreateDirectory` | Создание новой директории внутри ВМ
`CreatePolicy` | Создание политики резервного копирования
`DeleteBackup` | Удаление резервной копии
`DeletePolicy` | Удаление политики резервного копирования
`DeleteResource` | Удаление ВМ из сервиса {{ backup-name }}
`ExecutePolicy` | Выполнение политики резервного копирования
`RegisterResource` | Подключение ВМ к сервису {{ backup-name }}
`RevokePolicy` | Отзыв политики резервного копирования
`StartRecoverBackup` | Запуск восстановления ВМ
`UpdatePolicy` | Изменение политики резервного копирования


## {{ cdn-name }} {#cdn}

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
`gcore.ResourceCreate` | Создание ресурса
`gcore.ResourceUpdate` | Изменение ресурса

## {{ certificate-manager-name }} {#certificate-manager}

Имя сервиса — `certificatemanager`.

Имя события | Описание
--- | ---
`CreateCertificate` | Добавление сертификата
`CreateDomain` | Добавление домена
`UpdateCertificate` | Изменение сертификата
`UpdateDomain` | Изменение домена
`DeleteCertificate` | Удаление сертификата
`DeleteDomain` | Удаление домена
`UpdateCertificateAccessBindings` | Изменение привязок прав доступа для сертификата
`SetCertificateAccessBindings` | Назначение привязок прав доступа для сертификата
`SetDomainPrimaryCertificate` | Назначение домену основного сертификата

## {{ dns-name }} {#dns}

Имя сервиса — `dns`.

Имя события | Описание
--- | ---
`CreateDnsZone` | Создание зоны [DNS](../../glossary/dns.md)
`DeleteDnsZone` | Удаление зоны DNS
`SetDnsZoneAccessBindings` | Назначение привязок прав доступа к зоне DNS
`UpdateDnsZone` | Изменение зоны DNS
`UpdateDnsZoneAccessBindings` | Изменение привязок прав доступа к зоне DNS
`UpdateRecordSets` | Изменение набора записей

## {{ cloud-logging-name }} {#cloud-logging-name}

Имя сервиса — `logging`.

Имя события | Описание
--- | ---
`CreateLogGroup` | Создание лог-группы
`UpdateLogGroup` | Изменение лог-группы
`DeleteLogGroup` | Удаление лог-группы
`SetLogGroupAccessBindings` | Назначение привязок прав доступа для лог-группы
`UpdateLogGroupAccessBindings` | Изменение привязок прав доступа для лог-группы

## {{ compute-name }} {#compute}

Имя сервиса — `compute`.

Имя события | Описание
--- | ---
`AddInstanceOneToOneNat` | Добавление публичного IP-адреса виртуальной машине
`AttachInstanceDisk` | Подключение диска к ВМ
`AttachInstanceFilesystem` | Подключение файловой системы к ВМ
`ChangeDiskStatus` | Изменение статуса нереплицируемого диска
`CrashInstance` | Аварийное отключение ВМ
`CreateDisk` | Создание диска
`CreateFilesystem` | Создание файловой системы
`CreateGpuCluster` | Создание кластера GPU
`CreateImage` | Создание образа диска
`CreateInstance` | Создание ВМ
`CreateSnapshot` | Создание снимка диска
`CreateSnapshotSchedule` | Создание расписания снимков диска
`DeleteDisk` | Удаление диска
`DeleteFilesystem` | Удаление файловой системы
`DeleteGpuCluster` | Удаление кластера GPU
`DeleteImage` | Удаление образа диска
`DeleteInstance` | Удаление ВМ
`DeleteSnapshot` | Удаление снимка диска
`DeleteSnapshotSchedule` | Удаление расписания снимков диска
`DetachInstanceDisk` | Отключение диска от ВМ
`DetachInstanceFilesystem` | Отключение файловой системы от ВМ
`DisableSnapshotSchedule` | Отключение расписания снимков диска
`EnableSnapshotSchedule` | Включение расписания снимков диска
`GuestStopInstance` | Остановка ВМ по команде из этой ВМ
`PreemptInstance` | Прерывание работы ВМ
`RemoveInstanceOneToOneNat` | Удаление публичного IP-адреса ВМ
`RestartInstance` | Перезагрузка ВМ
`StartInstance` | Запуск ВМ
`StopInstance` | Остановка ВМ
`UpdateDisk` | Изменение диска
`UpdateFilesystem` | Изменение файловой системы
`UpdateGpuCluster` | Изменение кластера GPU
`UpdateImage` | Изменение образа диска
`UpdateInstance` | Изменение ВМ
`UpdateInstanceMetadata` | Изменение метаданных ВМ
`UpdateInstanceNetworkInterface` | Изменение сетевых настроек ВМ
`UpdateSnapshot` | Изменение снимка диска
`UpdateSnapshotSchedule` | Изменение параметров расписания снимков диска
`UpdateSnapshotScheduleDisks` | Изменение параметров расписания снимков дисков
`instancegroup.CreateInstanceGroup` | Создание группы ВМ
`instancegroup.DeleteInstanceGroup` | Удаление группы ВМ
`instancegroup.DeleteInstanceGroupInstances` | Удаление ВМ из группы
`instancegroup.PauseInstanceGroup` | Приостановка процессов управления группой ВМ
`instancegroup.ResumeInstanceGroup` | Возобновление процессов управления группой ВМ
`instancegroup.RollingRestartInstanceGroupInstances` | Поочередная перезагрузка виртуальных машин из группы
`instancegroup.SetInstanceGroupAccessBindings` | Назначение ролей на группу ВМ
`instancegroup.StartInstanceGroup` | Запуск группы ВМ
`instancegroup.StopInstanceGroup` | Остановка группы ВМ
`instancegroup.StopInstanceGroupInstances` | Остановка ВМ из группы
`instancegroup.UpdateInstanceGroup` | Изменение группы ВМ
`instancegroup.UpdateInstanceGroupAccessBindings` | Изменение ролей для группы ВМ

## {{ container-registry-name }} {#container-registry}

Имя сервиса — `containerregistry`.

Имя события | Описание
--- | ---
`CreateImage` | Создание образа
`CreateImageTag` | Создание тега образа
`CreateLifecyclePolicy` | Создание политики жизненного цикла
`CreateRegistry` | Создание реестра
`CreateRepository` | Создание репозитория
`CreateScanPolicy` | Создание политики сканирования
`DeleteImage` | Удаление образа
`DeleteImageTag` | Удаление тега образа
`DeleteLifecyclePolicy` | Удаление политики жизненного цикла
`DeleteRegistry` | Удаление реестра
`DeleteRepository` | Удаление репозитория
`ScanImage` | Сканирование образа
`UpdateIpPermission` | Изменение политики доступа с IP-адресов
`UpdateLifecyclePolicy` | Изменение политики жизненного цикла
`UpdateRegistry` | Изменение реестра
`UpdateScanPolicy` | Изменение политики сканирования
`UpdateRegistryAccessBindings` | Изменение привязок прав доступа на реестр  
`UpdateRepositoryAccessBindings` | Изменение привязок прав доступа на репозиторий
`SetRegistryAccessBindings`  | Назначение привязок прав доступа на реестр
`SetRepositoryAccessBindings` | Назначение привязок прав доступа на репозиторий

## {{ dataproc-name }} {#dataproc}

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

## {{ data-transfer-name }} {#datatransfer}

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
`UnfreezeTransferVersion` | Разрешение обновления трансфера до последней версии data planе
`UpdateEndpoint` | Изменение эндпоинта
`UpdateTransfer` | Изменение трансфера
`UpdateTransferVersion` | Обновление версии data planе трансфера

## {{ iam-name }} {#iam}

Имя сервиса — `iam`.

Имя события | Описание
--- | ---
`AddFederatedUserAccounts` | Добавление пользователя в федерацию
`CreateAccessKey` | Создание статического ключа
`CreateApiKey` | Создание API-ключа
`CreateCertificate` | Добавление сертификата для федерации
`CreateFederation` | Создание федерации
`CreateIamCookieForSubject` | Вход федеративного пользователя ^*^
`CreateKey` | Создание пары ключей для сервисного аккаунта
`CreateServiceAccount` | Создание сервисного аккаунта
`DeleteAccessKey` | Удаление статического ключа
`DeleteApiKey` | Удаление API-ключа
`DeleteCertificate` | Удаление сертификата для федерации
`DeleteFederation` | Удаление федерации
`DeleteKey` | Удаление пары ключей для сервисного аккаунта
`DeleteServiceAccount` | Удаление сервисного аккаунта
`DetectLeakedCredential` | Обнаружение секрета в открытом источнике
`UpdateAccessKey` | Обновление статического ключа
`UpdateApiKey` | Обновление API-ключа
`UpdateCertificate` | Обновление сертификата
`UpdateFederation` | Обновление федерации
`UpdateKey` | Обновление пары ключей
`UpdateServiceAccount` | Обновление сервисного аккаунта
`UpdateServiceAccountAccessBindings` | Изменение привязок прав доступа для сервисного аккаунта
`SetServiceAccountAccessBindings` | Назначение привязок прав доступа для сервисного аккаунта

\* Событие попадает в аудитный лог, только если [область сбора аудитных логов](./trail.md#collecting-area) трейла — `Организация`.

## {{ iot-name }} {#iot}

Имя сервиса — `iot`.

Имя события | Описание
--- | ---
`devices.CreateDevice` | Создание устройства
`devices.CreateRegistry` | Создание реестра
`devices.DeleteDevice` | Удаление устройства
`devices.DeleteRegistry` | Удаление реестра
`devices.UpdateDevice` | Изменение устройства
`devices.UpdateRegistry` | Изменение реестра

## {{ kms-name }} {#kms}

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
`SetAsymmetricEncryptionKeyAccessBindings` | Выбор привязок прав доступа для асимметричной ключевой пары шифрования
`SetAsymmetricSignatureKeyAccessBindings` | Выбор привязок прав доступа для ключевой пары электронной подписи
`SetPrimarySymmetricKeyVersion` | Выбор основной версии симметричного ключа
`SetSymmetricKeyAccessBindings` | Выбор привязок прав доступа для симметричного ключа
`UpdateAsymmetricEncryptionKey` | Изменение асимметричной ключевой пары шифрования
`UpdateAsymmetricSignatureKey` | Изменение ключевой пары электронной подписи
`UpdateSymmetricKey` | Изменение симметричного ключа
`UpdateSymmetricKeyAccessBindings` | Изменение привязок прав доступа для симметричного ключа

## {{ lockbox-name }} {#lockbox}

Имя сервиса — `lockbox`.

Имя события | Описание
--- | ---
`AddVersion` | Добавление версии секрета
`ActivateSecret` | Активация секрета
`CancelVersionDestruction` | Отмена ранее запланированного уничтожения версии секрета
`CreateSecret` | Создание секрета
`DeactivateSecret` | Деактивация секрета
`DeleteSecret` | Удаление секрета
`GetPayload` | Получение доступа к содержимому секрета ^*^
`ScheduleVersionDestruction` | Распланирование уничтожения версии секрета
`SetSecretAccessBindings` | Выбор привязок прав доступа для секрета
`UpdateSecret` | Изменение секрета
`UpdateSecretAccessBindings` | Изменение привязок прав доступа для секрета

\* Указанное событие по умолчанию не входит в аудитный лог. Чтобы оценить возможность добавления этого события, обратитесь в [службу поддержки]({{ link-console-support }}).

## {{ mkf-short-name }} {#managed-service-for-kafka}

Имя сервиса — `mdb.kafka`

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера

## {{ mch-short-name }} {#managed-service-for-clickhouse}

Имя сервиса — `mdb.clickhouse`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`AddClusterZookeeper` | Добавление подкластера ZooKeeper в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateClusterExternalDictionary` | Создание внешнего словаря
`CreateDatabase` | Создание базы данных
`CreateFormatSchema` | Создание схемы формата данных
`CreateMlModel` | Создание модели машинного обучения
`CreateShardGroup` | Создание группы шардов
`CreateUser` | Создание пользователя базы данных
`DeleteCluster` | Удаление кластера
`DeleteClusterExternalDictionary` | Изменение внешнего словаря
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`DeleteDatabase` | Удаление базы данных
`DeleteFormatSchema` | Удаление схемы формата данных
`DeleteMlModel` | Удаление модели машинного обучения
`DeleteShardGroup` | Удаление группы шардов
`DeleteUser` | Удаление пользователя базы данных
`GrantUserPermission` | Назначение прав пользователю базы данных
`MoveCluster` | Перемещение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterShard` | Изменение шарда в кластере
`UpdateFormatSchema` | Изменение схемы формата данных
`UpdateMlModel` | Изменение модели машинного обучения
`UpdateShardGroup` | Изменение группы шардов
`UpdateUser` | Изменение пользователя базы данных


## {{ mgl-name }} {#managed-service-for-gitlab}

Имя сервиса — `gitlab`.

Имя события | Описание
--- | ---
`BackupInstance` | Создание резервной копии
`CreateInstance` | Создание инстанса
`DeleteInstance` | Удаление инстанса
`StartInstance` | Запуск инстанса
`StopInstance` | Остановка инстанса
`UpdateInstance` | Изменение инстанса
`UpdateOmniauthInstance` | Изменение настроек OmniAuth
`UpgradeInstance` | Обновление версии GitLab
`CleanupRegistryInstance` | Очистка Docker Registry


## {{ mgp-short-name }} {#managed-service-for-greenplum}

Имя сервиса — `mdb.greenplum`.

Имя события | Описание
--- | ---
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`ExpandCluster` | Расширение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера


## {{ mmg-short-name }} {#managed-service-for-mongodb}

Имя сервиса — `mdb.mongodb`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`EnableClusterSharding` | Включение шардирования для кластера
`GrantUserPermission` | Назначение прав пользователю базы данных
`MoveCluster` | Перемещение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateUser` | Изменение пользователя базы данных


## {{ managed-k8s-name }} {#managed-service-for-kubernetes}

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
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UninstallHelmRelease` | Удаление версии Helm
`UpdateCluster` | Изменение кластера
`UpdateHelmRelease` | Изменение версии Helm
`UpdateNodeGroup` | Изменение группы узлов

## {{ mmy-short-name }} {#managed-service-for-mysql}

Имя сервиса — `mdb.mysql`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GrantUserPermission` | Назначение прав пользователю базы данных
`MoveCluster` | Перемещение кластера
`RescheduleMaintenance` | Отложить запланированные технические работы
`RestoreCluster` | Создание нового кластера из резервной копии
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов в кластере
`UpdateUser` | Изменение пользователя базы данных

## {{ mpg-short-name }} {#managed-service-for-postgresql}

Имя сервиса — `mdb.postgresql`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DeleteBackup` | Удаление резервной копии
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GrantUserPermission` | Назначение прав пользователю базы данных
`MoveCluster` | Перемещение кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`StartCluster` | Запуск кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов в кластере
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных

## {{ mrd-short-name }} {#managed-service-for-redis}

Имя сервиса — `mdb.redis`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`AddClusterShard` | Добавление шарда в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`DeleteCluster` | Удаление кластера
`DeleteClusterHosts` | Удаление хостов из кластера
`DeleteClusterShard` | Удаление шарда из кластера
`MoveCluster` | Перемещение кластера
`RebalanceCluster` | Перебалансировка кластера
`RestoreCluster` | Создание нового кластера из резервной копии
`StartCluster` | Запуск кластера
`StartClusterFailover` | Запуск переключения мастера для кластера
`StopCluster` | Остановка кластера
`UpdateCluster` | Изменение кластера
`UpdateClusterHosts` | Изменение хостов кластера

## {{ network-load-balancer-name }} {#network-load-balancer}

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
`RemoveNetworkLoadBalancerListener` | Удаление обработчика из сетевого балансировщика
`RemoveTargetGroupTargets` | Удаление ВМ из целевой группы
`StartNetworkLoadBalancer` | Запуск сетевого балансировщика
`StopNetworkLoadBalancer` | Остановка сетевого балансировщика
`UpdateNetworkLoadBalancer` | Изменение сетевого балансировщика
`UpdateTargetGroup` | Изменение целевой группы

## {{ objstorage-name }} {#objstorage}

Имя сервиса — `storage`.

Имя события | Описание
--- | ---
`BucketAclUpdate` | Изменение ACL бакета
`BucketCorsUpdate` | Изменение конфигурации CORS бакета
`BucketCreate` | Создание бакета
`BucketDelete` | Удаление бакета
`BucketEncryptionUpdate` | Обновление настроек шифрования бакета
`BucketVersioningUpdate` | Обновление настроек версионирования бакета
`BucketHttpsUpdate` | Изменение HTTPS-конфигурации для бакета
`BucketLifecycleUpdate` | Изменение жизненного цикла объекта в бакете
`BucketPolicyUpdate` | Изменение политик доступа бакета
`BucketTagsUpdate` | Изменение тегов бакета
`BucketUpdate` | Изменение бакета
`BucketWebsiteUpdate` | Изменение конфигурации веб-сайта
`ObjectAclUpdate` | Изменение ACL объекта в бакете^*^
`ObjectCreate` | Создание объекта в бакете ^*^
`ObjectDelete` | Удаление объекта в бакете ^*^
`ObjectUpdate` | Изменение объекта в бакете ^*^
`ObjectTagsDelete` | Удаление тегов объекта
`ObjectTagsUpdate` | Изменение тегов объекта

\* Указанные события по умолчанию не входят в аудитный лог. Чтобы оценить возможность добавления этих событий, обратитесь в [службу поддержки]({{ link-console-support }}).

## {{ serverless-containers-name }} {#serverless-containers}

Имя сервиса — `serverless.containers`.

Имя события | Описание
--- | ---
`CreateContainer` | Создание контейнера
`DeleteContainer` | Удаление контейнера
`DeployContainerRevision` | Создание ревизии контейнера
`RollbackContainer` | Откат контейнера к целевой ревизии
`SetContainerAccessBindings` | Назначение привязок прав доступа к контейнеру 
`UpdateContainer` | Изменение контейнера
`UpdateContainerAccessBindings` | Изменение привязок прав доступа к контейнеру
`mdbproxy.CreateProxy` | Создание прокси
`mdbproxy.DeleteProxy` | Удаление прокси
`mdbproxy.UpdateProxy` | Изменение прокси
`triggers.CreateTrigger` | Создание триггера
`triggers.DeleteTrigger` | Удаление триггера
`triggers.UpdateTrigger` | Изменение триггера

## {{ org-name }} {#organization}

Имя сервиса — `organizationmanager`.

Имя события | Описание
--- | ---
`AcceptInvitation` | Принятие приглашения
`CreateInvitations` | Создание приглашения
`CreateGroup` | Создание группы пользователей
`CreateMembership` | Добавление пользователя в организацию
`CreateOrganization` | Создание организации
`DeleteInvitation` | Удаление приглашения
`DeleteGroup` | Удаление группы пользователей
`DeleteMembership` | Удаление пользователя из организации
`DeleteOrganization` | Удаление организации
`RejectInvitation` | Отказ от приглашения
`ResendInvitation` | Повторная отправка приглашения
`SetGroupAccessBindings` | Назначение привязок прав доступа к группе пользователей
`SetOrganizationAccessBindings` | Назначение привязок прав доступа к организации
`UpdateGroup` | Изменение группы пользователей
`UpdateGroupAccessBindings` | Изменение привязок прав доступа к группе пользователей
`UpdateGroupMembers` | Изменение состава участников группы пользователей
`UpdateOrganization` | Изменение организации
`UpdateOrganizationAccessBindings` | Изменение привязок прав доступа к организации

## {{ resmgr-name }} {#resmgr}

Имя сервиса — `resourcemanager`.

Имя события | Описание
--- | ---
`AddCloudToOrganization` | Добавление облака в организацию
`CreateCloud` | Создание облака
`CreateFolder` | Создание каталога
`DeleteCloud` | Удаление облака
`DeleteFolder` | Удаление каталога
`UpdateCloud` | Изменение облака
`UpdateCloudAccessBindings` | Изменение привязок прав доступа на облако
`UpdateFolder` | Обновление каталога
`UpdateFolderAccessBindings` | Изменение привязок прав доступа на каталог
`SetCloudAccessBindings` | Назначение привязок прав доступа на облако
`SetFolderAccessBindings` | Назначение привязок прав доступа на каталог

## {{ captcha-name }} {#smartcaptcha}

Имя сервиса — `smartcaptcha`.

Имя события | Описание
--- | ---
`CreateCaptcha` | Создание капчи
`DeleteCaptcha` | Удаление капчи
`UpdateCaptcha` | Изменение капчи

## {{ vpc-name }} {#vpc}

Имя сервиса — `network`.

Имя события | Описание
--- | ---
`AddressAttached` | Привязка адреса к облачному ресурсу
`AddressDetached` | Отвязка адреса от облачного ресурса
`CreateAddress` | Создание адреса облачных ресурсов
`CreateGateway` | Создание шлюза
`CreateNetwork` | Создание облачной сети
`CreateRouteTable` | Создание таблицы маршрутизации
`CreateSecurityGroup` | Создание группы безопасности
`CreateSubnet` | Создание облачной подсети
`DeleteAddress` | Удаление адреса облачных ресурсов
`DeleteGateway` | Удаление шлюза
`DeleteNetwork` | Удаление облачной сети
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
`RouteTableAttached` | Добавление таблицы маршрутизации к подсети
`RouteTableDetached` | Отсоединение таблицы маршрутизации от подсети
`UpdateAddress` | Изменение адреса облачных ресурсов
`UpdateGateway` | Изменение шлюза
`UpdateNetwork` | Изменение облачной сети
`UpdateRouteTable` | Изменение таблицы маршрутизации
`UpdateSecurityGroup` | Изменение группы безопасности
`UpdateSubnet` | Изменение облачной подсети

## {{ ydb-short-name }} {#ydb}

Имя сервиса — `ydb`.

Имя события | Описание
--- | ---
`BackupDatabase` | Создание бэкапа базы данных
`CreateDatabase` | Создание базы данных
`DeleteBackup` | Удаление бэкапа базы данных
`DeleteDatabase` | Удаление базы данных
`MoveDatabase` | Перемещение базы данных
`RestoreBackup` | Восстановление базы данных из бэкапа
`StartDatabase` | Запуск базы данных
`StopDatabase` | Остановка базы данных
`UpdateDatabase` | Изменение базы данных

## {{ yq-short-name }} {#yq}

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
