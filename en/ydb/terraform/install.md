# Installing and configuring Terraform and the YDB provider

You can download Terraform from the official [HashiCorp](https://developer.hashicorp.com/terraform/downloads) website. If the site is unavailable, use our specially created [mirror](https://hashicorp-releases.yandexcloud.net/terraform/). Download the Terraform distribution for your platform and add the folder with the Terraform executable to the PATH variable: `export PATH=$PATH:/path/to/terraform`.


## Installing Terraform for Windows, Linux, and macOS from the HashiCorp site {#terraform-install-on-dif-os}

{% list tabs group=operating_system %}

- Linux {#linux}

   * Download the [Terraform](https://developer.hashicorp.com/terraform/downloads) distribution and follow [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started) to install it.

- macOS {#macos}

   * Download the [Terraform distribution](https://developer.hashicorp.com/terraform/downloads) and follow [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started) to install it.
   * Install Terraform using the [Homebrew](https://brew.sh) package manager and the `brew install terraform` command.

- Windows {#windows}

   * Download Terraform from the [official website](https://developer.hashicorp.com/terraform/downloads) and install it as per [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started).
   * Install Terraform using the [Chocolatey](https://chocolatey.org/install) package manager and the `choco install terraform` command.

{% endlist %}

Once you have installed Terraform, configure it to access YDB. First, install a provider to connect to YDB and provide API methods.


## Installing a YDB provider {#provider-install}

Terraform will download and install a provider from the URL specified by the user in the `provider_installation` section of the `.terraformrc` file.

{% list tabs group=operating_system %}

- Linux/macOS {#linux}

   1. Open the Terraform CLI configuration file, `~/.terraformrc`, in your favorite text editor.

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

   1. Open the Terraform CLI `terraform.rc` configuration file located in your user's `%APPDATA%` folder.
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

This completes the installation and setup of Terraform and the YDB provider. You can move on to creating [configuration files](./configure.md) for YDB access.
