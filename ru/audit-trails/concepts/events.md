# Справочник событий

Значение поля `event_type` (_тип события_) аудитного лога определяется сервисом-источником события.

Общий вид значения:

```text
yandex.cloud.audit.<имя сервиса>.<имя события>
```

Ниже описаны события для сервисов:

* [{{ compute-name }}](#compute)
* [{{ iam-name }}](#iam)
* [{{ kms-name }}](#kms)
* [{{ resmgr-name }}](#resmgr)
* [{{ objstorage-name }}](#objstorage)
* [{{ vpc-name }}](#vpc)

## {{ compute-name }} {#compute}

Имя сервиса — `compute`.

Имя события | Описание
--- | ---
`AddInstanceOneToOneNat` | Добавление публичного IP-адреса ВМ.
`AttachInstanceDisk` | Подключение диска к ВМ.
`CreateDisk` | Создание диска.
`CreateImage` | Создание образа диска.
`CreateInstance` | Создание ВМ.
`CreateSnapshot` | Создание снимка диска.
`DeleteDisk` | Удаление диска.
`DeleteImage` | Удаление образа диска.
`DeleteInstance` | Удаление ВМ.
`DeleteSnapshot` | Удаление снимка диска.
`DetachInstanceDisk` | Отключение диска от ВМ.
`RemoveInstanceOneToOneNat` | Удаление публичного IP-адреса ВМ.
`RestartInstance` | Перезагрузка ВМ.
`StartInstance` | Запуск ВМ.
`StopInstance` | Остановка ВМ.
`UpdateDisk` | Изменение диска.
`UpdateImage` | Изменение образа диска.
`UpdateInstance` | Изменение ВМ.
`UpdateInstanceMetadata` | Изменение метаданных ВМ.
`UpdateInstanceNetworkInterface` | Изменение сетевых настроек ВМ.
`UpdateSnapshot` | Изменение снимка диска.
`instancegroup.CreateInstanceGroup` | Создание группы ВМ.
`instancegroup.DeleteInstanceGroup` | Удаление группы ВМ
`instancegroup.StartInstanceGroup` | Запуск группы ВМ.
`instancegroup.StopInstanceGroup` | Остановка группы ВМ.
`instancegroup.UpdateInstanceGroup` | Изменение группы ВМ.
`instancegroup.UpdateInstanceGroupAccessBindings` | Назначение роли на группу ВМ.

## {{ iam-name }} {#iam}

Имя сервиса — `iam`.

Имя события | Описание
--- | ---
`AddFederatedUserAccounts` | Добавление пользователя в федерацию.
`CreateAccessKey` | Создание ключа доступа.
`CreateApiKey` | Создание API-ключа.
`CreateCertificate` | Добавление сертификата для федерации.
`CreateFederation` | Создание федерации.
`CreateIamCookieForSubject` | Создание {{ iam-short-name }}-сookie для аккаунта.
`CreateIamCookieFromPassportCookies` | Обмен сookie аккаунта на Яндексе на {{ iam-short-name }}-сookie.
`CreateIamTokenFromOAuth` | Обмен токена аккаунта на Яндексе на {{ iam-short-name }}-токен.
`CreateIamTokenFromPassportCookies` | Обмен сookie аккаунта на Яндексе на {{ iam-short-name }}-токен.
`CreateKey` | Создание пары ключей для сервисного аккаунта.
`CreateServiceAccount` | Создание сервисного аккаунта.
`DeleteAccessKey` | Удаление ключа доступа.
`DeleteApiKey` | Удаление API-ключа.
`DeleteCertificate` | Удаление сертификата для федерации.
`DeleteFederation` | Удаление федерации.
`DeleteKey` | Удаление пары ключей для сервисного аккаунта.
`DeleteServiceAccount` | Удаление сервисного аккаунта.
`UpdateAccessKey` | Обновление ключа доступа.
`UpdateApiKey` | Обновление API-ключа.
`UpdateCertificate` | Обновление сертификата.
`UpdateFederation` | Обновление федерации.
`UpdateKey` | Обновление пары ключей.
`UpdateServiceAccount` | Обновление сервисного аккаунта.
`UpdateServiceAccountAccessBindings` | Обновление списка привязок прав доступа.

## {{ kms-name }} {#kms}

Имя сервиса — `kms`.

Имя события | Описание
--- | ---
`CancelDeleteSymmetricKey` | Отмена ранее запланированного уничтожения ключа.
`CancelSymmetricKeyVersionDestruction` | Отмена ранее запланированного уничтожения версии симметричного ключа.
`CreateSymmetricKey` | Создание симметричного ключа.
`DeleteSymmetricKey` | Удаление симметричного ключа.
`RotateSymmetricKey` | Ротация симметричного ключа.
`ScheduleSymmetricKeyVersionDestruction` | Запланирование уничтожения версии симметричного ключа.
`SetPrimarySymmetricKeyVersion` | Выбор основной версии симметричного ключа.
`SetSymmetricKeyAccessBindings` | Выбор привязок прав доступа для симметричного ключа.
`UpdateSymmetricKey` | Изменение симметричного ключа.
`UpdateSymmetricKeyAccessBindings` | Обновление привязок прав доступа для симметричного ключа.

## {{ resmgr-name }} {#resmgr}

Имя сервиса — `resourcemanager`.

Имя события | Описание
--- | ---
`CreateCloud` | Создание облака.
`CreateFolder` | Создание каталога.
`DeleteCloud` | Удаление облака.
`DeleteFolder` | Удаление каталога.
`UpdateCloud` | Изменение облака.
`UpdateCloudAccessBindings` | Обновление привязок прав доступа для облака.
`UpdateFolder` | Обновление каталога.
`UpdateFolderAccessBindings` | Обновление привязок прав доступа для каталога.

## {{ objstorage-name }} {#objstorage}

Имя сервиса — `storage`.

Имя события | Описание
--- | ---
`BucketAclUpdate` | Изменение ACL бакета.
`BucketCorsUpdate` | Изменение конфигурации CORS бакета.
`BucketCreate` | Создание бакета.
`BucketDelete` | Удаление бакета.
`BucketHttpsUpdate` | Изменение HTTPS-конфигурации для бакета.
`BucketLifecycleUpdate` | Изменение жизненного цикла объекта в бакете.
`BucketPolicyUpdate` | Изменение политик доступа бакета.
`BucketUpdate` | Изменение бакета.
`BucketWebsiteUpdate` | Изменение конфигурации веб-сайта.
`ObjectCreate` | Создание объекта в бакете.
`ObjectDelete` | Удаление объекта в бакете.
`ObjectUpdate` | Изменение объекта в бакете.

## {{ vpc-name }} {#vpc}

Имя сервиса — `network`.

Имя события | Описание
--- | ---
`CreateNetwork` | Создание облачной сети.
`CreateRouteTable` | Создание таблицы маршрутизации.
`CreateSecurityGroup` | Создание группы безопасности.
`CreateSubnet` | Создание облачной подсети.
`DeleteNetwork` | Удаление облачной сети.
`DeleteRouteTable` | Удаление таблицы маршрутизации.
`DeleteSecurityGroup` | Удаление группы безопасности.
`DeleteSubnet` | Удаление облачной подсети.
`MoveNetwork` | Перемещение облачной сети в другой каталог.
`MoveRouteTable` | Перемещение таблицы маршрутизации в другой каталог.
`MoveSecurityGroup` | Перемещение группы безопасности в другой каталог.
`MoveSubnet` | Перемещение облачной подсети в другой каталог.
`UpdateNetwork` | Изменение облачной сети.
`UpdateRouteTable` | Изменение таблицы маршрутизации.
`UpdateSecurityGroup` | Изменение группы безопасности.
`UpdateSubnet` | Изменение облачной подсети.
