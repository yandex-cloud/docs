# AWS SDK для PHP


[AWS SDK для PHP](https://aws.amazon.com/ru/sdk-for-php/) — это комплект средств разработки для работы с сервисами AWS.

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

Чтобы установить AWS SDK для PHP, воспользуйтесь [инструкцией](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/getting-started_index.html) на сайте производителя. Для установки рекомендуем использовать менеджер зависимостей [Composer](https://getcomposer.org/).

## Настройка {#setup}

1. В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, [полученные ранее](#before-you-begin):

   ```
   [default]
   aws_access_key_id = <идентификатор_ключа>
   aws_secret_access_key = <секретный_ключ>
   ```

1. Если вы используете образ LAMP из Cloud Marketplace, добавьте в конфигурационный файл Apache `httpd.conf` (для Debian и Ubuntu — `apache2.conf`) переменную окружения `HOME` с указанием на домашний каталог:

   ```
   SetEnv HOME <домашний_каталог>
   ```
   
   Подробнее о расположении и названии конфигурационного файла Apache для разных ОС см. на [Apache HTTP Server Wiki](https://cwiki.apache.org/confluence/display/HTTPD/DistrosDefaultLayout).

Вместо файла `.aws/credentials` вы также можете использовать переменные среды `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY`.

Для доступа к Object Storage используйте адрес `storage.yandexcloud.net`.

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