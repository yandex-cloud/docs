# Справочник событий

Значение поля `event_type` (_тип события_) аудитного лога определяется сервисом-источником события.

Общий вид значения:

```text
yandex.cloud.audit.<имя сервиса>.<имя события>
```

Ниже описаны события для сервисов:

* [{{ at-name }}](#audit-trails)
* [{{ cloud-logging-name }}](#cloud-logging-name)
* [{{ compute-name }}](#compute)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ lockbox-name }}](#lockbox)
* [{{ network-load-balancer-name }}](#network-load-balancer)
* [{{ objstorage-name }}](#objstorage)
* [{{ resmgr-name }}](#resmgr)
* [{{ vpc-name }}](#vpc)
* [{{ ydb-short-name }}](#YDB)

## {{ at-name }} {#audit-trails}

Имя сервиса — `audittrails`.

Имя события | Описание
--- | ---
`CreateTrail` | Создание трейла
`DeleteTrail` | Удаление трейла
`SetTrailAccessBindings` | назначение привязок прав доступа для трейла
`UpdateTrail` | Изменение трейла
`UpdateTrailAccessBindings` | Обновление привязок прав доступа для трейла

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
`DetachInstanceFilesystem` | Отключение файловой системы к ВМ
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
`instancegroup.PauseInstanceGroup` | Приостановка процессов управления группой ВМ
`instancegroup.ResumeInstanceGroup` | Возобновление процессов управления группой ВМ
`instancegroup.StartInstanceGroup` | Запуск группы ВМ
`instancegroup.StopInstanceGroup` | Остановка группы ВМ
`instancegroup.UpdateInstanceGroup` | Изменение группы ВМ
`instancegroup.UpdateInstanceGroupAccessBindings` | Назначение роли на группу ВМ

## {{ iam-name }} {#iam}

Имя сервиса — `iam`.

Имя события | Описание
--- | ---
`AddFederatedUserAccounts` | Добавление пользователя в федерацию
`CreateAccessKey` | Создание ключа доступа
`CreateApiKey` | Создание API-ключа
`CreateCertificate` | Добавление сертификата для федерации
`CreateFederation` | Создание федерации
`CreateIamCookieForSubject` | Вход федеративного пользователя
`CreateKey` | Создание пары ключей для сервисного аккаунта
`CreateServiceAccount` | Создание сервисного аккаунта
`DeleteAccessKey` | Удаление ключа доступа
`DeleteApiKey` | Удаление API-ключа
`DeleteCertificate` | Удаление сертификата для федерации
`DeleteFederation` | Удаление федерации
`DeleteKey` | Удаление пары ключей для сервисного аккаунта
`DeleteServiceAccount` | Удаление сервисного аккаунта
`UpdateAccessKey` | Обновление ключа доступа
`UpdateApiKey` | Обновление API-ключа
`UpdateCertificate` | Обновление сертификата
`UpdateFederation` | Обновление федерации
`UpdateKey` | Обновление пары ключей
`UpdateServiceAccount` | Обновление сервисного аккаунта
`UpdateServiceAccountAccessBindings` | Обновление списка привязок прав доступа

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
`ScheduleVersionDestruction` | Распланирование уничтожения версии секрета
`SetSecretAccessBindings` | Выбор привязок прав доступа для секрета
`UpdateSecret` | Изменение секрета
`UpdateSecretAccessBindings` | Обновление привязок прав доступа для секрета

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
`ObjectCreate` | Создание объекта в бакете
`ObjectDelete` | Удаление объекта в бакете
`ObjectUpdate` | Изменение объекта в бакете

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
`UpdateFolderAccessBindings` | Обновление привязок прав доступа для каталога

## {{ vpc-name }} {#vpc}

Имя сервиса — `network`.

Имя события | Описание
--- | ---
`CreateAddress` | Создание адреса облачных ресурсов
`CreateNetwork` | Создание облачной сети
`CreateRouteTable` | Создание таблицы маршрутизации
`CreateSecurityGroup` | Создание группы безопасности
`CreateSubnet` | Создание облачной подсети
`DeleteAddress` | Удаление адреса облачных ресурсов
`DeleteNetwork` | Удаление облачной сети
`DeleteRouteTable` | Удаление таблицы маршрутизации
`DeleteSecurityGroup` | Удаление группы безопасности
`DeleteSubnet` | Удаление облачной подсети
`MoveAddress` | Перещение адреса облачных ресурсов в другой каталог
`MoveNetwork` | Перемещение облачной сети в другой каталог
`MoveRouteTable` | Перемещение таблицы маршрутизации в другой каталог
`MoveSecurityGroup` | Перемещение группы безопасности в другой каталог
`MoveSubnet` | Перемещение облачной подсети в другой каталог
`UpdateAddress` | Изменение адреса облачных ресурсов
`UpdateNetwork` | Изменение облачной сети
`UpdateRouteTable` | Изменение таблицы маршрутизации
`UpdateSecurityGroup` | Изменение группы безопасности
`UpdateSubnet` | Изменение облачной подсети

## {{ ydb-short-name }} {#YDB}

Имя сервиса — `ydb`.

Имя события | Описание
--- | ---
`BackupDatabase` | Создание бэкапа базы данных
`CreateDatabase` | Создание базы данных
`DeleteBackup` | Удаление бэкапа базы данных
`DeleteDatabase` | Удаление базы данных
`RestoreBackup` |  Восстановление базы данных из бэкапа
`StartDatabase` | Запуск базы данных 
`StopDatabase` | Остановка базы данных
`UpdateDatabase` | Изменение базы данных
