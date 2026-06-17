# Получить содержимое сертификата от Let's Encrypt

Вы можете сохранить цепочку [сертификатов](../../concepts/index.md) и приватный ключ для самостоятельного использования, например, при конфигурации веб-сервера на [виртуальной машине](../../../compute/concepts/vm.md).

Чтобы получить содержимое сертификата:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится сертификат.
    1. Перейдите в сервис **Certificate Manager**.
    1. В строке с нужным сертификатом нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow](../../../_assets/console-icons/arrow-up-from-line.svg) **Экспортировать сертификат**.

       Экспортировать можно только сертификаты в статусе `Issued`.
    1. Выберите один из вариантов экспорта. В файле `certificate.pem` в текстовом формате в кодировке Base64 будут сохранены:
       * **Сертификат и цепочка сертификатов** — цепочка сертификатов (конечный и промежуточный сертификат) и приватный ключ со стандартным обрамлением:
          ```text
          -----BEGIN CERTIFICATE-----
          MIIE5zCCA8+gAwI...
          -----END CERTIFICATE-----
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----
          -----BEGIN PRIVATE KEY-----
          MIIEvgIBADANBgk...
          -----END PRIVATE KEY-----
          ```

       * **Сертификат без приватного ключа** — цепочка сертификатов (конечный и промежуточный сертификат):
         ```text
          -----BEGIN CERTIFICATE-----
          MIIE5zCCA8+gAwI...
          -----END CERTIFICATE-----
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----
          ```

       * **Конечный сертификат без цепочки сертификатов**:
           ```text
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----`
          ```
       * **Только приватный ключ**:
          ```text
          -----BEGIN PRIVATE KEY-----
          MIIEvgIBADANBgk...
          -----END PRIVATE KEY-----`
          ```

    1. Нажмите **Скачать сертификат**.

- CLI {#cli}

  Команда отобразит цепочку сертификатов и приватный ключ и сохранит содержимое в файлы `--chain` и `--key` соответственно.
  * `--id` – идентификатор сертификата, должен быть указан один из флагов: `--id` или `--name`.
  * `--name` – название сертификата, должен быть указан один из флагов: `--id` или `--name`.
  * `--chain` – (опционально) файл, куда будет сохранена цепочка сертификатов в формате PEM.
  * `--key` – (опционально) файл, куда будет сохранен приватный ключ в формате PEM.

  ```bash
  yc certificate-manager certificate content \
    --id fpqcsmn76v82******** \
    --chain certificate_full_chain.pem \
    --key private_key.pem
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить содержимое пользовательского сертификата с помощью Terraform:
  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

     ```hcl
     data "yandex_cm_certificate_content" "cert_by_id" {
       certificate_id = "<идентификатор_сертификата>"
     }

     output "certificate_chain" {
       value = data.yandex_cm_certificate_content.cert_by_id.certificates
     }

     output "certificate_key" {
       value     = data.yandex_cm_certificate_content.cert_by_id.private_key
       sensitive = true
     }
     ```

     Где:
     * `data "yandex_cm_certificate_content"` — описание источника данных для содержимого сертификата:
       * `certificate_id` — идентификатор сертификата.
     * Блоки `output` — выходные переменные `certificate_chain` с цепочкой сертификатов и приватным ключом `certificate_key`:
       * `value` — возвращаемое значение.
       * `sensitive` — пометить как конфиденциальные данные.

     Более подробную информацию о параметрах источника данных `yandex_cm_certificate_content` смотрите в [документации провайдера](../../../terraform/data-sources/cm_certificate_content.md).
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
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

     Terraform создаст все требуемые ресурсы. Чтобы проверить результат, выполните команды:
     * Получить цепочку сертификата:

       ```bash
       terraform output certificate_chain
       ```

     * Получить значение приватного ключа:

       ```bash
       terraform output -raw certificate_key
       ```

- API {#api}

  Чтобы получить содержимое сертификата, воспользуйтесь методом REST API [get](../../api-ref/CertificateContent/get.md) для ресурса [CertificateContent](../../api-ref/CertificateContent/index.md) или вызовом gRPC API [CertificateContentService/Get](../../api-ref/grpc/CertificateContent/get.md).

{% endlist %}

Для сертификатов Let's Encrypt экспортируемая цепочка содержит конечный сертификат вашего домена и промежуточный сертификат. Корневой сертификат не включается, так как он уже встроен в доверенные хранилища операционных систем и браузеров. Этой цепочки достаточно для настройки веб-серверов, например Nginx или Apache. Если требуется полная цепочка с корневым сертификатом, его можно скачать с [сайта Let's Encrypt](https://letsencrypt.org/certificates/).

{% note info %}

Для чтения содержимого сертификата сервисному аккаунту необходимо выдать [роль](../../../iam/concepts/access-control/roles.md) `certificate-manager.certificates.downloader`.

{% endnote %}