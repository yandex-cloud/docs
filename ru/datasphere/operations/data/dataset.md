# Работа с датасетами

Для работы с большими объемами данных в {{ ml-platform-name }} используйте [датасеты](../../concepts/dataset.md). Основные операции с датасетами выполняются в коде ячеек с помощью [служебных команд](../../concepts/pragma.md) `#pragma dataset`. 

## Создать и инициализировать датасет {#create}

Создать и инициализировать датасет можно из ячейки с кодом на Bash или Python, содержащей команду `#pragma dataset init`. При инициализации укажите уникальное в пределах [проекта](../../concepts/project.md) имя датасета и размер [диска](../../../compute/concepts/disk.md), на котором будет размещен датасет.

{% note info %}

Во время инициализации датасета будет выделен весь запрошенный объем дискового хранилища, однако часть этого объема будет занята файловой системой. Указывайте размер датасета с запасом.

{% endnote %}

{% note tip %}

Чем больше выделенный для датасета [диск](../../../compute/concepts/disk.md), тем выше скорость чтения данных.

{% endnote %}

Во время инициализации датасет однократно подключается к проекту с доступом для чтения и записи. Если код в ячейке инициализации датасета выполнен успешно, датасет сохраняется и повторно подключается с доступом только для чтения. Если во время инициализации произойдет ошибка, датасет будет отключен и удален.

После инициализации данные датасета изменить невозможно. Если данные нужно актуализировать, удалите датасет и создайте новый.

### Наполнить датасет файлами из хранилища проекта или подключенного объектного хранилища {#from-files}

Этот способ также подойдет для создания датасета с данными из бакета [{{ objstorage-full-name }}](../../../storage/) или другого объектного хранилища, подключенного к хранилищу проекта с помощью [коннектора S3](connect-to-s3.md).

{% list tabs %}

- Bash

  Чтобы создать датасет `<имя_датасета>`, инициализируйте его и скопируйте файлы каталога `<имя_исходного_каталога>`:

  ```bash
  #!:bash
  #pragma dataset init <имя_датасета> --size 1Gb

  set -e
  cp -r <имя исходного каталога> /home/jupyter/mnt/datasets/<имя_датасета>
  ```

{% endlist %}

### Наполнить датасет из файла по ссылке {#from-link}

Чтобы создать датасет `<имя_датасета>` из архива [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html), выполните код в ячейке:

{% list tabs %}

- Bash

  ```bash
  #!:bash
  #pragma dataset init <имя_датасета> --size 1Gb

  set -e
  cd /home/jupyter/mnt/datasets/<имя_датасета>
  wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
  tar -xvf cifar-10-python.tar.gz
  rm -rf cifar-10-python.tar.gz
  ```

- Python 3

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

{% endlist %}

### Наполнить датасет объектами файловых хранилищ {#from-objects}

{% list tabs %}

