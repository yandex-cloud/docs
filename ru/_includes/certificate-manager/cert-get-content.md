Вы можете загрузить цепочку сертификатов и закрытый ключ для самостоятельного использования, 
например, при конфигурации веб-сервера на виртуальной машине.

Чтобы получить содержимое сертификата:

{% list tabs %}

- CLI

    Команда отобразит цепочку сертификатов и частный ключ и сохранит содержимое в файлы `--chain` и `--key` соответственно.

    * `--id` –  идентификатор сертификата, должен быть указан один из флагов: `--id` или `--name`.
    * `--name` – название сертификата, должен быть указан один из флагов: `--id` или `--name`.
    * `--chain` – (опционально) файл, куда будет сохранена цепочка сертификатов в формате PEM.
    * `--key` – (опционально) файл, куда будет сохранен частный ключ в формате PEM.


    ```
    yc certificate-manager certificate content \
      --id fpqcsmn76v82fi446ri7 \
      --chain certificate_full_chain.pem \
      --key private_key.pem
    ```

- API

  Чтобы получить содержимое сертификата, воспользуйтесь методом REST API [get](../../certificate-manager/api-ref/CertificateContent/get.md) для ресурса [CertificateContent](../../certificate-manager/api-ref/CertificateContent/) или вызовом gRPC API [CertificateContentService/Get](../../certificate-manager/api-ref/grpc/certificate_content_service.md#Get).

{% endlist %}

{% note info %}

Для чтения содержимого сертификата сервисному аккаунту необходимо выдать роль `certificate-manager.certificates.downloader`.

{% endnote %}