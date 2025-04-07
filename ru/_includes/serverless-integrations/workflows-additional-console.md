Раскройте блок **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:

1. Введите имя и описание рабочего процесса. Требования к имени:

    {% include [name-format-2](../name-format.md) %}

1. (Опционально) [Добавьте](../../serverless-integrations/operations/workflows/workflow/label-add.md) метки.
1. (Опционально) [Укажите](../../serverless-integrations/operations/workflows/workflow/network-add.md) облачную сеть.
1. Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [создайте](../../iam/operations/sa/create.md) новый.

    Сервисному аккаунту должны быть назначены роли для доступа к закрытым ресурсам, которые используются в шагах рабочего процесса.

1. (Опционально) [Настройте](../../serverless-integrations/operations/workflows/workflow/logs-write.md) запись логов.