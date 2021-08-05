---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Управление паролями реестра

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять паролями реестра для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль реестру {#create-or-add}

Вы можете добавить пароль уже созданному реестру или задать его при создании реестра с помощью параметра `--password`.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Добавить пароль уже созданному реестру {#add}  

{% list tabs %}

- Консоль управления

   Чтобы добавить пароль уже созданному реестру:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить пароль уже созданному реестру.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. В блоке **Пароли** нажмите кнопку **Добавить пароль**.
   1. В поле **Пароль** введите пароль, который вы будете использовать для доступа к реестру.<br/>Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/).<br/>Не забудьте сохранить пароль, он вам понадобится.
   1. Нажмите кнопку **Добавить**.

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

- Консоль управления

   Как задать пароль реестру при создании, читайте в разделе [{#T}](../registry/registry-create.md).

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

- Консоль управления

   Чтобы просмотреть список паролей реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите получить список паролей реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. На странице **Обзор** перейдите к разделу **Пароли**.

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

- Консоль управления

   Чтобы удалить пароль реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить пароль реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. Справа от удаляемого пароля нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

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
