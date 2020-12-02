# Подписка устройства или реестра на получение сообщений

Вы можете подписать:

- Реестр на события устройства, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Реестр на события устройства, используя перманентные топики `$devices/<ID устройства>/state` или `$registries/<ID реестра>/state`.
- Устройство на команды реестра, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.
- Устройство на команды реестра, используя перманентные топики `$devices/<ID устройства>/config` или `$registries/<ID реестра>/config`.
- Реестр или устройство на данные мониторинга устройства, используя топик `$monitoring/<ID устройства>/json`.



О том, как обмениваться сообщениями, читайте в разделе [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Подписать реестр на топики устройств {#sub-events}

Реестр можно подписать на топики от одного, нескольких или всех устройств, добавленных в него.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Подпишите реестр на топик одного устройства {#one-device}

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите реестр на топик устройства, используя авторизацию по сертификату:
        
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/events' \
        --qos 1
        ```
    - Подпишите реестр на перманентный топик устройства, используя авторизацию по сертификату:
        
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/state' \
        --qos 1
        ```
	  
        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      

	- Подпишите реестр на топик устройства, используя авторизацию по логину и паролю:
     
        ```
        $ yc iot mqtt subscribe \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$devices/<ID устройства>/events' \
        --qos 1
        ```
    - Подпишите реестр на перманентный топик устройства, используя авторизацию по логину и паролю:
     
        ```
        $ yc iot mqtt subscribe \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$devices/<ID устройства>/state' \
        --qos 1
        ```
		
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      
      
{% endlist %} 

### Подпишите реестр на топики всех устройств, добавленных в него {#all-device}

Реестр будет получать данные только от тех устройств, которые отправляют сообщения в топик `$registries/<ID реестра>/events` или `$registries/<ID реестра>/state`.

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите реестр на топики всех устройств, используя авторизацию по сертификату:
                
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/events' \
        --qos 1
        ```
		
    - Подпишите реестр на перманентные топики всех устройств, используя авторизацию по сертификату:
                
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/state' \
        --qos 1
        ```
      
        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      

	- Подпишите реестр на топики всех устройств, используя авторизацию по логину и паролю: 
    
        ```
        $ yc iot mqtt subscribe \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$registries/<ID реестра>/events' \
        --qos 1
        ```
    - Подпишите реестр на перманентные топики всех устройств, используя авторизацию по логину и паролю: 
    
        ```
        $ yc iot mqtt subscribe \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$registries/<ID реестра>/state' \
        --qos 1
        ```
		
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).    

{% endlist %}

## Подписать устройство на топики реестра {#sub-commands}

Команды от реестра могут предназначаться конкретному устройству или всем устройствам в реестре. Для этого используются разные топики.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Подпишите устройство на топики — команды для конкретного устройства {#for-one}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
        
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите устройство на топики — команды для конкретного устройства, используя авторизацию по сертификату: 
            
        ```
        yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<ID устройства>/commands' \
        --qos 1
        ```
			
    - Подпишите устройство на перманентные топики — команды для конкретного устройства, используя авторизацию по сертификату: 
            
        ```
        yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<ID устройства>/config' \
        --qos 1
        ```

        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик устройства для получения команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).              

	- Подпишите устройство на топики — команды для конкретного устройства, используя авторизацию по логину и паролю: 
            
        ```
        yc iot mqtt subscribe \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$devices/<ID устройства>/commands' \
        --qos 1
        ```
			
    - Подпишите устройство на перманентные топики — команды для конкретного устройства, используя авторизацию по логину и паролю: 
            
        ```
        yc iot mqtt subscribe \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$devices/<ID устройства>/config' \
        --qos 1
        ```
          
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для получения команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).            
          
{% endlist %}
          
### Подпишите устройство на топики — команды для всех устройств {#for-all}

Команды будут получать только устройства, подписанные на топик `$registries/<ID реестра>/commands` или `$registries/<ID реестра>/config`.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
        
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите устройство на топики — команды, используя авторизацию по сертификату:     
            
        ```
        $ yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/commands' \
        --qos 1
        ```
    - Подпишите устройство на перманентные топики — команды, используя авторизацию по сертификату:     
            
        ```
        $ yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/config' \
        --qos 2
        ```
		
        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).      

	- Подпишите устройство на топики — команды, используя авторизацию по логину и паролю:     
        
        ```
        $ yc iot mqtt subscribe \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$registries/<ID реестра>/commands' \
        --qos 1
        ```          
	- Подпишите устройство на перманентные топики — команды, используя авторизацию по логину и паролю:
        
        ```
        $ yc iot mqtt subscribe \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$registries/<ID реестра>/config' \
        --qos 1
        ```          
		
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/index.md#qos).  
{% endlist %}
