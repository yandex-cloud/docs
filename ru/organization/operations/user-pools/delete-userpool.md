---
title: Как удалить пул пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете удалить пул пользователей в {{ org-name }}.
---

# Удалить пул пользователей


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. В строке с нужным [пулом пользователей](../../concepts/user-pools.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление пула пользователей.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool delete <идентификатор_пула>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с описанием [пула пользователей](../../concepts/user-pools.md):

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

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_userpool` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} удалит все требуемые ресурсы. Проверить удаление ресурсов можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc organization-manager idp userpool list --organization-id <идентификатор_организации>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Delete](../../idp/api-ref/Userpool/delete.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Delete](../../idp/api-ref/grpc/Userpool/delete.md).

{% endlist %}