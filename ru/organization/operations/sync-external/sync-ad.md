---
title: Как настроить синхронизацию с {{ microsoft-idp.ad-full }} в {{ org-full-name }}
description: 'Настройте синхронизацию пользователей и групп между {{ microsoft-idp.ad-short }} и {{ org-full-name }}: подготовьте организацию и контроллер домена, настройте и запустите агент синхронизации.'
---

# Синхронизировать пользователей и группы с {{ microsoft-idp.ad-full }}


Если для управления пользователями ваша компания использует [{{ microsoft-idp.ad-full }}](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) и вы хотите организовать для ваших пользователей доступ к {{ yandex-cloud }}, вам не нужно создавать учетные записи для них вручную. Вместо этого вы можете настроить [синхронизацию](../../concepts/sync-external/ad-sync.md) с {{ org-full-name }} пользователей и групп из вашего каталога {{ microsoft-idp.ad-short }}.

## Подготовьте к синхронизации организацию {{ org-full-name }} {#prepare-org}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md) и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. [Создайте](../user-pools/create-userpool.md) пул пользователей в {{ org-full-name }} и [привяжите](../user-pools/add-domain.md#userpool) к нему [домен](../../concepts/domains.md), идентичный домену, который используется на [контроллере домена](https://ru.wikipedia.org/wiki/Контроллер_домена) {{ microsoft-idp.ad-short }}.

    Привязывать ваш собственный домен к [пулу пользователей](../../concepts/user-pools.md) не обязательно. Вместо этого вы можете привязать другой домен или выбрать домен по умолчанию. Но в этом случае в конфигурации [агента синхронизации](../../concepts/sync-external/ad-sync.md#sync-agent) потребуется настроить подстановку домена в параметре `replacement_domain`. Подробнее читайте в разделе [Параметры конфигурации агента](#config-sync-settings).
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) ему следующие роли на [организацию](../../concepts/organization.md), в которой находится нужный пул пользователей:

    {% include [ad-sync-sa-roles](../../../_includes/organization/external-sync/ad-sync-sa-roles.md) %}
