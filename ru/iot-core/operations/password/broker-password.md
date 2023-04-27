---
title: "Инструкция по управлению паролями брокера в {{ iot-full-name }}"
description: "Из статьи вы узнаете, как получить список паролей брокера, добавить или удалить пароль брокера в {{ iot-full-name }}."
---

# Управление паролями брокера

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

Чтобы начать обмен сообщениями между клиентами брокера, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять паролями брокера для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Добавить пароль](#create-or-add)
* [Посмотреть список паролей](#list)
* [Удалить пароль](#delete)

## Добавить пароль брокеру {#create-or-add}

Вы можете добавить пароль уже созданному брокеру или задать его при создании брокера с помощью параметра `--password`.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Добавить пароль уже созданному брокеру {#add}  

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите добавить пароль уже созданному брокеру.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите брокер.
   1. В блоке **Пароли** нажмите кнопку **Добавить пароль**.
   1. В поле **Пароль** введите пароль, который будете использовать для доступа к брокеру. Для создания пароля можно воспользоваться [генератором паролей](https://passwordsgenerator.net/). Не забудьте сохранить пароль, он вам понадобится.
   1. Нажмите кнопку **Добавить**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы добавить пароль: 
    1. Получите список брокеров в каталоге: 
    
        ```
        yc iot broker list
		```
		
		Результат:
		```
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4********** | my-broker         |
        +----------------------+-------------------+
        ```    
    1. Добавьте пароль брокеру:
    
        ```
        yc iot broker password add --broker-name my-broker --password Passw0rdForBroker
        ```
		
		Результат:
		```
		broker_id: arenou2oj4**********
        id: areuu2hgsv6klgbd4e6d
        created_at: "2019-12-16T15:32:46.655139Z"
        ```

- API

  Чтобы добавить пароль брокеру, воспользуйтесь методом REST API [addPassword](../../broker/api-ref/Broker/addPassword.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/AddPassword](../../broker/api-ref/grpc/broker_service.md#AddPassword).

{% endlist %}

### Задать пароль брокеру при создании {#create}

{% list tabs %}

- Консоль управления

   Как задать пароль брокеру при создании, читайте в разделе [{#T}](../broker/broker-create.md).

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Создайте брокер с паролем:       
    
    ```
    yc iot broker create --name broker-with-pass --password Passw0rdForDevice
    ```
	
	Результат:
	```
	done (1s)
    id: areg96c8lo**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-16T15:34:25.563Z"
    name: broker-with-pass
    status: ACTIVE
    log_group_id: ckghhil3b5**********
    ```

- API

  Чтобы задать пароль брокеру при создании, воспользуйтесь методом REST API [create](../../broker/api-ref/Broker/create.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Create](../../broker/api-ref/grpc/broker_service.md#Create).

{% endlist %}  

## Получить список паролей брокера {#list}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите получить список паролей брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите брокер.
   1. На странице **Обзор** перейдите к разделу **Пароли**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы получить список паролей:  
    1. Получите список брокеров в каталоге: 
    
        ```
        yc iot broker list
		```
		
		Результат:
		```
        +----------------------+--------------------+
        |          ID          |        NAME        |
        +----------------------+--------------------+
        | areg96c8lo********** | broker-with-pass   |
        | arenou2oj4********** | my-broker          |
        +----------------------+--------------------+
        ```
    1. Получите список паролей брокера: 
    
        ```
        yc iot broker password list --broker-name broker-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs95********** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```

- API

  Чтобы получить список паролей брокера, воспользуйтесь методом REST API [listPasswords](../../broker/api-ref/Broker/listPasswords.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/ListPasswords](../../broker/api-ref/grpc/broker_service.md#ListPasswords).

{% endlist %}     
   
## Удалить пароль брокера {#delete}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите удалить пароль брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите брокер.
   1. В строке с нужным паролем нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы удалить пароль:  
    1. Получите список паролей брокера: 
    
        ```
        yc iot broker password list --broker-name broker-with-pass
        ```
		
		Результат:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs95********** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```
    1. Удалите пароль: 
    
        ```
        yc iot broker password delete --broker-name broker-with-pass --password-id are0gffs957egmoksgf4
        ```
    1. Убедитесь, что пароль удален: 
        
        ```
        yc iot broker password list --broker-name broker-with-pass
        ```
		
		Результат:
		```
		+----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```

- API

  Чтобы удалить пароль брокера, воспользуйтесь методом REST API [deletePassword](../../broker/api-ref/Broker/deletePassword.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/DeletePassword](../../broker/api-ref/grpc/broker_service.md#DeletePassword).

{% endlist %}       