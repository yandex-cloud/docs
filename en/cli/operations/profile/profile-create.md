# Creating a profile

There are two ways to create a profile:
- [Creating an empty profile and adding parameters manually](#create).

   This creates and activates an empty profile: you have to [add all the parameters separately](manage-properties.md).
- [Wizard-based profile creation with basic parameters](#interactive-create).

   The CLI suggests setting the basic profile parameters step-by-step. You can use this method to redefine the parameters of an existing profile. This method doesn't work for service accounts.

## Creating an empty profile and adding parameters manually {#create}

Create a profile with the `test` name:
1. Run the command:

   ```bash
   yc config profile create test
   ```

   Result:

   ```text
   Profile 'test' created and activated
   ```

{% if product == "cloud-il" %}

1. Add the domain name and port for requests to {{ yandex-cloud }} to your profile:

   ```bash
   yc config set endpoint {{ api-host }}:443
   ```

{% endif %}

1. Add the necessary profile parameters, such as a folder:

   ```bash
   yc config set folder-id <folder ID>
   ```

   View the full [list of profile parameters](../../concepts/core-properties.md) and learn how to [manage](manage-properties.md) them.

You can view an example of this type of profile when [getting started](../../quickstart.md).

## Wizard-based profile creation with basic parameters {#interactive-create}

{% if product == "cloud-il" %}

Wizard-based profile creation is available:

* For users with a Google account:

   ```bash
   yc init \
     --endpoint {{ api-host }}:443 \
     --federation-endpoint {{ console-host }} \
     --federation-id google
   ```

   For more information, see [{#T}](../authentication/user.md).

* For federated users:

   ```bash
   yc init \
     --endpoint {{ api-host }}:443 \
     --federation-endpoint {{ console-host }} \
     --federation-id <federation ID>
   ```

   For more information, see [{#T}](../authentication/federated-user.md).

You can't run the `yc init` command without the `--endpoint`, `--federation-endpoint`, and `--federation-id` parameters.

{% endif %}

{% if product == "yandex-cloud" %}

If you use the wizard to create a profile, the CLI prompts you to enter the basic profile parameters step-by-step:
- Profile name.
- OAuth token.
- The cloud you have access rights to.
- Default folder.
- Default availability zone where {{ compute-full-name }} resources are created.

You can stop profile creation at any time. All the settings you entered before stopping are saved to the profile.

{% if audience == "internal" %}

{% note warning %}

These instructions describe the installation of the internal CLI build (from s3.mds.yandex.net) rather than the external one (from storage.yandexcloud.net). If you are using the external CLI build, follow [these instructions](../../../mdb/cli.md).

If you already have the CLI installed, use the `yc version` command to find out which build you have. If the version contains `+yandex`, the build is internal. Otherwise, it is external.

{% endnote %}

{% endif %}

If you aren't connected to the management console yet, log in to the [console]({{ link-console-main }}) and accept the user agreement by clicking **Log in**.

{% list tabs %}

- As a user

   {% include [include](../../../_includes/cli/create-profile.md) %}

- As a federated user

   {% include [include](../../../_includes/cli/auth-federated-user.md) %}

{% endlist %}

{% endif %}
