# AWS SDK для .NET

[AWS SDK для .NET](https://aws.amazon.com/ru/sdk-for-net/) — это комплект средств разработки для работы с сервисами AWS.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

{% include [install-java-sdk](../../_includes/aws-tools/install-net-sdk.md)%}

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-s3-url.md) %}

## Примеры кода {#java-sdk-examples}

Чтобы подключиться к {{ objstorage-name }}, используйте код

```
AmazonS3Config configsS3 = new AmazonS3Config { 
    ServiceURL = "https://s3.yandexcloud.net"
};

AmazonS3Client s3client = new AmazonS3Client(
    AWS_ACCESS_KEY,
    AWS_SECRET_KEY,
    configsS3
);
```