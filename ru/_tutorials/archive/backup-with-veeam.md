# Резервное копирование в {{ objstorage-full-name }} с помощью Veeam Backup

{{ objstorage-name }} можно использовать для резервного копирования и восстановления данных с помощью [Veeam Backup & Replication](https://en.wikipedia.org/wiki/Veeam_Backup_%26_Replication), а также реализации резервного копирования по [правилу «3-2-1»](https://habr.com/ru/companies/veeam/articles/188544/).

Особенности использования {{ objstorage-name }} для резервного копирования с помощью Veeam:

* Совместимость с [протоколом S3](../../glossary/s3.md).
* Поддержка [блокировки](../../storage/concepts/object-lock.md) файлов `s3 object lock`.
* Возможность ограничения доступа к данным с помощью [ACL](../../storage/concepts/acl.md) и [Bucket Policy](../../storage/concepts/policy.md).

Чтобы настроить использование {{ objstorage-name }} для резервного копирования с помощью Veeam:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Настройте сервисный аккаунт](#configure-service-account).
1. [Настройте резервное копирование](#configure-veeam).
1. [Запустите резервное копирование](#start-veeam-backup-job).
1. [Запустите восстановление из резервной копии](#start-veeam-restore-job).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования с помощью Veeam входит:

* плата за хранение данных (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-operations));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md#prices-traffic)).


## Создайте бакет {#create-bucket}

{% note info %}

В {{ objstorage-name }} поддерживается резервное копирование с помощью Veeam только в бакеты с [классом хранилища по умолчанию](../../storage/concepts/storage-class.md#default-storage-class) — **Стандартное**.

{% endnote %}

Чтобы создать бакет для резервного копирования:

{% list tabs group=instructions %}

- Консоль управления {#console}
 
  {% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

{% endlist %}

## Настройте сервисный аккаунт {#configure-service-account}

Резервное копирование в {{ objstorage-name }} выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте](../../iam/operations/sa/create.md) его.

Чтобы настроить сервисный аккаунт:

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `storage.editor`.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа. Сохраните идентификатор и секретный ключ, они понадобятся при настройке доступа Veeam к бакету в {{ objstorage-name }}. После закрытия окна параметры закрытого ключа будут недоступны.


## Настройте резервное копирование {#configure-veeam}

{% note info %}

Убедитесь, что компьютер, на котором развернут Veeam, имеет доступ к эндпоинту `{{ s3-storage-host }}` через порты `80` и `443`.

{% endnote %}

Чтобы настроить Veeam для работы с {{ objstorage-name }}:

1. Запустите Veeam.
1. На панели управления слева выберите **Backup Infrastructure** → **Backup Repositories**.
1. В открывшемся окне выберите тип объектного хранилища `S3 Compatible`.
1. Введите имя создаваемого репозитория.
1. Укажите эндпоинт подключения к {{ objstorage-name }} `https://{{ s3-storage-host }}`.
1. Введите наименование региона `{{ region-id }}` и нажмите кнопку **Add**.
1. В поле **Access Key** вставьте идентификатор статического ключа доступа.
1. В поле **Secret Key** вставьте секретный ключ.
1. Из списка доступных бакетов в {{ objstorage-name }} выберите целевой бакет для хранения резервных копий.


## Запустите резервное копирование {#start-veeam-backup-job}

Чтобы выполнить резервное копирование в ранее созданный бакет {{ objstorage-name }}:

1. В окне Veeam найдите сервер, резервную копию которого вы хотите сделать. Нажмите на нем правую кнопку мыши и выберите **Add to backup job** → **New job**.
1. В открывшемся окне выберите **Type Server** → **Mode Managed by backup server**.
1. В окне выбора репозитория для резервного копирования выберите созданный ранее в {{ objstorage-name }}.
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

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
