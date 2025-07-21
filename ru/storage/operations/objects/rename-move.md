---
title: Переименование и перемещение объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете переименовать или переместить объект в бакете в {{ objstorage-name }}.
---

# Переименование и перемещение объекта


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


Помимо {{ yandex-cloud }} CLI и AWS CLI для переименования и перемещения объектов вы можете воспользоваться [поддерживаемыми инструментами](../../../storage/tools/index.md), например файловым браузером.

## Переименование {#rename}

{% note info %}

Можно переименовать [объекты](../../concepts/object.md) в [бакете](../../concepts/bucket.md). Переименовать сам бакет нельзя. Но вы можете [создать](../buckets/create.md) новый бакет и [скопировать](./copy.md#copy-from-bucket-to-bucket) в него все объекты из исходного.

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для переименования объекта в бакете:

      ```bash
      yc storage s3 mv --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Выполните команду:

      ```bash
      yc storage s3 mv \
        s3://<имя_бакета>/<ключ_объекта> \
        s3://<имя_бакета>/<новый_ключ_объекта>
      ```

      Результат:

      ```text
      move: s3://my-bucket/object.txt to s3://my-bucket/renamed-object.txt
      ```

  Подробнее о команде `yc storage s3 mv` см. в [документации](../../cli-ref/s3/mv.md).

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Чтобы переименовать объект, выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv s3://<имя_бакета>/<ключ_объекта> s3://<имя_бакета>/<новый_ключ_объекта>
      ```

      Где: 

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `s3 mv` — команда для переименования или перемещения объекта. Чтобы переименовать объект, в первой части команды укажите имя бакета и актуальный [ключ](../../concepts/object.md#key) объекта, который нужно переименовать, а во второй — имя бакета и новый ключ объекта.

      Результат:

      ```text
      move: s3://<имя_бакета>/<ключ_объекта> to s3://<имя_бакета>/<новый_ключ_объекта>
      ```

  Подробнее о команде `aws s3 mv` см. в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html).

{% endlist %}

### Изменение префикса для группы объектов {#rename-prefix} 

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы изменить [префикс](../../concepts/object.md#key) для группы объектов, выполните команду:

  ```bash
  yc storage s3 mv --recursive \
    s3://<имя_бакета>/<префикс>/ \
    s3://<имя_бакета>/<новый_префикс>/
  ```

  Результат:

  ```text
  move: s3://my-bucket/my-prefix/ to s3://my-bucket/renamed-prefix/
  ```

  Подробнее о команде `yc storage s3 mv` см. в [документации](../../cli-ref/s3/mv.md).

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv --recursive s3://<имя_бакета>/<префикс>/ s3://<имя_бакета>/<новый_префикс>/
      ```

      Где: 

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `s3 mv` — команда для переименования или перемещения объекта. Чтобы переименовать объект, в первой части команды укажите имя бакета и актуальный [префикс](../../concepts/object.md#key) группы объектов, которую нужно переименовать, а во второй — имя бакета и новый префикс группы объектов.
      * `--recursive` — параметр для изменения префикса группы объектов.

      Результат:

      ```text
      move: s3://<имя_бакета>/<префикс>/ to s3://<имя_бакета>/<новый_префикс>/
      ```  

  Подробнее о команде `aws s3 mv` см. в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html).

{% endlist %}

## Перемещение {#move}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для перемещения объекта:

      ```bash
      yc storage s3 mv --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Выполните команду:

      ```bash
      yc storage s3 mv \
        s3://<имя_бакета-источника>/<ключ_объекта> \
        s3://<имя_целевого_бакета>/<ключ_объекта>
      ```

      Результат:

      ```text
      move: s3://my-bucket/object.txt to s3://new-bucket/object.txt
      ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Чтобы переместить объект, например, из одного бакета в другой, выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv s3://<имя_бакета-источника>/<ключ_объекта> s3://<имя_целевого_бакета>/<ключ_объекта>
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `s3 mv` — команда для переименования или перемещения объекта. Чтобы переместить объект, в первой части команды укажите имя бакета-источника и [ключ](../../concepts/object.md#key) объекта, который нужно переместить, а во второй — имя целевого бакета и ключ объекта.

      Результат:

      ```text
      move: s3://<имя_бакета-источника>/<ключ_объекта> to s3://<имя_целевого_бакета>/<ключ_объекта>
      ```

  Подробнее о команде `aws s3 mv` см. в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html).

{% endlist %}

### Перемещение объекта из одной папки в другую {#move-object-folder}

В {{ objstorage-name }} [папки](../../concepts/object.md#folder) имитируются с помощью префиксов ключей. Чтобы переместить объект из одной папки в другую, [переименуйте](#rename) префикс его ключа, например:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  ```bash
  yc storage s3 mv \
    s3://<имя_бакета>/<префикс>/<имя_объекта> \
    s3://<имя_бакета>/<новый_префикс>/<имя_объекта>
  ```

  Результат:

  ```text
  move: s3://my-bucket/my-prefix/object.txt to s3://my-bucket/renamed-prefix/object.txt
  ```

- AWS CLI {#aws-cli}

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    s3 mv s3://<имя_бакета>/<префикс>/<имя_объекта> s3://<имя_бакета>/<новый_префикс>/<имя_объекта>
  ```

  Результат:

  ```text
  move: s3://my-bucket/my-prefix/object.txt to s3://my-bucket/renamed-prefix/object.txt
  ```  

{% endlist %}

### Перемещение папки с объектами {#move-folder}

В {{ objstorage-name }} [папки](../../concepts/object.md#folder) имитируются с помощью префиксов ключей. Чтобы переместить папку с объектами, [измените](#rename-prefix) префикс для группы объектов. 

### Перемещение всех объектов из одного бакета в другой {#move-all}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Выполните команду:

  ```bash
  yc storage s3 mv --recursive \
    s3://<имя_бакета-источника>/ \
    s3://<имя_целевого_бакета>/
  ```

  Результат:

  ```text
  move: s3://my-bucket/object1.txt to s3://new-bucket/object1.txt
  move: s3://my-bucket/object2.txt to s3://new-bucket/object2.txt
  ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv --recursive s3://<имя_бакета-источника> s3://<имя_целевого_бакета>
      ```

      Где:
      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `s3 mv` — команда для переименования или перемещения объекта. Чтобы переместить все объекты, в первой части команды укажите имя бакета-источника, а во второй — имя целевого бакета.
      * `--recursive` — параметр для перемещения всех объектов из одного бакета в другой.

      Результат:

      ```text
      move: s3://<имя_бакета-источника>/<ключ_объекта_1> to s3://<имя_целевого_бакета>/<ключ_объекта_1>
      move: s3://<имя_бакета-источника>/<ключ_объекта_2> to s3://<имя_целевого_бакета>/<ключ_объекта_2>
      ```

  Подробнее о команде `aws s3 mv` см. в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html).

{% endlist %}
