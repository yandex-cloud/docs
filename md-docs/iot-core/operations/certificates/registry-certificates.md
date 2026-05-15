# Управление сертификатами реестра

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять сертификатами реестра для соответствующего способа авторизации.

{% note info %}

Если X.509 сертификат используется вместе с паролем, приоритет пароля выше.

{% endnote %}

- [Посмотреть список сертификатов реестра](registry-certificates.md#list-cert)
- [Добавить сертификат реестру](registry-certificates.md#add-cert)
- [Удалить сертификат реестра](registry-certificates.md#delete-cert)

Для обращения к [реестру](../../concepts/index.md#registry) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [Получение информации о реестре](../registry/registry-list.md).

## Получить список сертификатов реестра {#registry-certificates-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится реестр.
   1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **IoT Core**.
   1. Выберите реестр.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Получите список сертификатов реестра:

  ```bash
  yc iot registry certificate list --registry-name my-registry
  ```

  Результат:

  ```text
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | 0f511ea32139178edf73afb953a9cc39******** | 2019-05-29 16:46:23 |
  | 589ce1605019eeff7bb0992f290be0cd******** | 2019-05-29 16:40:48 |
  +------------------------------------------+---------------------+
  ```

- API {#api}

  Чтобы получить список сертификатов реестра, воспользуйтесь методом REST API [listCertificates](../../api-ref/Registry/listCertificates.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/ListCertificates](../../api-ref/grpc/Registry/listCertificates.md).

{% endlist %}

## Добавить сертификат {#add-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить сертификат реестра:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в который вы хотите добавить сертификат реестра.
   1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. На странице **Обзор** перейдите к разделу **Сертификаты** и нажмите кнопку **Добавить сертификат**.

      - Чтобы добавить файл:

         1. Выберите способ `Файл`.
         1. Нажмите **Прикрепить файл**.
         1. Укажите файл сертификата на вашем компьютере, нажмите **Открыть**.
         1. Нажмите **Добавить**.

      - Чтобы добавить текст:

         1. Выберите способ `Текст`.
         1. Вставьте тело сертификата в поле **Содержимое**.
         1. Нажмите **Добавить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Добавьте сертификат реестру:

  ```
  yc iot registry certificate add \
    --registry-name my-registry \ # Имя реестра.
    --certificate-file registry-cert.pem # Путь к публичной части сертификата.
  ```
  
  Результат:
  ```
  registry_id: b91ki3851hab********
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

  Чтобы добавить сертификат реестру, созданному с помощью Terraform:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_registry` — параметры реестра:
       * `name` — имя реестра.
       * `description` — описание реестра.
       * `certificates` — список сертификатов реестра для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs).

      Пример описания реестра в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в Terraform, см. в [документации провайдера](../../../terraform/resources/iot_core_registry.md).
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

      Проверить сертификаты реестра можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry certificate list --registry-name <имя_реестра>
      ```

- API {#api}

  Чтобы добавить сертификат реестру, воспользуйтесь методом REST API [addCertificate](../../api-ref/Registry/addCertificate.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/AddCertificate](../../api-ref/grpc/Registry/addCertificate.md).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить сертификат реестра:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого вы хотите удалить сертификат реестра.
   1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите сертификат реестра:

      ```
      yc iot registry certificate delete --registry-name my-registry --fingerprint 0f...
      ```

  1. Проверьте, что сертификат действительно удален:

      ```
      yc iot registry certificate list --registry-name my-registry
	    ```
	  
	    Результат:
	  
	    ```
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

  Чтобы удалить сертификат реестра, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите значение сертификата в блоке `certificates`, во фрагменте с описанием реестра. Чтобы удалить все сертификаты, удалите блок `certificates` целиком.

      Пример описания реестра в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_registry` в Terraform, см. в [документации провайдера](../../../terraform/resources/iot_core_registry.md).
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

      Проверить сертификаты реестра можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot registry certificate list --registry-name <имя_реестра>
      ```

- API {#api}

  Чтобы удалить сертификат реестра, воспользуйтесь методом REST API [deleteCertificate](../../api-ref/Registry/deleteCertificate.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/DeleteCertificate](../../api-ref/grpc/Registry/deleteCertificate.md).

{% endlist %}