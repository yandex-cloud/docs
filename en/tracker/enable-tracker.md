# Activating {{ tracker-full-name }}

If you're not using {{ tracker-full-name }} yet, you can activate the service to manage your organization's issues. To getting started with {{ tracker-name }}, you need to create a [company{{ yandex-cloud }}](../organization/). If you already have one, connect it to {{ tracker-name }}. If you don't have a company yet, you can create one when you activate {{ tracker-name }}.

{% note warning %}

Only users who have a Yandex account can activate {{ tracker-name }}.

If your organization's admin has already activated {{ tracker-name }}, [log in](user/login.md) to the service to start managing issues.

{% endnote %}

{% list tabs %}

- Web interface

   1. Log in to your [Yandex account]({{ link-passport }}). If you don't have an account yet, [create]({{ support-passport-create }}) it.

   1. Go to the [{{ tracker-name }} main page]({{ link-tracker-promo }}) and click **Try for free**.

   1. If you're the admin for one or more companies in {{ yandex-cloud }}, select the company you wish to connect to {{ tracker-name }} and click **Log in**.

      If you have no organization in {{ yandex-cloud }} or you want to create a new one, specify a name for your organization, add its description, and click **Create**.

      {{ tracker-full-name }} is automatically activated for the organization you selected or created. For more information about managing organizations, see the  [{{ org-full-name }}](../organization/) documentation.

- Mobile app

   1. Open the [{{ tracker-name }} mobile app](mobile.md) and choose **Log in to Yandex account**.

   1. Log in to your [Yandex account]({{ link-passport }}). If you don't have an account yet, [create]({{ support-passport-create }}) it.

      * If you don't have an organization in {{ yandex-cloud }}, the {{ tracker-full-name }} activation window opens. Accept the {{ yandex-cloud }} terms of use and tap **Log in**. Your organization is automatically created and {{ tracker-full-name }} is activated.

      * If {{ tracker-name }} is not enabled for your organization yet, it will be activated automatically the first time you log in to the mobile app.

      For more information about managing organizations, see the [{{ org-full-name }}](../organization/) documentation.

   1. To configure {{ tracker-full-name }}, go to the [web interface]({{ link-tracker }}). Some {{ tracker-name }} features aren't available in the [mobile app](mobile.md#restrictions).

{% endlist %}

## Getting started with {{ tracker-name }} {#setup}

To get started, configure {{ tracker-full-name }} via the web interface:

1. [Add your organization's employees to {{ tracker-name }}](add-users.md).

1. Your employees will need [full access to {{ tracker-name }}](access.md) in order to manage issues.

1. [Configure {{ tracker-name }} for your team](quick-start.md).

