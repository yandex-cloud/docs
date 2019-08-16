# Начало работы

Чтобы начать обмен данными между вашими устройствами:
- [Подготовьте сертификаты для реестра и устройства](#create-ca).
- [Создайте реестр и добавьте ему сертификат](#create-registry).
- [Создайте в реестре устройство и добавьте ему сертификат](#create-device).
- [Подключитесь к MQTT брокеру](#connect-mqtt-broker).

## Подготовка к работе {#before-begin}

Для начала работы вам понадобятся: 
 
1. Каталог в Яндекс.Облаке. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Интерфейс командной строки: [Yandex CLI](../cli/quickstart.md). 
1. Сертификат удостоверяющего центра: {{ ca-address }}.
1. [Сертификаты для реестра и устройства](quickstart.md#create-ca). 

## Создание сертификата {#create-ca}

Для взаимодействия устройству и реестру необходимы X.509 сертификаты:

- Если у вас есть сертификат, просто добавьте его к устройству в реестре.

- Если у вас нет сертификата, его можно создать, например, с помощью программы [OpenSSL](https://www.openssl.org): 
    
    ```
    $ openssl req -x509 \ # X.509 сертификат.
    -newkey rsa:4096 \ # Алгоритм шифрования.
    -keyout key.pem \ # Файл, в который будет записан приватный ключ.
    -out cert.pem \ # Файл, в который будет сохранен сертификат.
    -nodes \ # Флаг устанавливается, когда не надо шифровать публичный ключ.
    -days 365 \ # Срок действия сертификата в днях.
    -subj '/CN=localhost' # Объект запроса.
    ```

## Создание реестра {#create-registry}

1. Создайте реестр: 

    ```
    $ yc iot registry create --name my-registry
    
    id: b91hafek85hpppnbpld2
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-05-27T13:40:06.923Z"
    name: my-registry
    ```

1. Добавьте реестру сертификат: 

    ```
    $ yc iot registry certificate add \
    --registry-name my-registry \ # Имя реестра.
    --certificate-file ./certs/registry-cert.pem # Путь к публичной части сертификата.
    
    registry_id: b91hafek85hpppnbpld2
    fingerprint: 589ce16050****
    certificate_data: |
      -----BEGIN CERTIFICATE-----
      MIIE/jCCAuagAwIBAgIJAPRA...
      -----END CERTIFICATE-----
    created_at: "2019-05-27T13:41:45.295Z"
    ```

## Создание устройства {#create-device}

1. Создайте устройство: 
    
    ```
    $ yc iot device create \
    --registry-name my-registry \ # Имя реестра.
    --name my-device # Имя устройства.
    
    id: b912an77oqaeijolmlgm
    registry_id: b91hafek85hpppnbpld2
    created_at: "2019-05-27T13:44:35.164Z"
    name: my-device
    ```

1. Добавьте устройству сертификат: 
    
    ```
    $ yc iot device certificate add \
    --device-name my-device \ # Имя устройства.
    --certificate-file ./certs/device-cert.pem # Путь к публичной части сертификата.
    
    device_id: b912an77oqaeijolmlgm
    fingerprint: 65e5b05006...
    certificate_data: |
      -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAwIBAgIJANZbq...
      -----END CERTIFICATE-----
    created_at: "2019-05-27T13:45:23.306Z"
    ```

## Подлючение к MQTT брокеру {#connect-mqtt-broker}

Реестр и устройство готовы к работе. Подключитесь к MQTT брокеру, используя следующие данные:

- **Адрес брокера:** `{{ mqtt-broker-address }}`
- **Порт брокера:** `{{ mqtt-broker-port }}`
- **Протокол:** `TLSv1.2`

Для обмена данными используйте следующие [топики](concepts/index.md#interactions): 

- Топики устройства: 

    - `$devices/<ID устройства>/events` — топик для телеметрических данных. Устройство может писать в этот топик, а реестр — читать из него.
    - `$devices/<ID устройства>/commands` — топик для команд. Реестр может писать в этот топик, а устройство — читать из него.
    
- Топики реестра:  
  
    - `$registries/<ID реестра>/events` — топик для телеметрических данных. Устройство может писать в этот топик, а реестр — читать из него. 
    - `$registries/<ID реестра>/commands` — топик для команд. Реестр может писать в этот топик, а устройство — читать из него.

Узнать идентификатор устройства можно при его создании или с помощью команды: 

```
$ yc iot device list --registry-name my-registry
+----------------------+-----------+
|          ID          |   NAME    |
+----------------------+-----------+
| b912an77oqaeijolmlgm | my-device |
+----------------------+-----------+
```
    
Подробнее об обмене данными между устройствами читайте в разделе [Взаимодействие устройств](concepts/index.md#interactions).
