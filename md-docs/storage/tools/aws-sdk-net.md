# AWS SDK для .NET


[AWS SDK для .NET](https://aws.amazon.com/ru/sdk-for-net/) — это комплект средств разработки для работы с сервисами AWS.

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

Для установки AWS SDK для .NET воспользуйтесь [инструкцией](https://docs.aws.amazon.com/sdk-for-net/latest/developer-guide/net-dg-setup.html) на сайте производителя.

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

## Особенности {#features}

* AWS SDK для .NET некорректно обрабатывает конфигурации для жизненных циклов, которые не содержат в себе описания правил (ID). Добавьте описания ко всем правилам жизненного цикла.
* Для доступа к Object Storage, например при работе с классом `AmazonS3Config`, используйте адрес `s3.yandexcloud.net`.

## Примеры кода {#net-sdk-examples}

Чтобы подключиться к Object Storage, используйте код:

```csharp
AmazonS3Config configsS3 = new AmazonS3Config {
    ServiceURL = "https://s3.yandexcloud.net"
};

AmazonS3Client s3client = new AmazonS3Client(configsS3);
```

Пример программы с использованием .NET AWS SDK, которая при запуске создаст бакет, загрузит в него объект, удалит объект и удалит бакет:

```csharp
using Amazon.Runtime;
using Amazon.S3;
using Amazon.S3.Model;

namespace Example
{
    public static class Program
    {
        public static async Task Main()
        {
            var testBucketName = "your-unique-bucket-name";
            var uploadObjectKey = "object-key";
            AmazonS3Client s3client = null;

            try
            {
                // Настройка клиента S3
                AmazonS3Config configsS3 = new AmazonS3Config {
                    ServiceURL = "https://s3.yandexcloud.net",
                };
                s3client = new AmazonS3Client(configsS3);

                // Создание бакета
                Console.WriteLine($"Creating bucket {testBucketName}");
                try 
                {
                    await s3client.PutBucketAsync(new PutBucketRequest
                    {
                        BucketName = testBucketName,
                        UseClientRegion = true
                    });
                    Console.WriteLine($"Bucket '{testBucketName}' created successfully.");
                }
                catch (AmazonS3Exception ex) when (ex.StatusCode == System.Net.HttpStatusCode.Conflict)
                {
                    Console.WriteLine($"Bucket '{testBucketName}' already exists. Continuing with existing bucket.");
                }

                // Загрузка объекта
                Console.WriteLine($"Uploading object to bucket '{testBucketName}'.");
                try
                {
                    await s3client.PutObjectAsync(new Amazon.S3.Model.PutObjectRequest
                    {
                        BucketName = testBucketName,
                        Key = uploadObjectKey,
                        ContentBody = "Hello World!"
                    });
                    Console.WriteLine("Object was uploaded successfully.");
                }
                catch (AmazonS3Exception ex)
                {
                    Console.WriteLine($"Error uploading object: {ex.Message}");
                    throw; // Re-throw to be caught by outer try-catch
                }

                // Удаление объекта
                Console.WriteLine($"Deleting object with key '{uploadObjectKey}'");
                try
                {
                    await s3client.DeleteObjectAsync(new Amazon.S3.Model.DeleteObjectRequest
                    {
                        BucketName = testBucketName,
                        Key = uploadObjectKey
                    });
                    Console.WriteLine($"Object with key '{uploadObjectKey}' was deleted successfully");
                }
                catch (AmazonS3Exception ex)
                {
                    Console.WriteLine($"Error deleting object: {ex.Message}");
                    throw; // Re-throw to be caught by outer try-catch
                }
                
                // Удаление бакета
                Console.WriteLine($"Deleting bucket with name '{testBucketName}'");
                try
                {
                    await s3client.DeleteBucketAsync(new Amazon.S3.Model.DeleteBucketRequest
                    {
                        BucketName = testBucketName
                    });
                    Console.WriteLine($"Bucket '{testBucketName}' was deleted successfully");
                }
                catch (AmazonS3Exception ex)
                {
                    Console.WriteLine($"Error deleting bucket: {ex.Message}");
                    // Если нужно принудительно удалить не пустой бакет, можно добавить код здесь
                    throw; // Re-throw to be caught by outer try-catch
                }
            }
            catch (AmazonS3Exception ex)
            {
                Console.WriteLine($"Amazon S3 Error: {ex.ErrorCode}, Message: {ex.Message}");
                Console.WriteLine($"Status code: {ex.StatusCode}, Request ID: {ex.RequestId}");
            }
            catch (AmazonServiceException ex)
            {
                Console.WriteLine($"Amazon Service Error: {ex.ErrorCode}, Message: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"General error: {ex.Message}");
                Console.WriteLine(ex.StackTrace);
            }
            finally
            {
                // Правильная очистка ресурсов
                s3client?.Dispose();
            }
        }
    }
}
```

## См. также {#see-also}

* [Примеры использования AWS SDK для .NET в документации AWS](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/csharp_code_examples.html)