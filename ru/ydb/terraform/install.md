# Установка и настройка Terraform и провайдера для подключения к YDB

Terraform можно скачать с официального сайта [HashiCorp](https://developer.hashicorp.com/terraform/downloads), но если сайт не доступен – воспользуйтесь нашим специально созданным [зеркалом](https://hashicorp-releases.yandexcloud.net/terraform/). Скачайте дистрибутив Terraform для вашей платформы и добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH: export PATH=$PATH:/path/to/terraform`.


## Установка Terraform для Windows, Linux и macOS с сайта HashiCorp {#terraform-install-on-dif-os}

{% list tabs group=operating_system %}

- Linux {#linux}
    * Скачайте дистрибутив [Terraform](https://developer.hashicorp.com/terraform/downloads) и установите его согласно [инструкции](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started).
- macOS {#macos}
    * Скачайте [дистрибутив Terraform](https://developer.hashicorp.com/terraform/downloads) и установите его согласно [инструкции](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started).
    * Установите Terraform с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду: `brew install terraform`.
- Windows {#windows}
    * Скачайте Terraform с [официального сайта](https://developer.hashicorp.com/terraform/downloads) и установите его согласно [инструкции](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli?in=terraform%2Faws-get-started).
    * Установите Terraform с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду: `choco install terraform`.

{% endlist %}

После установки Terraform его нужно настроить для работы с YDB. Первое, что нужно сделать – это установить провайдер, который будет устанавливать соединение с YDB и предоставлять API-методы.


## Установка провайдера для работы с YDB {#provider-install}

Terraform самостоятельно скачает и устанавит провайдер с заданного пользователем url в блоке `provider_installation`, который должен быть расположен в файле `~/.terraformrc`.

{% list tabs group=operating_system %}
- Linux/macOS {#linux}
    1. Откройте файл конфигурации Terraform CLI `~/.terraformrc` в любом удобном для вас текстовом редакторе.
    1. Добавьте в него следующий блок:
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
    1. Откройте файл конфигурации Terraform CLI `terraform.rc` в папке `%APPDATA%` вашего пользователя. 
    1. Добавьте в него следующий блок:    
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

На этом установка и настройка Terraform и провайдера для подключения к YDB завершена. Можно переходить к созданию [конфигурационных файлов](./configure.md) для работы с YDB.
