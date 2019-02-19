# Получить список репозиториев в реестре

Чтобы получить список [репозиториев](../../concepts/repository.md) в реестре, необходимо указать реестр с помощью 
`--registry-id` или `--registry-name`. Узнать данные параметры можно [запросив список реестров](../registry/registry-list.md#registry-list).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

Получите список репозиториев в реестре:
    
* Используя параметр `--registry-id`:
    
    ```
    $ yc container repository list --registry-id crp3qleutgksvd1prhvb
    +-----------------------------+
    |            NAME             |
    +-----------------------------+
    | crp3qleutgksvd1prhvb/ubuntu |
    +-----------------------------+
    ```

* Используя параметр `--registry-name`:
    
    ```
    $ yc container repository list --registry-name new-reg
    +-----------------------------+
    |            NAME             |
    +-----------------------------+
    | crp3qleutgksvd1prhvb/ubuntu |
    +-----------------------------+
    ```

**[!TAB API]**

Чтобы получить список репозиториев в реестре, воспользуйтесь методом [list](../../api-ref/Repository/list.md) для ресурса [Repository](../../api-ref/Repository/).

---
