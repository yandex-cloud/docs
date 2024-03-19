# AWS Command Line Interface (AWS CLI)

[AWS CLI](https://aws.amazon.com/ru/cli/) — это интерфейс командной строки для работы с сервисами AWS. Общий [порядок вызова команд](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html) смотрите в официальной документации Amazon.

Для работы с {{ objstorage-name }} с помощью AWS CLI вы можете использовать следующие наборы команд:
* [s3api](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/index.html) — команды, соответствующие операциям в [REST API](../../glossary/rest-api.md). Перед использованием ознакомьтесь с [перечнем поддерживаемых операций](../s3/api-ref/index.md).
* [s3](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html) — дополнительные команды, упрощающие работу с большим количеством объектов.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% include [install-aws-cli](../../_includes/aws-tools/install-aws-cli.md) %}

## Настройка {#setup}

Для настройки AWS CLI введите команду `aws configure`. Команда запросит значения для следующих параметров:
1. `AWS Access Key ID` — идентификатор статического ключа, созданного при [подготовке к работе](#before-you-begin).
1. `AWS Secret Access Key` — содержимое статического ключа.
1. `Default region name` — регион `{{ region-id }}`.

   {% note info %}

   Для работы с {{ objstorage-name }} всегда указывайте регион — `{{ region-id }}`. Другие значения региона могут привести к ошибке авторизации.

   {% endnote %}

1. Значения остальных параметров оставьте без изменений.

### Конфигурационные файлы {#config-files}

В результате работы команда `aws configure` сохранит статический ключ и регион.
* Формат статического ключа в `.aws/credentials`:

  ```ini
  [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <содержимое_статического_ключа>
  ```

* Формат региона по умолчанию в `.aws/config`:

  ```ini
  [default]
    region = {{ region-id }}
  ```

* Вы можете создать несколько профилей для разных сервисных аккаунтов, указав их данные в файле `.aws/credentials`:

  ```ini
  [default]
    aws_access_key_id = <идентификатор_статического_ключа_1>
    aws_secret_access_key = <содержимое_статического_ключа_1>
  [<имя_профиля_2>]
    aws_access_key_id = <идентификатор_статического_ключа_2>
    aws_secret_access_key = <содержимое_статического_ключа_2>
  ...
  [<имя_профиля_n>]
    aws_access_key_id = <идентификатор_статического_ключа_n>
    aws_secret_access_key = <содержимое_статического_ключа_n>
  ```

  Где `default` — профиль по умолчанию.

  Чтобы переключаться между разными профилями в командах AWS CLI используется опция `--profile`, например:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    --profile <имя_профиля_2> \
    s3 mb s3://<имя_бакета>
  ```
  
## Особенности {#specifics}

Учитывайте особенности AWS CLI при работе с {{ objstorage-name }}:

* AWS CLI работает с {{ objstorage-name }} как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.
* По умолчанию клиент настроен на работу с серверами Amazon. Поэтому при запуске команды `aws` для работы с {{ objstorage-name }} обязательно используйте параметр `--endpoint-url`. Чтобы при каждом запуске не указывать параметр вручную, вы можете использовать псевдоним или файл конфигурации.
    * Создайте псевдоним (alias) с помощью команды:
    
      ```bash
      alias {{ storage-aws-cli-alias }}='aws s3 --endpoint-url=https://{{ s3-storage-host }}'
      ```

      Для создания псевдонима при каждом запуске терминала, добавьте команду `alias` в конфигурационный файл `~/.bashrc` или `~/.zshrc`, в зависимости от типа оболочки.

      С таким псевдонимом будут равносильны команды:

      ```bash
      aws s3 --endpoint-url=https://{{ s3-storage-host }} ls
      ```

      ```bash
      {{ storage-aws-cli-alias }} ls
      ```

    * (поддерживается в AWS CLI версий 1.29.0, 2.13.0 и выше) В файле конфигурации `.aws/credentials` добавьте параметр `endpoint_url`:

       ```text
       endpoint_url = https://{{ s3-storage-host }}
       ```

       После этого вы сможете вызывать команды без явного указания эндпоинта. Например, вместо `aws --endpoint-url=https://{{ s3-storage-host }} s3 ls` можно указывать `aws s3 ls`. Подробнее смотрите в документации [AWS CLI](https://docs.aws.amazon.com/sdkref/latest/guide/feature-ss-endpoints.html).

* При работе в macOS, в некоторых случаях требуется запуск вида:

  ```bash
  export PYTHONPATH=/Library/Python/2.7/site-packages; aws --endpoint-url=https://{{ s3-storage-host }} s3 ls
  ```

## Примеры операций {#aws-cli-examples}

{% note info %}

Для включения отладочного вывода в консоли используйте ключ `--debug`.

{% endnote %}

### Создать бакет {#creating-bucket}

```bash
aws s3 mb s3://bucket-name
```

Результат:

```text
make_bucket: bucket-name
```

{% note info %}

При создании бакета помните об [ограничениях на имя](../concepts/bucket.md#naming).

{% endnote %}

### Загрузить объекты {#uploading-objects}

Можно загрузить все объекты из директории, использовать фильтр или загрузить объекты по одному.
* Загрузить все объекты из локальной директории:

  ```bash
  aws s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
  ```

  Результат:

  ```text
  upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
  upload: ./textfile2.txt to s3://bucket-name/path_style_prefix/textfile2.txt
  upload: ./prefix/textfile3.txt to s3://bucket-name/path_style_prefix/prefix/textfile3.txt
  ```

* Загрузить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре `--exclude`:

  ```bash
  aws s3 cp --recursive --exclude "*" --include "*.log" \
    local_files/ s3://bucket-name/path_style_prefix/
  ```

  Результат:

  ```text
  upload: ./textfile1.log to s3://bucket-name/path_style_prefix/textfile1.log
  ```

* Загрузить объекты по одному, запуская для каждого объекта команду следующего вида:

  ```bash
  aws s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
  ```
  
  Результат:

  ```text
  upload: ./testfile.txt to s3://bucket-name/path_style_prefix/textfile.txt
  ```
  
### Получить список объектов {#getting-objects-list}

```bash
aws s3 ls --recursive s3://bucket-name
```

Результат:

```text
2022-09-05 17:10:34      10023 other/test1.png
2022-09-05 17:10:34      57898 other/test2.png
2022-09-05 17:10:34     704651 test.png
```

### Удалить объекты {#deleting-objects}

Можно удалить объекты с заданным префиксом, использовать фильтр или удалить объекты по одному.

* Удалить все объекты с заданным префиксом:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/ --recursive
  ```

  Результат:

  ```text
  delete: s3://bucket-name/path_style_prefix/test1.png
  delete: s3://bucket-name/path_style_prefix/subprefix/test2.png
  ```

* Удалить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре`--exclude`:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/ --recursive \
      --exclude "*" --include "*.log"
  ```

  Результат:
  
  ```text
  delete: s3://bucket-name/path_style_prefix/test1.log
  delete: s3://bucket-name/path_style_prefix/subprefix/test2.log
  ```

* Удалить объекты по одному, запуская для каждого объекта команду следующего вида:

  ```bash
  aws s3 rm s3://bucket-name/path_style_prefix/textfile.txt
  ```

  Результат:

  ```text
  delete: s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Получить объект {#retrieving-objects}

```bash
aws s3 cp s3://bucket-name/textfile.txt textfile.txt
```
Результат:

```text
download: s3://bucket-name/path_style_prefix/textfile.txt to ./textfile.txt
```
