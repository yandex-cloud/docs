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

Необходимо перенести файл `.terraformrc` из каталога `/home/user/terraform` в корень вашей домашней папки — `/home/user/`, а затем еще раз выполнить `terraform init`.
