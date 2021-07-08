# Резервное копирование в {{ objstorage-full-name }} через Acronis Backup Gateway

Чтобы настроить резервное копирование в {{ objstorage-name }} через Acronis Backup Gateway:

1. [Подготовьте облако к работе](#before-you-begin)
1. [Создайте бакет](#create-bucket)
1. [Настройте Acronis Backup Gateway](#configure-acronis)
1. [Протестируйте резервное копирование](#test-backup)
1. [Удалите созданные облачные ресурсы](#clear-out)

## Подготовьте облако к работе {#before-you-begin}

Перед использованием {{ objstorage-full-name }} нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](../../_includes/solutions/_common/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет находиться ваш бакет. Перейдите на [страницу облака](https://console.cloud.yandex.ru/cloud) и выберите или создайте каталог, в котором вы хотите создать бакет. [Подробнее об иерархии ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки резервного копирования и восстановления входит:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте бакет {#create-bucket}

Чтобы создать бакет для резервного копирования:

{% include [create-bucket](../_solutions_includes/create-public-bucket.md) %}

## Настройте Acronis Backup Gateway {#configure-acronis}

Чтобы настроить Acronis Backup Gateway для работы с {{ objstorage-name }}:

1. В Acronis Storage откройте меню **Services** и выберите пункт **Acronis Backup Gateway**.
1. Нажмите кнопку **Create Gateway**.
1. Выберите тип хранилища **Public Cloud**.
1. В списке **ABGW private** выберите сетевой интерфейс с ролью **ABGW private**.
1. В блоке **Public cloud parameters** задайте следующие настройки:
    1. Выберите тип провайдера **AuthV2 compatible**.
    1. В поле **Endpoint URL** укажите `{{ s3-storage-host }}`.
    1. Получите [статический ключ](../../iam/operations/sa/create-access-key.md) и укажите его для аутентификации.
    1. Укажите бакет `backup` для хранения резервных копий.
1. В блоке **Registration** укажите данные вашего аккаунта Acronis.
1. Нажмите кнопку **DONE**.

## Протестируйте резервное копирование {#test-backup}

1. Настройте резервное копирование в Acronis Backup по [инструкции](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33507.html).
1. Выполните резервное копирование по [инструкции](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#38855.html).

## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../_solutions_includes/storage-clear-out.md) %}
