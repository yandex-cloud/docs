# AWS SDK для Java

[AWS SDK для Java](https://aws.amazon.com/ru/sdk-for-java/) — это комплект средств разработки для работы с сервисами AWS.

## Подготовка к работе {#preparations}

{% include [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md) %}

## Установка {#installation}

Для установки AWS SDK для JAVA воспользуйтесь [инструкцией](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-install.html) на сайте производителя.

{% note info %}

Установите SDK версии не ниже 1.11.336.

{% endnote %}


## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup.md) %}


## Примеры кода {#java-sdk-examples}

Пример кода находится в каталоге `aws-java-sdk/samples/AmazonS3` в архиве с дистрибутивом SDK.

Чтобы подключиться к Object Storage замените в примере код

```cpp
AmazonS3 s3 = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(credentials))
    .withRegion("us-west-2")
    .build();
```

на

```cpp
AmazonS3 s3 = AmazonS3ClientBuilder.standard()
    .withCredentials(new AWSStaticCredentialsProvider(credentials))
    .withEndpointConfiguration(
        new AmazonS3ClientBuilder.EndpointConfiguration(
            "storage.yandexcloud.net","us-east-1"
        )
    )
    .build();
```

