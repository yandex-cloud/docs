
### From a mirror {#from-yc-mirror}

{% note alert %}

The mirror is temporarily unavailable.

{% endnote %}

You can download a {{ TF }} distribution for your platform from a [mirror]({{ terraform-mirror }}). When the download is complete, add the path to the folder with the executable to the `PATH` variable:

```
export PATH=$PATH:/path/to/terraform
```


### From the Hashicorp website {#from-hashicorp-site}


{% list tabs %}

- Windows

   Use one of the following methods:

   * [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and install it by following the [instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
   * Install {{ TF }} using the [Chocolatey](https://chocolatey.org/install) package manager and the command below:

      ```
      choco install terraform
      ```

- Linux

   [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and install it by following the [instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS

   Use one of the following methods:

   * [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and install it by following the [instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
   * Install {{ TF }} using the [Homebrew](https://brew.sh) package manager and the command below:

      ```
      brew install terraform
      ```

{% endlist %}

