
### Из зеркала {#from-yc-mirror}

Вы можете скачать дистрибутив {{ TF }} для вашей платформы из [зеркала]({{ terraform-mirror }}). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`:

```
export PATH=$PATH:/path/to/terraform
```


### С сайта Hashicorp {#from-hashicorp-site}


{% list tabs %}

- Windows

  Используйте один из способов:

  * [Скачайте дистрибутив {{ TF }}](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите {{ TF }} с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду:

     ```
     choco install terraform
     ```

- Linux

  [Скачайте дистрибутив {{ TF }}](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS

  Используйте один из способов:

    * [Скачайте дистрибутив {{ TF }}](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
    * Установите {{ TF }} с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду:

      ```
      brew install terraform
      ```

{% endlist %}

