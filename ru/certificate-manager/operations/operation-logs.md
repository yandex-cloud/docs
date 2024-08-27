# Посмотреть операции с сертификатом

Все действия с ресурсами сервиса {{ certificate-manager-name }} сохраняются в виде списка операций. Каждой операции присваивается уникальный идентификатор.

## Получить список операций {#get-operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится сертификат.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud.certificate-manager.label_certificates }}**.
  1. Выберите нужный сертификат.
  1. Перейдите на панель ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** для выбранного сертификата.

     В открывшемся списке отображаются операции с выбранным сертификатом.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список операций для сертификата, воспользуйтесь командой:

  ```bash
  yc certificate-manager certificates list-operations <имя_или_идентификатор_сертификата>
  ```

  Результат:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |    DESCRIPTION     |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------+
  | fpq207m67dkq******** | 2024-03-26 16:32:07 | aje9k8luj4qf******** | 2024-03-26 16:32:07 | DONE   | Update certificate |
  | fpqolhv1gtl5******** | 2024-03-21 12:32:27 | aje9k8luj4qf******** | 2024-03-21 12:32:27 | DONE   | Create certificate |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------+
  ```

  По умолчанию информация об операциях выводится в текстовом формате. Чтобы получить более подробную информацию, укажите формат `yaml` или `json` для выводимых данных с помощью флага `--format`:

  ```bash
  yc certificate-manager certificates list-operations <имя_или_идентификатор_сертификата> --format yaml
  ```

  Результат:

  ```text
  - id: fpq207m67dkq********
    description: Update certificate
    created_at: "2024-03-26T16:32:07.034Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-26T16:32:07.047Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.UpdateCertificateMetadata
      certificate_id: fpqf446dhkgi********
    response:
      '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.Certificate
      id: fpqf446dhkgi********
      folder_id: b1g681qpemb4********
      created_at: "2024-03-21T12:32:27.008Z"
      name: cert-alb
      labels:
        key: value
      type: IMPORTED
      domains:
        - cdn.yandexcloud.example
      status: ISSUED
      issuer: CN=cdn.yandexcloud.example
      subject: CN=cdn.yandexcloud.example
      serial: 6e71e5c50a038f96a144397315bd8e93********
      updated_at: "2024-03-26T16:32:07.022219309Z"
      issued_at: "2024-03-21T12:32:27.008Z"
      not_after: "2025-03-21T12:30:49Z"
      not_before: "2024-03-21T12:30:49Z"
      incomplete_chain: true
  - id: fpqolhv1gtl5********
    description: Create certificate
    created_at: "2024-03-21T12:32:27.062Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-03-21T12:32:27.082Z"
    ...
      not_before: "2024-03-21T12:30:49Z"
      incomplete_chain: true
  ```

- API {#api}

  Воспользуйтесь методом REST API [listOperations](../api-ref/Certificate/listOperations.md) для ресурса [Certificate](../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/ListOperations](../api-ref/grpc/certificate_service.md#ListOperations).

{% endlist %}

## Получить подробную информацию об операции {#get-operations-info}

1. [Получите список операций](#get-operations) для ресурса.
1. Скопируйте идентификатор нужной операции.
1. Получите подробную информацию об операции:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      Результат:

      ```text
      id: fpq207m67dkq********
      description: Update certificate
      created_at: "2024-03-26T16:32:07.034Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-26T16:32:07.047Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.UpdateCertificateMetadata
        certificate_id: fpqf446dhkgi********
      response:
        '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.Certificate
        id: fpqf446dhkgi********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-21T12:32:27.008Z"
        name: cert-alb
        labels:
          key: value
        type: IMPORTED
        domains:
          - cdn.yandexcloud.example
        status: ISSUED
        issuer: CN=cdn.yandexcloud.example
        subject: CN=cdn.yandexcloud.example
        serial: 6e71e5c50a038f96a144397315bd8e93********
        updated_at: "2024-03-26T16:32:07.022219309Z"
        issued_at: "2024-03-21T12:32:27.008Z"
        not_after: "2025-03-21T12:30:49Z"
        not_before: "2024-03-21T12:30:49Z"
        incomplete_chain: true
      ```

    - API {#api}

      Воспользуйтесь вызовом gRPC API [OperationService/Get](../api-ref/grpc/operation_service.md#Get).

    {% endlist %}

#### См. также {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
