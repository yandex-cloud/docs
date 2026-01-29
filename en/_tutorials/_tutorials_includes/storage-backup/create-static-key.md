{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `sa-backup-to-s3` service account.
  1. In the top panel, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Enter a description for the key and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key for later when you are mounting the bucket.

      {% note alert %}

      After you close this dialog, the key value will no longer be available.

      {% endnote %}

- CLI {#cli}

  1. Run this command:

      ```bash
      yc iam access-key create \
        --service-account-name sa-backup-to-s3
      ```

      Where `--service-account-name` is the name of the service account you are creating the key for.

      Result:

      ```text
      access_key:
        id: aje726ab18go********
        service_account_id: ajecikmc374i********
        created_at: "2024-11-28T14:16:44.936656476Z"
        key_id: YCAJEOmgIxyYa54LY********
      secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
      ```

  1. Save the ID (`key_id`) and secret key (`secret`) for later when you are mounting the bucket.

- API {#api}

  To create an access key, use the [create](../../../iam/awscompatibility/api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../../iam/awscompatibility/api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md) gRPC API call.

  Save the ID (`key_id`) and secret key (`secret`) for later when you are mounting the bucket.

{% endlist %}