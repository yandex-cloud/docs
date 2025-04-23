---
title: AWS SDK для .NET
description: Из статьи вы узнаете, что такое AWS SDK для .NET, как его установить и настроить, а также ознакомитесь с примерами кода.
---

# AWS SDK для .NET


[AWS SDK для .NET](https://aws.amazon.com/ru/sdk-for-net/) — это комплект средств разработки для работы с сервисами AWS.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% include [install-net-sdk](../../_includes/aws-tools/install-net-sdk.md)%}

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-s3-url.md) %}

## Особенности {#features}

* AWS SDK для .NET некорректно обрабатывает конфигурации для жизненных циклов, которые не содержат в себе описания правил (ID). Добавьте описания ко всем правилам жизненного цикла.
* Для доступа к {{ objstorage-name }}, например при работе с классом `AmazonS3Config`, используйте адрес `{{ s3-dotnet-sdk-host }}`.

## Примеры кода {#net-sdk-examples}

Чтобы подключиться к {{ objstorage-name }}, используйте код:

```csharp
AmazonS3Config configsS3 = new AmazonS3Config {
    ServiceURL = "https://{{ s3-dotnet-sdk-host }}"
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
                    ServiceURL = "https://{{ s3-dotnet-sdk-host }}",
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