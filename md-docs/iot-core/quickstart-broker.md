[Документация Yandex Cloud](../index.md) > [Yandex IoT Core](index.md) > Начало работы > Брокер

# Начало работы с брокерами Yandex IoT Core

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](sunset.md).

{% endnote %}

Чтобы начать работу с сервисом Yandex IoT Core:

1. [Создайте X.509-сертификат](#create-ca).
1. [Создайте брокер](#create-broker).
1. [Настройте обмен сообщениями](#exchange).

{% note info %}

Брокер находится на стадии [Preview](../overview/concepts/launch-stages.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

## Создайте сертификат для брокера {#create-ca}

Если у вас есть сертификат, добавьте его к брокеру после [создания](#create-broker). Если сертификата нет, создайте его с помощью программы [OpenSSL](https://www.openssl.org):

   ```bash
   openssl req -x509 \
   -newkey rsa:4096 \
      -keyout private-key.pem \
      -out cert.pem \
      -nodes \
      -days 365 \
      -subj '/CN=localhost'
   ```

   Где:

   * `-x509` — вид сертификата: X.509.
   * `-newkey` — алгоритм шифрования.
   * `-keyout` — файл с приватным ключом сертификата.
   * `-out` — файл с публичным ключом сертификата.
   * `-nodes` — флаг, который устанавливается, когда не надо шифровать публичный ключ.
   * `-days` — срок действия сертификата в днях.
   * `-subj` — объект запроса.

## Создайте брокер {#create-broker}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать брокер.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите иконку **Брокеры**.
   1. Нажмите кнопку **Создать брокер**.
   1. В блоке **Общая информация** укажите имя брокера `my-broker`.
   1. Добавьте сертификат:

      * Чтобы добавить файл:

         1. Выберите способ `Файл`.
         1. Нажмите кнопку **Прикрепить файл**.
         1. Выберите файл с публичным ключом сертификата и нажмите кнопку **Открыть**.
         1. Нажмите кнопку **Добавить**.

      * Чтобы добавить текст:

         1. Выберите способ `Текст`.
         1. Вставьте публичный ключ сертификата в поле **Содержимое**.
         1. Нажмите кнопку **Добавить**.

   1. Нажмите кнопку **Создать**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Создайте брокер:

      ```bash
      yc iot broker create --name my-broker
      ```

      Результат:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk*********
      created_at: "2022-05-28T11:29:42.420Z"
      name: my-broker
      status: ACTIVE
      ```

   1. Добавьте брокеру сертификат:

      ```bash
      yc iot broker certificate add \
         --broker-name my-broker \
         --certificate-file cert.pem
      ```

      Где:

      * `--broker-name` — имя брокера;
      * `--certificate-file` — путь к публичному ключу сертификата.

      Результат:

      ```text
      broker_id: b91ki3851h**********
      fingerprint: 1f21cf6d0183d****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIEpDCCAow...
         -----END CERTIFICATE-----
      created_at: "2023-07-11T16:20:53.466370019Z"
      ```

{% endlist %}

## Настройте обмен сообщениями {#exchange}

1. [Подпишитесь на получение сообщений в брокере](operations/subscribe.md#broker).
1. [Отправьте сообщение в брокере](operations/publish.md#broker).

## Что дальше {#what-is-next}

* Ознакомьтесь с [концепциями сервиса](concepts/index.md).
* Посмотрите, как [работать с брокерами](operations/index.md#broker).