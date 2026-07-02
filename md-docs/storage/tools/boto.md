[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Инструменты](index.md) > SDK > AWS SDK для Python (boto)

# boto3 и boto


[boto3](https://github.com/boto/boto3) и [boto](https://github.com/boto/boto) — это комплекты средств разработки (SDK) для языков программирования Python 2.x и 3.x. SDK предназначены для работы с сервисами AWS.


## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях смотрите на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).

          
    Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
    
    * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
    * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
    * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
    
    Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Установка {#installation}

Для установки boto воспользуйтесь инструкциями в репозитории разработчика: [boto3](https://github.com/boto/boto3/blob/develop/README.rst#quick-start), [boto](https://github.com/boto/boto#installation).

## Настройка {#setup}

{% list tabs group=instructions %}

- Локально {#locally}

  1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 
  
      Для macOS и Linux:
  
      ```bash
      mkdir ~/.aws/
      ```
  
      Для Windows:
  
      ```bash
      mkdir C:\Users\<имя_пользователя>\.aws\
      ```
  
  1.  В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, [полученные ранее](#before-you-begin):
  
      ```text
      [default]
      aws_access_key_id = <идентификатор_статического_ключа>
      aws_secret_access_key = <секретный_ключ>
      ```
  
  1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:
  
      ```text
      [default]
      region = ru-central1
      endpoint_url = https://storage.yandexcloud.net
      ```
  
      {% note info %}
  
      Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому Object Storage принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).
  
      {% endnote %}
  
  Для доступа к Object Storage используйте эндпоинт `https://storage.yandexcloud.net`.

- Yandex Cloud Functions {#functions}
  
  В функцию Cloud Functions [добавьте переменные окружения](../../functions/operations/function/version-manage.md#version-env):

  * `AWS_ACCESS_KEY_ID` — идентификатор статического ключа сервисного аккаунта.
  * `AWS_SECRET_ACCESS_KEY` — секретный ключ.
  * `AWS_DEFAULT_REGION` — идентификатор региона.

  Для доступа к Object Storage используйте адрес `storage.yandexcloud.net`.

{% endlist %}


## Пример {#boto-example}


{% list tabs group=instructions %}

- Локально {#locally}
  
  boto3: 

  ```python
  #!/usr/bin/env python
  #-*- coding: utf-8 -*-
  import boto3
  session = boto3.session.Session()
  s3 = session.client(
      service_name='s3',
      endpoint_url='https://storage.yandexcloud.net'
  )
  
  # Создать новый бакет
  s3.create_bucket(Bucket='bucket-name')
  
  # Загрузить объекты в бакет
  
  ## Из строки
  s3.put_object(Bucket='bucket-name', Key='object_name', Body='TEST', StorageClass='COLD')
  
  ## Из файла
  s3.upload_file('this_script.py', 'bucket-name', 'py_script.py')
  s3.upload_file('this_script.py', 'bucket-name', 'script/py_script.py')
  
  # Получить список объектов в бакете
  for key in s3.list_objects(Bucket='bucket-name')['Contents']:
      print(key['Key'])
  
  # Удалить несколько объектов
  forDeletion = [{'Key':'object_name'}, {'Key':'script/py_script.py'}]
  response = s3.delete_objects(Bucket='bucket-name', Delete={'Objects': forDeletion})
  
  # Получить объект
  get_object_response = s3.get_object(Bucket='bucket-name',Key='py_script.py')
  print(get_object_response['Body'].read())
  ```

  Boto3 по умолчанию использует аутентификационные данные из директории `~/.aws`, но вы можете указать переменные `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY` явно:

  ```python
  ...
  session = boto3.session.Session()
  s3 = session.client(
      service_name='s3',
      endpoint_url='https://storage.yandexcloud.net',
      aws_access_key_id='<идентификатор_статического_ключа>',
      aws_secret_access_key='<секретный_ключ>'
  )
  ```

  {% note info %}

  Данный метод считается небезопасным, так как существует риск утечки ключей.

  {% endnote %}

  {% cut "boto" %}

  ```python
  #!/usr/bin/env python
  #-*- coding: utf-8 -*-
  import os
  from boto.s3.key import Key
  from boto.s3.connection import S3Connection
  os.environ['S3_USE_SIGV4'] = 'True'
  conn = S3Connection(
      host='storage.yandexcloud.net'
  )
  conn.auth_region_name = 'ru-central1'
  
  # Создать новый бакет
  conn.create_bucket('bucket-name')
  bucket = conn.get_bucket('bucket-name')
  
  # Загрузить объекты в бакет
  
  ## Из строки
  bucket.new_key('test-string').set_contents_from_string('TEST')
  
  ## Из файла
  file_key_1 = Key(bucket)
  file_key_1.key = 'py_script.py'
  file_key_1.set_contents_from_filename('this_script.py')
  file_key_2 = Key(bucket)
  file_key_2.key = 'script/py_script.py'
  file_key_2.set_contents_from_filename('this_script.py')
  
  # Получить список объектов в бакете
  keys_list=bucket.list()
  for key in keys_list:
      print (key.key)
  
  # Удалить несколько объектов
  response = bucket.delete_keys(['test-string', 'py_script.py'])
  
  # Получить объект
  key = bucket.get_key('script/py_script.py')
  print (key.get_contents_as_string())
  ```

  {% endcut %}

- Yandex Cloud Functions {#functions}

  Смотрите пример в [руководстве по конвертации видео](../tutorials/video-converting-queue/index.md).

{% endlist %}