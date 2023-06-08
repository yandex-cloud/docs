Убедитесь, что установленная версия провайдера — {{ TF-version }} или выше:

```bash
terraform version
```

Пример результата:

```text
Terraform v1.4.6
on darwin_arm64
+ provider registry.terraform.io/yandex-cloud/yandex v0.91.0
```

{% cut "Если версия ниже" %}

Обновите версию провайдера:

1. В каталоге с конфигурационным файлом `.tf` [добавьте аутентификационные данные](../../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) в переменные окружения.

1. В этом же каталоге инициализируйте провайдера с новой версией, указанного в конфигурационном файле:

   ```bash
   terraform init -upgrade
   ```

1. Проверьте версию провайдера:

   ```bash
   terraform version
   ```

{% endcut %}
