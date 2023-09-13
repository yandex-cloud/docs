# Activating {{ tracker-full-name }}

If you aren't using {{ tracker-full-name }} to manage issues in your company, you can connect it. To work in {{ tracker-name }}, you'll need a [{{ yandex-cloud }} organization](../../organization/). If you already have an organization, connect {{ tracker-name }} to it. If you have no organization, you can create it when connecting {{ tracker-name }}.

{% note warning %}

Only the users that have an account on Yandex can connect {{ tracker-name }}.

If the administrator of your organization already connected {{ tracker-name }}, to start working with issues, [log in to the service](../user/login.md).

{% endnote %}

## Running a mobile app {#install}

1. Install the mobile app using your preferred [method](../mobile.md#install).

1. Open the {{ tracker-name }} mobile app and choose **Log in to Yandex account**.

1. Log in to your [Yandex account]({{ link-passport }}). If you do not have an account, [create]({{ support-passport-create }}) one.

   * If you don't have an organization in {{ yandex-cloud }}, the {{ tracker-full-name }} activation window opens. Accept the {{ yandex-cloud }} terms of use and tap **{{ ui-key.startrek.ui_components_PageHiThere.wrong-user-btn }}**. Your organization is automatically created and {{ tracker-full-name }} is activated.

   * If {{ tracker-name }} is not enabled for your organization yet, it will be activated automatically the first time you log in to the mobile app.

   For more information about managing organizations, see the [{{ org-full-name }}](../../organization/) documentation.

1. To set up {{ tracker-full-name }}, go to the [web interface of the service]({{ link-tracker }}). Some {{ tracker-name }} features are not available in the [mobile app](../mobile.md#restrictions).

## Getting started with {{ tracker-name }} {#setup}

To get started, configure {{ tracker-full-name }} via the web interface:

1. [Add your company's employees to {{ tracker-name }}](../add-users.md).

1. Your employees will need [full access to{{ tracker-name }}](../access.md) in order to manage issues.

1. [Configure {{ tracker-name }} for your team](../quick-start.md).