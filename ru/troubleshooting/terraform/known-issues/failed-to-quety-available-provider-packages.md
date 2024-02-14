# Устранение ошибки Failed to query available provider packages при использовании Terraform


## Описание проблемы {#issue-description}

При попытке задействовать Terraform для создания, изменения или удаления облачных ресурсов возникает сообщение об ошибке:

```text
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: could not connect to registry.terraform.io:
│ Failed to request discovery document: 403 Forbidden
```

## Решение {#issue-resolution}

Компания Hashicorp заблокировала доступ к своим репозиториям с российских IP-адресов.
Воспользуйтесь зеркалом реестра Hashicorp в Yandex Cloud. Для этого понадобится [сконфигурировать Terraform по следующей инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider)

Затем перейдите в каталог с кодом terraform-манифестов и выполните `terraform init -upgrade`.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
В запросе укажите следующую информацию:

1. Содержимое файла `~/.terraformrc` (на компьютерах с Linux или MacOS) или `%APPDATA%/terraform.rc` (на компьютерах с Windows). В Linux и MacOS символ `~` используется для сокращенного обозначения домашней директории пользователя.
2. Вывод ошибки при попытке примененить код манифеста командой `terraform plan` или `terraform apply`.
3. Вывод команд `curl -vk registry.terraform.io` и `curl -vk https://terraform-mirror.yandexcloud.net`
