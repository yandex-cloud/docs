# AWS SDK для C++


[AWS SDK для C++](https://aws.amazon.com/ru/sdk-for-cpp/) — это комплект средств разработки для работы с сервисами AWS.

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

Для установки AWS SDK для C++ воспользуйтесь [инструкцией](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/setup-linux.html) на сайте производителя.

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

## Примеры кода {#cpp-sdk-examples}

[Смотри примеры кода C++](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/cpp/example_code/s3) для работы с S3 от производителя.

Ниже представлен пример простой программы, иллюстрирующий отличие в настройках для Yandex Object Storage.

### CmakeLists 

```cmake
cmake_minimum_required(VERSION 3.8)
project("s3-examples")
set(CMAKE_CXX_STANDARD 20)

if(NOT BUILD_SHARED_LIBS)
    set(BUILD_SHARED_LIBS ON)
endif()

find_package(AWSSDK REQUIRED COMPONENTS s3 sts)

add_executable(EXAMPLE EXAMPLE_FILE_S3.cpp)

target_link_libraries(EXAMPLE ${AWSSDK_LINK_LIBRARIES}
${AWSSDK_PLATFORM_DEPS})
```

### Файл EXAMPLE_FILE_S3.cpp 

```cpp
#include <aws/core/Aws.h>
#include <aws/core/auth/AWSCredentialsProvider.h>
#include <aws/s3/S3Client.h>
#include <aws/s3/model/Bucket.h>
#include <aws/s3/model/CreateBucketConfiguration.h>
#include <aws/s3/model/CreateBucketRequest.h>
#include <aws/s3/model/DeleteBucketRequest.h>
#include <aws/s3/model/ListObjectsRequest.h>
#include <aws/s3/model/PutObjectRequest.h>
#include <sys/stat.h>

#include <fstream>
#include <iostream>


// Находит бакет и выводит его содержимое в консоль
bool FindTheBucket(const Aws::S3::S3Client& s3Client, const Aws::String& bucketName)
{
    Aws::S3::Model::ListBucketsOutcome outcome = s3Client.ListBuckets();
    Aws::S3::Model::ListObjectsRequest request;

    if (outcome.IsSuccess()) {
        std::cout << "Looking for a bucket named '" << bucketName << "'..." << std::endl;

        Aws::Vector<Aws::S3::Model::Bucket> bucket_list = outcome.GetResult().GetBuckets();
        for (Aws::S3::Model::Bucket const& bucket : bucket_list) {
            if (bucket.GetName() == bucketName) {
                request.WithBucket(bucketName);
                std::cout << "Found the bucket." << std::endl << std::endl;

                auto outcome_obj = s3Client.ListObjects(request);
                std::cout << "Objects in bucket '" << bucketName << "':" << std::endl;

                Aws::Vector<Aws::S3::Model::Object> objects = outcome_obj.GetResult().GetContents();
                for (Aws::S3::Model::Object& object : objects) {
                    std::cout << object.GetKey() << std::endl;
                }
                return true;
            }
        }

        std::cout << "Could not find the bucket." << std::endl << std::endl;
        return true;
    } else {
        std::cout << "ListBuckets error: " << outcome.GetError().GetMessage() << std::endl;
    }
    return false;
}

int main(int argc, char* argv[])
{
    Aws::SDKOptions options;
    Aws::InitAPI(options);
    {

        // Секция настроек для использования AWS SDK с Object Storage
        Aws::Client::ClientConfiguration config;
        config.region = Aws::String("ru-central1");
        config.endpointOverride = Aws::String("storage.yandexcloud.net");

        Aws::String bucket_name = "bucket_name";
        // Инициализация подключения
        Aws::S3::S3Client s3_client(config);

        FindTheBucket(s3_client, bucket_name);
    }
    Aws::ShutdownAPI(options);

    return 0;
}
```