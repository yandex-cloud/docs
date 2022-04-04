# Датасеты

_Датасет_ — это механизм хранения информации, который предоставляет быстрый доступ к большим объемам данных. Датасет может хранить до 4 ТБ, при этом доступ к данным будет быстрее, чем к основному хранилищу проекта. 

Создание и наполнение датасета происходит во время инициализации. После инициализации датасет доступен только для чтения. 

## Инициализация датасета {#init}

Создать и инициализировать датасет можно из ячейки, которая содержит команду `#pragma dataset init` на Bash или Python. При инициализации необходимо указать размер и уникальное в пределах [проекта](project.md) имя датасета. 

{% note info %}

Во время инициализации датасета будет выделен весь запрошенный объем дискового хранилища, однако часть этого объема будет занято файловой системой. Указывыйте размер датасета с запасом.

Датасеты не включены в основное хранилище проекта.

{% endnote %}

Во время инициализации датасет однократно подключается к проекту с доступом для чтения и записи. Если код в ячейке инициализации датасета выполнен успешно, датасет сохраняется и повторно подключается с доступом только для чтения. Если во время инициализации произойдет ошибка, датасет будет отключен и удален.

Создать датасет можно:

* Из файла, доступного по ссылке.

  {% list tabs %}
  
  - Bash
  
    Создание датасета `<DATASET_NAME>` из архива [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html):
    
    ```bash
    #!:bash
    #pragma dataset init <DATASET_NAME> --size 1Gb
    
    set -e
    cd /home/jupyter/mnt/datasets/<DATASET_NAME>
    wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    tar -xvf cifar-10-python.tar.gz
    rm -rf cifar-10-python.tar.gz
    ```
  
  - Python 3

    Создание датасета `<DATASET_NAME>` из архива [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html):
    
    ```python
    #pragma dataset init <DATASET_NAME> --size 1Gb
    
    from urllib.request import urlopen
    import tarfile
    from os import remove
    
    file_name = 'cifar-10-python.tar.gz'
    file_url = 'https://www.cs.toronto.edu/~kriz/' + file_name
    dest_dir = '/home/jupyter/mnt/datasets/<DATASET_NAME>/'
    dest_file = dest_dir + file_name
    
    with urlopen(file_url) as i:
      with open(dest_file, 'w+b') as o:
        o.write(i.read())
    
    tar = tarfile.open(dest_file)
    tar.extractall(dest_dir)
    tar.close()
    
    remove(dest_file)
    
    # This prevents serialization of temporary variables
    del i, o, tar
    ```
  
  {% endlist %}

* Из объектов файловых хранилищ.

  {% list tabs %}
  
  - {{ objstorage-short-name }}
  
    ```python
    #pragma dataset init <DATASET_NAME> --size 1Gb
    
    from cloud_ml.storage.api import Storage
    s3 = Storage.s3(access_key=<access_key>, secret_key=<secret_key>])
    s3.get('bucket/<path_within_S3>/file.txt', '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt')
    ```
    
  - Яндекс.Диск
  
    Для подключения к Яндекс.Диску вам понадобится идентификатор приложения и секрет. Чтобы их получить:
    1. На [странице регистрации приложений]({{ ya-client-app }}) в Яндекс ID выберите опцию **Веб-сервисы**.
    1. Вставьте в поле **Callback URI** значение ```{{ ya-oauth }}```.
    1. Настройте разрешения для Яндекс.Диска.
    1. Инициализируйте датасет в ячейке с кодом:

    ```python
    #pragma dataset init <DATASET_NAME> --size 1Gb

    from cloud_ml.storage.api import Storage
   
    disk = Storage.ya_disk(application_id='<id>', application_secret='<secret>')
    
    # downloading contents of the remote file into the local one
    disk.get('<path_within_ya_disk>/file.txt', '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt')
    ```  
  
  - Google Drive
  
    Для подключения к Google Drive воспользуйтесь [инструкцией](https://developers.google.com/drive/api/v3/enable-drive-api) в официальной документации и создайте **OAuth client ID** типа **TVs and limited input devices**. 
  
    Используйте созданный **OAuth client ID** и инициализируйте датасет, выполнив в ячейке код: 

    ```python
    #pragma dataset init <DATASET_NAME> --size 1Gb

    client_secret = {<client_secret>}
    
    gdrive = Storage.gdrive(client_secret)
    gdrive_file_id = '<fileID>'
    dst_path = '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt'
    gdrive.get(gdrive_file_id, dst_path)
    ```

  {% endlist %}

* Из локальных файлов.

  {% list tabs %}

  - Bash

    Чтобы создать датасет в произвольном формате, скопируйте локальные файлы:

    ```bash
    #!:bash
    #pragma dataset init  <DATASET_NAME> --size 1Gb
    
    set -e
    cp -r <SOURCE_FOLDER_NAME> /home/jupyter/mnt/datasets/<DATASET_NAME>
    ```

  {% endlist %}

## Использование датасета {#use}

После инициализации датасеты доступны из кода по пути вида `/home/jupyter/mnt/datasets/<DATASET_NAME>`. 

Чтобы посмотреть все доступные в проекте датасеты, откройте вкладку **Datasets** ![](../../_assets/datasphere/jupyterlab/dataset.svg). В ней вы увидите список созданных датасетов и сможете посмотреть их содержимое. 

Вывести список всех доступных в проекте датасетов можно, запустив ячейку с кодом:

```
#pragma datasets list
```

После инициализации данные датасета изменить невозможно. Если данные нужно актуализировать, удалите датасет и создайте новый.

## Удаление датасета {#delete}

Чтобы удалить датасет `<DATASET_NAME>`, выполните ячейку с кодом 

```
#pragma dataset delete <DATASET_NAME>
```