# Устранение ошибки `Invalid provider registry host`


## Описание проблемы {#issue-description}

При попытке выполнить `terraform init` возникает ошибка:
```
Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
╷
│ Error: Invalid provider registry host
│ 
│ The host "registry.terraform.io" given in in provider source address "registry.terraform.io/yandex-cloud/yandex" does not
│ offer a Terraform provider registry.
```

## Решение {#issue-resolution}

Убедитесь, что в файле конфигурации {{ TF }} верно настроен провайдер. Эта настройка описана [в руководстве по началу работы с {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).

Решение проблемы зависит от операционной системы:

{% list tabs %}

- Microsoft Windows®

  Убедитесь, что файл с названием `terraform.rc` расположен в каталоге `%APPDATA%` для пользователя, от имени которого выполняется `terraform init`. Если у вас уже есть загруженный файл `.terraformrc`, переименуйте и переместите его в нужный каталог. Найти его расположение в системе поможет переменная среды `$env:APPDATA` в PowerShell.

- Linux

  Перенесите файл `.terraformrc` из каталога `~/.terraform` в корень вашей домашней папки, а затем еще раз выполните `terraform init`.

{% endlist %}
