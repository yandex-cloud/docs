### From a {{ yandex-cloud }} mirror {#from-yc-mirror}

You can download a Terraform distribution for your platform from a [{{ yandex-cloud }} mirror](https://hashicorp-releases.website.yandexcloud.net/terraform/). When the download is complete, add the path to the folder with the executable to the `PATH` variable:

```
export PATH=$PATH:/path/to/terraform
```

### From the Hashicorp website {#from-hashicorp-site}

{% list tabs %}

- Windows

   Use one of the following methods:

   * [Download a Terraform distribution](https://www.terraform.io/downloads.html) and install it by following the [instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
   * Install Terraform using the [Chocolatey](https://chocolatey.org/install) package manager. To do this, run the command:

      ```
      choco install terraform
      ```

- Linux

   [Download a Terraform distribution](https://www.terraform.io/downloads.html) and install it by following the [instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS

   Use one of the following methods:

   * [Download a Terraform distribution](https://www.terraform.io/downloads.html) and install it by following the [instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
   * Install Terraform using the [Homebrew](https://brew.sh) package manager and the command below:

      ```
      brew install terraform
      ```

{% endlist %}

