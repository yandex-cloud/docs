# boto3 и boto

[boto3](https://github.com/boto/boto3) и [boto](https://github.com/boto/boto) — это комплекты средств разработки (SDK) для языков программирования Python 2.x и 3.x. SDK предназначены для работы с сервисами AWS.


## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

{% include [install-boto](../../_includes/aws-tools/install-boto.md)%}

## Настройка {#setup}

{% list tabs %}

- Локально

  {% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

- В Cloud Functions
  
  В функцию Cloud Functions [добавьте переменные окружения](../../functions/operations/function/version-manage#version-env):

  * `AWS_ACCESS_KEY_ID` — идентификатор статического ключа сервисного аккаунта.
  * `AWS_SECRET_ACCESS_KEY` — секретный ключ.
  * `AWS_DEFAULT_REGION` — идентификатор региона.

  Для доступа к {{ objstorage-name }} используйте адрес `{{ s3-storage-host }}`.

{% endlist %}


## Пример {#boto-example}


{% list tabs %}

- Локально 
  
  boto3: 

  {% include [boto3-example](../../_includes/storage/boto3-example.md) %}

  {% cut "boto" %}

  {% include [boto-example](../../_includes/storage/boto-example.md) %}

  {% endcut %}

- В Cloud Functions

  См. пример в [руководстве по конвертации видео](../../functions/tutorials/video-converting-queue.md).

{% endlist %}

