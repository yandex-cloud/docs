---
title: AWS SDK для Java
description: Из статьи вы узнаете, что такое AWS SDK для Java, как его установить и настроить, а также ознакомитесь с примерами кода.
---

# AWS SDK для Java


[AWS SDK для Java](https://aws.amazon.com/ru/sdk-for-java/) — это комплект средств разработки для работы с сервисами AWS, совместимый с {{ objstorage-full-name }}.

С помощью AWS SDK для Java вы создадите бакет, загрузите в него объекты, очистите содержимое бакета и удалите бакет.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% note warning %}

31 декабря 2025 года прекращается поддержка AWS SDK для Java версии 1.x. Чтобы продолжать получать новые функции и обновления безопасности, рекомендуется перейти на AWS SDK для Java версии 2.x.

{% endnote %}

{% list tabs group=instructions %}

- AWS SDK v2.x {#sdk-v2}

    {% include [install-java-sdk-v2](../../_includes/aws-tools/install-java-sdk-v2.md) %}

- AWS SDK v1.x {#sdk-v1}
    
    {% include [install-java-sdk-v1](../../_includes/aws-tools/install-java-sdk.md) %}

{% endlist %}

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Изменение эндпоинта {#adapt-code}

{% list tabs group=instructions %}

- AWS SDK v2.x {#sdk-v2}

    1. В директории `/src/main/java/org/example` откройте файл `DependencyFactory.java` и измените класс `DependencyFactory`:

        ```java
        public class DependencyFactory {
            private DependencyFactory() {}
            public static S3Client s3Client() {
                return S3Client.builder()
                .endpointOverride(URI.create("https://{{ s3-storage-host }}"))
                .httpClientBuilder(ApacheHttpClient.builder())
                .build();
            }
        }
        ```

    1. [Запустите код](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-run) согласно инструкции из документации AWS.

    Другие примеры использования AWS SDK для Java вы можете найти в [репозитории с примерами](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/javav2/example_code/s3/src/main/java/com/example/s3).

- AWS SDK v1.x {#sdk-v1}
    
    В директории `aws-java-sdk/samples/AmazonS3` в архиве с дистрибутивом SDK находится код, который нужно изменить.

    Чтобы подключиться к {{ objstorage-name }} замените в примере код:

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
                "{{ s3-storage-host }}","{{ region-id }}"
            )
        )
        .build();
    ```

    Другие примеры использования AWS SDK для Java вы можете найти в [репозитории с примерами](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/java/example_code/s3/src/main/java/aws/example/s3).

{% endlist %}