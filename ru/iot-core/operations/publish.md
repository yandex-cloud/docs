# Отправка сообщения

Вы можете отправлять сообщения следующих типов:
- Отправлять данные с устройства в реестр, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Отправлять данные с устройства в реестр, используя перманентные топики `$devices/<ID устройства>/state` или `$registries/<ID реестра>/state`.
- Отправлять команды из реестра на устройство, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.
- Отправлять команды из реестра на устройство, используя перманентные топики `$devices/<ID устройства>/config` или `$registries/<ID реестра>/config`.

Для получения сообщения необходимо быть подписанным на отправителя. Как это сделать, читайте в разделе [{#T}](subscribe.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Отправить сообщение с данными {#pub-events}

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Отправьте данные с устройства в топик устройства {#to-device-topic}

Реестр, подписанный на данный топик, будет знать, какое именно устройство отправило данные, так как в топике присутствует уникальный идентификатор устройства.

{% list tabs %}
 
- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    - Отправьте данные в топик устройства, используя авторизацию по сертификату: 
          
        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<ID устройства>/events' \
        --message 'Test data' \
        --qos 1
        ```
    - Отправьте данные в перманентный топик устройства, используя авторизацию по сертификату: 
          
        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<ID устройства>/state' \
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
        $ yc iot mqtt publish \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$devices/<ID устройства>/events' \
        --message 'Test data' \
        --qos 1
        ```

	- Отправьте данные в перманентный топик устройства, используя авторизацию по логину и паролю: 
    
        ```
        $ yc iot mqtt publish \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$devices/<ID устройства>/state' \
        --message 'Test data' \
        --qos 1
        ```
		
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).

{% endlist %}          

### Отправьте данные с устройства в топик реестра {#to-registry-topic}

Реестр, подписанный на данный топик, не будет знать, какое именно устройство отправило данные, так как в топике отсутствует уникальный идентификатор устройства.

{% list tabs %}
 
- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    - Отправьте данные в топик реестра, используя авторизацию по сертификату: 
        
        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/events' \
        --message 'Test data' \
        --qos 1
        ```

	- Отправьте данные в перманентный топик реестра, используя авторизацию по сертификату: 
        
        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/state' \
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
        $ yc iot mqtt publish \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$registries/<ID реестра>/events' \
        --message 'Test data' \
        --qos 1
        ```

	- Отправьте данные в перманентный топик реестра, используя авторизацию по логину и паролю:
	
        ```
        $ yc iot mqtt publish \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$registries/<ID реестра>/state' \
        --message 'Test data' \
        --qos 1
        ```
		
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      

{% endlist %}

## Отправить сообщение с командой {#pub-commands}

Реестр может отправить сообщение с командой одному, нескольким или всем устройствам, добавленным в него. Рассмотрим все варианты.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Отправьте команду одному устройству {#one-device}

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Отправьте команду, используя авторизацию по сертификату:

        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/commands' \
        --message 'Test command for first device' \
        --qos 1
        ```
		
    - Отправьте команду, используя перманентный топик и авторизацию по сертификату:

        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/config' \
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
        $ yc iot mqtt publish \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$devices/<ID устройства>/commands' \
        --message 'Test command for first device' \
        --qos 1
        ```                      
	- Отправьте команду, используя перманентный топик и авторизацию по логину и паролю: 

        ```
        $ yc iot mqtt publish \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$devices/<ID устройства>/config' \
        --message 'Test command for first device' \
        --qos 1
        ```                      

        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для получения команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).  

{% endlist %}       

### Отправьте команду всем устройствам, добавленным в реестр {#all-device}
                          
{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %} 
          
    - Отправьте команду всем устройствам, используя авторизацию по сертификату: 
    
        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/commands' \
        --message 'Test command for all devices' \
        --qos 1
        ```

    - Отправьте команду всем устройствам, используя перманентный топик и авторизацию по сертификату: 
    
        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/config' \
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
        $ yc iot mqtt publish \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$registries/<ID реестра>/commands' \
        --message 'Test command for all devices' \
        --qos 1
        ```

	- Отправьте команду всем устройствам, используя перманентный топик и авторизацию по логину и паролю:
    
        ```
        $ yc iot mqtt publish \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$registries/<ID реестра>/config' \
        --message 'Test command for all devices' \
        --qos 1
        ```
		
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).        

{% endlist %}
