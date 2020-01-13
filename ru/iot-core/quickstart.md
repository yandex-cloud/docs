# Начало работы

Чтобы начать работу c сервисом {{ iot-name }}:

* [Создайте X.509-сертификаты](#create-ca).
* [Создайте реестр](#create-registry).
* [Создайте устройство](#create-device).
* [Настройте между ними процесс обмена сообщениями](#exchange).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в Яндекс.Облако или зарегистрируйтесь, если вы еще не зарегистрированы.
2. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
3. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).

## Создайте сертификат {#create-ca}

Устройство и реестр взаимодействуют с помощью X.509-сертификатов:

- Если у вас есть сертификат, просто добавьте его к устройству в реестре.
- Если у вас нет сертификата, его можно создать, например, с помощью программы [OpenSSL](https://www.openssl.org):

    ```
    $ openssl req -x509 \
    -newkey rsa:4096 \
    -keyout key.pem \
    -out cert.pem \
    -nodes \
    -days 365 \
    -subj '/CN=localhost'
    ```
  
    Где: 
    - `-x509` — X.509-сертификат.
    - `newkey` — алгоритм шифрования.
    - `-keyout` — файл, в который будет записан приватный ключ.
    - `-out` — файл, в который будет сохранен сертификат.
    - `-nodes` — флаг, который устанавливается, когда не надо шифровать публичный ключ.
    - `-days` — срок действия сертификата в днях.
    - `-subj` — объект запроса.

## Создайте реестр {#create-registry}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    Чтобы создать [реестр](concepts/index.md#registry):
    1. Выполните команду:

        ```
        $ yc iot registry create --name my-registry

        id: b91hafek85hpppnbpld2
        folder_id: aoek49ghmknnpj1ll45e
        created_at: "2019-05-27T13:40:06.923Z"
        name: my-registry
        ```
    2. Добавьте реестру сертификат:

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

    Чтобы создать [устройство](concepts/index.md#device):
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
- [Отправить сообщение](operations/publish.md).
- [Подписать устройство или реестр на получение сообщений](operations/subscribe.md).

## Что дальше {#what-is-next}

- Ознакомьтесь с [концепциями сервиса](concepts/index.md).
- Посмотрите, как [работать с реестрами и устройствами](operations/index.md).
