# Получить информацию об имеющихся Docker-образах

Узнайте, как получить:
* [Список Docker-образов в реестре](#docker-image-list)
* [Подробную информацию о Docker-образе](#docker-image-get)

## Получить список Docker-образов в реестре {#docker-image-list}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Получите список [Docker-образов](../../concepts/docker-image.md) в текущем реестре:
  
  ```
  $ yc container image list
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
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Получите подробную информацию о Docker-образе с помощью `id` из [предыдущего](#docker-image-list) пункта:
  
  ```
  $ yc container image get crphc7nnrvhlg73oeiv5
  id:crphc7nnrvhlg73oeiv5
  name: crpd50616s9a2t7gr8mi/ubuntu
  digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
  compressed_size: "32179828"
  config:
  id: crpm7evgqjvq5nmfbr0o
    digest: sha256:50ff4b0e5783e7d012818d995ddea71849c9e88221d9707018e924b850d5961b
    size: "3618"
  layers:
  - id: crp0l3gr1hd2dilbdp6u
    digest: sha256:a5bdc630309340a3154f37e17c00a61c28c476107656e8d6744d2ba9af980058
    size: "509"
  - id: crpqlnj04jn0oatdi08d
    digest: sha256:84ed7d2f608f8a65d944b40132a0333069302d24e9e51a6d6b338888e8fd0a6b
    size: "32174695"
  - id: crpudn4acvclasn6u1uh
    digest: sha256:be2bf1c4a48dae92d5a1b8aa319c8767fa491316fb80da52de80378264599a16
    size: "843"
  - id: crpqp1jjjmft5o02hg97
    digest: sha256:e9055237d68d011bb90d49096b637b3b6c5c7251f52e0f2a2a44148aec1181dc
    size: "163"
  tags:
  - hello
  ```
  
- API
  
  Чтобы получить подробную информацию о Docker-образе, воспользуйтесь методом [get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/).
  
{% endlist %}



