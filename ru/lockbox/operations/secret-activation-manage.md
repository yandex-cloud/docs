# Деактивировать и активировать секрет 

## Деактивировать секрет {#secret-deactivate}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Напротив нужного секрета нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.lockbox.button_deactivate-secret }}**.
    1. Подтвердите деактивацию.

- API

  Чтобы деактивировать секрет, воспользуйтесь методом REST API [deactivate](../api-ref/Secret/deactivate.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Deactivate](../api-ref/grpc/secret_service.md#Deactivate).

{% endlist %}

## Активировать секрет {#secret-activate}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Напротив нужного секрета нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.lockbox.button_activate-secret }}**.

- API

  Чтобы активировать секрет, воспользуйтесь методом REST API [activate](../api-ref/Secret/activate.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Activate](../api-ref/grpc/secret_service.md#Activate).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
