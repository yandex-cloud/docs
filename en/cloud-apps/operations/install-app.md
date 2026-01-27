---
title: How to install {{ cloud-apps-name }}
description: Follow this guide to deploy a {{ yandex-cloud }} app.
---

# Installing {{ cloud-apps-name }}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
    1. Select **{{ ui-key.yacloud.component.navigation-menu.label_cloud-apps }}**.
    1. In the left-hand panel, select **{{ ui-key.yacloud.cloud-apps.label_marketplace }}**.
    1. Select the app and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
    1. Enter the application name and select a service account. This service account will deploy all your application's resources, so it needs the permissions to manage them. These include permissions to create {{ sf-name }} or assign folder access permissions to another service account. To create a service account with the `admin` role for the folder, select `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`.
    1. Configure the app settings.
    1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}**.

    The required {{ yandex-cloud }} resources will be automatically created in the selected folder.

{% endlist %}
