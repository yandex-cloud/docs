# Создать реестр

В одном каталоге можно создать только один [реестр](../../concepts/registry.md). Использовать созданный реестр могут все, у кого есть права на каталог. 


---
 
**[!TAB Консоль управления]**

Чтобы создать [реестр](../../concepts/registry.md): 
1. Откройте раздел **Container Registry** в каталоге, где требуется создать реестр.
1. Нажмите кнопку **Создать реестр**.
1. Задайте имя реестра.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Нажмите кнопку **Создать реестр**.

 
**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Убедитесь, что в каталоге еще не создан реестр:

    ```
    $ yc container registry list
    +----+------+-----------+
    | ID | NAME | FOLDER ID |
    +----+------+-----------+
    +----+------+-----------+
    ```
    
    Если в каталоге уже есть реестр, посмотрите, как можно его изменить, в разделе [Изменить реестр](registry-update.md).

1. Создайте реестр:
    
    ```
    $ yc container registry create --name my-reg
    ..done
    id: crpd50616s9a2t7gr8mi
    folder_id: b1g88tflru0ek1omtsu0
    name: my-reg
    status: ACTIVE
    created_at: "2019-01-09T14:34:06.601Z"
    ```
    
    [!INCLUDE [name-format](../../../_includes/name-format.md)]
    
    Обратите внимание: 
    - Флаг `--name` необязательный — можно создать реестр без имени и обращаться к нему по идентификатору.
    - Поле `name` — пользовательское, оно используется при листинге в YC CLI и **не используется** в Docker CLI.
    
1. Проверьте, что реестр создался: 
    
    ```
    $ yc container registry list
    +----------------------+--------+----------------------+
    |          ID          |  NAME  |      FOLDER ID       |
    +----------------------+--------+----------------------+
    | crpd50616s9a2t7gr8mi | my-reg | b1g88tflru0ek1omtsu0 |
    +----------------------+--------+----------------------+
    ```

**[!TAB API]**

Чтобы создать реестр, воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/).

---
