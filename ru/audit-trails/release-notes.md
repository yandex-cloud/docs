---
title: История изменений в {{ at-full-name }}
description: В разделе представлена история изменений сервиса {{ at-name }}.
---

# История изменений в {{ at-full-name }}

## II квартал 2025 {#q2-2025}

* Добавлены новые события для сервисов:

  {% cut "{{ alb-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CancelZonalShift` | Остановка процесса вывода трафика из какой-либо зоны доступности
  `StartZonalShift` | Запуск процесса вывода трафика из какой-либо зоны доступности

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `LoadbalancerHTTPAccessLog` | Логирование HTTP-запросов
  `LoadbalancerTCPAccessLog` | Логирование TCP-запросов

  {% endcut %}

  {% cut "{{ baremetal-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `ApplyUpdatePrivateCloudConnection` | Применение изменений приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `CreateImage` | Создание загрузочного образа
  `CreatePrivateCloudConnection` | Создание [приватного соединения](../baremetal/concepts/network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
  `CreatePublicSubnet` | Создание [публичной подсети](../baremetal/concepts/network.md#public-network)
  `DeleteImage` | Удаление загрузочного образа
  `DeletePrivateCloudConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `DeletePublicSubnet` | Удаление публичной подсети
  `UpdateImage` | Изменение загрузочного образа
  `UpdatePrivateCloudConnection` | Изменение приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `UpdatePublicSubnet` | Изменение публичной подсети

  {% endcut %}

  {% cut "{{ certificate-manager-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetExCertificateContent` | Получение содержимого истекшего SSL-сертификата

  {% endcut %}

  {% cut "{{ video-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateStylePreset` | Создание пресета плеера
  `DeleteStylePreset` | Удаление пресета плеера
  `UpdateStylePreset` | Изменение пресета плеера

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса
  `MigrateInstance` | [Динамическая миграция](../compute/concepts/live-migration.md) ВМ ^*^

  \* В аудитный лог попадают события только для ВМ с настроенной [политикой обслуживания](../compute/concepts/vm-policies.md).

  {% endcut %}

  {% cut "{{ datalens-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `SwitchDataExportProhibition` | Изменение запрета на экспорт данных
  `SwitchWorkbookFileExportProhibition` | Изменение запрета на экспорт файлов из воркбука

  {% endcut %}

  {% cut "{{ foundation-models-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `TextProcessing` | Обработка текста
  `GetTextProcessingResult` | Получение результатов обработки текста

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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
  `saml.ReactivateApplication` | Перезапуск SAML-приложения
  `saml.SetApplicationAccessBindings` | Назначение прав доступа к SAML-приложению
  `saml.SuspendApplication` | Приостановка SAML-приложения
  `saml.UpdateApplication` | Изменение SAML-приложения
  `saml.UpdateApplicationAccessBindings` | Изменение прав доступа к SAML-приложению
  `saml.UpdateApplicationAssignments` | Изменение списка пользователей SAML-приложения
  `saml.UpdateSignatureCertificate` | Изменение сертификата для подписи

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `idp.AuthenticateByPassword` | Аутентификация по паролю

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `credential.CreateRefreshTokenForSubject` | Создание [refresh-токена](../iam/concepts/authorization/refresh-token.md) для пользователя
  `credential.RevokeRefreshTokenForSubject` | Отзыв refresh-токена у пользователя

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `oauthclient.CreateOAuthClient` | Создание OAuth-клиента
  `oauthclient.CreateOAuthClientSecret` | Создание секрета для OAuth-клиента
  `oauthclient.DeleteOAuthClient` | Удаление OAuth-клиента
  `oauthclient.DeleteOAuthClientSecret` | Удаление секрета для OAuth-клиента
  `oauthclient.UpdateOAuthClient` | Обновление OAuth-клиента

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateClusterExtension` | Создание расширения
  `DeleteClusterExtension` | Удаление расширения
  `UpdateClusterExtension` | Изменение расширения

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `SetClusterExtensions` | Установка расширений для кластера

  {% endcut %}
  
  {% cut "{{ managed-k8s-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateClusterCertificate` | Изменение [сертификата кластера](../managed-kubernetes/concepts/release-channels-and-updates.md#certificates)

  {% endcut %}

  {% cut "{{ mtr-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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
  
  {% cut "{{ message-queue-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateQueue` | Создание очереди сообщений
  `DeleteQueue` | Удаление очереди сообщений
  `UpdateQueue` | Изменение очереди сообщений

  {% endcut %}

  {% cut "{{ speechkit-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `stt.GetRecognition` | Запрос на получение результатов асинхронного распознавания речи
  `stt.RecognizeSpeechAsync` | Запрос на асинхронное для распознавание речи
  `stt.RecognizeSpeechStream` | Запрос на потоковое распознавание речи
  `tts.UtteranceSynthesis` | Запрос на синтез речи

  {% endcut %}

  {% cut "{{ sws-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateDomain` | Создание домена
  `CreateLoadBalancer` | Создание прокси-сервера
  `DeleteDomain` | Удаление домена
  `DeleteLoadBalancer` | Удаление прокси-сервера
  `UpdateDomain` | Изменение домена
  `UpdateLoadBalancer` | Изменение прокси-сервера

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `SWSMatchedRequest` | Срабатывание правила профиля безопасности

  {% endcut %}

  {% cut "{{ translate-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `TranslateText` | Запрос на перевод текста

  {% endcut %}
  
  {% cut "{{ vision-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `RecognizeText` | Запрос на распознавание текста
  `GetRecognition` | Запрос на получение распознанного результата

  {% endcut %}

  {% cut "{{ wiki-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

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

  {% cut "{{ baremetal-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateExternalConnection` стало `CreatePrivateCloudConnection` | Создание [приватного соединения](../baremetal/concepts/network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
  `DeleteExternalConnection` стало `DeletePrivateCloudConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  
  {% endcut %}

## I квартал 2025 {#q1-2025}

* Добавлены новые события для сервисов:

  {% cut "{{ baremetal-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `BatchCreateServer` | Аренда одновременно нескольких [серверов](../baremetal/concepts/servers.md) {{ baremetal-name }}
  `CreateExternalConnection` | Создание [приватного соединения](../baremetal/concepts/network.md#private-connection-to-vpc) с подсетями в VPC или в on-prem инфраструктуре
  `CreatePrivateSubnet` | Создание [приватной подсети](../baremetal/concepts/network.md#private-subnet)
  `CreateServer` | Аренда сервера {{ baremetal-name }}
  `CreateVRF` | Создание [виртуального сегмента сети](../baremetal/concepts/network.md#vrf-segment) (VRF)
  `DeleteExternalConnection` | Удаление приватного соединения с подсетями в VPC или в on-prem инфраструктуре
  `DeletePrivateSubnet` | Удаление приватной подсети
  `DeleteVRF` | Удаление виртуального сегмента сети (VRF)
  `PowerOffServer` | Выключение питания сервера {{ baremetal-name }}
  `PowerOnServer` | Включение питания сервера {{ baremetal-name }}
  `RebootServer` | Перезапуск сервера {{ baremetal-name }}
  `RegisterServerBackupAgent` | Регистрация [агента](../backup/concepts/agent.md) {{ backup-full-name }} на сервере {{ baremetal-name }}
  `ReinstallServer` | Переустановка операционной системы сервера {{ baremetal-name }}
  `StartServerProlongation` | Включение автопродления аренды сервера {{ baremetal-name }}
  `StopServerProlongation` | Выключение автопродления аренды сервера {{ baremetal-name }}
  `UpdatePrivateSubnet` | Изменение приватной подсети
  `UpdateServer` | Изменение сервера {{ baremetal-name }}
  `UpdateVRF` | Изменение виртуального сегмента сети (VRF)

  {% endcut %}

  {% cut "{{ backup-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteArchive` | Удаление архива резервной копии

  {% endcut %}

  {% cut "{{ cdn-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `gcore.ResourceDelete` | Удаление ресурса
  `gcore.ResourceRuleCreate` | Создание правила Rewrite
  `gcore.ResourceRuleDelete` | Удаление правила Rewrite
  `gcore.ResourceRuleUpdate` | Изменение правила Rewrite

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateFilestore` | Создание файлового хранилища
  `CreateModel` | Создание [модели](../datasphere/concepts/models/index.md)
  `CreateS3Connector` | Создание [коннектора S3](../datasphere/concepts/s3-connector.md)
  `CreateSecret` | Создание [секрета](../datasphere/concepts/secrets.md)
  `CreateSparkConnector` | Создание [коннектора Spark](../datasphere/concepts/spark-connector.md)
  `CreateYandexDataProcessing` | Создание [шаблона {{ dataproc-name }}](../datasphere/concepts/data-processing-template.md)
  `DeleteFilestore` | Удаление файлового хранилища
  `DeleteModel` | Удаление модели
  `DeleteS3Connector` | Удаление коннектора S3
  `DeleteSecret` | Удаление секрета
  `DeleteSparkConnector` | Удаление коннектора Spark
  `DeleteYandexDataProcessing` | Удаление шаблона {{ dataproc-name }}
  `UpdateFilestore` | Изменение файлового хранилища
  `UpdateModel` | Изменение модели
  `UpdateS3Connector` | Изменение коннектора S3
  `UpdateSecret` | Изменение секрета
  `UpdateSparkConnector` | Изменение коннектора Spark
  `UpdateYandexDataProcessing` | Изменение шаблона {{ dataproc-name }}

  {% endcut %}

  {% cut "{{ cloud-desktop-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateDesktop` | Создание рабочего стола
  `CreateDesktopGroup` | Создание группы рабочих столов
  `DeleteDesktop` | Удаление рабочего стола
  `DeleteDesktopGroup` | Удаление группы рабочих столов
  `RestartDesktop` | Перезагрузка рабочего стола

  {% endcut %}

  {% cut "{{ video-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ compute-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateReservedInstancePool` | Создание пула зарезервированных ВМ
  `DeleteReservedInstancePool` | Удаление пула зарезервированных ВМ
  `UpdateReservedInstancePool` | Изменение пула зарезервированных ВМ

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `RevokeLeakedCredential` | Отзыв скомпрометированного секрета
  `workload.oidc.SetFederationAccessBindings` | Назначение прав доступа федерации сервисных аккаунтов
  `workload.oidc.UpdateFederationAccessBindings` | Изменение прав доступа федерации сервисных аккаунтов

  {% endcut %}
  
  {% cut "{{ mch-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `RestartClusterHosts` | Перезапуск хостов кластера

  {% endcut %}

  {% cut "{{ mgl-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateRunner` | Создание {{ GLR }}
  `DeleteRunner` | Удаление {{ GLR }}
  `StartRunner` | Запуск {{ GLR }}
  `StopRunner` | Остановка {{ GLR }}
  `UpdateRunner` | Изменение {{ GLR }}

  {% endcut %}

  {% cut "{{ managed-k8s-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  [События уровня сервисов](./concepts/format-data-plane.md):

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
  `apiserver.ApiServerNonstandardVerb` | Событие генерируется, если аудитный лог {{ managed-k8s-name }} содержит нестандартное значение в поле `verb`
  `apiserver.ApiServerOptions` | Настройка ресурса
  `apiserver.ApiServerPatch` | Изменение ресурса
  `apiserver.ApiServerPost` | Создание ресурса
  `apiserver.ApiServerPut` | Обновление ресурса
  `apiserver.ApiServerUpdate` | Изменение запроса
  `apiserver.ApiServerWatch` | Отслеживание ресурсов
  
  {% endcut %}

  {% cut "{{ mos-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `RestartOpenSearch` | Перезапуск кластера
  `SwitchMaster` | Смена лидера кворума хостов с ролью `MANAGER`

  {% endcut %}

  {% cut "{{ mrd-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateUser` | Создание пользователя в кластере
  `DeleteUser` | Удаление пользователя из кластера
  `UpdateUser` | Обновление пользователя в кластере

  {% endcut %}

  {% cut "{{ vpc-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreatePrivateEndpoint` | Создание сервисного подключения
  `DeletePrivateEndpoint` | Удаление сервисного подключения
  `UpdatePrivateEndpoint` | Изменение сервисного подключения

  {% endcut %}

  {% cut "{{ billing-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `BillingAccountCreate` | Создание платежного аккаунта
  `BillingAccountUpdate` | Изменение платежного аккаунта

  {% endcut %}

  {% cut "{{ lockbox-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `GetPayload` | Факт доступа к содержимому секрета
  `GetPayloadEx` | Факт доступа к содержимому секрета по каталогу или имени

  {% endcut %}

  {% cut "{{ metadata-hub-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateCluster` | Создание [кластера](../metadata-hub/concepts/metastore.md) {{ metastore-full-name }}
  `DeleteCluster` | Удаление кластера {{ metastore-full-name }}
  `StartCluster` | Запуск кластера {{ metastore-full-name }}
  `StopCluster` | Остановка кластера {{ metastore-full-name }}
  `UpdateCluster` | Изменение кластера {{ metastore-full-name }}

  {% endcut %}

* Удалены события для сервисов:

  {% cut "{{ managed-k8s-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ApiServerAuditEvent` | Событие аудита кластера {{ managed-k8s-name }}

  {% endcut %}

## IV квартал 2024 {#q4-2024}

* Добавлены новые события для сервисов:

  {% cut "{{ org-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `AttachRegion` | Подключение региона

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ mos-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "{{ objstorage-name }} " %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `PresignURLCreate` | Создание подписанной ссылки

  {% endcut %}


## III квартал 2024 {#q3-2024}

* Добавлена возможность фильтрации по типам событий. Подробнее см. в разделе [Настройки трейла](./concepts/trail.md#trail-settings).
* Добавлены новые события для сервисов:

  {% cut "{{ certificate-manager-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `GetCertificateContent` | Получение содержимого SSL-сертификата

  {% endcut %}

  {% cut "{{ org-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteFederatedUserAccounts` | Удаление пользователя из федерации

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ iam-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `workload.CreateFederatedCredential` | Создание [привязки](../iam/concepts/workload-identity.md#federated-credentials) в федерации сервисных аккаунтов
  `workload.DeleteFederatedCredential` | Удаление привязки из федерации сервисных аккаунтов
  `workload.oidc.CreateFederation` | Создание [федерации сервисных аккаунтов](../iam/concepts/workload-identity.md)
  `workload.oidc.DeleteFederation` | Удаление федерации сервисных аккаунтов
  `workload.oidc.UpdateFederation` | Изменение федерации сервисных аккаунтов

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `RevokeIamToken` | Отзыв IAM-токена

  {% endcut %}

  {% cut "{{ load-testing-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateRegressionDashboard` | Создание дашборда регрессий
  `DeleteRegressionDashboard` | Удаление дашборда регрессий
  `UpdateRegressionDashboard` | Изменение дашборда регрессий

  {% endcut %}

  {% cut "{{ maf-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Имя события | Описание
  --- | ---
  `CreateCluster` | Создание кластера
  `DeleteCluster` | Удаление кластера
  `StartCluster` | Запуск кластера
  `StopCluster` | Остановка кластера
  `UpdateCluster` | Изменение кластера

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `AddClusterShard` | Добавление шарда в кластер
  `DeleteClusterShard` | Удаление шарда из кластера

  {% endcut %}

  {% cut "{{ mgp-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Имя события | Описание
  --- | ---
  `MoveCluster` | Перемещение кластера

  {% endcut %}

  {% cut "{{ managed-k8s-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ApiServerAuditEvent` | Событие аудита кластера {{ managed-k8s-name }}

  {% endcut %}

  {% cut "{{ mmy-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных

  {% endcut %}

  {% cut "{{ sd-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Имя события | Описание
  --- | ---
  `ComputeNodeAccess` | Подключение [модуля](../security-deck/concepts/access-transparency.md) {{ atr-name }} к [подкластеру](../data-proc/concepts/index.md#resources) {{ dataproc-name }}
  `MDBClusterAccess` | Подключение модуля {{ atr-name }} к кластеру базы данных

  {% endcut %}

  {% cut "{{ sws-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `ArlMatchedRequest` | Запрос по правилам ARL
  `WafMatchedExclusionRule` | Примененное правило исключения WAF
  `WafMatchedRule` | Примененное правило WAF

  {% endcut %}

  {% cut "{{ postbox-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ api-gw-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `SetApiGatewayAccessBindings` | Назначение привязок прав доступа к API-шлюзу
  `UpdateApiGatewayAccessBindings` | Изменение привязок прав доступа к API-шлюзу

  {% endcut %}

  {% cut "{{ backup-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `InitResource` | Инициализация подключения ВМ к сервису {{ backup-name }}
  `UpdateResource`| Обновление статуса подключения ВМ к сервису {{ backup-name }}

  {% endcut %}

  {% cut "{{ certificate-manager-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `SetCertificateAccessBindings` | Назначение привязок прав доступа для сертификата
  `SetDomainPrimaryCertificate` | Назначение домену основного сертификата

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `AttachInstanceNetworkInterface` | Подключение сетевого интерфейса
  `DetachInstanceNetworkInterface` | Отключение сетевого интерфейса

  {% endcut %}

  {% cut "{{ ml-platform-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CloneJob` | Клонирование задания
  `UpdateJobDataTtl` | Изменение времени жизни данных задания

  {% endcut %}

  {% cut "{{ sf-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `mdbproxy.SetProxyAccessBindings` | Назначение привязок прав доступа к управляемой базе данных
  `mdbproxy.UpdateProxyAccessBindings` | Изменение привязок прав доступа к управляемой базе данных
  `triggers.PauseTrigger` | Остановка триггера
  `triggers.ResumeTrigger` | Запуск триггера

  {% endcut %}

  {% cut "{{ iam-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `SetServiceAccountAccessBindings` | Назначение привязок прав доступа для сервисного аккаунта

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateIamToken` | Создание IAM-токена
  `oslogin.CheckSshPolicy` | Проверка прав на подключение по SSH при доступе по {{ oslogin }}
  `oslogin.GenerateSshCertificate` | Генерация SSH-сертификата для доступа по {{ oslogin }}

  {% endcut %}

  {% cut "{{ mch-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "{{ mgl-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `FinishMigration` | Завершение процесса миграции инстанса в другую зону доступности
  `PrepareBackupUpload` | Подготовка к восстановлению из резервной копии
  `RollbackMigration` | Отмена процесса миграции инстанса в другую зону доступности
  `StartMigration` | Запуск процесса миграции инстанса в другую зону доступности

  {% endcut %}

  {% cut "{{ mpg-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserSQLRequest`| SQL-запрос пользователя к базе данных

  {% endcut %}

  {% cut "{{ mrd-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `EnableClusterSharding` | Включение шардирования кластера

  {% endcut %}

  {% cut "{{ marketplace-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `ActivateSubscriptionAutoRenewal` | Активация автоматического продления подписки
  `CancelSubscriptionAutoRenewal` | Отмена автоматического продления подписки

  {% endcut %}

  {% cut "{{ speechsense-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `CreateTalksReport` | Создание отчета о диалоге
  `GetTalk` | Получение диалога
  `GetTalkAudio` | Получение аудиозаписи диалога
  `SearchTalks` | Поиск диалога
  `UploadTalkToConnection` | Загрузка диалога в подключение

  {% endcut %}

  {% cut "{{ websql-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateSavedQuery` | Сохранение запроса
  `DeleteExecutedQuery` | Удаление выполненного запроса
  `DeleteSavedQuery` | Удаление сохраненного запроса
  `EditSavedQuery` | Редактирование сохраненного запроса
  `PublishExecutedQuery` | Публикация выполненного запроса
  `PublishSavedQuery` | Публикация сохраненного запроса

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `Execute` | Выполнение запроса
  `GenerateSql` | Генерация запроса
  `GetDatabaseStructure` | Получение структуры базы данных

  {% endcut %}

  {% cut "{{ wiki-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

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

  {% cut "{{ certificate-manager-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateDomainAccessBindings` | Изменение прав доступа для домена

  {% endcut %}

  {% cut "{{ cloud-apps-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateCloudApplication` | Создание приложения
  `DeleteCloudApplication` | Удаление приложения
  `UpdateCloudApplication` | Изменение приложения

  {% endcut %}

  {% cut "{{ dns-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdatePrivateNetworks` | Изменение приватных сетей

  {% endcut %}

  {% cut "{{ cloud-logging-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ org-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateOsLoginProfile` | Создание профиля {{ oslogin }}
  `CreateUserSshKey` | Создание SSH-ключа пользователя
  `UpdateOsLoginProfile` | Изменение профиля {{ oslogin }}
  `UpdateOsLoginSettings` | Изменение настроек {{ oslogin }}
  `UpdateUserSshKey` | Изменение SSH-ключа пользователя
  `SetDefaultProfile` | Назначение профиля по умолчанию
  `DeleteOsLoginProfile` | Удаление профиля {{ oslogin }}
  `DeleteUserSshKey` | Удаление SSH-ключа пользователя

  {% endcut %}

  {% cut "{{ compute-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateHostGroup` | Создание группы выделенных хостов
  `DeleteHostGroup` | Удаление группы выделенных хостов
  `UpdateHostGroup` | Изменение группы выделенных хостов
  `serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса

  {% endcut %}

  {% cut "{{ kms-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `asymmetricencryption.CancelAsymmetricEncryptionKeyDeletion` | Отмена удаления асимметричной ключевой пары шифрования
  `asymmetricsignature.CancelAsymmetricSignatureKeyDeletion` | Отмена удаления ключевой пары электронной подписи

  {% endcut %}

  {% cut "{{ load-testing-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ mgl-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `CreateInstanceBackup` | Создание резервной копии инстанса
  `ReconfigureGitlab` | Изменение конфигурации GitLab
  `RescheduleMaintenance` | Перенос запланированного технического обслуживания
  `ScheduleUpgrade` | Назначение времени обновления инстанса

  {% endcut %}

  {% cut "{{ mch-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `UpdateClusterExternalDictionary` | Изменение внешнего словаря

  {% endcut %}


  {% cut "{{ mgp-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ mmg-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `DeleteBackup` | Удаление резервной копии

  {% endcut %}

  {% cut "{{ mmy-short-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных

  {% endcut %}

  {% cut "{{ mos-short-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `MoveCluster` | Перемещение кластера
  `UpdateDashboardsNodeGroup` | Изменение группы хостов типа `Dashboards`

  {% endcut %}

  {% cut "{{ mpg-short-name }}" %}

  [События уровня сервисов](./concepts/format-data-plane.md):

  Событие | Описание
  --- | ---
  `DatabaseUserLogin` | Подключение пользователя к базе данных
  `DatabaseUserLogout` | Отключение пользователя от базы данных
  `StartClusterFailover` | Запуск переключения мастера для кластера

  {% endcut %}

  {% cut "{{ TR }}" %}

  [События уровня конфигурации](./concepts/format.md):

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

  {% cut "{{ vpc-name }}" %}

  [События уровня конфигурации](./concepts/format.md):

  Событие | Описание
  --- | ---
  `RelocateSubnet` | Перемещение облачной подсети в другую зону доступности

  {% endcut %}

* Исправлена ошибка, из-за которой события поставлялись с задержкой, когда трейл находился в статусе `Error`.

* Изменен механизм доставки событий управления базами данных и пользователями внутри баз данных от сервисов {{ mpg-full-name }}, {{ mmy-full-name }} и {{ mmg-full-name }}. Теперь они относятся к [событиям уровня сервисов](./concepts/format-data-plane.md).
