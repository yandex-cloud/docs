# Управление ключами {{ kms-short-name }} с {{ TF-full }}

[{{ TF }}-провайдер]({{ tf-provider-link }}/) для {{ yandex-cloud }} поддерживает работу с ключами {{ kms-short-name }}.

## Добавление ключа {#add}

{% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

## Управление доступом к ключу {#security}

Для управления доступом к ключу через {{ TF }} назначьте необходимые роли на каталог, содержащий ключ. 

Например, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) на сервисный аккаунт роль `kms.keys.encrypterDecrypter`, дающую права шифровать и расшифровывать данные ключами из определенного каталога:

```hcl
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = "<идентификатор_каталога>"
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:<идентификатор_сервисного_аккаунта>"
}
```

## См. также {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{#T}](../security/index.md).
* [Документация провайдера {{ yandex-cloud }}]({{ tf-provider-link }}/).
* [Шифрование данных с помощью CLI и API {{ yandex-cloud }}](../../kms/operations/key.md).
