---
title: Creating configuration files and connecting to {{ ydb-short-name }}
description: Follow this guide to create configuration files and connect to {{ ydb-short-name }}.
---

# Creating configuration files and connecting to {{ ydb-short-name }}

{% note warning %}

For this tutorial, you need to install a {{ TF }} provider for {{ ydb-short-name }}. If you do not have a provider for {{ ydb-short-name }} installed, see [Installing and configuring {{ TF }} and the {{ ydb-short-name }} provider](./install.md).

{% endnote %}

Create a directory where you will place your {{ TF }} configuration files for {{ ydb-short-name }}, then create a file named `main.tf.`, e.g.:
```bash
mkdir ydb_terraform && cd ydb_terraform
touch main.tf
```

## Provider section properties {#tproviders_description}

Add the following section at the beginning of the file and save this file:

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
  zone = "{{ region-id }}-a" # Default availability zone
}
```

Here is the description of the provider section fields:
* `source`: Provider's global [source address](https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses).
* `required_version`: Minimum {{ TF }} version the provider is compatible with.
* `provider`: Provider name.
* `zone`: Default [availability zone](../../overview/concepts/geo-scope.md) for all your cloud resources.

To initialize the provider, run `terraform init` in the directory with the configuration files. In the terminal, you will see a message about successful installation. Now that {{ TF }} is installed and set up, you can start creating a [serverless](./serverless-database.md) or [dedicated](./dedicated-database.md) database.
