# Получить информацию об имеющихся Docker-образах

Узнайте, как получить:
* [Список Docker-образов в реестре](#docker-image-list).
* [Подробную информацию о Docker-образе](#docker-image-get).

## Получить список Docker-образов в реестре {#docker-image-list}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Получите список [Docker-образов](../../concepts/docker-image.md) в текущем реестре:

  ```bash
  yc container image list
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------------+------+-----------------+
  |          ID          |       CREATED       |            NAME            | TAGS | COMPRESSED SIZE |
  +----------------------+---------------------+----------------------------+------+-----------------+
  | crp9vik7sgec******** | 2019-01-17 17:00:48 | crph8pf7irvc********/myimg |  111 | 30.7 MB         |
  +----------------------+---------------------+----------------------------+------+-----------------+
  ```

- API {#api}

  Чтобы получить список Docker-образов в реестре, воспользуйтесь методом [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md).

{% endlist %}

## Получить информацию о Docker-образе {#docker-image-get}

{% list tabs group=instructions %}

- CLI {#cli}

  Получите подробную информацию о Docker-образе с помощью `id` из [предыдущего](#docker-image-list) пункта:

  ```bash
  yc container image get crphc7nnrvhl********
  ```

  Результат:
  
  ```bash
  id:crphc7nnrvhl********
  name: crpd50616s9a********/ubuntu
  digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
  ...
    size: "163"
  tags:
  - hello
  ```

- API {#api}

  Чтобы получить подробную информацию о Docker-образе, воспользуйтесь методом [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md).

{% endlist %}