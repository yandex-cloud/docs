# boto3 и boto

[boto3](https://github.com/boto/boto3) и [boto](https://github.com/boto/boto) — это комплекты средств разработки (SDK) для языков программирования Python 2.x и 3.x. SDK предназначены для работы с сервисами AWS.


## Подготовка к работе {#preparations}

{% include [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md) %}

## Установка {#installation}

Для установки boto воспользуйтесь инструкциями в репозитории разработчика: [boto3](https://github.com/boto/boto3/blob/develop/README.rst#quick-start), [boto](https://github.com/boto/boto#installation).

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup.md) %}


## Пример {#boto-example}


{% list tabs %}

- boto3
  
  ```python
  #!/usr/bin/env python
  #-*- coding: utf-8 -*-
  import boto3
  session = boto3.session.Session()
  s3 = session.client(
      service_name='s3',
      endpoint_url='https://{{ s3-storage-host }}'
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
  
- boto
  
  ```python
  #!/usr/bin/env python
  #-*- coding: utf-8 -*-
  import os
  from boto.s3.key import Key
  from boto.s3.connection import S3Connection
  os.environ['S3_USE_SIGV4'] = 'True'
  conn = S3Connection(
      host='storage.api.cloud.yandex.net'
  )
  conn.auth_region_name = 'us-east-1'
  
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
      print key.key
  
  # Удалить несколько объектов
  response = bucket.delete_keys(['test-string', 'py_script.py'])
  
  # Получить объект
  key = bucket.get_key('script/py_script.py')
  print key.get_contents_as_string()
  ```
  
{% endlist %}
