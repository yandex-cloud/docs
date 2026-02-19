---
title: Как редактировать пул пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете редактировать пул пользователей в {{ org-name }}.
---

# Редактировать пул пользователей


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. В строке с нужным [пулом пользователей](../../../organization/concepts/user-pools.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **Изменить**.
  1. Задайте новое название или описание пула пользователей.

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

  1. Задайте новый [домен](../../concepts/domains.md), который будет использоваться, если к пулу не привязаны другие домены.
  1. Добавьте или удалите метки.
  1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool update --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool update <идентификатор_пула> \
       --userpool-name <название_пула> \
       --description <описание_пула> \
       --default-subdomain <домен_по_умолчанию> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:
     
     * `--userpool-name` — новое название пула пользователей. Название должно быть уникальным в рамках организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description` — новое описание пула пользователей.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените параметры [пула пользователей](../../concepts/user-pools.md):

     ```hcl
     resource "yandex_organizationmanager_idp_userpool" "example_userpool" {
       organization_id   = "<идентификатор_организации>"
       name              = "<название_пула>"
       description       = "<описание_пула>"
       default_subdomain = "<домен_по_умолчанию>"
       labels            = {
         <ключ> = "<значение>"
       }
     }
     ```

     Где:

     * `name` — новое название пула пользователей. Название должно быть уникальным в рамках организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description` — новое описание пула пользователей.
     * `default_subdomain` — новый [домен](../../concepts/domains.md) по умолчанию. Будет использоваться, если к пулу не привязаны другие домены.
     * `labels` — новый список [меток](../../../resource-manager/concepts/labels.md).

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_userpool` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} обновит все требуемые ресурсы. Проверить изменения можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager idp userpool get <идентификатор_пула>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Update](../../idp/api-ref/Userpool/update.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Update](../../idp/api-ref/grpc/Userpool/update.md).

{% endlist %}