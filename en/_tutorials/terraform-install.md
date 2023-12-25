
### From a mirror {#from-yc-mirror}


{% note alert %}

The mirror may be unavailable.

{% endnote %}


You can download a {{ TF }} distribution for your platform from a [mirror]({{ terraform-mirror }}). When the download is complete, add the path to the folder with the executable to the `PATH` variable:

```
export PATH=$PATH:/path/to/terraform
```

### From the Hashicorp website {#from-hashicorp-site}


{% list tabs group=operating_system %}

- Windows {#windows}

   Use one of the following methods:

   * [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install it.
   * Install {{ TF }} using the [Chocolatey](https://chocolatey.org/install) package manager and the command below:

      ```
      choco install terraform
      ```

- Linux {#linux}

   [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install it.

- macOS {#macos}

   Use one of the following methods:

   * [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install it.
   * Install {{ TF }} using the [Homebrew](https://brew.sh) package manager and the command below:

      ```
      brew install terraform
      ```

{% endlist %}

