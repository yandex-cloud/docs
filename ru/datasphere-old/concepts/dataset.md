# Датасеты

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Датасет — это механизм хранения информации, который предоставляет быстрый доступ к большим объемам данных. Датасет может хранить до 4 ТБ, при этом доступ к данным будет быстрее, чем к основному хранилищу проекта. 

Создание и наполнение датасета происходит во время инициализации. После инициализации датасет доступен только для чтения. 

## Инициализация датасета {#init}

Создать и инициализировать датасет можно из ячейки, которая содержит команду `#pragma dataset init` на Bash или Python. При инициализации необходимо указать размер и уникальное в пределах [проекта](project.md) имя датасета. 

{% note info %}

Во время инициализации датасета будет выделен весь запрошенный объем дискового хранилища, однако часть этого объема будет занята файловой системой. Указывайте размер датасета с запасом.

Датасеты не включены в основное хранилище проекта.

{% endnote %}

Во время инициализации датасет однократно подключается к проекту с доступом для чтения и записи. Если код в ячейке инициализации датасета выполнен успешно, датасет сохраняется и повторно подключается с доступом только для чтения. Если во время инициализации произойдет ошибка, датасет будет отключен и удален.

Создать датасет можно:

* Из файла, доступного по ссылке.

  {% list tabs %}
  
  - Bash
  
    Создание датасета `<имя_датасета>` из архива [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html):
    
    ```bash
    #!:bash
    #pragma dataset init <имя_датасета> --size 1Gb
    
    set -e
    cd /home/jupyter/mnt/datasets/<имя_датасета>
    wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    tar -xvf cifar-10-python.tar.gz
    rm -rf cifar-10-python.tar.gz
    ```

    Где `<имя_датасета>` — имя создаваемого датасета.
  
  - Python 3

    Создание датасета `<имя_датасета>` из архива [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html):
    
    ```python
    #pragma dataset init <имя_датасета> --size 1Gb
    
    from urllib.request import urlopen
    import tarfile
    from os import remove
    
    file_name = 'cifar-10-python.tar.gz'
    file_url = 'https://www.cs.toronto.edu/~kriz/' + file_name
    dest_dir = '/home/jupyter/mnt/datasets/<имя_датасета>/'
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

    Где `<имя_датасета>` — имя создаваемого датасета.
  
  {% endlist %}

* Из объектов файловых хранилищ.

  Для подключения к хранилищу вам понадобится аутентификационная информация — [ключи доступа](../../iam/operations/sa/create-access-key.md) и пароли. Мы рекомендуем использовать для хранения такой информации [секреты](../concepts/secrets.md).

  {% list tabs %}
  
  - {{ objstorage-short-name }}
  
    ```python
    #pragma dataset init <имя_датасета> --size 1Gb
    
    from cloud_ml.storage.api import Storage
    s3 = Storage.s3(access_key=<ключ_доступа>, secret_key=<секретный_ключ>)
    s3.get('bucket/<путь_внутри_бакета>/file.txt', '/home/jupyter/mnt/datasets/<имя_датасета>/<путь>/file.txt')
    ```

    Где:

    * `<имя_датасета>` — имя создаваемого датасета.
    * `<ключ_доступа>` — идентификатор [статического ключа доступа](../../iam/operations/sa/create-access-key.md) к хранилищу.
    * `<секретный_ключ>` — значение [секретного ключа доступа](../../iam/operations/sa/create-access-key.md) к хранилищу.
    * `<путь_внутри_бакета>` — [ключ объекта или префикс](../../storage/concepts/object.md#key).
    * `<путь>` — путь до файла внутри датасета.
    
  - Яндекс Диск
  
    Для подключения к Яндекс Диску вам понадобится идентификатор приложения и секрет. Чтобы их получить:

    1. На [странице регистрации приложений]({{ ya-client-app }}) в Яндекс ID выберите опцию **Веб-сервисы**.
    1. Вставьте в поле **Callback URI** значение `{{ ya-oauth }}`.
    1. Настройте разрешения для Яндекс Диска.
    1. Инициализируйте датасет в ячейке с кодом:

       ```python
       #pragma dataset init <имя_датасета> --size 1Gb

       from cloud_ml.storage.api import Storage
   
       disk = Storage.ya_disk(application_id='<идентификатор_приложения>', application_secret='<секрет>')
    
       # downloading contents of the remote file into the local one
       disk.get('<путь_внутри_Яндекс_Диска>/file.txt', '/home/jupyter/mnt/datasets/<имя_датасета>/<путь>/file.txt')
       ```

       Где:

       * `<имя_датасета>` — имя создаваемого датасета.
       * `<идентификатор_приложения>` — идентификатор приложения для доступа к Яндекс Диску.
       * `<секрет>` — секрет приложения для доступа к Яндекс Диску.
       * `<путь_внутри_Яндекс_Диска>` — путь до каталога с файлом.
       * `<путь>` — путь до файла внутри датасета.
  
  - Google Drive
  
    Для подключения к Google Drive воспользуйтесь [инструкцией](https://developers.google.com/drive/api/v3/enable-drive-api) в официальной документации и создайте **OAuth client ID** типа **TVs and Limited Input devices**. 
  
    Используйте созданный **OAuth client ID** и инициализируйте датасет, выполнив в ячейке код: 

    ```python
    #pragma dataset init <имя_датасета> --size 1Gb

    client_secret = {<секрет_клиента>}
    
    gdrive = Storage.gdrive(client_secret)
    gdrive_file_id = '<идентификатор_файла>'
    dst_path = '/home/jupyter/mnt/datasets/<имя_датасета>/<путь>/file.txt'
    gdrive.get(gdrive_file_id, dst_path)
    ```
    
    Где:

    * `<имя_датасета>` — имя создаваемого датасета.
    * `<секрет_клиента>` — секретный ключ, полученный при создании **OAuth client ID**.
    * `<идентификатор_файла>` — идентификатор файла в Google Drive.
    * `<путь>` — путь до файла внутри датасета.

  {% endlist %}

* Из локальных файлов.

  {% list tabs %}

  - Bash

    Чтобы создать датасет в произвольном формате, скопируйте локальные файлы:

    ```bash
    #!:bash
    #pragma dataset init <имя_датасета> --size 1Gb
    
    set -e
    cp -r <имя_каталога_источника> /home/jupyter/mnt/datasets/<имя_датасета>
    ```

    Где:

    * `<имя_датасета>` — имя создаваемого датасета.
    * `<имя_каталога_источника>` — имя локального каталога с файлами для копирования.

  {% endlist %}

## Использование датасета {#use}

После инициализации датасеты доступны из кода по пути вида `/home/jupyter/mnt/datasets/<имя_датасета>`. 

Чтобы посмотреть все доступные в проекте датасеты, откройте вкладку **Datasets** ![datasets](../../_assets/datasphere/jupyterlab/dataset.svg). В ней вы увидите список созданных датасетов и сможете посмотреть их содержимое. 

Вывести список всех доступных в проекте датасетов можно, запустив ячейку с кодом:

```
#pragma datasets list
```

После инициализации данные датасета изменить невозможно. Если данные нужно актуализировать, удалите датасет и создайте новый.

## Удаление датасета {#delete}

Чтобы удалить датасет `<имя_датасета>`, выполните ячейку с кодом:

```
#pragma dataset delete <имя_датасета>
```

Где `<имя_датасета>` — имя удаляемого датасета.