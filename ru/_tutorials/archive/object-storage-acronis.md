# Резервное копирование в {{ objstorage-full-name }} через Acronis Backup Gateway

Чтобы настроить резервное копирование в {{ objstorage-name }} через [Acronis](https://www.acronis.com/en-us/products/backup/cloud-storage/) Backup Gateway:

1. [Подготовьте облако к работе](#before-you-begin)
1. [Создайте бакет](#create-bucket)
1. [Настройте Acronis Backup Gateway](#configure-acronis)
1. [Протестируйте резервное копирование](#test-backup)

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Для настройки резервного копирования вам понадобится сервисный аккаунт с ключами доступа:

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с ролью `editor`.
1. [Создайте](../../iam/operations/sa/create-access-key.md) статические ключи доступа. Сразу сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры закрытого ключа будут недоступны.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования и восстановления входит:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования:

{% include [create-bucket](../_tutorials_includes/create-public-bucket.md) %}

## Настройте Acronis Backup Gateway {#configure-acronis}

Чтобы настроить Acronis Backup Gateway для работы с {{ objstorage-name }}:

1. Создайте [аккаунт Acronis](https://account.acronis.com/#/auth/signup).
1. В [Acronis Cloud Storage](https://www.acronis.com/en-us/products/backup/cloud-storage/) откройте меню **Services** и выберите пункт **Acronis Backup Gateway**.
1. Нажмите кнопку **Create Gateway**.
1. Выберите тип хранилища **Public Cloud**.
1. В списке **ABGW private** выберите сетевой интерфейс с ролью **ABGW private**.
1. В блоке **Public cloud parameters** задайте следующие настройки:
    1. Выберите тип провайдера **AuthV2 compatible**.
    1. В поле **Endpoint URL** укажите `{{ s3-storage-host }}`.
    1. Укажите статический ключ для аутентификации.
    1. Укажите бакет для хранения резервных копий.
1. В блоке **Registration** укажите данные вашего аккаунта Acronis.
1. Нажмите кнопку **DONE**.

## Протестируйте резервное копирование {#test-backup}

Настройте и выполните резервное копирование в Acronis Backup по [инструкции](https://www.acronis.com/en-us/support/documentation/BackupService/index.html#33507.html).

## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../_tutorials_includes/storage-clear-out.md) %}
