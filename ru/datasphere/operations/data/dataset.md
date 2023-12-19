# Работа с датасетами

Для работы с большими объемами данных в {{ ml-platform-name }} используйте [датасеты](../../concepts/dataset.md). Основные операции с датасетами выполняются в коде ячеек с помощью [служебных команд](../../concepts/pragma.md) `#pragma dataset`. 

## Создать и инициализировать датасет {#create}

Создать и инициализировать датасет можно из ячейки с кодом на Bash или Python, содержащей команду `#pragma dataset init`. При инициализации укажите уникальное в пределах [проекта](../../concepts/project.md) имя датасета и размер [диска](../../../compute/concepts/disk.md), на котором будет размещен датасет.

{% note info %}

Во время инициализации датасета будет выделен весь запрошенный объем дискового хранилища, однако часть этого объема будет занята файловой системой. Указывайте размер датасета в ГБ, округляя до целого в большую сторону.

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

  import os
  import boto3

  S3_CREDS = {
      "aws_access_key_id": os.environ['<секрет_с_ID_ключа_доступа>'],
      "aws_secret_access_key": os.environ['<секрет_с_секретным_ключом>']
  }
  bucket_name = "<имя_бакета>"

  source_path = ''
  target_path = '/home/jupyter/mnt/datasets/<имя_датасета>/'

  s3r = boto3.resource(service_name='s3', endpoint_url='https://storage.yandexcloud.net', **S3_CREDS)
  bucket = s3r.Bucket(bucket_name)

  for obj in bucket.objects.filter(Prefix=source_path):
      if not os.path.relpath(obj.key, source_path).startswith('../'):
          os.makedirs(os.path.join(target_path, os.path.dirname(obj.key)), exist_ok=True)
          if obj.key[-1] != '/':
              bucket.download_file(obj.key, os.path.join(target_path, obj.key))
  ```

  Где:

  * `aws_access_key_id` — идентификатор [статического ключа доступа](../../../iam/concepts/authorization/access-key.md), [сгенерированный](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта проекта.
  * `aws_secret_access_key` — секретный ключ, сгенерированный для того же сервисного аккаунта.

- Яндекс Диск

  Инициализируйте датасет в ячейке с кодом:

  ```python
  #pragma dataset init <имя_датасета> --size 8Gb

  import requests
  from urllib.parse import urlencode
  from io import BytesIO
  from zipfile import ZipFile

  base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
  public_key = '<ссылка_на_каталог_на_Яндекс_Диске>'

  final_url = base_url + urlencode(dict(public_key=public_key))
  response = requests.get(final_url)
  download_url = response.json()['href']
  response = requests.get(download_url)

  dist_path = '/home/jupyter/mnt/datasets/<имя_датасета>/'
  zipfile = ZipFile(BytesIO(response.content))
  zipfile.extractall(path=dist_path)
  ```

  Где `<ссылка_на_каталог_на_Яндекс_Диске>` — ссылка для доступа к каталогу на Яндекс Диске, содержимое которого нужно загрузить в {{ ml-platform-name }}.

- Google Drive

  1. Установите пакет [gdown](https://pypi.org/project/gdown/):

     ```python
     %pip install gdown
     ```

  1. Инициализируйте датасет в ячейке с кодом:

     ```python
     #pragma dataset init <имя_датасета> --size 1Gb

     import gdown

     gdrive_folder_id = '<ID_папки_Google_Drive>'
     dst_path = '/home/jupyter/mnt/datasets/<имя_датасета>/'

     gdown.download_folder(id=gdrive_folder_id, output=dst_path, use_cookies=False)
     ```

     Где `gdrive_folder_id` — идентификатор папки Google Drive, который содержится в адресе после `https://drive.google.com/drive/folders/`. Например, в URL `https://drive.google.com/drive/folders/exampleId` идентификатор папки — `exampleId`.

{% endlist %}

## Активировать датасет {#use}

Сразу после инициализации датасет становится активным в проекте и доступен по адресу `/home/jupyter/mnt/datasets/<имя_датасета>`. Одновременно в проекте может быть активировано до 3 датасетов. Во время работы вы можете активировать датасеты, когда они необходимы, и отключать их, если данные больше не нужны.

Чтобы активировать датасет:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![dataset](../../../_assets/console-icons/layers.svg)**{{ ui-key.yc-ui-datasphere.resources.dataset}}**.
1. В строке с нужным датасетом нажмите значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.activate}}**.

## Посмотреть список датасетов, доступных в проекте {#list}

На странице проекта в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset}}**. Затем перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Поделиться датасетом {#share}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. Выберите нужный датасет в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, с которым нужно поделиться датасетом.

Чтобы датасет стал доступен для работы в другом проекте, администратор проекта должен [добавить](../projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Удалить датасет {#delete}

Вы можете удалить датасет, только если он:

* не активирован в собственном проекте;
* не используется в других проектах; 
* недоступен в сообществе.

Чтобы удалить датасет:

1. На странице проекта в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. В строке с нужным датасетом нажмите значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
