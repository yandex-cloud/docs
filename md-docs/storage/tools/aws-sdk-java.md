[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Инструменты](index.md) > SDK > AWS SDK для Java

# AWS SDK для Java


[AWS SDK для Java](https://aws.amazon.com/ru/sdk-for-java/) — это комплект средств разработки для работы с сервисами AWS, совместимый с Yandex Object Storage.

С помощью AWS SDK для Java вы создадите бакет, загрузите в него объекты, очистите содержимое бакета и удалите бакет.

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

{% note warning %}

31 декабря 2025 года прекращается поддержка AWS SDK для Java версии 1.x. Чтобы продолжать получать новые функции и обновления безопасности, рекомендуется перейти на AWS SDK для Java версии 2.x.

{% endnote %}

{% list tabs group=instructions %}

- AWS SDK v2.x {#sdk-v2}

    1. [Установите Java](https://www.oracle.com/java/technologies/downloads/).
    1. [Установите Apache Maven](https://maven.apache.org/install.html) для сборки проекта.
    1. [Создайте проект](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-projectsetup) согласно инструкции из документации AWS.
        
        Ниже приведена структура созданного проекта:
    
        ```text
        getstarted
        ├── README.md
        ├── pom.xml
        └── src
            ├── main
            │   ├── java
            │   │   └── org
            │   │       └── example
            │   │           ├── App.java
            │   │           ├── DependencyFactory.java
            │   │           └── Handler.java
            │   └── resources
            │       └── simplelogger.properties
            └── test
                └── java
                    └── org
                        └── example
                            └── HandlerTest.java
    
        10 directories, 7 files
        ```
    
    1. [Внесите изменения в код проекта](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-code) согласно инструкции из документации AWS.

- AWS SDK v1.x {#sdk-v1}
    
    Для установки AWS SDK для Java v.1.x воспользуйтесь [инструкцией](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-install.html) на сайте производителя.

{% endlist %}

## Настройка {#setup}

1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1.  В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, [полученные ранее](#before-you-begin):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = ru-central1
    endpoint_url = https://storage.yandexcloud.net
    ```

    {% note info %}

    Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому Object Storage принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).

    {% endnote %}

Для доступа к Object Storage используйте эндпоинт `https://storage.yandexcloud.net`.

## Изменение эндпоинта {#adapt-code}

{% list tabs group=instructions %}

- AWS SDK v2.x {#sdk-v2}

    1. В директории `/src/main/java/org/example` откройте файл `DependencyFactory.java` и измените класс `DependencyFactory`:

        ```java
        public class DependencyFactory {
            private DependencyFactory() {}
            public static S3Client s3Client() {
                return S3Client.builder()
                .endpointOverride(URI.create("https://storage.yandexcloud.net"))
                .httpClientBuilder(ApacheHttpClient.builder())
                .build();
            }
        }
        ```

    1. [Запустите код](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-run) согласно инструкции из документации AWS.

    Другие примеры использования AWS SDK для Java вы можете найти в [репозитории с примерами](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/javav2/example_code/s3/src/main/java/com/example/s3).

- AWS SDK v1.x {#sdk-v1}
    
    В директории `aws-java-sdk/samples/AmazonS3` в архиве с дистрибутивом SDK находится код, который нужно изменить.

    Чтобы подключиться к Object Storage замените в примере код:

    ```java
    AmazonS3 s3 = AmazonS3ClientBuilder.standard()
        .withCredentials(new AWSStaticCredentialsProvider(credentials))
        .withRegion("us-west-2")
        .build();
    ```

    на

    ```java
    AmazonS3 s3 = AmazonS3ClientBuilder.standard()
        .withCredentials(new AWSStaticCredentialsProvider(credentials))
        .withEndpointConfiguration(
            new AmazonS3ClientBuilder.EndpointConfiguration(
                "storage.yandexcloud.net","ru-central1"
            )
        )
        .build();
    ```

    Другие примеры использования AWS SDK для Java вы можете найти в [репозитории с примерами](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/java/example_code/s3/src/main/java/aws/example/s3).

{% endlist %}