# Отправка сообщения

Вы можете отправлять сообщения следующих типов:

- Отправлять данные с устройства в реестр, используя топики `$devices/<ID устройства>/events` или `$registries/<ID реестра>/events`.
- Отправлять команды из реестра на устройство, используя топики `$devices/<ID устройства>/commands` или `$registries/<ID реестра>/commands`.

Для получения сообщения необходимо быть подписанным на отправителя. Как это сделать, читайте в разделе [{#T}](subscribe.md).

{% include [registry-and-device-topic-note](../../_includes/iot-core/registry-and-device-topic-note.md) %}

{% include [iot-before-begin](../../_includes/iot-core/iot-before-begin.md) %}

## Отправить сообщение с данными {#pub-events}

Отправьте сообщение с данными, используя следующие параметры:
- `--cert` — путь к публичной части сертификата устройства.
- `--key` — путь к публичной части сертификата устройства.
- `--topic` — топик устройства.
- `--message` — текст сообщения.
- `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}
 
- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    - Отправьте данные с устройства в топик устройства: 
        
        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$devices/<ID устройства>/events' \
        --message 'Test data' \
        --qos 1
        ```

      Реестр, подписанный на данный топик, будет знать, какое именно устройство отправило данные, так как в топике присутствует уникальный идентификатор устройства.
    - Отправьте данные с устройства в топик реестра:

        ```
        $ yc iot mqtt publish \
        --cert device-cert.pem \
        --key device-key.pem \
        --topic '$registries/<ID реестра>/events' \
        --message 'Test data' \
        --qos 1
        ```

      Реестр, подписанный на данный топик, не будет знать, какое именно устройство отправило данные, так как в топике отсутствует уникальный идентификатор устройства.

{% endlist %}

## Отправить сообщение с командой {#pub-commands}

Реестр может отправить сообщение с командой одному, нескольким или всем устройствам, добавленным в него. Рассмотрим все варианты.

Отправьте сообщение с командой, используя следующие параметры:
- `--cert` — путь к публичной части сертификата реестра.
- `--key` — путь к публичной части сертификата реестра.
- `--topic` — топик устройства.
- `--message` — текст сообщения.
- `--qos` — [уровень качества обслуживания (QoS)](../concepts/topic.md#qos).

{% include [debug-note](../../_includes/iot-core/debug-note.md) %}

{% list tabs %}

- CLI
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    - Отправьте команду одному устройству:
        
        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$devices/<ID устройства>/commands' \
        --message 'Test command for first device' \
        --qos 1
        ```
    - Отправьте команду всем устройствам, добавленным в реестр:
                
        ```
        $ yc iot mqtt publish \
        --cert registry-cert.pem \
        --key registry-key.pem \
        --topic '$registries/<ID реестра>/commands' \
        --message 'Test command for all devices' \
        --qos 1
        ```

{% endlist %}
