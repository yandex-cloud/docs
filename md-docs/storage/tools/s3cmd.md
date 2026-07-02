[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Инструменты](index.md) > Консольные клиенты > S3cmd

# S3cmd


[S3cmd](https://s3tools.org/s3cmd) — это консольный клиент (Linux, Mac) для сервисов, поддерживающих HTTP API Amazon S3. Общий порядок вызова команд смотрите в [официальной документации](https://s3tools.org/usage) S3cmd.

{% note info %}

S3cmd не поддерживает работу с [версиями](../concepts/versioning.md) объектов. Чтобы работать с версиями объектов, используйте [AWS CLI](aws-cli.md).

{% endnote %}

## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях смотрите на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).

          
    Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
    
    * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
    * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
    * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
    
    Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

Чтобы установить S3cmd, ознакомьтесь с [разделом установки](https://github.com/s3tools/s3cmd/blob/master/INSTALL.md) в репозитории S3cmd на GitHub.

## Настройка {#setup}

Для настройки S3cmd используйте команду `s3cmd --configure`. При запросе укажите значения для следующих параметров:

* `Access Key` — введите идентификатор ключа, [полученный ранее](#before-you-begin);
* `Secret Key` — содержимое статического ключа, [полученное ранее](#before-you-begin);
* `Default Region` — введите `ru-central1`;

   Для работы с Object Storage всегда указывайте регион `ru-central1`. Другие значения региона могут привести к ошибке авторизации.

* `S3 Endpoint` — введите `storage.yandexcloud.net`;
* `DNS-style bucket+hostname:port template for accessing a bucket` — введите `%(bucket)s.storage.yandexcloud.net`;
* Значения остальных параметров оставьте без изменений;

Программа попытается установить соединение с Object Storage и получить список бакетов. В случае успеха, программа выведет `Success. Your access key and secret key worked fine :-)`.

Команда `s3cmd --configure` сохранит настройки в файле `~/.s3cfg` в формате:

```text
[default]
access_key = id
secret_key = secretKey
bucket_location = ru-central1
host_base = storage.yandexcloud.net
host_bucket = %(bucket)s.storage.yandexcloud.net
```

При необходимости эти настройки можно изменить напрямую в файле. Также можно указать настройки при запуске программы с помощью соответствующих параметров.

Для корректной работы команд, управляющих хостингом статических сайтов, в конфигурационный файл необходимо вручную добавить параметр:

```text
website_endpoint = http://%(bucket)s.website.yandexcloud.net
```

## Особенности {#specifics}

- S3cmd работает с Object Storage как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.
- S3cmd не поддерживает работу с [версиями](../concepts/versioning.md) объектов. Чтобы работать с версиями объектов, используйте [AWS CLI](aws-cli.md).
- По умолчанию S3cmd загружает объекты в стандартное хранилище. Чтобы указать [класс хранилища](../concepts/storage-class.md), при загрузке объекта используйте параметр `--storage-class`.
- По умолчанию при загрузке объекта S3cmd может отправлять дополнительный заголовок `X-Amz-Meta-S3cmd-Attrs` с атрибутами вашего файла (права доступа, владельцы файла, временные метки). Значение заголовка сохраняется в [метаданных](../concepts/object.md#metadata) объекта. Отключить отправку атрибутов можно с помощью параметра `preserve_attrs = False` в конфигурационном файле `~/.s3cfg` или флага `--no-preserve`.

## Примеры операций {#s3cmd-examples}

{% note info %}

Для включения отладочного вывода в консоли используйте флаг `--debug`.

{% endnote %}

### Получить список бакетов {#listing-buckets}

{% note info %}

Авторизация в [Amazon S3 HTTP API](../s3/index.md) и [инструментах с его поддержкой](index.md) осуществляется с помощью [статических ключей](../../iam/concepts/authorization/access-key.md), полученных для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

Вы можете просматривать список бакетов только в том каталоге, в котором был создан используемый сервисный аккаунт.

{% endnote %}

```bash
s3cmd ls
```

### Создать бакет {#creating-bucket}

```bash
s3cmd mb s3://bucket
```

При создании бакета помните об [ограничениях на имя](../concepts/bucket.md#naming).

### Загрузить объект в холодное хранилище {#uploading-object}

```bash
s3cmd --storage-class COLD put local_file s3://bucket/object
```

### Получить список объектов {#getting-object-list}

```bash
s3cmd ls s3://bucket
```

### Получить объект {#retrieving-object}

```bash
s3cmd get s3://bucket/object local_file
```

### Удалить объект {#deleting-object}

```bash
s3cmd del s3://bucket/object
```

### Загрузка объекта с указанием MIME-типов {#mime-types}

Для указания [MIME-типов](https://ru.wikipedia.org/wiki/Список_MIME-типов) при загрузке объектов используйте команду `put` со следующими флагами:

```bash
s3cmd put \
  --no-guess-mime-type \
  --no-mime-magic \
  --mime-type="application/javascript" \
  <путь_к_локальному_файлу> \
  s3://<имя_бакета>/
```

Где `--mime-type` — MIME-тип вашего объекта.