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

Решение этой проблемы будет зависеть от используемой на вашей ВМ операционной системы:

{% list tabs %}

- Microsoft Windows®

  Необходимо убедиться, что файл с названием `terraform.rc` расположен в каталоге `%APPDATA%` для пользователя, от имени которого выполняется `terraform init`. Если у вас уже есть загруженный файл `.terraformrc`, его необходимо переименовать и переместить в нужный каталог. Найти его расположение в системе поможет переменная среды `$env:APPDATA` в PowerShell.

- Linux

  Необходимо перенести файл `.terraformrc` из каталога `~/.terraform` в корень вашей домашней папки, а затем еще раз выполнить `terraform init`.

{% endlist %}
