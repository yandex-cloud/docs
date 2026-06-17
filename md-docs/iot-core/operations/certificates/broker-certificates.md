# Управление сертификатами брокера

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

{% note info %}

Брокер находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы начать обмен сообщениями между клиентами брокера, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять сертификатами брокера для соответствующего способа авторизации.

{% note info %}

Если X.509 сертификат используется вместе с паролем, приоритет пароля выше.

{% endnote %}

- [Посмотреть список сертификатов брокера](broker-certificates.md#list-cert)
- [Добавить сертификат брокеру](broker-certificates.md#add-cert)
- [Удалить сертификат брокера](broker-certificates.md#delete-cert)

Для обращения к [брокеру](../../concepts/index.md#broker) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя брокера, читайте в разделе [Получение информации о брокере](../broker/broker-list.md).

## Получить список сертификатов брокера {#broker-certificates-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится брокер.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Выберите брокер. Список сертификатов отобразится в разделе **Сертификаты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Получите список сертификатов брокера:

  ```bash
  yc iot broker certificate list --broker-name my-broker
  ```

  Результат:

  ```text
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc********** | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0********** | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API {#api}

  Чтобы получить список сертификатов брокера, воспользуйтесь методом REST API [listCertificates](../../broker/api-ref/Broker/listCertificates.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/ListCertificates](../../broker/api-ref/grpc/Broker/listCertificates.md).

{% endlist %}

## Добавить сертификат {#add-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в который вы хотите добавить сертификат брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Выберите в списке нужный брокер.
   1. На странице **Обзор** перейдите к разделу **Сертификаты** и нажмите кнопку **Добавить сертификат**.

      - Чтобы добавить файл:

         1. Выберите способ `Файл`.
         1. Нажмите **Прикрепить файл**.
         1. Выберите файл сертификата на вашем компьютере, нажмите **Открыть**.
         1. Нажмите **Добавить**.

      - Чтобы добавить текст:

         1. Выберите способ `Текст`.
         1. Вставьте тело сертификата в поле **Содержимое**.
         1. Нажмите **Добавить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Добавьте сертификат брокеру:

  ```bash
  yc iot broker certificate add \
    --broker-name my-broker \
    --certificate-file broker-cert.pem
  ```

  Где:
  * `--broker-name` — имя брокера.
  * `--certificate-file` — путь к публичной части сертификата.
  
  Результат:
  ```text
  broker_id: b91ki3851h**********
  fingerprint: 589ce1605...
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAw...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T16:40:48.230Z"
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить сертификат брокеру, созданному с помощью Terraform:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_broker` — параметры брокера:
       * `name` — имя брокера.
       * `description` — описание брокера.
       * `certificates` — список сертификатов брокера для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs).

      Пример описания брокера в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```

      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить сертификаты брокера можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker certificate list --broker-name <имя_брокера>
      ```

- API {#api}

  Чтобы добавить сертификат брокеру, воспользуйтесь методом REST API [addCertificate](../../broker/api-ref/Broker/addCertificate.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/AddCertificate](../../broker/api-ref/grpc/Broker/addCertificate.md).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого хотите удалить сертификат брокера.
   1. Перейдите в сервис **IoT Core**.
   1. На панели слева выберите **Брокеры**.
   1. Выберите в списке нужный брокер.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Удалите сертификат брокера:

      ```bash
      yc iot broker certificate delete --broker-name my-broker --fingerprint 0f...
      ```

  1. Проверьте, что сертификат удален:

      ```bash
      yc iot broker certificate list --broker-name my-broker
	    ```

	    Результат:
	  
	    ```text
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить сертификат брокера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите значение сертификата в блоке `certificates`, во фрагменте с описанием брокера. Чтобы удалить все сертификаты, удалите блок `certificates` целиком.

      Пример описания брокера в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_broker` в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```

      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить сертификаты брокера можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker certificate list --broker-name <имя_брокера>
      ```

- API {#api}

  Чтобы удалить сертификат брокера, воспользуйтесь методом REST API [deleteCertificate](../../broker/api-ref/Broker/deleteCertificate.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/DeleteCertificate](../../broker/api-ref/grpc/Broker/deleteCertificate.md).

{% endlist %}