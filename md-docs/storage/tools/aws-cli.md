# AWS Command Line Interface (AWS CLI)


[AWS CLI](https://aws.amazon.com/ru/cli/) — это интерфейс командной строки для работы с сервисами AWS. Общий [порядок вызова команд](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html) смотрите в официальной документации Amazon.

Для работы с Object Storage с помощью AWS CLI вы можете использовать следующие наборы команд:
* [s3api](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/index.html) — команды, соответствующие операциям в [REST API](../../glossary/rest-api.md). Перед использованием ознакомьтесь с [перечнем поддерживаемых операций](../s3/api-ref/index.md).
* [s3](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html) — дополнительные команды, упрощающие работу с большим количеством объектов.

## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях см. на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).

          
    Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
    
    * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
    * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
    * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
    
    Подробнее см. [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее см. [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

Для установки AWS CLI воспользуйтесь [инструкцией](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) на сайте разработчика.

## Настройка {#setup}

Для настройки AWS CLI в терминале введите команду `aws configure`. Команда запросит значения для следующих параметров:
1. `AWS Access Key ID` — идентификатор статического ключа, [полученный ранее](#before-you-begin).
1. `AWS Secret Access Key` — содержимое статического ключа, [полученное ранее](#before-you-begin).
1. `Default region name` — регион `ru-central1`.

    Для работы с Object Storage всегда указывайте регион — `ru-central1`. Другие значения региона могут привести к ошибке авторизации.

1. Значения остальных параметров оставьте без изменений.

### Конфигурационные файлы {#config-files}

В результате работы команда `aws configure` сохранит статический ключ и регион.
* Формат статического ключа в `.aws/credentials`:

  ```ini
  [default]
  aws_access_key_id = <идентификатор_статического_ключа>
  aws_secret_access_key = <содержимое_статического_ключа>
  ```

* Формат региона по умолчанию в `.aws/config`:

  ```ini
  [default]
  region = ru-central1
  ```


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее см. [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).


### Настройка дополнительного профиля {#additional-profile}

Вы можете создать несколько профилей для AWS CLI с помощью команды:

  ```bash
  aws configure --profile <имя_профиля>
  ```

Данные профилей будут сохранены в файлах `.aws/credentials` и `.aws/config` в следующем виде:
* `credentials`:

  ```ini
  [default]
  aws_access_key_id = <идентификатор_статического_ключа_1>
  aws_secret_access_key = <содержимое_статического_ключа_1>
  [<имя_профиля_2>]
  aws_access_key_id = <идентификатор_статического_ключа_2>
  aws_secret_access_key = <содержимое_статического_ключа_2>
  ...
  [<имя_профиля_n>]
  aws_access_key_id = <идентификатор_статического_ключа_n>
  aws_secret_access_key = <содержимое_статического_ключа_n>
  ```

* `config`:

  ```ini
  [default]
  region = ru-central1
  [profile <имя_профиля_2>]
  region = ru-central1
  ...
  [profile <имя_профиля_n>]
  region = ru-central1
  ```

  Где `default` — профиль по умолчанию.

Чтобы переключаться между разными профилями в командах AWS CLI используется опция `--profile`, например:

  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net/ \
    --profile <имя_профиля_2> \
    s3 mb s3://<имя_бакета>
  ```

## Особенности {#specifics}

Учитывайте особенности AWS CLI при работе с Object Storage:

* AWS CLI работает с Object Storage как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.
* По умолчанию клиент настроен на работу с серверами Amazon. Поэтому при запуске команды `aws` для работы с Object Storage обязательно используйте параметр `--endpoint-url`. Чтобы при каждом запуске не указывать параметр вручную, вы можете использовать файл конфигурации или псевдоним.
    * (поддерживается в AWS CLI версий 1.29.0, 2.13.0 и выше) В файле конфигурации `.aws/config` добавьте параметр `endpoint_url`:

       ```text
       endpoint_url = https://storage.yandexcloud.net
       ```

       После этого вы сможете вызывать команды без явного указания эндпоинта. Например, вместо `aws --endpoint-url=https://storage.yandexcloud.net s3 ls` можно указывать `aws s3 ls`. Подробнее смотрите в документации [AWS CLI](https://docs.aws.amazon.com/sdkref/latest/guide/feature-ss-endpoints.html).

    * Создайте псевдоним (alias) с помощью команды:

      ```bash
      alias ycs3='aws s3 --endpoint-url=https://storage.yandexcloud.net'
      ```

      Для создания псевдонима при каждом запуске терминала, добавьте команду `alias` в конфигурационный файл `~/.bashrc` или `~/.zshrc`, в зависимости от типа оболочки.

      С таким псевдонимом будут равносильны команды:

      ```bash
      aws s3 --endpoint-url=https://storage.yandexcloud.net ls
      ```

      ```bash
      ycs3 ls
      ```

## Примеры операций {#aws-cli-examples}

{% note info %}

Для включения отладочного вывода в консоли используйте флаг `--debug`.

{% endnote %}

### Создать бакет {#creating-bucket}

```bash
aws s3 mb s3://bucket-name
```

Результат:

```text
make_bucket: bucket-name
```

{% note info %}

При создании бакета помните об [ограничениях на имя](../concepts/bucket.md#naming).

{% endnote %}

### Загрузить объекты {#uploading-objects}

Можно загрузить все объекты из директории, использовать фильтр или загрузить объекты по одному.
* Загрузить все объекты из локальной директории:

  ```bash
  aws s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
  ```

  Результат:

  ```text
  upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
  upload: ./textfile2.txt to s3://bucket-name/path_style_prefix/textfile2.txt
  upload: ./prefix/textfile3.txt to s3://bucket-name/path_style_prefix/prefix/textfile3.txt
  ```

* Загрузить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре `--exclude`:

  ```bash
  aws s3 cp --recursive --exclude "*" --include "*.log" \
    local_files/ s3://bucket-name/path_style_prefix/
  ```

  Результат:

  ```text
  upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
  ```

* Загрузить объекты по одному, запуская для каждого объекта команду следующего вида:

  ```bash
  aws s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
  ```

  Результат:

  ```text
  upload: ./testfile.txt to s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Получить список объектов {#getting-objects-list}

```bash
aws s3 ls --recursive s3://bucket-name
```

Результат:
```text
2022-09-05 17:10:34      10023 other/test1.png
2022-09-05 17:10:34      57898 other/test2.png
2022-09-05 17:10:34     704651 test.png
```

### Удалить объекты {#deleting-objects}

Можно удалить объекты с заданным префиксом, использовать фильтр или удалить объекты по одному.

* Удалить все объекты с заданным префиксом:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/ --recursive
  ```

  Результат:

  ```text
  delete: s3://bucket-name/path_style_prefix/test1.png
  delete: s3://bucket-name/path_style_prefix/subprefix/test2.png
  ```

* Удалить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре`--exclude`:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/ --recursive \
      --exclude "*" --include "*.log"
  ```

  Результат:

  ```text
  delete: s3://bucket-name/path_style_prefix/test1.log
  delete: s3://bucket-name/path_style_prefix/subprefix/test2.log
  ```

* Удалить объекты по одному, запуская для каждого объекта команду следующего вида:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/textfile.txt
  ```

  Результат:

  ```text
  delete: s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Получить объект {#retrieving-objects}

```bash
aws s3 cp s3://bucket-name/textfile.txt textfile.txt
```
Результат:

```text
download: s3://bucket-name/path_style_prefix/textfile.txt to ./textfile.txt
```


## См. также {#see-also}

* [Как начать работать с AWS CLI в Yandex Object Storage](../quickstart/quickstart-aws-cli.md).