---
title: Как синхронизировать пользователей и группы с {{ microsoft-idp.ad-short }}
description: Следуя данной инструкции, вы сможете настроить синхронизацию пользователей и групп в {{ org-full-name }} с {{ microsoft-idp.ad-full }} с помощью агента {{ ad-sync-agent }}.
---

# Синхронизировать пользователей и группы с {{ microsoft-idp.ad-full }}


{% include [note-preview](../../_includes/note-preview.md) %}

Если для управления пользователями ваша компания использует [{{ microsoft-idp.ad-full }}](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) и вы хотите организовать для ваших пользователей доступ к {{ yandex-cloud }}, вам не нужно вручную создавать в {{ yandex-cloud }} учетные записи для ваших пользователей. Вместо этого вы можете настроить [синхронизацию](../concepts/ad-sync.md) с {{ org-full-name }} пользователей и групп, созданных в вашем каталоге {{ microsoft-idp.ad-short }}.

## Подготовьте к синхронизации организацию {{ org-name }} {#prepare-org}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. [Создайте](./user-pools/create-userpool.md) пул пользователей в {{ org-name }} и [привяжите](./user-pools/add-domain.md#userpool) к нему [домен](../concepts/domains.md), идентичный домену, который используется на [контроллере домена](https://ru.wikipedia.org/wiki/Контроллер_домена) {{ microsoft-idp.ad-short }}.

    Привязывать ваш собственный домен к [пулу пользователей](../concepts/user-pools.md) не обязательно. Вместо этого вы можете привязать другой домен или выбрать домен по умолчанию. Но в этом случае в конфигурации [агента синхронизации](../concepts/ad-sync.md#sync-agent) потребуется настроить подстановку домена в параметре `replacement_domain`. Подробнее см. в разделе [{#T}](../concepts/ad-sync.md#agent-config).
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) ему следующие роли на [организацию](../concepts/organization.md), в которой находится нужный пул пользователей:

    {% include [ad-synk-sa-roles](../../_includes/organization/ad-synk-sa-roles.md) %}
1. [Создайте](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../iam/concepts/authorization/key.md) для вашего [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

## Подготовьте контроллер домена {{ microsoft-idp.ad-short }} {#dc-setup}

{% include [ad-synk-presetup-ad](../../_includes/organization/ad-synk-presetup-ad.md) %}

## Настройте и запустите агент синхронизации {#setup-agent}

Вы можете установить [агент](../concepts/ad-sync.md#sync-agent) синхронизации на любой сервер под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux) или [Windows](https://ru.wikipedia.org/wiki/Windows).

Прежде, чем приступать к синхронизации, откройте на сервере, где вы будете запускать агента, следующие [TCP](https://ru.wikipedia.org/wiki/TCP)-порты для входящего и исходящего сетевого трафика:

* Для обращения к API {{ yandex-cloud }}:

    * `443` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к контроллеру домена {{ microsoft-idp.ad-short }}:

    {% include [ad-synk-ports](../../_includes/organization/ad-synk-ports.md) %}

Чтобы запустить синхронизацию пользователей и групп:

{% list tabs group=operating_system %}

- Linux {#linux}

  В терминале Linux:

  1. Чтобы установить агент {{ ad-sync-agent }}, выполните команду:

      ```bash
      curl {{ ad-sync-agent-linuxlink }} | bash
      ```

      Результат:

      ```text
      Example config file downloaded to /etc/yc-identityhub-sync-agent/config.yaml. Modify it with your values
      Service installed as yc-identityhub-sync-agent
      To start the service: sudo systemctl start yc-identityhub-sync-agent
      To enable the service to start on boot: sudo systemctl enable yc-identityhub-sync-agent
      To check service status: sudo systemctl status yc-identityhub-sync-agent
      yc-identityhub-sync-agent is installed to /usr/bin/yc-identityhub-sync-agent
      ```
  1. Скопируйте на ваш сервер файл с сохраненным ранее авторизованным ключом сервисного аккаунта.

      Для этого вы можете воспользоваться командой `scp` или любым другим подходящим инструментом.
  1. В любом текстовом редакторе откройте [YAML](https://yaml.org/)-файл с конфигурацией агента синхронизации. В примере ниже используется редактор `nano`:

      ```bash
      nano /etc/yc-identityhub-sync-agent/config.yaml
      ```
  1. В открывшемся файле задайте конфигурацию агента синхронизации:

      {% include [ad-synk-yaml-config](../../_includes/organization/ad-synk-yaml-config.md) %}

      {% include [ad-synk-yaml-config-legend](../../_includes/organization/ad-synk-yaml-config-legend.md) %}
  1. Запустите сервис агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

      ```bash
      sudo systemctl start yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      sudo cat /etc/yc-identityhub-sync-agent/identity_hub.log
      ```

      {% include [check-sync-results-in-ui](../../_includes/organization/check-sync-results-in-ui.md) %}

  1. Чтобы остановить синхронизацию, остановите запущенный процесс агента синхронизации:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

- Windows {#windows}

  В терминале PowerShell:

  1. Чтобы установить агент {{ ad-sync-agent }}, выполните команду:

      ```bash
      iex (New-Object System.Net.WebClient).DownloadString('{{ ad-sync-agent-windowslink }}')
      ```

      Результат:

      ```text
      Example config file downloaded to C:\ProgramData\YcIdentityHubSyncAgent\config.yaml. Modify it with your values
      yc-identityhub-sync-agent is installed to C:\Program Files\YcIdentityHubSyncAgent\bin\yc-identityhub-sync-agent.exe
      Config file is located at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml

      Status   Name               DisplayName
      ------   ----               -----------
      Stopped  yc-identityhub-... Yandex Identity Hub Sync Agent
      yc-identityhub-sync-agent installed as Windows service 'yc-identityhub-sync-agent' (not started automatically)
      1. Modify the config file at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml with your values
      2. Run: Start-Service yc-identityhub-sync-agent
      ```
  1. Скопируйте на ваш сервер файл с сохраненным ранее авторизованным ключом сервисного аккаунта. Для этого вы можете воспользоваться любым подходящим инструментом.
  1. В любом текстовом редакторе откройте [YAML](https://yaml.org/)-файл конфигурации агента `config.yaml`, расположенный в папке `C:\ProgramData\YcIdentityHubSyncAgent\`, и добавьте в него следующую конфигурацию:

      {% include [ad-synk-yaml-config](../../_includes/organization/ad-synk-yaml-config.md) %}

      {% include [ad-synk-yaml-config-legend](../../_includes/organization/ad-synk-yaml-config-legend.md) %}

  1. Запустите службу агента синхронизации:

      ```powershell
      Start-Service yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      cat C:\ProgramData\YcIdentityHubSyncAgent\identity_hub.log
      ```

      {% include [check-sync-results-in-ui](../../_includes/organization/check-sync-results-in-ui.md) %}

  1. Чтобы остановить процесс синхронизации, остановите созданную службу:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../concepts/ad-sync.md)