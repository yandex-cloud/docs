---
title: How to create a test agent in {{ load-testing-full-name }}
description: In this guide, you will learn how to create a test agent.
---

# Creating a test agent

## Setting up the infrastructure {#infrastructure-prepare}

1. Create a service account for your test agent:

    {% include [sa-create](../../_includes/load-testing/sa-create.md) %}
1. [Configure](../../load-testing/operations/security-groups-agent.md) a test agent security group.

## Creating a test agent {#create-agent}

{% note info %}

If you need an agent for one-off use, you can [create](#create-temporal-agent) a temporary agent. A temporary test agent will be created for a particular test and deleted once the test is over.

{% endnote %}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Creating a temporary test agent {#create-temporal-agent}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder for testing.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** section, click **{{ ui-key.yacloud.load-testing.label_agent-temporal-selector }}**.
   1. Under **{{ ui-key.yacloud.load-testing.title_temporal-agent-field }}**:
      * Select a suitable agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).

      {% note warning %}

      To run a temporary test agent, first assign these additional roles to your `sa-loadtest` [service account](../../iam/concepts/users/service-accounts.md): `compute.editor`, `iam.serviceAccounts.user`, `vpc.user`, and `vpc.publicAdmin`.

      {% endnote %}

      * Select the `sa-loadtest` service account.
      * Specify the [subnet](../../vpc/concepts/network.md#subnet) hosting your test target.
      * If you have access to [security groups](../../vpc/concepts/security-groups.md), select a preset agent security group.

{% endlist %}