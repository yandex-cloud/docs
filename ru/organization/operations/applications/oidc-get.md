---
title: Как получить информацию об OIDC-приложении в {{ org-full-name }}
description: Следуя данной инструкции, вы получите информацию об OIDC-приложении в {{ org-name }}.
---

# Получить информацию об OIDC-приложении в {{ org-full-name }}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Нажмите на строку с [OIDC-приложением](../../concepts/applications.md#oidc), о котором вы хотите получить информацию.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об [OIDC-приложении](../../concepts/applications.md#oidc):

     ```bash
     yc organization-manager idp application oauth application get --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-22T11:53:21.689383Z"
     ```

{% endlist %}