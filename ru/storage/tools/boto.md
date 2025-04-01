---
title: boto3 и boto
description: Из статьи вы узнаете, что такое boto3 и boto, как их установить и настроить, а также ознакомитесь с примерами операций.
---

# boto3 и boto


[boto3](https://github.com/boto/boto3) и [boto](https://github.com/boto/boto) — это комплекты средств разработки (SDK) для языков программирования Python 2.x и 3.x. SDK предназначены для работы с сервисами AWS.


## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% include [install-boto](../../_includes/aws-tools/install-boto.md)%}

## Настройка {#setup}

{% list tabs group=instructions %}

- Локально {#locally}

  {% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

- {{ sf-full-name }} {#functions}
  
  В функцию {{ sf-name }} [добавьте переменные окружения](../../functions/operations/function/version-manage#version-env):

  * `AWS_ACCESS_KEY_ID` — идентификатор статического ключа сервисного аккаунта.
  * `AWS_SECRET_ACCESS_KEY` — секретный ключ.
  * `AWS_DEFAULT_REGION` — идентификатор региона.

  Для доступа к {{ objstorage-name }} используйте адрес `{{ s3-storage-host }}`.

{% endlist %}


## Пример {#boto-example}


{% list tabs group=instructions %}

- Локально {#locally}
  
  boto3: 

  {% include [boto3-example](../../_includes/storage/boto3-example.md) %}

  Boto3 по умолчанию использует аутентификационные данные из директории `~/.aws`, но вы можете указать переменные `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY` явно:

  ```python
  ...
  session = boto3.session.Session()
  s3 = session.client(
      service_name='s3',
      endpoint_url='https://{{ s3-storage-host }}',
      aws_access_key_id='<идентификатор_статического_ключа>',
      aws_secret_access_key='<секретный_ключ>'
  )
  ```

  {% note info %}

  Данный метод считается небезопасным, так как существует риск утечки ключей.

  {% endnote %}

  {% cut "boto" %}

  {% include [boto-example](../../_includes/storage/boto-example.md) %}

  {% endcut %}

- {{ sf-full-name }} {#functions}

  См. пример в [руководстве по конвертации видео](../tutorials/video-converting-queue.md).

{% endlist %}

