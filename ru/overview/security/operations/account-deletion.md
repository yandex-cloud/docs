# Удаление паспортного аккаунта из организации

Данная инструкция описывает, как удалить привилегированный паспортный аккаунт с ролью `organization-manager.organizations.owner` из [организации](../../../organization/).

Такая потребность может возникнуть в сценариях, когда необходимо полностью контролировать аутентификацию привилегированного аккаунта. В данном случае привилегированного аккаунта, который имеет полные права на организацию и все ресурсы организации.

Удалить привилегированный аккаунт можно, если предварительно передать роль `organization-manager.organizations.owner` федеративному аккаунту. Однако в этом случае возникает риск, что возможная поломка федерации (на стороне облака или клиента) приведет к невозможности управлять организацией с помощью любого из федеративных аккаунтов.

Инструкция содержит действия по митигации риска, связанного с поломкой федерации.

## Основные действия {#main-steps}

1. Создайте [федерацию](../../../organization/add-federation.md).  
1. Проверьте работу федерации, войдя от имени одного из федеративных пользователей.
1. Назначьте роль `organization-manager.organizations.owner` федеративному пользователю:

    {% list tabs %}

    - CLI

        ``` yc
        yc organization-manager organization add-access-binding \
            --id= <идентификатор организации> \
            --subject= federatedUser:<идентификатор федеративного аккаунта> \
            --role=organization-manager.organizations.owner 
        ```

    {% endlist %}

1. Создайте служебное облако `security`.
1. Назначьте роль `admin` на облако `security` офицерам безопасности, которые смогут восстановить доступ к облаку в случае поломки федерации.
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) в облаке `security` для резервного восстановления доступа к организации.

    Если вы используете уже существующий сервисный аккаунт, убедитесь, что у него отсутствуют [статические](../../../iam/concepts/authorization/access-key.md) и [API-ключи](../../../iam/concepts/authorization/api-key.md).

    {% list tabs %}

    - CLI

        ``` yc
        yc iam api-key list --service-account-id=<идентификатор сервисного аккаунта> 
        yc iam access-key list --service-account-id=<идентификатор сервисного аккаунта> 
        ```

    {% endlist %}

    {% note warning %}

    Офицер безопасности имеет возможность повысить себе роль вплоть до `organization-manager.organizations.owner` за счет того, что он контролирует сервисный аккаунт, которому назначена такая роль. Убедитесь, что в административный доступ к облаку `security` и сервисному аккаунту есть только у офицеров безопасности, для этого выполните команду:

    {% list tabs %}

    - CLI

        ``` yc
        yc iam service-account list-access-bindings --id <идентификатор сервисного аккаунта>
        ```

    {% endlist %}

    Учитывайте, что сервисным аккаунтом смогут управлять все пользователи с ролью `admin` на каталог, облако или организацию, где расположен этот сервисный аккаунт. Таким образом, эти пользователи также смогут повысить себе роль вплоть `organization-manager.organizations.owner`. Следите, чтобы роль `admin` на сервисный аккаунт, а также на каталог, облако, организацию, где он расположен, была только у доверенных пользователей.

    {% endnote %}

1. Назначение сервисному аккаунту роль `resource-manager.organization.owner`:  

    {% list tabs %}

    - CLI

        ``` yc
        yc organization-manager organization add-access-binding \
            --id= <идентификатор организации> \
            --service-account-id=<идентификатор сервисного аккаунта> \
            --role=organization-manager.organizations.owner 
        ```

    {% endlist %}

1. [Создайте авторизованный ключ](../../../iam/operations/iam-token/create-for-sa.md#via-cli) для сервисного аккаунта.
1. Сохраните файл ключа в доверенном хранилище.
1. Удалите роль `resource-manager.organization.owner` у паспортного аккаунта через консоль или интерфейс командной строки:

    {% list tabs %}

    - CLI

        ``` yc
        yc organization-manager organization remove-access-binding \
            --id=<идентификатор организации> \
            --user-account-id=<идентификатор паспортного аккаунта> \
            --role=organization-manager.organizations.owner 
        ```

    {% endlist %}

## Дополнительные меры {#additional-measures}

Настройте Audit trails на действия с сервисным аккаунтом и федеративной учетной записью, которые обладают ролью `resource-manager.organization.owner`:

1. [Настройте сбор аудитных логов с уровня организации](../../../audit-trails/quickstart.md) в Audit Trails .
1. Отслеживайте как минимум следующие события (в [Object Storage](../../../audit-trails/tutorials/search-bucket.md), [лог-группе](../../../audit-trails/tutorials/search-cloud-logging.md), [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main), [в вашем SIEM](../../../audit-trails/concepts/export-siem.md)):

    * Создание ключей для сервисного аккаунта (события: `yandex.cloud.audit.iam.CreateAccessKey`, `yandex.cloud.audit.iam.CreateKey`, `yandex.cloud.audit.iam.CreateApiKey` и `authentication.subject_id = <идентификатор сервисного аккаунта>`).
    * Назначение прав доступа на сервисный аккаунт (событие: `UpdateServiceAccountAccessBindings` и `details.service_account_id = <идентификатор сервисного аккаунта>`).
    * Любое действие с правами `resource-manager.organization.owner` (`.authentication.subject_id == <идентификатор пользователя с данными правами>`).

Для анализа и реагирования на события в {{ at-name }} можно использовать [Managed ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main).

## Действия в случае поломки федерации {#federation-repair}

1. Получите доступ к сохраненному в доверенном хранилище авторизованному ключу.
1. [Аутентифицируйтесь](../../../cli/operations/authentication/service-account.md#auth-as-sa) от имени сервисного аккаунта.
1. Далее:
    * Либо назначьте роль `resource-manager.organization.owner` паспортной учетной записи и с ее помощью восстановите федерацию.
    * Либо восстановите федерацию из интерфейса командной строки CLI.
1. Проверьте доступ от лица федеративного пользователя.

## Действия после восстановления федерации {#after-federation-repairation}

1. Если паспортной учетной записи была выдана роль `resource-manager.organization.owner` — [отзовите роль](../../../iam/operations/roles/revoke.md).
1. Создайте новый авторизованный ключ для сервисного аккаунта и сохраните его в доверенном хранилище.
