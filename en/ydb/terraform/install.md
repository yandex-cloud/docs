---
title: "Installing and configuring {{ TF }} and a provider for connection to {{ ydb-short-name }}"
description: "This is a step-by-step guide for installing and configuring {{ TF }} and a {{ yandex-cloud }} provider."
---

# Installing and configuring {{ TF }} and a provider to connect to {{ ydb-short-name }}

You can download {{ TF }} from the official [HashiCorp](https://developer.hashicorp.com/terraform/downloads) website. If the site is unavailable, use our specially created [mirror](https://hashicorp-releases.yandexcloud.net/terraform/). Download the {{ TF }} distribution for your platform and add the path to the folder with the executable to the `PATH: export PATH=$PATH:/path/to/terraform` variable.


## Installing {{ TF }} for Windows, Linux, and macOS from the HashiCorp website {#terraform-install-on-dif-os}

{% list tabs group=operating_system %}

- Linux {#linux}

   * Download the [{{ TF }}](https://developer.hashicorp.com/terraform/downloads) distribution and follow [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started) to install it.

- macOS {#macos}

   * Download the [{{ TF }} distribution](https://developer.hashicorp.com/terraform/downloads) and follow [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started) to install it.
   * Install {{ TF }} using the [Homebrew](https://brew.sh) package manager and the `brew install terraform` command.

- Windows {#windows}

   * Download {{ TF }} from the [official website](https://developer.hashicorp.com/terraform/downloads) and follow [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started) to install it.
   * Install {{ TF }} using the [Chocolatey](https://chocolatey.org/install) package manager and the `choco install terraform` command.

{% endlist %}

Once you have installed {{ TF }}, configure it to access {{ ydb-short-name }}. First, install a provider to connect to {{ ydb-short-name }} and provide API methods.


## Installing a {{ ydb-short-name }} provider {#provider-install}

{{ TF }} will download and install a provider from the URL specified by the user in the `provider_installation` section of the `.terraformrc` file.

{% list tabs group=operating_system %}

- Linux/macOS {#linux}

   1. Open the {{ TF }} CLI configuration file, `~/.terraformrc`, in any text editor.

      {% include [terraform-configure-provider-directory](../../_tutorials/terraform-configure-provider-directory.md) %}

   1. Add the following section to the file:

      ```tf
      provider_installation {
          network_mirror {
              url = "https://terraform-mirror.yandexcloud.net/"
              include = ["registry.terraform.io/*/*"]
      }
          direct {
              exclude = ["registry.terraform.io/*/*"]
          }
      }
      ```

- Windows {#windows}

   1. Open the {{ TF }} CLI configuration file named `terraform.rc` in your user's `%APPDATA%` folder.
   1. Add the following section to the file:

      ```tf
      provider_installation {
          network_mirror {
              url = "https://terraform-mirror.yandexcloud.net/"
              include = ["registry.terraform.io/*/*"]
      }
          direct {
              exclude = ["registry.terraform.io/*/*"]
          }
      }
      ```

{% endlist %}

This completes the installation and configuration of {{ TF }} and the provider for connection to {{ ydb-short-name }}. You can move on to creating [configuration files](./configure.md) for {{ ydb-short-name }} access.
