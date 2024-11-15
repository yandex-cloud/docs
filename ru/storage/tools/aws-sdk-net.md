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

Чтобы подключиться к {{ objstorage-name }}, используйте код

```csharp
AmazonS3Config configsS3 = new AmazonS3Config {
    ServiceURL = "https://{{ s3-dotnet-sdk-host }}"
};

AmazonS3Client s3client = new AmazonS3Client(configsS3);
```
