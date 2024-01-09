# Создание нового облака


[При регистрации](../../../billing/quickstart/index.md#create_billing_account) для вас будет автоматически создано [облако](../../concepts/resources-hierarchy.md#cloud) с именем `cloud-<Яндекс_ID>`. После того, как вы привязали платежный аккаунт, вы сможете создать дополнительное облако.

Чтобы создать дополнительное облако:



{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../../../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account) или попросите вашего администратора назначить вам роль `billing.accounts.member` на платежный аккаунт.
  1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) выберите платежный аккаунт.
  1. В блоке **{{ ui-key.yacloud.billing.account.dashboard-resources.section_resources }}** нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Введите имя облака. Требования к имени:

       {% include [name-format.md](../../../_includes/name-format.md) %}

  1. Укажите организацию, к которой будет привязано облако.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**. Вы будете перенаправлены на страницу каталога `default` в новом облаке.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Обязательно привяжите облако к платежному аккаунту, чтобы сделать облако активным. Для этого используйте ресурс `yandex_billing_cloud_binding` с указанием на облако в поле `cloud_id`.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "<имя_облака>"
        organization_id = "<идентификатор_организации>"
      }

      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<идентификатор_платежного_аккаунта>"
        cloud_id           = yandex_resourcemanager_cloud.cloud1.id
      }
      ```

      Где:

      * `name` — имя облака. Требования к имени:
      
        {% include [name-format.md](../../../_includes/name-format.md) %}
        
      * `organization_id` — идентификатор организации. {{ TF }} позволяет создать облако только для существующей организации. Перечень идентификаторов организаций можно получить с помощью команды [CLI](../../../cli/quickstart.md): `yc organization-manager organization list`.
      * `billing_account_id` — идентификатор платежного аккаунта.
      * `cloud_id` — идентификатор облака, которое будет привязано к платежному аккаунту.

      Более подробную информацию о параметрах ресурсов `yandex_resourcemanager_cloud` и `yandex_billing_cloud_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-docs-link }}).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в организации будет создано облако, привязанное к платежному аккаунту. Проверить облако и его параметры можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc resource-manager cloud list
    ```

- API {#api}

  Чтобы создать облако, воспользуйтесь методом REST API [create](../../api-ref/Cloud/create.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/Create](../../api-ref/grpc/cloud_service.md#Create).

{% endlist %}

{% note info %}

При создании облака вы автоматически получите роль [владельца](../../concepts/resources-hierarchy.md#owner) в этом облаке.

{% endnote %}

#### См. также {#see-also}

* [{#T}](update.md)
* [{#T}](set-access-bindings.md)
* [{#T}](switch-cloud.md)
* [{#T}](../folder/create.md)
* [{#T}](../../../billing/concepts/billing-account.md)
