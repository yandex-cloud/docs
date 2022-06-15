# Получить информацию об имеющихся Docker-образах

Узнайте, как получить:
* [Список Docker-образов в реестре](#docker-image-list).
* [Подробную информацию о Docker-образе](#docker-image-get).

## Получить список Docker-образов в реестре {#docker-image-list}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Получите список [Docker-образов](../../concepts/docker-image.md) в текущем реестре:

  ```bash
  yc container image list
  ```

  Результат выполнения команды:

  ```bash
  +----------------------+---------------------+----------------------------+------+-----------------+
  |          ID          |       CREATED       |            NAME            | TAGS | COMPRESSED SIZE |
  +----------------------+---------------------+----------------------------+------+-----------------+
  | crp9vik7sgeco7emq743 | 2019-01-17 17:00:48 | crph8pf7irvcu3p7gjpb/myimg |  111 | 30.7 MB         |
  +----------------------+---------------------+----------------------------+------+-----------------+
  ```

- API

  Чтобы получить список Docker-образов в реестре, воспользуйтесь методом [list](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/).

{% endlist %}

## Получить информацию о Docker-образе {#docker-image-get}

{% list tabs %}

- CLI

  Получите подробную информацию о Docker-образе с помощью `id` из [предыдущего](#docker-image-list) пункта:

  ```bash
  yc container image get crphc7nnrvhlg73oeiv5
  ```
  
  Результат выполнения команды:
  
  ```bash
  id:crphc7nnrvhlg73oeiv5
  name: crpd50616s9a2t7gr8mi/ubuntu
  digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
  ...
    size: "163"
  tags:
  - hello
  ```

- API

  Чтобы получить подробную информацию о Docker-образе, воспользуйтесь методом [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/).

{% endlist %}