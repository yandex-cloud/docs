[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Вопросы и ответы

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

Убедитесь, что в файле конфигурации Terraform верно настроен провайдер. Эта настройка описана в статье [Настройте провайдер](../quickstart.md#configure-provider).

Решение проблемы зависит от операционной системы:

{% list tabs %}

- Microsoft Windows®

  Убедитесь, что файл с названием `terraform.rc` расположен в каталоге `%APPDATA%` для пользователя, от имени которого выполняется `terraform init`. Если у вас уже есть загруженный файл `.terraformrc`, переименуйте и переместите его в нужный каталог. Найти его расположение в системе поможет переменная среды `$env:APPDATA` в PowerShell.

- Linux

  Перенесите файл `.terraformrc` из каталога `~/.terraform` в корень вашей домашней папки, а затем еще раз выполните `terraform init`.

{% endlist %}

Если эти действия не помогли, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support).

#### Как устранить ошибку `Failed to query available provider packages`? {#failed-to-query-available-provider-packages}

При попытке задействовать Terraform для создания, изменения или удаления облачных ресурсов возникает сообщение об ошибке:

```text
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider yandex-cloud/yandex: could not connect to registry.terraform.io:
│ Failed to request discovery document: 403 Forbidden
```

Компания HashiCorp заблокировала доступ к своим репозиториям с российских IP-адресов. Воспользуйтесь зеркалом реестра HashiCorp в Yandex Cloud. Для этого нужно:

1. Сконфигурировать Terraform по инструкции из статьи [Настройте провайдер](../quickstart.md#configure-provider).
1. Перейти в каталог с кодом Terraform-манифестов.
1. Выполнить команду `terraform init -upgrade`.