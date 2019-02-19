# Удалить реестр

> [!NOTE]
>
> Удалить можно только пустой реестр. Не забудьте [удалить Docker-образы из реестра](../docker-image/docker-image-delete.md) перед началом операции.  

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, 
читайте в разделе [Получить информацию об имеющихся реестрах](registry-list.md).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

1. Удалите реестр:
    
    * Используя `id`:
        
        ```
        $ yc container registry delete --id crp3qleutgksvd1prhvb
        ..done
        ```
       
    * Используя `name`:
        
        ```
        $ yc container registry delete --name new-reg
        ..done
        ```
    
1. Проверьте, что реестр действительно удален: 
    
    ```
    $ yc container registry list
    +----+------+-----------+
    | ID | NAME | FOLDER ID |
    +----+------+-----------+
    +----+------+-----------+
    ```

**[!TAB API]**

Чтобы удалить реестр, воспользуйтесь методом [delete](../../api-ref/Registry/delete.md) для ресурса [Registry](../../api-ref/Registry/).



---
