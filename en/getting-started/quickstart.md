# Getting started with {{ yandex-cloud }}

To get access to {{ yandex-cloud }}, a system administrator should submit a request. If the request is approved, they are granted access to the management console and can create accounts for other employees of your company.

## Step 1. Filling out the application form {#leave-request}

To submit a request:

1. In the [management console]({{ link-console-main }}), click **Get started** and then click **Log in using Google** in the window that opens.

   You'll see the Google authentication window.

1. Log in.

   {% note alert %}

   The account you're authenticating with will be used to log in to the console. It will be assigned the [organization owner](../iam/concepts/access-control/roles.md#owner) role. The organization owner creates accounts for all other employees, manages these accounts, sets up access permissions, and enables/disables services.

   {% endnote %}

   Select or specify the desired account.

1. Read the [Privacy Policy](../legal/privacy.md) and [Terms of Use](../legal/terms.md) and consent to receive marketing materials and other messages from {{ yandex-cloud }}.

1. Click **Log in**.

   This opens the application form.

1. Fill out the form.

   Enter your full name, your corporate email address, and a contact phone number as well as your organization information. Also describe how you intend to use {{ yandex-cloud }} services. This information will help us make a decision on whether to reject or accept your request.

1. Click **Send request**.

As soon as we review your request, you'll receive a message to your organization's corporate email address notifying you of the results and providing further instructions.

## Step 2. First log-in to the {{ yandex-cloud }} management console {#cloud-init}

After your request is approved, log in to the {{ yandex-cloud }} [management console]({{ link-console-main }}) with the same Google account as you used when filling out the application form.

This opens a window where you can create your first cloud. If necessary, edit the cloud name and click **Create**. This automatically creates an organization in {{ yandex-cloud }}. [Learn more about organizations in {{ yandex-cloud }}](../organization).

{% note info %}

At the [Preview](../overview/concepts/launch-stages.md) stage, the following limitation applies: only one organization and one cloud are available.

{% endnote %}

## Step 3. Setting up your cloud {#configure-cloud}

Create accounts for your company employees, set up a hierarchy of resources, and configure access to these resources. For more information, see the following sections in the documentation:

- [Managing user accounts](../organization/manage-users) and [Managing identity federations](../organization/add-federation)
- [{{ yandex-cloud }} resource hierarchy](../resource-manager/concepts/resources-hierarchy.md)
- [Identification and access control to cloud resources](../iam)

## Employee authentication {#auth}

Find out from your system administrator what account management system is set up for your organization in {{ yandex-cloud }}. In the [management console]({{ link-console-main }}), click **Get started** and log in using one of the following ways:

{% list tabs %}

- Google account

   A system administrator will send an invitation to join the organization to your Google account email.

   1. To open the invitation, click the link in the email message. Accept the invitation.

   1. Read the [Privacy Policy](../legal/privacy.md) and [Terms of Use](../legal/terms.md) and consent to receive marketing materials and other messages from {{ yandex-cloud }}.

   1. To go to the {{ yandex-cloud }} console, confirm adding your account to the organization by clicking **Log in**.

   1. Select your organization from the list and click **Next**.

- Identity federation

   1. In the window that opens, click **Log in via SSO**.

   1. Log in.

      Specify the federation ID and the username of the account that the system administrator created for you.

   1. Read the [Privacy Policy](../legal/privacy.md) and [Terms of Use](../legal/terms.md) and consent to receive marketing materials and other messages from {{ yandex-cloud }}.

   1. Click **Log in**.

{% endlist %}