- {{ objstorage-short-name }}

  Если вы подключаетесь к бакету {{ objstorage-name }} с помощью коннектора S3, создайте датасет из объектов как из [локальных файлов](#from-files) проекта.

  ```python
  #pragma dataset init <имя_датасета> --size 1Gb

  from cloud_ml.storage.api import Storage
  s3 = Storage.s3(access_key=<ключ_доступа>, secret_key=<секретный_ключ>])
  s3.get('bucket/<путь_к_хранилищу>/file.txt', '/home/jupyter/mnt/datasets/<имя_датасета>/<путь>/file.txt')
  ```

  Где:
  * `access_key` — идентификатор [статического ключа доступа](../../../iam/concepts/authorization/access-key.md), [сгенерированный](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта проекта;
  * `secret_key` — секретный ключ, сгенерированный для того же сервисного аккаунта.

  {% include [use secrets](../../../_includes/datasphere/use-secrets.md) %}

- Яндекс Диск

  Для подключения к Яндекс Диску вам понадобится идентификатор приложения (`ClientID`) и секретный ключ (`Client secret`). Чтобы их получить:

  {% include [oauth-token](../../../_includes/datasphere/token-for-ya-disk.md) %}

  1. [В интерфейсе {{ ml-platform-name }}]({{ link-datasphere-main }}) [создайте секреты](secrets.md#create), содержащие сгенерированные значения идентификатора приложения и секретного ключа.
  1. Инициализируйте датасет в ячейке с кодом:

     ```python
     #pragma dataset init <имя_датасета> --size 1Gb

     from cloud_ml.storage.api import Storage

     disk = Storage.ya_disk(application_id=os.environ[<секрет_с_ClientID>], application_secret=[<секрет_с_Client secret>])

     # downloading contents of the remote file into the local one
     disk.get('<путь_в_Яндекс_Диске>/file.txt', '/home/jupyter/mnt/datasets/<имя_датасета>/<путь>/file.txt')
     ```

    {% note info %}

    При первом подключении {{ ml-platform-name }} к Яндекс Диску потребуется перейти на страницу авторизации Яндекс ID и скопировать код подтверждения в поле **Enter the confirmation code** ноутбука.

    {% endnote %}

{% if audience == "draft" %}
- Google Drive

  Для подключения к Google Drive воспользуйтесь [инструкцией](https://developers.google.com/drive/api/v3/enable-drive-api) в официальной документации и создайте **OAuth client ID** типа **TVs and limited input devices**.

  Используйте созданный **OAuth client ID** и инициализируйте датасет, выполнив в ячейке код: 

    ```python
    #pragma dataset init <имя_датасета> --size 1Gb

    client_secret = {<идентификатор_OAuth_клиентского_файла>}

    gdrive = Storage.gdrive(client_secret)
    gdrive_file_id = '<идентификатор_файла_в_Google_Drive>'
    dst_path = '/home/jupyter/mnt/datasets/<имя_датасета>/<путь>/file.txt'
    gdrive.get(gdrive_file_id, dst_path)
    ```
{% endif %}

{% endlist %}

## Активировать датасет {#use}

Сразу после инициализации датасет становится активным в проекте и доступен по адресу `/home/jupyter/mnt/datasets/<имя_датасета>`. Одновременно в проекте может быть активировано до 3 датасетов. Во время работы вы можете активировать датасеты, когда они необходимы, и отключать их, если данные больше не нужны.

Чтобы активировать датасет:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **Ресурсы проекта** нажмите ![dataset](../../../_assets/datasphere/dataset.svg)**Датасет**.
1. В строке с нужным датасетом нажмите значок ![options](../../../_assets/options.svg) и выберите **Применить**.

## Посмотреть список датасетов, доступных в проекте {#list}

{% list tabs %}

- Интерфейс {{ ml-platform-name }}

  Откройте страницу проекта в блоке **Ресурсы проекта** → ![dataset](../../../_assets/datasphere/dataset.svg) **Датасет** и перейдите на вкладку **Доступные**.

- Код в ноутбуке

  Выполните ячейку с кодом:

  ```bash
  #pragma datasets list
  ```

{% endlist %}

## Поделиться датасетом {#share}

Поделиться датасетом в сообществе может только администратор сообщества.

Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **Ресурсы проекта** нажмите ![dataset](../../../_assets/datasphere/dataset.svg)**Датасет**.
1. Выберите нужный датасет в списке.
1. Перейдите на вкладку **Доступ**.
1. Включите опцию видимости напротив названия сообщества, с которым нужно поделиться датасетом.

## Удалить датасет {#delete}

Вы можете удалить датасет, только если он:

* не активирован в собственном проекте;
* не используется в других проектах; 
* недоступен в сообществе.

Чтобы удалить датасет:

{% list tabs %}

- Интерфейс {{ ml-platform-name }}

  1. На странице проекта в блоке **Ресурсы проекта** нажмите ![dataset](../../../_assets/datasphere/dataset.svg)**Датасет**.
  1. В строке с нужным датасетом нажмите значок ![options](../../../_assets/options.svg) и выберите **Удалить**.

- Код в ноутбуке

  Чтобы удалить датасет `<имя_датасета>`, выполните ячейку с кодом:

  ```bash
  #pragma dataset delete <имя_датасета>
  ```

{% endlist %}