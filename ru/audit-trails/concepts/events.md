# Справочник событий

Значение поля `event_type` (_тип события_) аудитного лога определяется сервисом-источником события.

Общий вид значения:

```text
yandex.cloud.audit.<имя сервиса>.<имя события>
```

Ниже описаны события для сервисов:

* [{{ at-name }}](#audit-trails)
* [{{ certificate-manager-name }}](#certificate-manager)
* [{{ cloud-logging-name }}](#cloud-logging-name)
* [{{ compute-name }}](#compute)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ mch-short-name }}](#managed-service-for-clickhouse)
* [{{ mgl-full-name }}](#managed-service-for-gitlab)
* [{{ mmg-short-name }}](#managed-service-for-mongodb)
* [{{ mmy-short-name }}](#managed-service-for-mysql)
* [{{ mpg-short-name }}](#managed-service-for-postgresql)
* [{{ mrd-short-name }}](#managed-service-for-redis)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ org-name }}](#organization)
* [{{ resmgr-name }}](#resmgr)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#ydb)

## {{ at-name }} {#audit-trails}

Имя сервиса — `audittrails`.

Имя события | Описание
--- | ---
`CreateTrail` | Создание трейла
`DeleteTrail` | Удаление трейла
`SetTrailAccessBindings` | Назначение привязок прав доступа для трейла
`UpdateTrail` | Изменение трейла
`UpdateTrailAccessBindings` | Обновление привязок прав доступа для трейла

## {{ certificate-manager-name }} {#certificate-manager}

Имя сервиса — `certificatemanager`.

Имя события | Описание
--- | ---
`CreateCertificate` | Создание сертификата
`UpdateCertificate` | Изменение сертификата
`DeleteCertificate` | Удаление сертификата
`UpdateCertificateAccessBindings` | Обновление привязок прав доступа для сертификата
`SetCertificateAccessBindings` | Назначение привязок прав доступа для сертификата

## {{ cloud-logging-name }} {#cloud-logging-name}

Имя сервиса — `logging`.

Имя события | Описание
--- | ---
`CreateLogGroup` | Создание лог-группы
`UpdateLogGroup` | Изменение лог-группы
`DeleteLogGroup` | Удаление лог-группы
`SetLogGroupAccessBindings` | Назначение привязок прав доступа для лог-группы
`UpdateLogGroupAccessBindings` | Обновление привязок прав доступа для лог-группы

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
`CreateImage` | Создание образа диска
`CreateInstance` | Создание ВМ
`CreateSnapshot` | Создание снимка диска
`DeleteDisk` | Удаление диска
`DeleteFilesystem` | Удаление файловой системы
`DeleteImage` | Удаление образа диска
`DeleteInstance` | Удаление ВМ
`DeleteSnapshot` | Удаление снимка диска
`DetachInstanceDisk` | Отключение диска от ВМ
`DetachInstanceFilesystem` | Отключение файловой системы от ВМ
`GuestStopInstance` | Остановка ВМ по команде из этой ВМ
`PreemptInstance` | Прерывание работы ВМ
`RemoveInstanceOneToOneNat` | Удаление публичного IP-адреса ВМ
`RestartInstance` | Перезагрузка ВМ
`StartInstance` | Запуск ВМ
`StopInstance` | Остановка ВМ
`UpdateDisk` | Изменение диска
`UpdateFilesystem` | Изменение файловой системы
`UpdateImage` | Изменение образа диска
`UpdateInstance` | Изменение ВМ
`UpdateInstanceMetadata` | Изменение метаданных ВМ
`UpdateInstanceNetworkInterface` | Изменение сетевых настроек ВМ
`UpdateSnapshot` | Изменение снимка диска
`instancegroup.CreateInstanceGroup` | Создание группы ВМ
`instancegroup.DeleteInstanceGroup` | Удаление группы ВМ
`instancegroup.DeleteInstanceGroupInstances` | Удаление ВМ из группы
`instancegroup.PauseInstanceGroup` | Приостановка процессов управления группой ВМ
`instancegroup.ResumeInstanceGroup` | Возобновление процессов управления группой ВМ
`instancegroup.SetInstanceGroupAccessBindings` | Назначение ролей на группу ВМ
`instancegroup.StartInstanceGroup` | Запуск группы ВМ
`instancegroup.StopInstanceGroup` | Остановка группы ВМ
`instancegroup.StopInstanceGroupInstances` | Остановка ВМ из группы
`instancegroup.UpdateInstanceGroup` | Изменение группы ВМ
`instancegroup.UpdateInstanceGroupAccessBindings` | Обновление ролей для группы ВМ

## {{ iam-name }} {#iam}

Имя сервиса — `iam`.

Имя события | Описание
--- | ---
`AddFederatedUserAccounts` | Добавление пользователя в федерацию
`CreateAccessKey` | Создание ключа доступа
`CreateApiKey` | Создание API-ключа
`CreateCertificate` | Добавление сертификата для федерации
`CreateFederation` | Создание федерации
`CreateIamCookieForSubject` | Вход федеративного пользователя ^*^
`CreateKey` | Создание пары ключей для сервисного аккаунта
`CreateServiceAccount` | Создание сервисного аккаунта
`DeleteAccessKey` | Удаление ключа доступа
`DeleteApiKey` | Удаление API-ключа
`DeleteCertificate` | Удаление сертификата для федерации
`DeleteFederation` | Удаление федерации
`DeleteKey` | Удаление пары ключей для сервисного аккаунта
`DeleteServiceAccount` | Удаление сервисного аккаунта
`DetectLeakedCredential` | Обнаружение секрета в открытом источнике
`UpdateAccessKey` | Обновление ключа доступа
`UpdateApiKey` | Обновление API-ключа
`UpdateCertificate` | Обновление сертификата
`UpdateFederation` | Обновление федерации
`UpdateKey` | Обновление пары ключей
`UpdateServiceAccount` | Обновление сервисного аккаунта
`UpdateServiceAccountAccessBindings` | Обновление списка привязок прав доступа

\* Событие попадает в аудитный лог, только если [область сбора аудитных логов](./trail.md#collecting-area) трейла — `Организация`.

## {{ kms-name }} {#kms}

Имя сервиса — `kms`.

Имя события | Описание
--- | ---
`CancelDeleteSymmetricKey` | Отмена ранее запланированного уничтожения ключа
`CancelSymmetricKeyVersionDestruction` | Отмена ранее запланированного уничтожения версии симметричного ключа
`CreateSymmetricKey` | Создание симметричного ключа
`DeleteSymmetricKey` | Удаление симметричного ключа
`RotateSymmetricKey` | Ротация симметричного ключа
`ScheduleSymmetricKeyVersionDestruction` | Запланирование уничтожения версии симметричного ключа
`SetPrimarySymmetricKeyVersion` | Выбор основной версии симметричного ключа
`SetSymmetricKeyAccessBindings` | Выбор привязок прав доступа для симметричного ключа
`UpdateSymmetricKey` | Изменение симметричного ключа
`UpdateSymmetricKeyAccessBindings` | Обновление привязок прав доступа для симметричного ключа

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
`UpdateSecretAccessBindings` | Обновление привязок прав доступа для секрета

\* Указанное событие по умолчанию не входит в аудитный лог. Чтобы добавить это событие в аудитный лог, обратитесь в [службу технической поддержки]({{ link-console-support }}). Шаблон обращения:
«Просьба включить запись событий data plane Lockbox в audit trail `<id трейла>`».

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
`CreateShardGroup` | Созданрие группы шардов
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
`UpdateClusterExternalDictionary` | Удаление внешнего словаря
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
`RescheduleMaintenance` | Отложены запланированные технические работы
`ScheduleUpgrade` | Запланировано обновление версии GitLab
`StartInstance` | Запуск инстанса
`StopInstance` | Остановка инстанса
`UpdateInstance` | Изменение инстанса
`UpdateOmniauthInstance` | Изменение настроек OmniAuth
`UpgradeInstance` | Обновление версии GitLab

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

## {{ mmy-short-name }} {#managed-service-for-mysql}

Имя сервиса — `mdb.mysql`.

Имя события | Описание
--- | ---
`AddClusterHosts` | Добавление новых хостов в кластер
`BackupCluster` | Создание резервной копии
`CreateCluster` | Создание кластера
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
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
`BucketHttpsUpdate` | Изменение HTTPS-конфигурации для бакета
`BucketLifecycleUpdate` | Изменение жизненного цикла объекта в бакете
`BucketPolicyUpdate` | Изменение политик доступа бакета
`BucketUpdate` | Изменение бакета
`BucketWebsiteUpdate` | Изменение конфигурации веб-сайта
`ObjectCreate` | Создание объекта в бакете ^*^
`ObjectDelete` | Удаление объекта в бакете ^*^
`ObjectUpdate` | Изменение объекта в бакете ^*^

\* Указанные события по умолчанию не входят в аудитный лог. Чтобы добавить эти события в аудитный лог, обратитесь в [службу технической поддержки]({{ link-console-support }}). Шаблон обращения:
«Просьба включить запись событий data plane object storage в audit trail `<id трейла>`».

## {{ org-name }} {#organization}

Имя сервиса — `organizationmanager`.

Имя события | Описание
--- | ---
`CreateMembership` | Добавление пользователя в организацию
`DeleteMembership` | Удаление пользователя из организации

## {{ resmgr-name }} {#resmgr}

Имя сервиса — `resourcemanager`.

Имя события | Описание
--- | ---
`CreateCloud` | Создание облака
`CreateFolder` | Создание каталога
`DeleteCloud` | Удаление облака
`DeleteFolder` | Удаление каталога
`UpdateCloud` | Изменение облака
`UpdateCloudAccessBindings` | Обновление привязок прав доступа для облака
`UpdateFolder` | Обновление каталога
`UpdateFolderAccessBindings` | Обновление привязок прав доступа для каталога ^*^

\* Событие может не попадать в аудитный лог, если права сервисному аккаунту были назначены через [консоль]({{ link-console-main }}).

## {{ vpc-name }} {#vpc}

Имя сервиса — `network`.

Имя события | Описание
--- | ---
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
