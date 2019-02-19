# Получить информацию об имеющихся реестрах

Узнайте, как получить: 
* [Список реестров в каталоге](#registry-list)
* [Подробную информацию о реестре](#registry-get)

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

## Получить список реестров в каталоге {#registry-list}

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Получите список [реестов](../../concepts/registry.md) в каталоге по умолчанию:

```
$ yc container registry list
+----------------------+--------+----------------------+
|          ID          |  NAME  |      FOLDER ID       |
+----------------------+--------+----------------------+
| crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
+----------------------+--------+----------------------+
```

**[!TAB API]**

Чтобы получить список реестов в каталоге по умолчанию, воспользуйтесь методом [list](../../api-ref/Registry/list.md) для ресурса [Registry](../../api-ref/Registry/).


---


## Получить подробную информацию о реестре {#registry-get}

Для обращения к реестру используйте параметры `id` или `name` из [предыдущего](#registry-list) пункта.

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Получите подробную информацию о реестре:
    
* Используя параметр `id`:
    
    ```
    $ yc container registry get --id crpd50616s9a2t7gr8mi
    id: crpd50616s9a2t7gr8mi
    folder_id: b1g88tflru0ek1omtsu0
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-09T14:34:06.601Z"
    ```

* Используя параметр `name`:

    ```
    $ yc container registry get --name my-reg
    id: crpd50616s9a2t7gr8mi
    folder_id: b1g88tflru0ek1omtsu0
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-09T14:34:06.601Z"
    ```
**[!TAB API]**

Чтобы получить подробную информацию о реестре, воспользуйтесь методом [get](../../api-ref/Registry/get.md) для ресурса [Registry](../../api-ref/Registry/).


---
