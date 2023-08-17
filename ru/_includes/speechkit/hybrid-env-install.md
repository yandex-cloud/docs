1. {% include [cli-install](../cli-install.md) %}
1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md) в {{ container-registry-full-name }}.

   {% include [default-catalogue](../default-catalogue.md) %}

   ```bash
   yc container registry create --name speechkit-hybrid
   ```

   Результат:

   ```text
   id: <идентификатор реестра>
   folder_id: <идентификатор каталога>
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "<дата и время создания>"
   ```

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `{{ roles-editor }}` на выбранный каталог.
1. [Создайте API-ключ](../../iam/operations/api-key/create.md) для сервисного аккаунта.
1. Сообщите идентификатор созданного реестра команде {{ speechkit-name }}. В вашем реестре появятся все необходимые контейнеры, и вам предоставят файл `docker-compose.yaml` с настройками развертывания.
