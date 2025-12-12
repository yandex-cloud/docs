## Get your cloud ready {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet. For information on how to get started with {{ yandex-cloud }}, see [Getting started with {{ yandex-cloud }}](../../../getting-started/).
1. Accept the user agreement.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../../billing/concepts/billing-account.md) linked and its status is `ACTIVE`. If you do not have a billing account yet, [create one](../../../billing/quickstart/index.md#create_billing_account). If your billing account has the `TRIAL_ACTIVE` status, [activate its paid version](../../../billing/operations/activate-commercial.md).
1. [Assign](../../../iam/operations/roles/grant.md) the `speech-sense.spaces.creator` role to your {{ yandex-cloud }} account.

    {% include [note-managing-roles](../../../_includes/mdb/note-managing-roles.md) %}


### Create a service account {#create-sa}

Create a service account with the `speech-sense.data.editor` [role](../../../speechsense/security/index.md#speechsense-data-editor) for amoCRM access to the {{ speechsense-name }} project.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the [service account](../../../iam/concepts/users/service-accounts.md): `speechsense`.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `speech-sense.data.editor`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}


### Create an API key for the service account {#create-key}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `speechsense` service account.
  1. In the top panel, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** field, click **{{ ui-key.yacloud_portal.filters.action_select-all }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key for later.

      {% note alert %}

      After you close this dialog, the key value will no longer be available.

      {% endnote %}

{% endlist %}


### Create a space and link a billing account {#create-space}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
  1. Click **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
  1. Enter a name for the [space](../../../speechsense/concepts/resources-hierarchy.md#space).
  1. Click **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
  1. [Link a billing account](../../../speechsense/operations/space/link-ba.md) to the space to pay for {{ speechsense-name }}.

      {% include [manage-ba-note](../../../_includes/speechsense/manage-ba-note.md) %}

{% endlist %}


### Add the service account to the space {#add-sa-to-space}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

  1. Navigate to the [new space](#create-space) in the {{ speechsense-name }} [interface]({{ link-speechsense-main }}).
  1. Click ![image](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yc-ui-talkanalytics.team.add-from-organization-key-value }}**.
  1. Copy the ID of the `speechsense` [service account you created earlier](#create-sa) and paste it to the search bar.
  1. Select the `speechsense` service account and specify the [{{ roles-speechsense-data-editor }}](../../../speechsense/security/index.md#speechsense-data-editor) role. This role will allow the service account to upload data to {{ speechsense-name }}.
  1. Click **{{ ui-key.yc-ui-talkanalytics.common.add }}**.

{% endlist %}