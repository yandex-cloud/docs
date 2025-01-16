---
title: AWS SDK для PHP
description: Из статьи вы узнаете, что такое AWS SDK для PHP, как его установить и настроить, а также ознакомитесь с примерами кода.
---

# AWS SDK для PHP


[AWS SDK для PHP](https://aws.amazon.com/ru/sdk-for-php/) — это комплект средств разработки для работы с сервисами AWS.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% include [install-php-sdk](../../_includes/aws-tools/install-php-sdk.md)%}

## Настройка {#setup}

1. Создайте в домашнем каталоге файл `.aws/credentials` и укажите в нем статический ключ:

   ```
   [default]
   aws_access_key_id = <идентификатор_ключа>
   aws_secret_access_key = <секретный_ключ>
   ```

1. Если вы используете образ LAMP из {{ marketplace-name }}, добавьте в конфигурационный файл Apache `httpd.conf` (для Debian и Ubuntu — `apache2.conf`) переменную окружения `HOME` с указанием на домашний каталог:

   ```
   SetEnv HOME <домашний_каталог>
   ```
   
   Подробнее о расположении и названии конфигурационного файла Apache для разных ОС см. на [Apache HTTP Server Wiki](https://cwiki.apache.org/confluence/display/HTTPD/DistrosDefaultLayout).

Вместо файла `.aws/credentials` вы также можете использовать переменные среды `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY`.

Для доступа к {{ objstorage-name }} используйте адрес `{{ s3-storage-host }}`.

## Примеры кода {#code-examples}

{% list tabs %}

- Список имен бакетов

  Не забудьте указать путь к вашему проекту в строке с подключением файла `autoload.php`:

  ```php
  <?php

  // Предполагается, что AWS SDK установлен через Composer

  require "<путь_к_проекту>/vendor/autoload.php";
  use Aws\S3\S3Client;

  $s3 = new S3Client([
      "version" => "latest",
      "endpoint" => "https://storage.yandexcloud.net",
      "region" => "ru-central1",
  ]);

  $buckets = $s3->listBuckets();
  $bucket_count = 1;

  echo "<b>Well, here are your buckets:</b></br></br>";
  foreach ($buckets["Buckets"] as $bucket) {
      echo $bucket_count . ". " . $bucket["Name"] . "</br>";
      $bucket_count++;
  }

  ?>
  ```

{% endlist %}

Также см. [примеры кода](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/s3-examples.html) и [справочник PHP API](https://docs.aws.amazon.com/aws-sdk-php/v3/api/index.html) в документации AWS.