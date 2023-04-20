# Деактивировать и активировать секрет 

## Деактивировать секрет {#secret-deactivate}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ lockbox-short-name }}**.
    1. Напротив нужного секрета нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Нажмите кнопку **Деактивировать**.
    1. Подтвердите деактивацию.

- API

  Чтобы деактивировать секрет, воспользуйтесь методом REST API [deactivate](../api-ref/Secret/deactivate.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Deactivate](../api-ref/grpc/secret_service.md#Deactivate).

{% endlist %}

## Активировать секрет {#secret-activate}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ lockbox-short-name }}**.
    1. Напротив нужного секрета нажмите ![image](../../_assets/horizontal-ellipsis.svg).
    1. Подтвердите активацию.

- API

  Чтобы активировать секрет, воспользуйтесь методом REST API [activate](../api-ref/Secret/activate.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Activate](../api-ref/grpc/secret_service.md#Activate).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/secret.md)
