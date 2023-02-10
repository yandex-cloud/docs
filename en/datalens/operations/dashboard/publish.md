---
title: "Instructions for publishing a dashboard in {{ datalens-full-name }}"
description: "In this tutorial, you'll learn how to publish a dashboard in {{ datalens-full-name }} and share a dashboard that contains Yandex Metrica or AppMetrica data."
---

# Publishing dashboards

Before publishing data, make sure that:

* Your charts and dashboards don't contain any personal data or trade secrets. Access to published data is not restricted.
* You can't publish dashboards and charts built on the [Yandex Metrica API](../connection/create-metrica-api.md) and [AppMetrica](../connection/create-appmetrica.md), but you can [share](#share) them.
* You have administrator rights to published charts and dashboards, as well as related objects.

To publish a dashboard:

1. On the navigation page, find the dashboard and open it.

1. At the top of the dashboard interface, click ![image](../../../_assets/datalens/horizontal-ellipsis.svg) and select ![image](../../../_assets/datalens/share-black.svg) **Public access**.

1. In the window that opens, enable **Access via link**.

1. Select the charts you want to publish with the dashboard.

   {% note info %}

   Granting public access causes frequent queries to the database, so estimate the DB load.

   {% endnote %}

1. Copy the public link and click **Apply**.

## Share a dashboard based on Yandex Metrica or AppMetrica data {#share}

To share a dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}
