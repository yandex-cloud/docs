# AWS Command Line Interface (AWS CLI)

[AWS CLI](https://aws.amazon.com/ru/cli/) — это интерфейс командной строки для работы с сервисами AWS. Общий [порядок вызова команд](https://docs.aws.amazon.com/cli/latest/reference/) смотрите в официальной документации Amazon.

Для работы с {{ objstorage-name }} с помощью AWS CLI вы можете использовать следующие наборы команд:
* [s3api](https://docs.aws.amazon.com/cli/latest/reference/s3api/index.html) — команды, соответствующие операциям в REST API. Перед использованием ознакомьтесь с [перечнем поддерживаемых операций](../s3/api-ref/index.md).
* [s3](https://docs.aws.amazon.com/cli/latest/reference/s3/index.html) — дополнительные команды, упрощающие работу с большим количеством объектов.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

{% include [install-aws-cli](../../_includes/aws-tools/install-aws-cli.md) %}

## Настройка {#setup}

Для настройки AWS CLI используйте команду `aws configure`. Команда запросит значения для следующих параметров:
1. `AWS Access Key ID` — введите идентификатор ключа, который вы получили при генерации статического ключа.
1. `AWS Secret Access Key` — введите секретный ключ, который вы получили при генерации статического ключа.
1. `Default region name` — введите значение `{{ region-id }}`.

   {% note info %}

   Для работы с {{ objstorage-name }} всегда указывайте регион — `{{ region-id }}`. Другие значения региона могут привести к ошибке авторизации.

   {% endnote %}

1. Значения остальных параметров оставьте без изменений.

### Конфигурационные файлы {#config-files}

В результате своей работы команда `aws configure` сохранит настройки в файлах:
* Статический ключ в `.aws/credentials` в формате:

  ```
  [default]
    aws_access_key_id = id
    aws_secret_access_key = secretKey
  ```

* Регион по умолчанию в `.aws/config` в формате:

  ```
  [default]
    region={{ region-id }}
  ```

## Особенности {#specifics}

При использовании AWS CLI для работы с {{ objstorage-name }} учитывайте следующие особенности этого инструмента:
* AWS CLI работает с {{ objstorage-name }} как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.
* При запуске команды `aws` для работы с {{ objstorage-name }} обязателен параметр `--endpoint-url`, поскольку по умолчанию клиент настроен на работу с серверами Amazon. Чтобы не указывать параметр вручную при каждом запуске, создайте псевдоним (alias), например:

  ```bash
  alias ycs3='aws s3 --endpoint-url=https://{{ s3-storage-host }}'
  ```
  
  С таким псевдонимом будут равносильны, например, две следующие команды:

  ```bash
  aws s3 --endpoint-url=https://{{ s3-storage-host }} ls
  ```

  ```bash
  ycs3 ls
  ```
  
  Чтобы псевдоним создавался при каждом запуске терминала, добавьте команду `alias` в конфигурационный файл `~/.bashrc` или `~/.zshrc`, в зависимости от типа используемой оболочки.
  
* При работе в macOS, в некоторых случаях требуется запуск вида:

  ```
  export PYTHONPATH=/Library/Python/2.7/site-packages; aws --endpoint-url=https://{{ s3-storage-host }} s3 ls
  ```

## Примеры операций {#aws-cli-examples}

{% note info %}

Для включения отладочного вывода в консоли используйте ключ `--debug`.

{% endnote %}

### Создать бакет {#creating-bucket}

```bash
aws --endpoint-url=https://{{ s3-storage-host }} s3 mb s3://bucket-name
```

{% note info %}

При создании бакета помните об [ограничениях на имя](../concepts/bucket.md#naming).

{% endnote %}

### Загрузить объекты {#uploading-objects}

Загрузить объекты можно разными способами, например:
* Загрузить все объекты из локальной директории:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
  ```

* Загрузить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре `--exclude`:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 cp --recursive --exclude "*" --include "*.log" \
    local_files/ s3://bucket-name/path_style_prefix/
  ```

* Загрузить объекты по одному, запуская для каждого объекта команду следующего вида:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Получить список объектов {#getting-objects-list}

```bash
aws --endpoint-url=https://{{ s3-storage-host }} \
  s3 ls --recursive s3://bucket-name
```

### Удалить объекты {#deleting-objects}

Удалить объекты можно разными способами, например:
* Удалить все объекты с заданным префиксом:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 rm s3://bucket-name/path_style_prefix/ --recursive
  ```

* Удалить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре`--exclude`:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 rm s3://bucket-name/path_style_prefix/ --recursive \
      --exclude "*" --include "*.log"
  ```

* Удалить объекты по одному, запуская для каждого объекта команду следующего вида:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 rm s3://bucket-name/path_style_prefix/textfile.txt
  ```

### Получить объект {#retrieving-objects}

```bash
aws --endpoint-url=https://{{ s3-storage-host }} \
  s3 cp s3://bucket-name/textfile.txt textfile.txt
```
