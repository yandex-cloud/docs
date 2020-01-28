# Подписка устройства или реестра на получение сообщений

Вы можете подписать:

- Реестр на события устройства, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Устройство на команды реестра, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.

О том, как обмениваться сообщениями, читайте в разделе [{#T}](publish.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Подписать реестр на устройство {#sub-events}

Реестр можно подписать на одно, несколько или все устройства, добавленные в него.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Подпишите реестр на одно устройство {#one-device}

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите реестр, используя сертификат:
        
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/events' \
        --qos 1
        ```
      
        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).      
    - Подпишите реестр, используя логин и пароль:
     
        ```
        $ yc iot mqtt subscribe \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$devices/<ID устройства>/events' \
        --qos 1
        ```
      
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик устройства для отправки данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).      
      
{% endlist %} 

### Подпишите реестр на все устройства, добавленные в него {#all-device}

Реестр будет получать данные только от тех устройств, которые отправляют сообщения в топик `$registries/<ID реестра>/events`.

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите реестр, используя сертификат:
                
        ```
        $ yc iot mqtt subscribe \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/events' \
        --qos 1
        ```
      
        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).      
    - Подпишите реестр, используя логин и пароль: 
    
        ```
        $ yc iot mqtt subscribe \
        --username <ID реестра> \
        --password <пароль для реестра> \
        --topic '$registries/<ID реестра>/events' \
        --qos 1
        ```
      
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для получения данных.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).    

{% endlist %}

## Подписать устройство на реестр {#sub-commands}

Команды от реестра могут предназначаться конкретному устройству или всем устройствам в реестре. Для этого используются разные топики.

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

### Подпишите устройство на команды для конкретного устройства {#for-one}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
        
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите устройство на команды для конкретного устройства:
        
        - Используя сертификат: 
            
            ```
            yc iot mqtt subscribe \
            --cert device-cert.pem \
            --key device-key.pem \
            --topic '$devices/<ID устройства>/commands' \
            --qos 1
            ```

            Где:
            - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
            - `--topic` — топик устройства для получения команд.
            - `--message` — текст сообщения.
            - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).              
        - Используя логин и пароль: 
            
            ```
            yc iot mqtt subscribe \
            --username <ID устройства> \
            --password <пароль для устройства> \
            --topic '$devices/<ID устройства>/commands' \
            --qos 1
            ```
          
            Где:
            - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
            - `--topic` — топик устройства для получения команд.
            - `--message` — текст сообщения.
            - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).            
          
{% endlist %}
          
### Подпишите устройство на команды для всех устройств {#for-all}

Команды будут получать только устройства, подписанные на топик `$registries/<ID реестра>/commands`.

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
        
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Подпишите устройство, используя сертификат:     
            
        ```
        $ yc iot mqtt subscribe \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/commands' \
        --qos 1
        ```
      
        Где:
        - `--cert` и `--key` — параметры для авторизации с помощью сертификата.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).      
    - Подпишите устройство, используя логин и пароль:     
        
        ```
        $ yc iot mqtt subscribe \
        --username <ID устройства> \
        --password <пароль для устройства> \
        --topic '$registries/<ID реестра>/commands' \
        --qos 1
        ```          
      
        Где:
        - `--username` и `--password` — параметры для авторизации с помощью логина и пароля.
        - `--topic` — топик реестра для отправки команд.
        - `--message` — текст сообщения.
        - `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).  
{% endlist %}
