[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Практические руководства](index.md) > Резервное копирование > Резервное копирование в Object Storage с помощью Veeam Backup

# Резервное копирование в Object Storage с помощью Veeam Backup

# Резервное копирование в Yandex Object Storage с помощью Veeam Backup

Object Storage можно использовать для резервного копирования и восстановления данных с помощью [Veeam Backup & Replication](https://en.wikipedia.org/wiki/Veeam_Backup_%26_Replication), а также реализации резервного копирования по [правилу «3-2-1»](https://habr.com/ru/companies/veeam/articles/188544/).

Особенности использования Object Storage для резервного копирования с помощью Veeam:

* Совместимость с [протоколом S3](../../glossary/s3.md).
* Поддержка [блокировки](../concepts/object-lock.md) файлов `s3 object lock`.
* Возможность ограничения доступа к данным с помощью [ACL](../concepts/acl.md) и [Bucket Policy](../concepts/policy.md).

Чтобы настроить использование Object Storage для резервного копирования с помощью Veeam:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Настройте сервисный аккаунт](#configure-service-account).
1. [Настройте резервное копирование](#configure-veeam).
1. [Запустите резервное копирование](#start-veeam-backup-job).
1. [Запустите восстановление из резервной копии](#start-veeam-restore-job).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования с помощью Veeam входит:

* плата за хранение данных ([тарифы Object Storage](../pricing.md#prices-storage));
* плата за операции с данными ([тарифы Object Storage](../pricing.md#prices-operations));
* стоимость исходящего трафика из Yandex Cloud в интернет ([тарифы Object Storage](../pricing.md#prices-traffic)).


## Создайте бакет {#create-bucket}

{% note info %}

В Object Storage поддерживается резервное копирование с помощью Veeam только в бакеты с [классом хранилища по умолчанию](../concepts/storage-class.md#default-storage-class) — **Стандартное**.

{% endnote %}

Чтобы создать бакет для резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}
 
  1. В [консоли управления](https://console.yandex.cloud) Yandex Cloud выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
  1. На странице каталога нажмите ![plus](../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите **Бакет**.
  1. В поле **Имя** укажите имя [бакета](../concepts/bucket.md) в соответствии с [правилами именования](../concepts/bucket.md#naming).
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
  1. Укажите максимальный размер бакета в ГБ.
  1. Нажмите **Создать бакет**.

{% endlist %}

## Настройте сервисный аккаунт {#configure-service-account}

Резервное копирование в Object Storage выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `storage.editor`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Сохраните идентификатор и секретный ключ, они понадобятся при настройке доступа Veeam к бакету в Object Storage. После закрытия окна параметры закрытого ключа будут недоступны.


## Настройте резервное копирование {#configure-veeam}

{% note info %}

Убедитесь, что компьютер, на котором развернут Veeam, имеет доступ к эндпоинту `storage.yandexcloud.net` через порты `80` и `443`.

{% endnote %}

Чтобы настроить Veeam для работы с Object Storage:

1. Запустите Veeam.
1. На панели управления слева выберите **Backup Infrastructure** → **Backup Repositories**.
1. В открывшемся окне выберите тип объектного хранилища `S3 Compatible`.
1. Введите имя создаваемого репозитория.
1. Укажите эндпоинт подключения к Object Storage `https://storage.yandexcloud.net`.
1. Введите наименование региона `ru-central1` и нажмите кнопку **Add**.
1. В поле **Access Key** вставьте идентификатор статического ключа доступа.
1. В поле **Secret Key** вставьте секретный ключ.
1. Из списка доступных бакетов в Object Storage выберите целевой бакет для хранения резервных копий.


## Запустите резервное копирование {#start-veeam-backup-job}

Чтобы выполнить резервное копирование в ранее созданный бакет Object Storage:

1. В окне Veeam найдите сервер, резервную копию которого вы хотите сделать. Нажмите на нем правую кнопку мыши и выберите **Add to backup job** → **New job**.
1. В открывшемся окне выберите **Type Server** → **Mode Managed by backup server**.
1. В окне выбора репозитория для резервного копирования выберите созданный ранее в Object Storage.
1. Из списка задач по резервному копированию выберите созданную ранее задачу. Нажмите на ней правой кнопкой мыши и выберите **Start**.
1. По окончании процесса резервного копирования будет сформирован подробный отчет.


## Запустите восстановление из резервной копии {#start-veeam-restore-job}

Чтобы восстановить из резервной копии файл или папку:

1. На панели управления слева выберите **Home** → **Backups** → **Object Storage**.
1. На созданной ранее резервной копии нажмите правой кнопкой мыши и выберите **Restore guest files**.
1. В окне выбора файлов и папок для восстановления нажмите **Browse**. 
1. В открывшемся диспетчере файлов выберите файл или папку для восстановления и нажмите **Restore**.
1. По окончании процесса восстановления из резервной копии будет сформирован подробный отчет.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../operations/objects/delete-all.md) [объекты](../concepts/object.md) в [бакете](../concepts/bucket.md).
1. [Удалите](../operations/buckets/delete.md) бакет.