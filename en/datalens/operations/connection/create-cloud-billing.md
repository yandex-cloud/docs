---
title: How to create a {{ yandex-cloud }} Billing connection
description: Follow this guide to create a {{ yandex-cloud }} Billing connection.
---

# Creating a {{ yandex-cloud }} Billing connection

You can only access statistics in the billing accounts where you have the `{{ roles-viewer }}`, `{{ roles-editor }}`, or `{{ roles-admin }}` role. See [Access management](../../../billing/security/index.md#primitive-roles).
Access to a billing account is granted to a user or service account [on the list of users](../../../billing/security/index.md#set-member-role) of the selected account. See [this detailed guide](../../../billing/security/index.md#set-role).

To create a {{ yandex-cloud }} Billing connection:

1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **{{ yandex-cloud }} Billing** connection.
1. Select **Automatically create dashboard, charts, and dataset on top of connection** if you want to get a ready-made {{ yandex-cloud }} Billing Dashboard with a dataset and a set of charts.
1. Click **Create connection**.
1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.