---
title: Создание нового облака
description: Следуя данной инструкции, вы сможете создать новое облако.
---

# Создание нового облака

[При регистрации](../../../billing/quickstart/index.md#create_billing_account) для вас будет автоматически создано [облако](../../concepts/resources-hierarchy.md#cloud) с именем `cloud-<Яндекс_ID>`. После того как вы привязали платежный аккаунт, вы сможете создать дополнительное облако.

Чтобы создать дополнительное облако:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../../../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account) или попросите вашего администратора назначить вам роль `billing.accounts.member` на платежный аккаунт.
  1. Перейдите в [консоль управления]({{ link-console-main }}).
  1. В левом верхнем углу рядом в полем **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** нажмите значок ![plus](../../../_assets/console-icons/plus.svg). В открывшемся окне:
  
      1. Задайте имя облака. Требования к имени:

          {% include [name-format.md](../../../_includes/name-format.md) %}
      1. Если у вас несколько организаций, выберите нужную.
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% note info %}

  Чтобы создать новое облако с помощью {{ yandex-cloud }} CLI, [привяжите](../../../cli/operations/profile/manage-properties.md#set) организацию к [профилю CLI](../../../cli/operations/profile/profile-list.md).

  {% endnote %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды для создания облака:

      ```bash
      yc resource-manager cloud create --help
      ```

  1. Если у вас еще нет привязанной организации, привяжите организацию, в которой вы хотите создать облако, к профилю CLI:

      ```bash
      yc config set organization-id <идентификатор_организации>
      ```

      Где `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой вы создаете облако.

  1. Выполните команду, чтобы создать облако:

      ```bash
      yc resource-manager cloud create \
        --name <имя_облака> \
        --billing-account-id <идентификатор_платежного_аккаунта>
      ```

      Где:

      * `--name` – имя создаваемого облака. Требования к имени:

          {% include [name-format.md](../../../_includes/name-format.md) %}
      * `--billing-account-id` – идентификатор [платежного аккаунта](../../../billing/concepts/billing-account.md), к которому будет привязано создаваемое облако.

          Идентификатор платежного аккаунта можно узнать в [интерфейсе {{ billing-name }}]({{ link-console-billing }}) в блоке **{{ ui-key.yacloud_billing.billing.account.dashboard-info.title_main }}** на странице нужного платежного аккаунта.

      Результат:

      ```text
      done (4s)
      id: b1gbi30tq0m9********
      created_at: "2024-12-10T09:25:22Z"
      name: my-new-cloud
      organization_id: bpfaidqca8vd********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note warning %}

  Обязательно привяжите облако к платежному аккаунту, чтобы сделать облако активным. Создаваемое облако будет находиться в статусе `Creating`, пока к нему не будет привязан платежный аккаунт. Для привязки облака к платежному аккаунту используйте ресурс `yandex_billing_cloud_binding` с указанием идентификатора облака в поле `cloud_id`.

  {% endnote %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      # Создание облака

      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "<имя_облака>"
        organization_id = "<идентификатор_организации>"
      }

      # Привязка облака к платежному аккаунту

      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<идентификатор_платежного_аккаунта>"
        cloud_id           = yandex_resourcemanager_cloud.cloud1.id
      }
      ```

      Где:

      * `name` — имя облака. Требования к имени:
      
        {% include [name-format.md](../../../_includes/name-format.md) %}
        
      * `organization_id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации. {{ TF }} позволяет создать облако только для существующей организации.
      * `billing_account_id` — идентификатор [платежного аккаунта](../../../billing/concepts/billing-account.md), к которому будет привязано создаваемое облако.

          [Идентификатор платежного аккаунта](../../../billing/concepts/billing-account.md#billing-account-id) можно узнать в [интерфейсе {{ billing-name }}]({{ link-console-billing }}) в блоке **{{ ui-key.yacloud_billing.billing.account.dashboard-info.title_main }}** на странице нужного платежного аккаунта.
      * `cloud_id` — [идентификатор](../../../resource-manager/operations/cloud/get-id.md) облака, которое будет привязано к платежному аккаунту.

      Более подробную информацию о параметрах ресурсов `yandex_resourcemanager_cloud` и `yandex_billing_cloud_binding` в {{ TF }}, см. в [документации провайдера]({{ tf-docs-link }}).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в организации будет создано облако, привязанное к платежному аккаунту. Проверить облако и его параметры можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc resource-manager cloud list
    ```

- API {#api}

  Чтобы создать облако, воспользуйтесь методом REST API [create](../../api-ref/Cloud/create.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/Create](../../api-ref/grpc/Cloud/create.md).

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
