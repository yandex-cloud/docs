# Начало работы

Создайте [реестр](concepts/index.md#registry) и [устройство](concepts/index.md#device) в реестре и настройте процесс обмена сообщениями между ними.

## Перед началом работы {#before-you-begin}

Чтобы начать работать c сервисом {{ iot-name }}:
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в Облако или зарегистрируйтесь, если вы еще не зарегистрированы.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. [Сертификаты для реестра и устройства](quickstart.md#create-ca).

## Создайте сертификат {#create-ca}

Для взаимодействия устройству и реестру необходимы X.509 сертификаты:

- Если у вас есть сертификат, просто добавьте его к устройству в реестре.
- Если у вас нет сертификата, его можно создать, например, с помощью программы [OpenSSL](https://www.openssl.org). Используйте следующие параметры:
    - `-x509` — X.509 сертификат
    - `newkey` — алгоритм шифрования.
    - `-keyout` — файл, в который будет записан приватный ключ.
    - `-out` — файл, в который будет сохранен сертификат.
    - `-nodes` — флаг устанавливается, когда не надо шифровать публичный ключ.
    - `-days` — срок действия сертификата в днях.
    - `-subj` — объект запроса.
    
    ```
    $ openssl req -x509 \
    -newkey rsa:4096 \
    -keyout key.pem \
    -out cert.pem \
    -nodes \
    -days 365 \
    -subj '/CN=localhost'
    ```

## Создайте реестр {#create-registry}

{% list tabs %}
    
- CLI

    {% include [cli-install](../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    Чтобы создать реестр:
    1. Выполните команду:
    
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

{% endlist %}

## Создайте устройство {#create-device}

{% list tabs %}

- CLI
    
    {% include [cli-install](../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    Чтобы создать устройство: 
    1. Выполните команду: 
        
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

{% endlist %}

## Настройте обмен сообщениями между устройствами и реестрами {#exchange}

Узнайте, как: 
- [{#T}](operations/publish.md).
- [{#T}](operations/subscribe.md).

## Что дальше {#what-is-next}

- Ознакомьтесь с [концепциями сервиса](concepts/index.md).
- Посмотрите, как [работать с реестрами и устройствами](operations/index.md).
