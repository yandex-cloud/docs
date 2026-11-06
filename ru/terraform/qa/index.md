---
title: Вопросы и ответы о {{ TF }} в {{ yandex-cloud }}
description: 'Ответы на часто задаваемые вопросы о {{ TF }}: ошибки настройки провайдера.'
---

# Вопросы и ответы

#### Как устранить ошибку `Invalid provider registry host`? {#invalid-provider-registry-host}

При попытке выполнить `terraform init` возникает ошибка:

```text
Initializing the backend...

Initializing provider plugins...
- Finding latest version of yandex-cloud/yandex...
╷
│ Error: Invalid provider registry host
│
│ The host "registry.terraform.io" given in in provider source address "registry.terraform.io/yandex-cloud/yandex" does not
│ offer a Terraform provider registry.
```

Убедитесь, что в файле конфигурации {{ TF }} верно настроен провайдер. Эта настройка описана в статье [{#T}](../quickstart.md#configure-provider).

Решение проблемы зависит от операционной системы:

{% list tabs %}

- Microsoft Windows®

  Убедитесь, что файл с названием `terraform.rc` расположен в каталоге `%APPDATA%` для пользователя, от имени которого выполняется `terraform init`. Если у вас уже есть загруженный файл `.terraformrc`, переименуйте и переместите его в нужный каталог. Найти его расположение в системе поможет переменная среды `$env:APPDATA` в PowerShell.

- Linux

  Перенесите файл `.terraformrc` из каталога `~/.terraform` в корень вашей домашней папки, а затем еще раз выполните `terraform init`.

{% endlist %}

Если эти действия не помогли, [создайте запрос в техническую поддержку]({{ link-console-support }}).

#### Как устранить ошибку `Failed to query available provider packages`? {#failed-to-query-available-provider-packages}

При попытке задействовать {{ TF }} для создания, изменения или удаления облачных ресурсов возникает сообщение об ошибке:

```text
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: could not connect to registry.terraform.io:
│ Failed to request discovery document: 403 Forbidden
```

Компания HashiCorp заблокировала доступ к своим репозиториям с российских IP-адресов. Воспользуйтесь зеркалом реестра HashiCorp в {{ yandex-cloud }}. Для этого нужно:

1. Сконфигурировать {{ TF }} по инструкции из статьи [{#T}](../quickstart.md#configure-provider).
1. Перейти в каталог с кодом {{ TF }}-манифестов.
1. Выполнить команду `terraform init -upgrade`.
