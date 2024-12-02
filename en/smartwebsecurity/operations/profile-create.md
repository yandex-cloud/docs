---
title: How to create a {{ sws-full-name }} security profile
description: Follow this guide to create a {{ sws-full-name }} security profile.
---

# Creating a security profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your [security profile](../concepts/profiles.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
  1. Select one of the creation options:
      * **{{ ui-key.yacloud.smart-web-security.title_default-template }}** (recommended). A preset profile includes:

        * [Basic default rule](../concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](../concepts/rules.md#rule-action).
        * [Smart Protection rule](../concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.
      * **{{ ui-key.yacloud.smart-web-security.title_no-template }}**. This profile includes only the basic default rule enabled for all traffic.

  1. Enter the profile name.
  1. (Optional) Enter a description.
  1. (Optional) Add [labels](../../resource-manager/concepts/labels.md) for your profile.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select an action to be applied to the traffic that mismatches the criteria of other rules: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
  1. Select or create an [ARL profile](../operations/arl-profile-create.md) to limit the number of requests.
  1. Select or create a [{{ captcha-full-name }}](../../smartcaptcha/) to verify suspicious requests:

        {% include [captcha-integration](../../_includes/smartwebsecurity/captcha-integration.md) %}

  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. In the rule creation window:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

  1. Add all relevant rules to the profile one by one.

      The rules you created will appear under **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** in the table.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../cli/quickstart.md) command for creating a [security profile](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile create --help
     ```

  1. To create a security profile, run this command:

     ```bash
     yc smartwebsecurity security-profile create \
        --name <security_profile_name> \
        --description "<profile_description>" \
        --labels <label_1_key>=<label_1_value>,<label_2_key>=<label_2_value>,...,<label_n_key>=<label_n_value> \
        --default-action <action> \
        --captcha-id <CAPTCHA_ID> \
        --security-rules-file <path_to_file_with_rules>
     ```

     Where:

     * `--name`: Security profile name. This is a required parameter. If you specify only the profile name without additional parameters, a single [basic rule](../concepts/rules.md#base-rules) will be created in the security profile.
     * `--description`: Text description of the security profile. This is an optional parameter.
     * `--labels`: List of [labels](../../resource-manager/concepts/labels.md) to add to the profile in `KEY=VALUE` format. This is an optional parameter. For example: `--labels foo=baz,bar=baz'`.
     * `--default-action`: Action to perform for the traffic that mismatches the criteria of other rules. This is an optional parameter. The default value is `allow`, which allows all requests to the service. To block requests, set the parameter to `deny`.
     * `--captcha-id`: ID of the CAPTCHA in [{{ captcha-full-name }}](../../smartcaptcha/) to verify suspicious requests. This is an optional parameter.
      * `--security-rules-file`: Path to the [YAML](https://en.wikipedia.org/wiki/YAML) file with security rule description. This is an optional parameter. For example:

          {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

     Result:

     ```text
     id: fev6q4qqnn2q********
     folder_id: b1g07hj5r6i********
     cloud_id: b1gia87mbaom********
     name: my-sample-profile
     description: "my description"
     labels: label1=value1,label2=value2
     default_action: DENY
     created_at: "2024-07-25T19:21:05.039610Z"
     ```

  For more information about the `yc smartwebsecurity security-profile create` command, see the [CLI reference](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/create.md).

- API {#api}

  Use the [create](../api-ref/SecurityProfile/create.md) REST API method for the [SecurityProfile](../api-ref/SecurityProfile/) resource or the [SecurityProfileService/Create](../api-ref/grpc/SecurityProfile/create.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](host-connect.md)
* [{#T}](profile-update.md)
* [{#T}](profile-delete.md)