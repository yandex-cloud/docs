Make sure the provider version you are using is {{ TF-version }} or higher:

```bash
terraform version
```

Result example:

```text
Terraform v1.4.6
on darwin_arm64
+ provider registry.terraform.io/yandex-cloud/yandex v0.91.0
```

{% cut "If the version is older" %}

Update the provider version:

1. In the folder with the `.tf` configuration file, [add the credentials](../../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) to environment variables.

1. In the same folder, initialize the provider with the updated version specified in the configuration file:

   ```bash
   terraform init -upgrade
   ```

1. Check the provider version:

   ```bash
   terraform version
   ```

{% endcut %}
