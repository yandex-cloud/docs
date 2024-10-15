Вы можете сохранить цепочку [сертификатов](../../certificate-manager/concepts/index.md) и приватный ключ для самостоятельного использования, например, при конфигурации веб-сервера на [виртуальной машине](../../compute/concepts/vm.md).

Чтобы получить содержимое сертификата:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится сертификат.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Напротив сертификата нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_export }}**.

       Экспортировать можно только сертификаты в статусе `Issued`.
    1. Выберите один из вариантов экспорта. В файле `certificate.pem` в текстовом формате в кодировке Base64 будут сохранены:
       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_full }}** — цепочка сертификатов (корневой и конечный сертификат) и приватный ключ со стандартным обрамлением:
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

       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_no_private_key }}** — цепочка сертификатов (корневой и конечный сертификат):
         ```text
          -----BEGIN CERTIFICATE-----
          MIIE5zCCA8+gAwI...
          -----END CERTIFICATE-----
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----
          ```

       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_leaf_only }}**:
           ```text
          -----BEGIN CERTIFICATE-----
          MIIFFjCCAv6gAwIBAg...
          -----END CERTIFICATE-----`
          ```
       * **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_select_private_key_only }}**:
          ```text
          -----BEGIN PRIVATE KEY-----
          MIIEvgIBADANBgk...
          -----END PRIVATE KEY-----`
          ```

    1. Нажмите **{{ ui-key.yacloud.certificate-manager.overview.certificate_content_download }}**.

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить содержимое пользовательского сертификата с помощью {{ TF }}:
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:


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

     Более подробную информацию о параметрах источника данных `yandex_cm_certificate_content` см. в [документации провайдера]({{ tf-provider-datasources-link }}/cm_certificate_content).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Чтобы проверить результат, выполните команды:
     * Получить цепочку сертификата:

       ```bash
       terraform output certificate_chain
       ```

     * Получить значение приватного ключа:

       ```bash
       terraform output -raw certificate_key
       ```

- API {#api}

  Чтобы получить содержимое сертификата, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/CertificateContent/get.md) для ресурса [CertificateContent](../../certificate-manager/api-ref/CertificateContent/) или вызовом gRPC API [CertificateContentService/Get](../../certificate-manager/api-ref/grpc/certificate_content_service.md#Get).

{% endlist %}

{% note info %}

Для чтения содержимого сертификата сервисному аккаунту необходимо выдать [роль](../../iam/concepts/access-control/roles.md) `certificate-manager.certificates.downloader`.

{% endnote %}