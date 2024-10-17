---
title: Как отправлять сообщения ресурсам {{ iot-full-name }}
description: Следуя данной инструкции, вы сможете отправлять сообщения ресурсам {{ iot-full-name }}.
---

# Отправка сообщения 

Сервис предоставляет две модели управления ресурсами:
* при использовании брокера отправка и прием сообщений может осуществляться в произвольных топиках, не начинающихся с `$`;
* при использовании реестров и устройств выбор топиков ограничен.

Подробнее о различиях брокеров и реестров устройств читайте в разделе [{#T}](../concepts/index.md).

При использовании реестров и устройств, вы можете отправлять сообщения следующих типов:
- Отправлять данные с устройства в реестр, используя топики `$devices/<идентификатор_устройства>/events` или `$registries/<идентификатор_реестра>/events`.
- Отправлять данные с устройства в реестр, используя перманентные топики `$devices/<идентификатор_устройства>/state` или `$registries/<идентификатор_реестра>/state`.
- Отправлять команды из реестра на устройство, используя топики `$devices/<идентификатор_устройства>/commands` или `$registries/<идентификатор_реестра>/commands`.
- Отправлять команды из реестра на устройство, используя перманентные топики `$devices/<идентификатор_устройства>/config` или `$registries/<идентификатор_реестра>/config`.

Для получения сообщения необходимо быть подписанным на отправителя. Как это сделать, читайте в разделе [{#T}](subscribe.md).

О том, как убедиться, что сообщение было успешно отправлено и доставлено, читайте в разделе [{#T}](../tutorials/message-delivery-check.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-you-begin](../../_includes/iot-core/iot-before-you-begin.md) %}

## Отправить сообщение с данными {#pub-events}

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Отправьте данные с устройства в топик устройства {#to-device-topic}

Реестр, подписанный на данный топик, будет знать, какое именно устройство отправило данные, так как в топике присутствует уникальный идентификатор устройства.

{% list tabs group=instructions %}

- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    - Отправьте данные в топик устройства, используя авторизацию по сертификату: 
          
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$devices/<идентификатор_устройства>/events' \
          --message 'Test data' \
          --qos 1
        ```
    - Отправьте данные в перманентный топик устройства, используя авторизацию по сертификату: 
          
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$devices/<идентификатор_устройства>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Где:

        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

	- Отправьте данные в топик устройства, используя авторизацию по логину и паролю: 
    
        ```
        yc iot mqtt publish \
          --username <идентификатор_устройства> \
          --password <пароль_для_устройства> \
          --topic '$devices/<идентификатор_устройства>/events' \
          --message 'Test data' \
          --qos 1
        ```

	- Отправьте данные в перманентный топик устройства, используя авторизацию по логину и паролю: 
    
        ```
        yc iot mqtt publish \
          --username <идентификатор_устройства> \
          --password <пароль_для_устройства> \
          --topic '$devices/<идентификатор_устройства>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Где:

        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

- API {#api}

  Чтобы отправить данные с устройства в топик устройства, воспользуйтесь методом REST API [publish](../api-ref/DeviceData/publish.md) для ресурса [DeviceData](../api-ref/DeviceData/index.md) или вызовом gRPC API [DeviceDataService/Publish](../api-ref/grpc/DeviceData/publish.md).

{% endlist %}          

### Отправьте данные с устройства в топик реестра {#to-registry-topic}

Реестр, подписанный на данный топик, не будет знать, какое именно устройство отправило данные, так как в топике отсутствует уникальный идентификатор устройства.

{% list tabs group=instructions %}

- CLI {#cli}
    
    - Отправьте данные в топик реестра, используя авторизацию по сертификату: 
        
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$registries/<идентификатор_реестра>/events' \
          --message 'Test data' \
          --qos 1
        ```

	- Отправьте данные в перманентный топик реестра, используя авторизацию по сертификату: 
        
        ```
        yc iot mqtt publish \
          --cert device-cert.pem \
          --key device-key.pem \
          --topic '$registries/<идентификатор_реестра>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Где:

        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

	- Отправьте данные в топик реестра, используя авторизацию по логину и паролю:
    
        ```
        yc iot mqtt publish \
          --username <идентификатор_устройства> \
          --password <пароль_для_устройства> \
          --topic '$registries/<идентификатор_реестра>/events' \
          --message 'Test data' \
          --qos 1
        ```

	- Отправьте данные в перманентный топик реестра, используя авторизацию по логину и паролю:
	
        ```
        yc iot mqtt publish \
          --username <идентификатор_устройства> \
          --password <пароль_для_устройства> \
          --topic '$registries/<идентификатор_реестра>/state' \
          --message 'Test data' \
          --qos 1
        ```
		
        Где:

        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

- API {#api}

  Чтобы отправить данные с устройства в топик реестра, воспользуйтесь методом REST API [publish](../api-ref/DeviceData/publish.md) для ресурса [DeviceData](../api-ref/DeviceData/index.md) или вызовом gRPC API [DeviceDataService/Publish](../api-ref/grpc/DeviceData/publish.md).

{% endlist %}

## Отправить сообщение с командой {#pub-commands}

Реестр может отправить сообщение с командой одному, нескольким или всем устройствам, добавленным в него. Рассмотрим все варианты.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Отправьте команду одному устройству {#one-device}

{% list tabs group=instructions %}

- CLI {#cli}

    - Отправьте команду, используя авторизацию по сертификату:

        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$devices/<идентификатор_устройства>/commands' \
          --message 'Test command for first device' \
          --qos 1
        ```
		
    - Отправьте команду, используя перманентный топик и авторизацию по сертификату:

        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$devices/<идентификатор_устройства>/config' \
          --message 'Test command for first device' \
          --qos 1
        ```
      
        Где:

        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик устройства для получения команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      

	- Отправьте команду, используя авторизацию по логину и паролю: 

        ```
        yc iot mqtt publish \
          --username <идентификатор_реестра> \
          --password <пароль_для_реестра> \
          --topic '$devices/<идентификатор_устройства>/commands' \
          --message 'Test command for first device' \
          --qos 1
        ```                      
	- Отправьте команду, используя перманентный топик и авторизацию по логину и паролю: 

        ```
        yc iot mqtt publish \
          --username <идентификатор_реестра> \
          --password <пароль_для_реестра> \
          --topic '$devices/<идентификатор_устройства>/config' \
          --message 'Test command for first device' \
          --qos 1
        ```                      

        Где:

        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для получения команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

- API {#api}

  Чтобы отправить команду одному устройству, воспользуйтесь методом REST API [publish](../api-ref/RegistryData/publish.md) для ресурса [RegistryData](../api-ref/RegistryData/index.md) или вызовом gRPC API [RegistryDataService/Publish](../api-ref/grpc/RegistryData/publish.md).

{% endlist %}

### Отправьте команду всем устройствам, добавленным в реестр {#all-device}
{% list tabs group=instructions %}

- CLI {#cli}
          
    - Отправьте команду всем устройствам, используя авторизацию по сертификату: 
    
        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$registries/<идентификатор_реестра>/commands' \
          --message 'Test command for all devices' \
          --qos 1
        ```

    - Отправьте команду всем устройствам, используя перманентный топик и авторизацию по сертификату: 
    
        ```
        yc iot mqtt publish \
          --cert registry-cert.pem \
          --key registry-key.pem \
          --topic '$registries/<идентификатор_реестра>/config' \
          --message 'Test command for all devices' \
          --qos 1
        ```
		
        Где:

        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      

	- Отправьте команду всем устройствам, используя авторизацию по логину и паролю:
    
        ```
        yc iot mqtt publish \
          --username <идентификатор_реестра> \
          --password <пароль_для_реестра> \
          --topic '$registries/<идентификатор_реестра>/commands' \
          --message 'Test command for all devices' \
          --qos 1
        ```

	- Отправьте команду всем устройствам, используя перманентный топик и авторизацию по логину и паролю:
    
        ```
        yc iot mqtt publish \
          --username <идентификатор_реестра> \
          --password <пароль_для_реестра> \
          --topic '$registries/<идентификатор_реестра>/config' \
          --message 'Test command for all devices' \
          --qos 1
        ```
		
        Где:

        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

- API {#api}

  Чтобы отправить команду всем устройствам, добавленным в реестр, воспользуйтесь методом REST API [publish](../api-ref/RegistryData/publish.md) для ресурса [RegistryData](../api-ref/RegistryData/index.md) или вызовом gRPC API [RegistryDataService/Publish](../api-ref/grpc/RegistryData/publish.md).

{% endlist %}

## Отправить сообщение в брокере {#broker}

При использовании брокера сообщение можно отправить в произвольный топик, используя для авторизации логин и пароль или любой сертификат, назначенный брокеру.

{% list tabs group=instructions %}

- CLI {#cli}

    - Отправьте сообщение, используя авторизацию по логину и паролю:

        ```
        yc iot mqtt publish \
          --username <идентификатор_брокера> \
          --password <пароль_для_брокера> \
          --topic /my/custom/topic \
          --message 'Test broker message'
          --qos 1
        ```

        Где:

        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — произвольное имя топика, соответствующее спецификации [MQTT](../../glossary/mqtt-server.md) и не начинающееся с символа `$`
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

    - Отправьте сообщение, используя авторизацию по сертификату:

        ```
        yc iot mqtt publish \
          --cert broker-cert.pem \
          --key broker-key.pem \
          --topic /my/custom/topic \
          --message 'Test broker message'
          --qos 1
        ```

        Где:

        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — произвольное имя топика, соответствующее спецификации MQTT и не начинающееся с символа `$`
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

- API {#api}

  Чтобы отправить сообщение в брокере, воспользуйтесь методом REST API [publish](../broker/api-ref/BrokerData/publish.md) для ресурса [BrokerData](../broker/api-ref/BrokerData/index.md) или вызовом gRPC API [BrokerDataService/Publish](../broker/api-ref/grpc/BrokerData/publish.md).

{% endlist %}
