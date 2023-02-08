---
title: "Tutorial on changing\_the organization for the cloud in {{ resmgr-full-name }}"
description: "In this tutorial, you'll learn how to change the organization for the cloud in {{ resmgr-full-name }}."
---

# Changing an organization for a cloud

{% if product == "yandex-cloud" %}
{% note info %}

In the [management console]({{ link-console-main }}), you can select the interface of navigating resources and services. To switch to another navigation mode: in the account information section, click ![image](../../../_assets/settings.svg), then select ![image](../../../_assets/experiments.svg) **Experiments** and enable **New navigation**.

{% endnote %}

To change the organization assigned to the cloud:

{% list tabs %}

- Old navigation

  1. In the [management console]({{ link-console-main }}) click ![***](../../../_assets/options.svg) next to the appropriate cloud and select **Change organization**.

      ![image](../../../_assets/iam/cloud-actions.png)

  1. Select a new organization from the list and click **Change**.

- New navigation

{% endif %}
{% if product == "cloud-il" %}
{% note info %}

At the [Preview](../../../overview/concepts/launch-stages.md) stage, the following limitation applies: only one organization and one cloud are available.

{% endnote %}

{% list tabs %}
- Management console

{% endif %}
  1. In the [management console]({{ link-console-main }}), select the cloud from the list on the left.
  1. In the upper-right corner, click ![***](../../../_assets/options.svg)and select **Change organization**.

   ![image](../../../_assets/iam/change-organization-n-n.png)

  1. Select a new organization from the list and click **Change**.

{% endlist %}