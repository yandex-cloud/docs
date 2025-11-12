---
title: How to get a list of OIDC apps in {{ org-full-name }}
description: Follow this guide to get a list of OIDC apps in {{ org-name }}.
---

# Getting a list of OIDC apps in {{ org-full-name }}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.

     This will display all [OIDC apps](../../concepts/applications.md#oidc) available in your organization.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get a list of [OIDC apps](../../concepts/applications.md#oidc):

     ```bash
     yc organization-manager idp application oauth application list --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp application oauth application list --organization-id <organization_ID>
     ```

     Where `--organization-id` is the [ID of the organization](../organization-get-id.md) you need the list of OIDC apps for.

     Result:

     ```text
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     |          ID          |        NAME        |   ORGANIZATION ID    |          DESCRIPTION           | STATUS |          GROUP CLAIMS SETTINGS          |           CLIENT GRANT           | LABELS |     CREATED AT      |     UPDATED AT      |
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     | ek0o663g4rs2******** | oidc-app           | bpf2c65rqcl8******** |                                | ACTIVE | group_distribution_type:NONE            | client_id:"ajeqqip130i1********" |        | 2025-10-21 10:51:28 | 2025-10-22 11:53:21 |
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     ```

{% endlist %}