---
title: Как получить список OIDC-приложений в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете получить список OIDC-приложений в {{ org-name }}.
---

# Получить список OIDC-приложений в {{ org-full-name }}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.

     Отобразятся все [OIDC-приложения](../../concepts/applications.md#oidc), доступные в вашей организации.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка [OIDC-приложений](../../concepts/applications.md#oidc):

     ```bash
     yc organization-manager idp application oauth application list --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список OIDC-приложений.

     Результат:

     ```text
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     |          ID          |        NAME        |   ORGANIZATION ID    |          DESCRIPTION           | STATUS |          GROUP CLAIMS SETTINGS          |           CLIENT GRANT           | LABELS |     CREATED AT      |     UPDATED AT      |
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     | ek0o663g4rs2******** | oidc-app           | bpf2c65rqcl8******** |                                | ACTIVE | group_distribution_type:NONE            | client_id:"ajeqqip130i1********" |        | 2025-10-21 10:51:28 | 2025-10-22 11:53:21 |
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     ```

{% endlist %}