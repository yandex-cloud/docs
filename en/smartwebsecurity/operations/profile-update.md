---
title: "How to edit basic parameters of a {{ sws-full-name }} security profile"
description: "Follow this guide to edit basic parameters of a {{ sws-full-name }} security profile."
---

# Editing basic parameters in a security profile

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the profile row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
   1. In the window that opens, edit the parameters:

      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      * **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
      * **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}**: Select or create an [ARL profile](../concepts/arl.md).
      * Select or create a [{{ captcha-name }}](../../smartcaptcha/) to verify suspicious requests.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/quickstart.md) command for editing [security profile](../concepts/profiles.md) basic parameters:

      ```bash
      yc smartwebsecurity security-profile update --help
      ```

   1. To view a list of current security profiles in the default folder, run this command:

      {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

   1. To edit basic parameters for a security profile, run this command:

      ```bash
      yc smartwebsecurity security-profile update \
         --name <security_profile_name> \
         --new-name <new_name_for_security_profile> \
         --description "<profile_description>" \
         --labels <key_of_label_1>=<value_of_label_1>,<key_of_label_2>=<value_of_label_2>,...,<key_of_label_n>=<value_of_label_n> \
         --default-action <action> \
         --captcha-id <CAPTCHA_ID> \
         --security-rules-file <path_to_file_with_security_rules>
      ```

      Where:

      * `--name`: Security profile name. This is a required parameter. Instead of the security profile name, you can provide its ID in the `--id` parameter.
      * `--new-name`: New name for the security profile. This is an optional parameter if the profile name remains unchanged.
      * `--description`: Text description of the security profile. This is an optional parameter.
      * `--labels`: List of [labels](../../resource-manager/concepts/labels.md) to add to the profile in `KEY=VALUE` format. This is an optional parameter. For example, it may take the following value: `--labels foo=baz,bar=baz'`.
      * `--default-action`: Action to perform for traffic that mismatches the criteria of other rules. This is an optional parameter. The default value is `allow`, which allows all requests to the service. To block requests, set the parameter to `deny`.
      * `--captcha-id`: ID of the CAPTCHA in [{{ captcha-name }}](../../smartcaptcha/) to verify suspicious requests. This is an optional parameter.
      * `--security-rules-file`: Path to the [YAML](https://en.wikipedia.org/wiki/YAML) file with security rules. This is an optional parameter. For example:

         {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

      Result:

      ```bash
      id: fev6q4qqnn2q********
      folder_id: b1g07hj5r6i********
      cloud_id: b1gia87mbaom********
      name: my-sample-profile
      new-name: my-update-profile
      description: "my update description"
      labels: label1=value1,label2=value2
      default_action: DENY
      created_at: "2024-07-25T19:21:05.039610Z"
      ```

   For more information about the `yc smartwebsecurity security-profile update` command, see the [CLI reference](../../cli/cli-ref/managed-services/smartwebsecurity/security-profile/update.md).

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)
