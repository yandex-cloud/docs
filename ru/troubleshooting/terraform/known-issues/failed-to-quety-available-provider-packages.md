# Устранение ошибки `Failed to query available provider packages` при использовании {{ TF }}


## Описание проблемы {#issue-description}

При попытке задействовать {{ TF }} для создания, изменения или удаления облачных ресурсов возникает сообщение об ошибке:

```text
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: could not connect to registry.terraform.io:
│ Failed to request discovery document: 403 Forbidden
```

## Решение {#issue-resolution}

Компания HashiCorp заблокировала доступ к своим репозиториям с российских IP-адресов. Воспользуйтесь зеркалом реестра HashiCorp в {{ yandex-cloud }}. Для этого понадобится:

1. [Сконфигурировать {{ TF }} по следующей инструкции](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
1. Перейти в каталог с кодом {{ TF }}-манифестов.
1. Выполнить команду `terraform init -upgrade`.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Содержимое файла `~/.terraformrc` для устройств с Linux или MacOS или `%APPDATA%/terraform.rc` для устройств с Microsoft Windows®. Для Linux и MacOS символ `~` используется для сокращенного обозначения домашней директории пользователя.
1. Вывод ошибки при попытке применить код манифеста командой `terraform plan` или `terraform apply`.
1. Вывод команд `curl -vk registry.terraform.io` и `curl -vk https://terraform-mirror.yandexcloud.net`.
