{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `sa-backup-to-s3`.
  1. На панели сверху нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните полученные идентификатор и секретный ключ — они понадобятся позднее при монтировании бакета.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI {#cli}

  1. Выполните команду:

      ```bash
      yc iam access-key create \
        --service-account-name sa-backup-to-s3
      ```

      Где `--service-account-name` — имя сервисного аккаунта, для которого создается ключ.

      Результат:

      ```text
      access_key:
        id: aje726ab18go********
        service_account_id: ajecikmc374i********
        created_at: "2024-11-28T14:16:44.936656476Z"
        key_id: YCAJEOmgIxyYa54LY********
      secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
      ```

  1. Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся позднее при монтировании бакета.

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

  Сохраните идентификатор (`key_id`) и секретный ключ (`secret`) — они понадобятся позднее при монтировании бакета.

{% endlist %}