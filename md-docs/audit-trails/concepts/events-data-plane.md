# Справочник событий уровня сервисов

Значение поля `event_type` (_тип события_) аудитного лога уровня сервисов определяется сервисом-источником события.

Общий вид значения:

```text
{{ at-event-prefix }}.audit.<имя_сервиса>.<имя_события>
```

Подробная JSON-структура записи события приведена в справочнике аудитных логов. События в нем отсортированы по алфавиту без разделения на уровни и содержат все возможные поля. В реальных логах набор полей зависит от параметров события и конкретного объекта.

Ниже описаны события для сервисов:

* [{{ alb-full-name }}](events-data-plane.md#alb)
* [{{ baremetal-full-name }}](events-data-plane.md#baremetal)
* [{{ certificate-manager-full-name }}](events-data-plane.md#certificate-manager)
* [{{ cloud-desktop-full-name }}](events-data-plane.md#clouddesktop)
* [{{ dns-full-name }}](events-data-plane.md#dns)
* [{{ compute-full-name }}](events-data-plane.md#compute)
* [{{ ai-studio-full-name }}](events-data-plane.md#ai-studio)
* [{{ org-full-name }}](events-data-plane.md#organization)
* [{{ iam-full-name }}](events-data-plane.md#iam)
* [{{ kms-full-name }}](events-data-plane.md#kms)
* [{{ lockbox-full-name }}](events-data-plane.md#lockbox)
* [{{ mkf-full-name }}](events-data-plane.md#mkf)
* [{{ mch-full-name }}](events-data-plane.md#mch)
* [{{ managed-k8s-full-name }}](events-data-plane.md#managed-service-for-kubernetes)
* [{{ mmg-full-name }}](events-data-plane.md#mmg)
* [{{ mmy-full-name }}](events-data-plane.md#mmy)
* [{{ mos-full-name }}](events-data-plane.md#mos)
* [{{ mpg-full-name }}](events-data-plane.md#mpg)
* [{{ mspqr-full-name }}](events-data-plane.md#spqr)
* [{{ mrd-full-name }}](events-data-plane.md#mrd)
* [{{ objstorage-full-name }}](events-data-plane.md#objstorage)
* [{{ sd-full-name }}](events-data-plane.md#security-deck)
* [{{ speechkit-full-name }}](events-data-plane.md#speechkit)
* [{{ speechsense-full-name }}](events-data-plane.md#speechsense)
* [{{ sws-full-name }}](events-data-plane.md#sws)
* [{{ translate-full-name }}](events-data-plane.md#translate)
* [{{ vpc-full-name }}](events-data-plane.md#vpc)
* [{{ vision-full-name }}](events-data-plane.md#vision)
* [{{ wiki-full-name }}](events-data-plane.md#wiki)
* [{{ websql-full-name }}](events-data-plane.md#websql)

## {{ alb-full-name }} {#alb}

Имя сервиса — `apploadbalancer`.

Имя события | Описание
--- | ---
`LoadBalancerHTTPAccessLog` | Логирование HTTP-запросов
`LoadBalancerTCPAccessLog` | Логирование TCP-запросов

## {{ baremetal-full-name }} {#baremetal}

Имя сервиса — `baremetal`.

Имя события | Описание
--- | ---
`flowlogs.ExternalFlow` | Поток трафика серверов {{ baremetal-name }} во внешние сети

## {{ certificate-manager-full-name }} {#certificate-manager}

Имя сервиса — `certificatemanager`.

Имя события | Описание
--- | ---
`GetCertificateContent` | Получение содержимого SSL-сертификата
`GetExCertificateContent` | Получение содержимого истекшего SSL-сертификата

## {{ cloud-desktop-full-name }} {#clouddesktop}

Имя сервиса — `clouddesktop`.

Имя события | Описание
--- | ---
`GenerateDesktopRDPFile` | Генерация RDP-файла для подключения к рабочему столу
`ResetDesktopPassword` | Сброс пароля рабочего стола

## {{ dns-full-name }} {#dns}

Имя сервиса — `dns`.

Имя события | Описание
--- | ---
`ProcessDnsQuery` | Результат выполнения DNS запроса от клиента Cloud DNS

{% note info %}

Если действие выполнил один из инфраструктурных сервисов {{ yandex-cloud }} или сотрудник поддержки, то в полях `client_ip` и `server_ip` в секции `details` будет указано специальное значение: `cloud.yandex`.

{% endnote %}

## {{ compute-full-name }} {#compute}

Имя сервиса — `compute`.

Имя события | Описание
--- | ---
`serialssh.ConnectSerialPort` | Подключение к серийному порту инстанса
`MigrateInstance` | [Динамическая миграция](../../compute/concepts/live-migration.md) ВМ ^*^ 

\* В аудитный лог попадают события только для ВМ с настроенной [политикой обслуживания](../../compute/concepts/maintenance-policies.md).

## {{ ai-studio-full-name }} {#ai-studio}

Имя сервиса — `ai`.

Имя события | Описание
--- | ---
`foundationmodels.GetTextProcessingResult` | Запрос на получение результата генерации
`foundationmodels.TextProcessing` | Запрос на генерацию
`searchindex.CreateSearchIndex` | Создание поискового индекса
`searchindex.DeleteFilesFromSearchIndex` | Удаление файлов из поискового индекса
`searchindex.DeleteSearchIndex` | Удаление поискового индекса
`searchindex.UploadFilesToSearchIndex` | Загрузка файлов в поисковый индекс

## {{ org-full-name }} {#organization}

Имя сервиса — `organizationmanager`.

Имя события | Описание
--- | ---
`idp.AuthenticateByPassword` | Аутентификация по паролю

## {{ iam-full-name }} {#iam}

Имя сервиса — `iam`.

Имя события | Описание
--- | ---
`awscompatibility.CreateEphemeralAccessKey` | Создание эфемерного статического ключа доступа
`awscompatibility.CreateTemporaryAccessKey` | Создание временного ключа доступа
`CreateIamToken` | Создание IAM-токена
`credential.ApplicationLoginEvent` | Вход пользователя в приложение
`credential.CreateRefreshTokenForSubject` | Создание [refresh-токена](../../iam/concepts/authorization/refresh-token.md) для пользователя
`credential.CreateYcSsprToken` | Создание токена для самостоятельного сброса пароля
`credential.RevokeRefreshTokenForSubject` | Отзыв refresh-токена у пользователя
`credential.RevokeSsoSession` | Завершение SSO-сессии
`mfa.VerifyUserCredential` | Подтверждение учетных данных пользователя в процессе проверки дополнительных [факторов MFA](../../organization/concepts/mfa.md)
`oslogin.CheckSshPolicy` | Проверка прав на подключение по SSH при доступе по {{ oslogin }}
`oslogin.GenerateSshCertificate` | Генерация SSH-сертификата для доступа по {{ oslogin }}
`RevokeIamToken` | Отзыв IAM-токена

## {{ kms-full-name }} {#kms}

Имя сервиса — `kms`.

Имя события | Описание
--- | ---
`Decrypt` | Расшифрование шифртекста с помощью ключа
`Encrypt` | Шифрование тестовой строки с помощью ключа
`GenerateDataKey` | Формирование ключа с высокой энтропией для шифрования по схеме Envelope Encryption
`ReEncrypt` | Расшифрование шифртекста ключом с предыдущей версией и шифрование расшифрованного текста новой версией этого же ключа

## {{ lockbox-full-name }} {#lockbox}

Имя сервиса — `lockbox`.

Имя события | Описание
--- | ---
`GetPayload` | Факт доступа к содержимому секрета
`GetPayloadEx` | Факт доступа к содержимому секрета по каталогу или имени

## {{ mkf-full-name }} {#mkf}

Имя сервиса — `mdb.kafka`.

Имя события | Описание
--- | ---
`AlterConfigAdminApi` | Изменение конфигурации Admin API
`CreateTopicAdminApi` | Создание топика Admin API
`DeleteTopicAdminApi` | Удаление топика Admin API

## {{ mch-full-name }} {#mch}

Имя сервиса — `mdb.clickhouse`.

Имя события | Описание
--- | ---
`CreateDatabase` | Создание базы данных
`CreateFormatSchema` | Создание схемы формата данных
`CreateMlModel` | Создание модели машинного обучения
`CreateUser` | Создание пользователя базы данных
`DatabaseUserLogin` | Подключение пользователя к базе данных
`DatabaseUserLogout` | Отключение пользователя от базы данных
`DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных
`DeleteDatabase` | Удаление базы данных
`DeleteFormatSchema` | Удаление схемы формата данных
`DeleteMlModel` | Удаление модели машинного обучения
`DeleteUser` | Удаление пользователя базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`SetClusterExtensions` | Установка расширений для кластера
`UpdateFormatSchema` | Изменение схемы формата данных
`UpdateMlModel` | Изменение модели машинного обучения
`UpdateUser` | Изменение пользователя базы данных

## {{ managed-k8s-full-name }} {#managed-service-for-kubernetes}

Имя сервиса — `k8s`.

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

## {{ mmg-full-name }} {#mmg}

Имя сервиса — `mdb.mongodb`.

Имя события | Описание
--- | ---
`AuthCheck` | Проверка аутентификации
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GenericAuditEvent` | Запуск проверки базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных
`UserAuthentication` | Аутентификация пользователя
`UserLogout` | Отключение пользователя от базы данных

## {{ mmy-full-name }} {#mmy}

Имя сервиса — `mdb.mysql`.

Имя события | Описание
--- | ---
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DatabaseUserSQLRequest` | SQL-запрос пользователя к базе данных^1^
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных

^1^ Требуется включение [настроек {{ MY }}](../../managed-mysql/concepts/settings-list.md#dbms-cluster-settings): **Audit log** и **Audit log policy**. Включение этих настроек может создать дополнительную нагрузку на хосты кластера, поэтому рекомендуется предварительно проверить работу системы в dev/stage-средах. Также их включение может потребовать перезапуска сервисов, поэтому для включения рекомендуется выбрать время наименьшей нагрузки на кластер.

## {{ mos-full-name }} {#mos}

Имя сервиса — `mdb.opensearch`.

Имя события | Описание
--- | ---
`ComplianceReadEvent` | Чтение данных в соответствии с требованиями безопасности
`ComplianceWriteEvent` | Запись данных в соответствии с требованиями безопасности
`FailedLoginRestEvent` | Неудачная попытка аутентификации при выполнении REST‑запроса
`GrantedPrivilegesRestEvent` | Предоставление прав доступа для выполнения REST-запросов
`GrantedPrivilegesTransportEvent` | Предоставление прав доступа для выполнения внутренних запросов
`MissingPrivilegesRestEvent` | Недостаточно прав доступа для выполнения REST-запросов
`MissingPrivilegesTransportEvent` | Недостаточно прав доступа для выполнения внутренних запросов
`SecurityIndexAttemptTransportEvent` | Попытка доступа к индексу безопасности через внутренний запрос

## {{ mgp-full-name }} {#mgp}

Имя сервиса — `mdb.greenplum`.

Имя события | Описание
--- | ---
`CreateHBARule` | Создание правила аутентификации пользователей
`CreatePXFDatasource` | Создание подключения к внешней таблице
`CreateResourceGroup` | Создание ресурсной группы
`CreateUser` | Создание пользователя базы данных
`DeleteHBARule` | Удаление правила аутентификации пользователей
`DeletePXFDatasource` | Удаление подключения к внешней таблице
`DeleteResourceGroup` | Удаление ресурсной группы
`DeleteUser` | Удаление пользователя базы данных
`ListPXFDatasources` | Получение списка подключений к внешней таблице
`ListUsers` | Получение списка пользователей базы данных
`UpdateHBARule` | Изменение правила аутентификации пользователей
`UpdatePXFDatasource` | Изменение подключения к внешней таблице
`UpdateResourceGroup` | Изменение ресурсной группы
`UpdateUser` | Изменение пользователя базы данных

## {{ mpg-full-name }} {#mpg}

Имя сервиса — `mdb.postgresql`.

Имя события | Описание
--- | ---
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DatabaseUserLogin` | Подключение пользователя к базе данных
`DatabaseUserLogout`| Отключение пользователя от базы данных
`DatabaseUserSQLRequest`| SQL-запрос пользователя к базе данных^1^
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`GetDatabase` | Получение информации о базе данных
`GetUser` | Получение информации о пользователе базы данных
`GrantUserPermission` | Назначение прав пользователю базы данных
`ListDatabases` | Получение списка баз данных
`ListUsers` | Получение списка пользователей базы данных
`RevokeUserPermission` | Отзыв прав у пользователя базы данных
`UpdateDatabase` | Изменение базы данных
`UpdateUser` | Изменение пользователя базы данных

^1^ Требуется дополнительная настройка на стороне {{ mpg-name }}. Подробнее см. в разделе [{#T}](../../managed-postgresql/operations/extensions/pgaudit.md)

## {{ mspqr-full-name }} {#spqr}

Имя сервиса — `mdb.spqr`.

Имя события | Описание
--- | ---
`AddClusterShards` | Добавление шардов в кластер
`CreateDatabase` | Создание базы данных
`CreateUser` | Создание пользователя базы данных
`DeleteClusterShards` | Удаление шардов из кластера
`DeleteDatabase` | Удаление базы данных
`DeleteUser` | Удаление пользователя базы данных
`UpdateUser` | Изменение пользователя базы данных

## {{ mrd-full-name }} {#mrd}

Имя сервиса — `mdb.redis`.

Имя события | Описание
--- | ---
`CreateUser` | Создание пользователя в кластере
`DatabaseConnectionClose` | Закрытие подключения к базе данных
`DatabaseConnectionOpen` | Открытие подключения к базе данных
`DatabaseUserLogin` | Вход пользователя в базу данных
`DeleteUser` | Удаление пользователя из кластера
`UpdateUser` | Обновление пользователя в кластере

## {{ objstorage-full-name }} {#objstorage}

Имя сервиса — `storage`.

Имя события | Описание
--- | ---
`ObjectAclUpdate` | Изменение ACL объекта в бакете
`ObjectCreate` | Создание объекта в бакете
`ObjectDelete` | Удаление объекта из бакета
`ObjectGetByPresignURL` | Получение объекта из бакета по [подписанному URL](../../storage/security/overview.md#pre-signed)
`ObjectTagsDelete` | Удаление тегов объекта в бакете
`ObjectTagsUpdate` | Изменение тегов объекта в бакете
`ObjectUpdate` | Изменение объекта в бакете
`PresignURLCreate` | Создание подписанной ссылки

## {{ sd-full-name }} {#security-deck}

Имя сервиса — `securitydeck`.

### Модуль {{ atr-name }} {#sd-access-transparency}

Имя модуля — `securitydeck.accesstransparency`.

Имя события | Описание
--- | ---
`ComputeNodeAccess` | Подключение [модуля](../../security-deck/concepts/access-transparency.md) {{ atr-name }} к [подкластеру](../../data-proc/concepts/index.md#resources) {{ dataproc-name }}
`MDBClusterAccess` | Подключение модуля {{ atr-name }} к кластеру базы данных

### Модуль {{ alerts-name }} {#sd-alerts}

Имя модуля — `securitydeck.alerts`.

Имя события | Описание
--- | ---
`CreateAlert` | Создание алерта

### Модуль Контроль конфигурации ({{ cspm-name }}) {#sd-cspm}

Имя модуля — `securitydeck.cspm`.

Имя события | Описание
--- | ---
`AssetFailedRuleCheck` | Отчет [модуля](../../security-deck/concepts/cspm.md) {{ cspm-name }} о неудачной проверке объекта
`AssetPassedRuleCheck` | Отчет модуля {{ cspm-name }} об успешной проверке объекта
`AssetRuleCheckCouldNotBeExecuted` | Отчет модуля {{ cspm-name }} об ошибке проверки объекта
`AssetRuleCheckNoLongerInScope` | Отчет модуля {{ cspm-name }} об исключении правила из области действия

### Модуль Контроль {{ k8s }}® ({{ kspm-name }}) {#sd-kspm}

Имя модуля — `securitydeck.kspm`.

Имя события | Описание
--- | ---
`TriggerAdmissionControl` | Срабатывание [модуля](../../security-deck/concepts/kspm.md) {{ kspm-name }} при проверке создаваемых и изменяемых ресурсов
`TriggerRuntimeControl` | Срабатывание модуля {{ kspm-name }} при контроле безопасности рабочих нагрузок
`TriggerRuntimeProcessInfo` | Срабатывание модуля {{ kspm-name }} при получении информации о процессе

## {{ speechkit-full-name }} {#speechkit}

Имя сервиса — `ai.speechkit`.

Имя события | Описание
--- | ---
`stt.GetRecognition` | Запрос на получение результатов асинхронного распознавания речи
`stt.RecognizeSpeechAsync` | Запрос на асинхронное для распознавание речи
`stt.RecognizeSpeechStream` | Запрос на потоковое распознавание речи
`tts.UtteranceSynthesis` | Запрос на синтез речи

## {{ speechsense-full-name }} {#speechsense}

Имя сервиса — `speechsense`.

Имя события | Описание
--- | ---
`CreateTalksReport` | Создание отчета о диалоге
`GetTalk` | Получение диалога
`GetTalkAudio` | Получение аудиозаписи диалога
`SearchTalks` | Поиск диалога
`UploadTalkToConnection` | Загрузка диалога в подключение

## {{ sws-full-name }} {#sws}

Имя сервиса — `smartwebsecurity`.

Имя события | Описание
--- | ---
`ArlMatchedRequest` | Срабатывание правила из профиля ARL
`SWSMatchedRequest` | Срабатывание правила профиля безопасности
`WafMatchedExclusionRule` | Срабатывание правила-исключения из профиля WAF
`WafMatchedRule` | Срабатывание правила из профиля WAF

## {{ translate-full-name }} {#translate}

Имя сервиса — `ai.translate`.

Имя события | Описание
--- | ---
`TranslateText` | Запрос на перевод текста

## {{ vpc-full-name }} {#vpc}

Имя сервиса — `network`.

Имя события | Описание
--- | ---
`CreateIpfix` | Создание записи о сетевой трансляции адреса ([NAT](https://wikipedia.org/wiki/Nat))
`DeleteIpfix` | Удаление записи о сетевой трансляции адреса (NAT)
`ExternalFlow` | Поток трафика во внешние сети по отношению к {{ vpc-short-name }}

## {{ vision-full-name }} {#vision}

Имя сервиса — `ai.ocr`.

Имя события | Описание
--- | ---
`RecognizeText` | Запрос на распознавание текста
`GetRecognition` | Запрос на получение распознанного результата

## {{ wiki-full-name }} {#wiki}

Имя сервиса — `wiki`.

Имя события | Описание
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
`ChangeOrganizationDomain` | Изменение домена организации
`ChangeOrganizationMetrika` | Изменение [счетчика Яндекс Метрики](https://yandex.ru/support/wiki/ru/add-metrika) организации
`ChangeOrganizationSettings` | Изменение настроек организации
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
`InviteActivate` | Активация приглашения
`InviteDelete` | Удаление приглашения
`InviteReactivate` | Повторная отправка приглашения
`InviteRemoveAccess` | Отмена доступа по приглашению
`InviteRemoveAllAccesses` | Отмена доступа по всем приглашениям
`InviteUse` | Использование приглашения
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

## {{ websql-full-name }} {#websql}

Имя сервиса — `websql`.

Имя события | Описание
--- | ---
`Execute` | Выполнение запроса
`GenerateSql` | Генерация запроса
`GetDatabaseStructure` | Получение структуры базы данных