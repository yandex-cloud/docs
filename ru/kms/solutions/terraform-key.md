# Управление ключами {{ kms-short-name }} с Hashicorp Terraform

[Terraform-провайдер для {{ yandex-cloud }}](https://www.terraform.io/docs/providers/yandex/index.html) поддерживает работу с ключами {{ kms-short-name }}.

## Добавление ключа {#add}

Добавить ключ {{ kms-short-name }} можно с помощью блока [yandex_kms_symmetric_key](https://www.terraform.io/docs/providers/yandex/r/kms_symmetric_key.html):

```
resource "yandex_kms_symmetric_key" "kms-key" {
  lifecycle {
    prevent_destroy = true
  }

  name              = "example-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" // equal to 1 year
}
```

{% note warning %}

Удаление ключа {{ kms-short-name }} равносильно уничтожению всех зашифрованных с его помощью данных — без ключа восстановить данные не получится. Блок `lifecycle` необходим, чтобы обезопасить ключ от удаления (например, командой `terraform destroy`).

{% endnote %}

## Управление доступом к ключу {#security}

Для управления доступом к ключу через Terraform назначьте необходимые роли на каталог, содержащий ключ. 

Например, назначьте на сервисный аккаунт роль, дающую права шифровать и расшифровывать данные ключами из определенного каталога:

```
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = "<ID каталога>"

  role   = "kms.keys.encrypterDecrypter"
  member = "serviceAccount:<ID сервисного аккаунта>"
}
```

## См. также {#see-also}

* [Начало работы с Terraform в {{ yandex-cloud }}](../../solutions/infrastructure-management/terraform-quickstart.md).
* [{#T}](../security/index.md).
* [Документация провайдера {{ yandex-cloud }}](https://www.terraform.io/docs/providers/yandex/index.html).

