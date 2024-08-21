---
title: "How to deactivate and activate a secret in {{ lockbox-full-name }}"
description: "In this tutorial, you will learn how to deactivate and activate a secret in {{ lockbox-full-name }}."
---

# Deactivating and activating a secret

A secret can be either active or deactivated. When a secret is active, it enables access to both its metadata and content (key-value pairs). When deactivated, it allows access only to its metadata, with the secret content being inaccessible.

## Deactivating a secret {#secret-deactivate}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the secret and select **{{ ui-key.yacloud.lockbox.button_deactivate-secret }}**.
   1. Confirm the deactivation.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the CLI command description for information about deactivating a secret:

      ```bash
      yc lockbox secret deactivate --help
      ```
   1. Deactivate a secret by specifying its ID or name:

      ```bash
      yc lockbox secret deactivate <secret_name>
      ```
      Result:

      ```bash
      id: e6qkkp3k29jf********
      folder_id: b1go3el0d8fs********
      created_at: "2023-11-08T13:14:34.676Z"
      name: first-secret
      status: INACTIVE
      current_version:
        id: e6qor8pe3ju7********
        secret_id: e6qkkp3k29jf********
        created_at: "2023-11-08T13:14:34.676Z"
        status: ACTIVE
        payload_entry_keys:
          - secret-key
      ```

- API {#api}

   To deactivate a secret, use the [deactivate](../api-ref/Secret/deactivate.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Deactivate](../api-ref/grpc/secret_service.md#Deactivate) gRPC API call.

{% endlist %}

## Activating a secret {#secret-activate}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the secret and select **{{ ui-key.yacloud.lockbox.button_activate-secret }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. See the CLI command description for information about activating a secret:

      ```bash
      yc lockbox secret activate --help
      ```
   1. Activate a secret by specifying its ID or name:

      ```bash
      yc lockbox secret activate <secret_name>
      ```
      Result:

      ```bash
      id: e6qkkp3k29jf********
      folder_id: b1go3el0d8fs********
      created_at: "2023-11-08T13:14:34.676Z"
      name: first-secret
      status: ACTIVE
      current_version:
        id: e6qor8pe3ju7********
        secret_id: e6qkkp3k29jf********
        created_at: "2023-11-08T13:14:34.676Z"
        status: ACTIVE
        payload_entry_keys:
          - secret-key
      ```

- API {#api}

   To activate a secret, use the [activate](../api-ref/Secret/activate.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Activate](../api-ref/grpc/secret_service.md#Activate) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
