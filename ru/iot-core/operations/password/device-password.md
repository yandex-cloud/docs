# Управление паролями устройства

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять паролями устройства для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль устройству {#create-or-add}

Вы можете добавить пароль уже созданному устройству или задать его при создании устройства с помощью параметра `--password`.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Добавить пароль уже созданному устройству {#add}  

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    Чтобы добавить пароль: 
    1. Получите список устройств в реестре: 
    
        ```
        $ yc iot device --registry-name my-registry list
        +----------------------+--------+
        |          ID          |  NAME  |
        +----------------------+--------+
        | arenak5ciqss6pbas5tm | second |
        | areqjd6un3afc3cefuio | first  |
        +----------------------+--------+
        ```    
    1. Добавьте пароль устройству:
    
        ```
        $ yc iot device password add --device-name first --password Passw0rdForDevice
        device_id: areqjd6un3afc3cefcvm
        id: areqjd6un3afc3cefuio
        created_at: "2019-12-16T15:11:36.892167Z"
        ```
       
{% endlist %}

### Задать пароль устройству при создании {#create}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы задать пароль при создании:
    1. Получите список реестров в каталоге: 
        
        ```
        $ yc iot registry list
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4ct42eq8f4m | my-registry       |
        +----------------------+-------------------+
        ```
    1. Создайте устройство с паролем:       
    
        ```
        $ yc iot device create --registry-name my-registry --name device-with-pass --password Passw0rdForDevice
        id: arepomfambsg5biqc25n
        registry_id: arenou2oj4ct42eq8g3n
        created_at: "2019-12-16T15:18:39.358922Z"
        name: device-with-pass
        ```
       
{% endlist %}  

## Получить список паролей устройства {#list}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы получить список паролей:  
    1. Получите список устройств в реестре: 
    
        ```
        $ yc iot device --registry-name my-registry list
        +----------------------+------------------+
        |          ID          |       NAME       |
        +----------------------+------------------+
        | arenak5ciqss6pbas5tm | second           |
        | arepomfambsg5biqc77p | device-with-pass |
        | areqjd6un3afc3cefuio | first            |
        +----------------------+------------------+
        ```
    1. Получите список паролей устройства: 
    
        ```
        $ yc iot device password list --device-name device-with-pass
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | areuin5t7pndvlj6n4tr | 2019-12-16 15:18:39 |
        +----------------------+---------------------+
        ```

{% endlist %}     
   
## Удалить пароль устройства {#delete}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы удалить пароль:  
    1. Получите список паролей устройства: 
    
        ```
        $ yc iot device password list --device-name device-with-pass
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | areuin5t7pndvlj6n4tr | 2019-12-16 15:18:39 |
        +----------------------+---------------------+
        ```
    1. Удалите пароль: 
    
        ```
        $ yc iot device password delete --device-name device-with-pass --password-id areuin5t7pndvlj6n4tr
        ```
    1. Убедитесь, что пароль действительно удален: 
        
        ```
        $ yc iot device password list --device-name device-with-pass
        +----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```
       
{% endlist %}       
