Вы можете загрузить цепочку сертификатов и закрытый ключ для самостоятельного использования, например, при конфигурации веб-сервера на виртуальной машине.

Чтобы получить содержимое сертификата:

{% list tabs %}

- CLI

  Команда отобразит цепочку сертификатов и приватный ключ и сохранит содержимое в файлы `--chain` и `--key` соответственно.

  * `--id` –  идентификатор сертификата, должен быть указан один из флагов: `--id` или `--name`.
  * `--name` – название сертификата, должен быть указан один из флагов: `--id` или `--name`.
  * `--chain` – (опционально) файл, куда будет сохранена цепочка сертификатов в формате PEM.
  * `--key` – (опционально) файл, куда будет сохранен приватный ключ в формате PEM.


  ```
  yc certificate-manager certificate content \
    --id fpqcsmn76v82******** \
    --chain certificate_full_chain.pem \
    --key private_key.pem
  ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить содержимое пользовательского сертификата с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      
      ```
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
      * блоки `output` — выходные переменные `certificate_chain` с цепочкой сертификатов и приватным ключом `certificate_key`:
         * `value` — возвращаемое значение.
         * `sensitive` — пометить как конфиденциальные данные.

     Более подробную информацию о параметрах источника данных `yandex_cm_certificate_content` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_cm_certificate_content).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Чтобы проверить результат, выполните команды:

      * Получить цепочку сертификата:

        ```bash
        terraform output certificate_chain
        ```

      * Получить значение приватного ключа:

        ```bash
        terraform output -raw certificate_key
        ```

- API

  Чтобы получить содержимое сертификата, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/CertificateContent/get.md) для ресурса [CertificateContent](../../certificate-manager/api-ref/CertificateContent/) или вызовом gRPC API [CertificateContentService/Get](../../certificate-manager/api-ref/grpc/certificate_content_service.md#Get).

{% endlist %}

{% note info %}

Для чтения содержимого сертификата сервисному аккаунту необходимо выдать роль `certificate-manager.certificates.downloader`.

{% endnote %}