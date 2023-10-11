# Creating configuration files and connecting to YDB {#configure}

{% note warning %}

To work with this guide, make sure that a Terraform provider for YDB is installed. To install a YDB provider, see [Installing and configuring Terraform and the YDB provider](./install.md).

{% endnote %}

Create a directory for Terraform's YDB configuration files and create a file named `main.tf`, e.g.:
```bash
mkdir ydb_terraform && cd ydb_teraform
touch main.tf
```

Add the following section to the beginning of the file and save the file:

```tf
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a" # Default availability zone
}
```

Values of the provider section parameters:
* `source`: Global provider [source address](https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses).
* `required_version`: Minimum Terraform version the provider is compatible with.
* `provider`: Provider name.
* `zone`: [The availability zone](../../overview/concepts/geo-scope.md) where all cloud resources will be created by default.

To initialize the provider, run the `terraform init` command in the directory hosting the configuration files. In the terminal, you will see a message about successful installation. Now that Terraform is installed and set up, you can start creating a [serverless](./serverless-database.md) or [dedicated](./dedicated-database.md) database.