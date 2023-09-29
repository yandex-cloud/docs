# Шифрование секретов в {{ TF-full }}

{% include [terraform-encryption](../../_includes/kms/terraform-encryption.md) %}

## Рекомендации для безопасного хранения секретных данных {#save-secret}

* Не указывайте значения секретов в конфигурационном файле явно. Читайте их из хранилища, доступ к которому ограничен (например, вы можете использовать хранилища секретов).
* Рассмотрите возможность [удаленного хранения {{ TF }}-state](https://www.terraform.io/docs/state/sensitive-data.html).

## См. также {#see-also}

* [Начало работы с {{ TF }} в {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Документация провайдера {{ yandex-cloud }}]({{ tf-provider-link }}/).
* [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html).
* [Шифрование данных с помощью CLI и API {{ yandex-cloud }}](../../kms/operations/symmetric-encryption.md).
* [{#T}](vault-secret.md)
