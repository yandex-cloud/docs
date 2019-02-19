## Удалить Docker-образ из реестра

Для удаления [Docker-образа](../../concepts/docker-image.md) используйте его идентификатор. Узнать идентификатор можно
[запросив список Docker-образов в нужном реестре](docker-image-list.md#docker-image-list). 

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

1. Удалите Docker-образ: 

    ```
    $ yc container image delete --id crp9vik7sgeco7emq743
    ```
    
1. Проверьте, что Docker-образ действительно удален:

    ```
    $ yc container image list
    +----+---------+------+------+-----------------+
    | ID | CREATED | NAME | TAGS | COMPRESSED SIZE |
    +----+---------+------+------+-----------------+
    +----+---------+------+------+-----------------+
    ```

**[!TAB API]**

Чтобы удалить Docker-образ, воспользуйтесь методом [delete](../../api-ref/Image/delete.md) для ресурса [Image](../../api-ref/Image/).

---
