# Обработка аудитных логов Yandex Audit Trails

Yandex Audit Trails — сервис для сбора и выгрузки аудитных логов ресурсов Yandex Cloud в различные принимающие системы, в том числе в Yandex Object Storage и в Yandex Data Streams. Audit Trails и Yandex Query интегрированы между собой, что позволяет решать задачи поиска в аудитных логах.

![image](../../_assets/query/audit-trails-query.png)

Обработав аудитные логи с помощью Query, можно получить, например, такую информацию:

* кто удалил каталог облака;
* кто добавил доступ к серийной консоли ВМ Yandex Compute Cloud;
* кто изменил права на доступ к бакету Object Storage;
* кто получил права администратора.

Заранее подготовленные запросы для таких сценариев доступны [в репозитории на GitHub](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches). Так же вы можете создавать свои собственные [запросы на языке YQL](../../query/yql-tutorials/index.md).

В этом сценарии вы создадите [трейлы](../../audit-trails/concepts/trail.md), которые будут загружать аудитные логи всех ресурсов [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [бакет](../../storage/concepts/bucket.md) Object Storage, а также отправлять их в [поток](../concepts/glossary.md#stream-concepts) Data Streams. Далее вы выполните аналитический и потоковый запросы к данным логов с помощью Query.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Настройте Audit Trails {#at-setup}

[Создайте два трейла](../../audit-trails/operations/create-trail.md):

* для загрузки аудитных логов каталога в бакет Object Storage;
* для отправки аудитных логов каталога в поток Data Streams.

## Настройте интеграцию Audit Trails и Query {#integration}


Чтобы настроить интеграцию:

1. Перейдите к списку трейлов в консоли Yandex Cloud.
1. Выберите созданный ранее трейл для загрузки аудитных логов облака в бакет и нажмите кнопку **Обработать в YQ**.
1. При первом переходе из Audit Trails в Query необходимо выполнить настройку интеграции:
   1. В интерфейсе Query в диалоге создания соединения выберите сервисный аккаунт, от имени которого будет выполнять чтение данных из Object Storage и нажмите кнопку **Создать**.
   1. В интерфейсе Query в диалоге создания привязки к данным проверьте предустановленные параметры, нажав кнопку **Предпросмотр**, после чего завершите интеграцию, нажав кнопку **Создать**.

Вы будете автоматически перемещены на панель **Audit trails** интерфейса Query.

Выполните аналогичные действия для созданного ранее трейла, который отправляет данные в поток Data Streams.

## Аналитические запросы к данным в Object Storage

Чтобы выполнить запрос к аналитическим данным Audit Trails, которые хранятся в Object Storage:

1. На панели **Audit trails** интерфейса Query выберите тип анализа данных **Аналитический**, а в списке [привязок к данным](../../query/concepts/glossary.md#binding) выберите `audit-trails-test-object_storage`.
1. Выберите нужный запрос к данным из Object Storage из списка и нажмите кнопку **Выполнить**.

Результаты аналитического запроса можно:

* скачать через интерфейс пользователя Query с помощью кнопки **Экспорт**;
* [сохранить в бакет](../../query/sources-and-sinks/object-storage-write.md) Object Storage;
* получить и обработать через [Query HTTP API](../../query/api/index.md).
<!-- * [визуализировать](../../query/tutorials/datalens.md) в Yandex DataLens; -->

## Потоковые запросы к данным из Data Streams


Чтобы выполнить запрос к потоковым данным Audit Trails, которые передаются через Data Streams:

1. В разделе **Audit trails** в интерфейсе **Yandex Query** выберите нужный тип анализа данных: **Потоковый**, а в списке [привязок к данным](../../query/concepts/glossary.md#binding) выберите нужную.
1. Выберите нужный запрос к данным из Object Storage из списка и нажмите кнопку **Выполнить**.

Результаты потокового запроса можно:

* [отправить в Yandex Monitoring](../../query/sources-and-sinks/monitoring.md) в виде метрик;
* [отправить в выходной поток Data Streams](../../query/sources-and-sinks/data-streams-write.md) в виде данных, а далее обработать с помощью [триггеров Yandex Cloud Functions](../../functions/operations/trigger/data-streams-trigger-create.md).

## См. также

* [Yandex Object Storage](../../storage/index.md).
* [Yandex Data Streams](../index.md).
* [Yandex DataLens](../../datalens/index.md).