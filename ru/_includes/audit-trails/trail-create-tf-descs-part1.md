* `name` — имя создаваемого трейла. Требования к формату имени:

    {% include [name-format](../name-format.md) %}

* `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создается трейл.
* `description` — описание трейла. Необязательный параметр.
* `labels` — список [меток](../../resource-manager/concepts/labels.md) в формате `ключ=значение`. Необязательный параметр.
* `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, от имени которого трейл собирает и загружает аудитные логи.

    В зависимости от [области сбора](../../audit-trails/concepts/trail.md#collecting-area) аудитных логов [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../../iam/concepts/access-control/roles.md) `audit-trails.viewer` на организацию, облако или каталог, в которых трейл будет собирать аудитные логи.
