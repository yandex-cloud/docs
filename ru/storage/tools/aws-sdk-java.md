---
title: AWS SDK для Java v.1.x
description: Из статьи вы узнаете, что такое AWS SDK для Java v.1.x, как его установить и настроить, а также ознакомитесь с примерами кода.
---

# AWS SDK для Java v.1.x


[AWS SDK для Java v.1.x](https://aws.amazon.com/ru/sdk-for-java/) — это комплект средств разработки для работы с сервисами AWS.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% include [install-java-sdk](../../_includes/aws-tools/install-java-sdk.md)%}

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Примеры кода {#java-sdk-examples}

Пример кода находится в каталоге `aws-java-sdk/samples/AmazonS3` в архиве с дистрибутивом SDK.

Чтобы подключиться к {{ objstorage-name }} замените в примере код

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

