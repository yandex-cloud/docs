# Шифрование секретов в Hashicorp Terraform

[Terraform-провайдер для {{ yandex-cloud }}]({{ tf-provider-link }}/) позволяет зашифровать секреты ключом {{ kms-short-name }} для последующего их использования в Terraform-конфигурации.

Открытый текст и ключ {{ kms-short-name }}, который следует использовать для шифрования, необходимо указать в блоке [yandex_kms_secret_ciphertext]({{ tf-provider-link }}/kms_secret_ciphertext):

```
resource "yandex_kms_secret_ciphertext" "encrypted_strong_password" {
  key_id      = "<ID ключа>"
  aad_context = "additional authenticated data"
  plaintext   = "strong password"
}
```

После этого доступ к шифртексту можно получить через переменную `${yandex_kms_secret_ciphertext.encrypted_strong_password.ciphertext}`.

{% note warning %}

Использование `yandex_kms_secret_ciphertext` позволяет скрыть секреты при разворачивании инфраструктуры, но в общем случае указание `plaintext` и `aad_context` в конфигурационном файле в открытом виде небезопасно. Секреты могут быть прочитаны из файла конфигурации, могут попасть в Terraform-state или могут быть прочитаны из логов выполнения.

{% endnote %}

## Рекомендации для безопасного хранения секретных данных {#save-secret}

* Не указывайте значения секретов в конфигурационном файле явно. Читайте их из хранилища, доступ к которому ограничен (например, использовать хранилища секретов).
* Рассмотрите возможность [удаленного хранения Terraform-state](https://www.terraform.io/docs/state/sensitive-data.html).

## См. также {#see-also}

* [Начало работы с Terraform в {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Документация провайдера {{ yandex-cloud }}]({{ tf-provider-link }}/).
* [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html).
