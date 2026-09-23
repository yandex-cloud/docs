---
title: Удалить аккаунт пользователя из организации {{ org-full-name }}
description: Из этой статьи вы узнаете, как удалить аккаунт пользователя из организации {{ org-full-name }}.
---

# Удалить аккаунт пользователя

Удалить аккаунт из организации может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [{#T}](../security/index.md#add-role).

{% note tip %}

Отменить удаление аккаунта пользователя из [организации](../concepts/organization.md) невозможно. Чтобы вернуть пользователя, который ранее был удален, повторно [добавьте](add-account.md) его в организацию.

{% endnote %}

## Удалить пользователя с аккаунтом на Яндексе {#yandex-and-federated}

Чтобы удалить из организации пользователя [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

      ```bash
      yc organization-manager user remove --help
      ```

  1. Удалите членство пользователя в организации:

      ```bash
      yc organization-manager user remove \
        --organization-id <идентификатор_организации> \
        --subject-id <идентификатор_пользователя>
      ```

      Укажите [идентификатор организации](organization-get-id.md) и [идентификатор пользователя](users-get.md). Оба параметра обязательны для этого примера.

- API {#api}

    Воспользуйтесь методом REST API [deleteMembership](../api-ref/User/deleteMembership.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/DeleteMembership](../api-ref/grpc/User/deleteMembership.md).

{% endlist %}

## Удалить федеративного пользователя {#federated}

Чтобы удалить из организации [федеративного пользователя](../../iam/concepts/users/accounts.md#saml-federation):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

      ```bash
      yc organization-manager user remove --help
      ```

  1. Удалите членство пользователя в организации:

      ```bash
      yc organization-manager user remove \
        --organization-id <идентификатор_организации> \
        --subject-id <идентификатор_пользователя>
      ```

      Укажите [идентификатор организации](organization-get-id.md) и [идентификатор пользователя](users-get.md). Оба параметра обязательны для этого примера.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. В конфигурации, управляющей федеративным пользователем, удалите блок `yandex_organizationmanager_saml_federation_user_account` этого пользователя и ссылки на него. Это удаляет членство пользователя в организации, но не его учетную запись у поставщика удостоверений.

     Подробная информация о ресурсе `yandex_organizationmanager_saml_federation_user_account` приведена в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_saml_federation_user_account).

  1. Примените изменения, проверив список удаляемых ресурсов в плане:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом REST API [deleteMembership](../api-ref/User/deleteMembership.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/DeleteMembership](../api-ref/grpc/User/deleteMembership.md).

{% endlist %}

{% note info %}

После удаления из организации [федеративного пользователя](../../iam/concepts/users/accounts.md#saml-federation) он удаляется из федерации и высвобождает использованные квоты. Если в федерации включено автоматическое создание пользователей, удаленный пользователь может выполнить вход в [организацию](../concepts/organization.md) и вновь [стать ее членом](../concepts/membership.md). Чтобы исключить такую возможность, удалите или заблокируйте этого пользователя в IdP.

{% endnote %}

## Удалить локального пользователя {#local}

Чтобы удалить из организации [локального](../../iam/concepts/users/accounts.md#local) пользователя:


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [delete-user-ui](../../_includes/organization/delete-user-ui.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления пользователя из [пула](../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user delete --help
     ```
  1. {% include [cli-list-userpools](../../_includes/organization/cli-list-userpools.md) %}
  1. {% include [cli-userpool-list-users](../../_includes/organization/cli-userpool-list-users.md) %}
  1. Чтобы удалить из организации локального пользователя, передайте его идентификатор в команде:

     ```bash
     yc organization-manager idp user delete <идентификатор_пользователя>
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. В конфигурации, управляющей локальным пользователем, удалите блок `yandex_organizationmanager_idp_user` этого пользователя и ссылки на него. Это удаляет пользователя из пула, а не только его членство в организации.
  1. Примените изменения, проверив список удаляемых ресурсов в плане:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    Воспользуйтесь методом REST API [delete](../idp/api-ref/User/delete.md) для ресурса [User](../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/Delete](../idp/api-ref/grpc/User/delete.md).

{% endlist %}