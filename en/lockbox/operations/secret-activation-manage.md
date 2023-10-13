# Disabling and enabling a secret

## Deactivating a secret {#secret-deactivate}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the secret and select **{{ ui-key.yacloud.lockbox.button_deactivate-secret }}**.
   1. Confirm the deactivation.

- API

   To deactivate a secret, use the [deactivate](../api-ref/Secret/deactivate.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Deactivate](../api-ref/grpc/secret_service.md#Deactivate) gRPC API call.

{% endlist %}

## Activating a secret {#secret-activate}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the secret and select **{{ ui-key.yacloud.lockbox.button_activate-secret }}**.

- API

   To activate a secret, use the [activate](../api-ref/Secret/activate.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/Activate](../api-ref/grpc/secret_service.md#Activate) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
