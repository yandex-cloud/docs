---
title: Удалить федерацию удостоверений в {{ org-full-name }}
description: Из этой статьи вы узнаете, как удалить федерацию удостоверений в {{ org-full-name }}.
---

# Удалить федерацию удостоверений

{% note info %}

Удалить федерацию удостоверений может пользователь с [ролью](../security/index.md#organization-manager-organizations-owner) `organization-manager.organizations.owner`.

{% endnote %}

Чтобы удалить федерацию удостоверений:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  1. В строке с федерацией удостоверений нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды удаления группы пользователей {{ org-full-name }}:

      ```bash
      yc organization-manager federation saml delete --help
      ```

  1. Получите список федераций в организации:

     ```bash
     yc organization-manager federation saml list \
       --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](organization-get-id.md), в которой нужно получить список федераций.
  
  1. Чтобы удалить федерацию удостоверений, выполните команду:

      ```bash
      yc organization-manager federation saml delete <имя_или_идентификатор_федерации>
      ```

- API {#api}

    Воспользуйтесь методом REST API [Federation.delete](../saml/api-ref/Federation/delete.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Delete](../saml/api-ref/grpc/Federation/delete.md).

{% endlist %}