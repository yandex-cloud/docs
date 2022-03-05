### С сайта Hashicorp {#from-hashicorp-site}

{% list tabs %}

- Windows

  Используйте один из способов:

  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Сhocolatey](https://chocolatey.org/install), используя команду:

     ```
     choco install terraform
     ```

- Linux

  [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS

  Используйте один из способов:

    * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
    * Установите Terraform с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду:

      ```
      brew install terraform
      ```

{% endlist %}

### Из зеркала {{ yandex-cloud }} {#from-yc-mirror}

Вы можете скачать дистрибутив Terraform для вашей платформы из [зеркала {{ yandex-cloud }}](https://hashicorp-releases.website.yandexcloud.net/terraform/). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`: 

```
export PATH=$PATH:/path/to/terraform
```