1. (Опционально) [Создайте](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните [авторизованный ключ](../../../iam/concepts/authorization/key.md) для вашего [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

    {% include [ad-sync-iam-via-metadata-warning](../../../_includes/organization/external-sync/ad-sync-iam-via-metadata-warning.md) %}

## Подготовьте контроллер домена {{ microsoft-idp.ad-short }} {#dc-setup}

Для корректной работы агента синхронизации на стороне {{ microsoft-idp.ad-short }} выполните следующие действия:

{% include [ad-sync-presetup-ad](../../../_includes/organization/external-sync/ad-sync-presetup-ad.md) %}

## Включите обратную запись паролей (опционально) {#enable-password-writeback}

Если вы планируете использовать [обратную запись паролей](../../concepts/sync-external/ad-sync.md#password-writeback) из {{ org-full-name }} в {{ microsoft-idp.ad-short }}, включите ее для пула пользователей в {{ org-full-name }}.

{% include [pw-writeback-preview-notice](../../../_includes/organization/external-sync/pw-writeback-preview-notice.md) %}

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Посмотрите описание команды CLI для создания настроек синхронизации:

    ```bash
    yc organization-manager idp synchronization-settings create --help
    ```

1. Создайте настройки синхронизации с включенной обратной записью паролей:

    ```bash
    yc organization-manager idp synchronization-settings create \
      --subject-container-id <идентификатор_пула_пользователей> \
      --filter "domain=<домен_в_Active_Directory>" \
      --enable-password-writeback
    ```

    Где:

    * `--subject-container-id` — идентификатор [пула пользователей](../../concepts/user-pools.md), для которого создаются настройки синхронизации.
    * `--filter` — домен {{ microsoft-idp.ad-short }}, который нужно синхронизировать. Укажите тот же домен, что и в параметре `sync_settings.filter.domain` конфигурации агента.
    * `--enable-password-writeback` — включает обратную запись паролей для пула пользователей.

При [настройке агента](#setup-agent) также задайте в его конфигурации параметр `enable_password_writeback: true`.

## Настройте и запустите агент синхронизации {#setup-agent}

{% include [ext-sync-agent-setup-instr-intro](../../../_includes/organization/external-sync/ext-sync-agent-setup-instr-intro.md) %}

* Для обращения к API {{ yandex-cloud }}:

    * `443` — для [HTTPS](https://ru.wikipedia.org/wiki/HTTPS);

* Для обращения к контроллеру домена {{ microsoft-idp.ad-short }}:

    {% include [ad-sync-ports](../../../_includes/organization/external-sync/ad-sync-ports.md) %}

{% include [ad-sync-kerberos-components-installation-info](../../../_includes/organization/external-sync/ad-sync-kerberos-components-installation-info.md) %}

Чтобы запустить синхронизацию пользователей и групп:

{% list tabs group=operating_system %}

- Linux {#linux}

  В терминале Linux:

  1. {% include [agent-linux-installation-part-1](../../../_includes/organization/external-sync/agent-linux-installation-part-1.md) %}
  1. {% include [agent-linux-installation-part-2](../../../_includes/organization/external-sync/agent-linux-installation-part-2.md) %}
  1. {% include [agent-linux-installation-part-3](../../../_includes/organization/external-sync/agent-linux-installation-part-3.md) %}
  1. {% include [agent-ad-installation-part-4](../../../_includes/organization/external-sync/agent-ad-installation-part-4.md) %}

      {% list tabs group=authentication_linux %}

      - По логину и паролю {#password_linux}

        {% include [ad-sync-yaml-config](../../../_includes/organization/external-sync/ad-sync-yaml-config.md) %}

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      - По протоколу Kerberos {#kerberos_linux}

        {% include [ad-sync-yaml-config-kerberos](../../../_includes/organization/external-sync/ad-sync-yaml-config-kerberos.md) %}

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      {% endlist %}

  1. Запустите сервис агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

      ```bash
      sudo systemctl start yc-identityhub-sync-agent
      ```
  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      sudo cat /etc/yc-identityhub-sync-agent/identity_hub.log
      ```

      {% include [check-sync-results-in-ui](../../../_includes/organization/external-sync/check-sync-results-in-ui.md) %}

  1. Чтобы остановить синхронизацию, остановите запущенный процесс агента синхронизации:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

- Windows {#windows}

  В терминале PowerShell:

  1. {% include [agent-win-installation-part-1](../../../_includes/organization/external-sync/agent-win-installation-part-1.md) %}
  1. {% include [agent-win-installation-part-2](../../../_includes/organization/external-sync/agent-win-installation-part-2.md) %}
  1. {% include [agent-win-installation-part-3](../../../_includes/organization/external-sync/agent-win-installation-part-3.md) %}
  1. {% include [agent-ad-installation-part-4](../../../_includes/organization/external-sync/agent-ad-installation-part-4.md) %}

      {% list tabs group=authentication_windows %}

      - От имени аккаунта gMSA {#gmsa-windows}

        {% include [ad-sync-yaml-config-gmsa](../../../_includes/organization/external-sync/ad-sync-yaml-config-gmsa.md) %}

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      - По логину и паролю {#password_windows}

        {% include [ad-sync-yaml-config](../../../_includes/organization/external-sync/ad-sync-yaml-config.md) %}

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      - По протоколу Kerberos {#kerberos_windows}

        {% include [ad-sync-yaml-config-kerberos](../../../_includes/organization/external-sync/ad-sync-yaml-config-kerberos.md) %}

        Описание полей приведено в разделе [Параметры конфигурации агента](#agent-config).

      {% endlist %}

  1. Запустите службу агента синхронизации:

      ```powershell
      Start-Service yc-identityhub-sync-agent
      ```

      {% include [runas-gmsa-account-notice](../../../_includes/organization/external-sync/runas-gmsa-account-notice.md) %}

  1. Чтобы убедиться, что процесс синхронизации идет, посмотрите файл с логами агента. Например:

      ```bash
      cat C:\ProgramData\YcIdentityHubSyncAgent\identity_hub.log
      ```

      {% include [check-sync-results-in-ui](../../../_includes/organization/external-sync/check-sync-results-in-ui.md) %}

  1. Чтобы остановить процесс синхронизации, остановите созданную службу:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```

      В результате процесс синхронизации пользователей и групп будет остановлен.

{% endlist %}

## Протестируйте изменения в конфигурации агента {#dry-run}

Агент {{ ad-sync-agent }} можно запустить в [тестовом режиме](../../concepts/sync-external/ad-sync.md#dry-run) (dry run). Этот режим позволяет убедиться в корректности вносимых в конфигурацию агента изменений, прежде чем применять эти изменения в рабочем режиме.

{% include [dry-run-instruction](../../../_includes/organization/external-sync/dry-run-instruction.md) %}

{% note info %}

{% include [ad-sync-account-expires-solution](../../../_includes/organization/external-sync/ad-sync-account-expires-solution.md) %}

{% endnote %}

## Параметры конфигурации агента {#agent-config}

В файле `config.yaml` задайте параметры подключения и синхронизации.

Для подключения к {{ microsoft-idp.ad-short }} выберите настройки `drsr` и `ldap`, соответствующие вашему способу аутентификации:

* По логину и паролю — укажите учетные данные пользователя домена.
* По протоколу Kerberos — дополнительно заполните секцию `kerberos`.
* От имени аккаунта gMSA — используйте параметр `use_windows_identity: true` для `drsr` или `ldap`. Доступно только в Windows.

Параметры сгруппированы по назначению:

* Подключение к {{ yandex-cloud }}:

    * [userpool_id](#config-userpool-id);
    * [cloud_credentials_file_path](#config-cloud-credentials-file-path);
    * [use_metadata_service](#config-use-metadata-service).

* Файлы агента:

    * [working_directory](#config-working-directory);
    * [check_config_permissions](#config-check-config-permissions).

* Подключение к {{ microsoft-idp.ad-short }}:

    * [drsr](#config-drsr);
    * [ldap](#config-ldap);
    * [kerberos](#config-kerberos).

* Синхронизация:

    * [sync_settings](#config-sync-settings);
    * [enable_password_writeback](#config-enable-password-writeback);
    * [dry_run](#config-dry-run).

* Логи:

    * [logger](#config-logger).

{% include [config-legend-userpool-id](../../../_includes/organization/external-sync/config-legend-userpool-id.md) %}

{% include [config-legend-working-directory](../../../_includes/organization/external-sync/config-legend-working-directory.md) %}

{% include [config-legend-check-config-permissions](../../../_includes/organization/external-sync/config-legend-check-config-permissions.md) %}

{% include [config-legend-cred-file-path](../../../_includes/organization/external-sync/config-legend-cred-file-path.md) %}

{% include [config-legend-use-metadata-service](../../../_includes/organization/external-sync/config-legend-use-metadata-service.md) %}

{% include [config-legend-enable-pw-wb-ad](../../../_includes/organization/external-sync/config-legend-enable-pw-wb-ad.md) %}

{% include [config-legend-dry-run](../../../_includes/organization/external-sync/config-legend-dry-run.md) %}

{% include [config-legend-drsr](../../../_includes/organization/external-sync/config-legend-drsr.md) %}

{% include [config-legend-ldap-ad](../../../_includes/organization/external-sync/config-legend-ldap-ad.md) %}

{% include [config-legend-kerberos-ad](../../../_includes/organization/external-sync/config-legend-kerberos-ad.md) %}

{% include [config-legend-logger](../../../_includes/organization/external-sync/config-legend-logger.md) %}

{% include [config-legend-sync-settings-ad](../../../_includes/organization/external-sync/config-legend-sync-settings-ad.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/sync-external/index.md)
* [{#T}](../../concepts/sync-external/ad-sync.md)
* [{#T}](./sync-ldap.md)

[*gmsa_account]: {% include notitle [get-folder-id](../../../_popups/identity-hub/gmsa.md) %}
