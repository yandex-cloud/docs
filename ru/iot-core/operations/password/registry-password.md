# Управление паролями реестра

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано как управлять паролями реестра для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль реестру {#create-or-add}

Вы можете добавить пароль уже созданному реестру, или задать его при создании реестра с помощью параметра `--password`.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Добавить пароль уже созданному реестру {#add}  

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    Чтобы добавить пароль: 
    1. Получите список реестров в каталоге: 
    
        ```
        $ yc iot registry list
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4ct42eq82er | my-registry       |
        +----------------------+-------------------+
        ```    
    1. Добавьте пароль реестру:
    
        ```
        $ yc iot registry password add --registry-name my-registry --password Passw0rdForRegistry
        registry_id: arenou2oj4ct42eq8g3n
        id: areuu2hgsv6klgbd4e6d
        created_at: "2019-12-16T15:32:46.655139Z"
        ```
       
{% endlist %}

### Задать пароль реестру при создании {#create}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Создайте реестр с паролем:       
    
    ```
    $ yc iot registry create --name registry-with-pass --password Passw0rdForDevice
    done (1s)
    id: areg96c8loruvvudj54t
    folder_id: b1g88tflru0ek1omtfd3
    created_at: "2019-12-16T15:34:25.563Z"
    name: registry-with-pass
    status: ACTIVE
    log_group_id: ckghhil3b5o9t4pf1nvg
    ```
       
{% endlist %}  

## Получить список паролей реестра {#list}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы получить список паролей:  
    1. Получите список реестров в каталоге: 
    
        ```
        $ yc iot registry list
        +----------------------+--------------------+
        |          ID          |        NAME        |
        +----------------------+--------------------+
        | areg96c8loruvvudj54t | registry-with-pass |
        | arenou2oj4ct42eq82er | my-registry        |
        +----------------------+--------------------+
        ```
    1. Получите список паролей реестра: 
    
        ```
        $ yc iot registry password list --registry-name registry-with-pass
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957egmoksgf4 | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```

{% endlist %}     
   
## Удалить пароль реестра {#delete}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы удалить пароль:  
    1. Получите список паролей реестра: 
    
        ```
        $ yc iot registry password list --registry-name registry-with-pass
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957egmoksgf4 | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```
    1. Удалите пароль: 
    
        ```
        $ yc iot registry password delete --registry-name registry-with-pass --password-id are0gffs957egmoksgf4
        ```
    1. Убедитесь, что пароль действительно удален: 
        
        ```
        $ yc iot registry password list --registry-name registry-with-pass
        +----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```
       
{% endlist %}       
