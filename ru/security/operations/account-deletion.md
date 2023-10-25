# Удаление паспортного аккаунта из организации

Данная инструкция описывает, как удалить привилегированный паспортный аккаунт с ролью `organization-manager.organizations.owner` из [организации](../../organization/).

Такая потребность может возникнуть в сценариях, когда необходимо полностью контролировать аутентификацию привилегированного аккаунта. В данном случае привилегированного аккаунта, который имеет полные права на организацию и все ресурсы организации.

Удалить привилегированный аккаунт можно, если предварительно передать роль `organization-manager.organizations.owner` федеративному аккаунту. Однако в этом случае возникает риск, что возможная поломка федерации (на стороне облака или клиента) приведет к невозможности управлять организацией с помощью любого из федеративных аккаунтов.

Инструкция содержит действия по митигации риска, связанного с поломкой федерации.

## Основные действия {#main-steps}

1. Создайте [федерацию](../../organization/concepts/add-federation.md).  
1. Проверьте работу федерации, войдя от имени одного из федеративных пользователей.
1. Назначьте роль `organization-manager.organizations.owner` федеративному пользователю:

    {% list tabs %}

    - CLI

        ``` yc
        yc organization-manager organization add-access-binding \
            --id= <идентификатор_организации> \
            --subject= federatedUser:<идентификатор_федеративного_аккаунта> \
            --role=organization-manager.organizations.owner
        ```

    {% endlist %}

1. Создайте служебное облако `security`.
1. Назначьте роль `admin` на облако `security` офицерам безопасности, которые смогут восстановить доступ к облаку в случае поломки федерации.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) в облаке `security` для резервного восстановления доступа к организации.

    Если вы используете уже существующий сервисный аккаунт, убедитесь, что у него отсутствуют [статические](../../iam/concepts/authorization/access-key.md) и [API-ключи](../../iam/concepts/authorization/api-key.md).

    {% list tabs %}

    - CLI

        ``` yc
        yc iam api-key list --service-account-id=<идентификатор_сервисного_аккаунта> 
        yc iam access-key list --service-account-id=<идентификатор_сервисного_аккаунта> 
        ```

    {% endlist %}

    {% note warning %}

    Офицер безопасности имеет возможность повысить себе роль вплоть до `organization-manager.organizations.owner` за счет того, что он контролирует сервисный аккаунт, которому назначена такая роль. Убедитесь, что в административный доступ к облаку `security` и сервисному аккаунту есть только у офицеров безопасности, для этого выполните команду:

    {% list tabs %}

    - CLI

        ``` yc
        yc iam service-account list-access-bindings --id <идентификатор_сервисного_аккаунта>
        ```

    {% endlist %}

    Учитывайте, что сервисным аккаунтом смогут управлять все пользователи с ролью `admin` на каталог, облако или организацию, где расположен этот сервисный аккаунт. Таким образом, при получении контроля над сервисным аккаунтом пользователи смогут совершать любые действия в организации, в том числе назначать себе роли вплоть до `organization-manager.organizations.owner`. Следите, чтобы роль `admin` на сервисный аккаунт, а также на каталог, облако, организацию, где он расположен, была только у доверенных пользователей.

    {% endnote %}

1. Назначьте сервисному аккаунту роль `organization-manager.organizations.owner`:

    {% list tabs %}

    - CLI

        ``` yc
        yc organization-manager organization add-access-binding \
            --id= <идентификатор_организации> \
            --service-account-id=<идентификатор_сервисного_аккаунта> \
            --role=organization-manager.organizations.owner 
        ```

    {% endlist %}

1. [Создайте авторизованный ключ](../../iam/operations/iam-token/create-for-sa.md#via-cli) для сервисного аккаунта.
1. Сохраните файл ключа в доверенном хранилище.
1. Удалите роль `organization-manager.organizations.owner` у паспортного аккаунта через консоль или интерфейс командной строки:

    {% list tabs %}

    - CLI

        ``` yc
        yc organization-manager organization remove-access-binding \
            --id=<идентификатор_организации> \
            --user-account-id=<идентификатор_паспортного_аккаунта> \
            --role=organization-manager.organizations.owner 
        ```

    {% endlist %}

## Дополнительные меры {#additional-measures}

Настройте {{ at-name }} на действия с сервисным аккаунтом и федеративной учетной записью, которые обладают ролью `organization-manager.organizations.owner`:

1. [Настройте сбор аудитных логов с уровня организации](../../audit-trails/quickstart.md) в {{ at-full-name }}.

1. Отслеживайте как минимум следующие события (в [Object Storage](../../audit-trails/tutorials/search-bucket.md), [лог-группе](../../audit-trails/tutorials/search-cloud-logging.md), [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main) и [в вашем SIEM](../../audit-trails/concepts/export-siem.md)):

    * Создание ключей для сервисного аккаунта (события: `{{ at-event-prefix }}.audit.iam.CreateAccessKey`, `{{ at-event-prefix }}.audit.iam.CreateKey`, `{{ at-event-prefix }}.audit.iam.CreateApiKey` и `authentication.subject_id = <идентификатор_сервисного_аккаунта>`).
    * Назначение прав доступа на сервисный аккаунт (событие: `UpdateServiceAccountAccessBindings` и `details.service_account_id = <идентификатор_сервисного_аккаунта>`).
    * Любое действие с правами `organization-manager.organizations.owner` (`.authentication.subject_id == <идентификатор_пользователя_с_данными_правами>`).

Для анализа и реагирования на события в {{ at-name }} можно использовать [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main).

## Действия в случае поломки федерации {#federation-repair}

1. Получите доступ к сохраненному в доверенном хранилище авторизованному ключу.
1. [Аутентифицируйтесь](../../cli/operations/authentication/service-account.md#auth-as-sa) от имени сервисного аккаунта.
1. Далее:

    * Либо назначьте роль `organization-manager.organizations.owner` паспортной учетной записи и с ее помощью восстановите федерацию.
    * Либо восстановите федерацию из интерфейса командной строки CLI.

1. Проверьте доступ от лица федеративного пользователя.

## Действия после восстановления федерации {#after-federation-repairation}

1. Если паспортной учетной записи была выдана роль `organization-manager.organizations.owner` — [отзовите роль](../../iam/operations/roles/revoke.md).
1. Создайте новый авторизованный ключ для сервисного аккаунта и сохраните его в доверенном хранилище.
