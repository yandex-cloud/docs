```python
#!/usr/bin/env python
#-*- coding: utf-8 -*-
import os
from boto.s3.key import Key
from boto.s3.connection import S3Connection
os.environ['S3_USE_SIGV4'] = 'True'
conn = S3Connection(
    host='{{ s3-storage-host }}'
)
conn.auth_region_name = '{{ region-id }}'

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