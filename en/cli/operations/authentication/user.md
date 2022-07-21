# Authenticating as a user

{% if product == "yandex-cloud" %}

You can authenticate in the [profile creation](../profile/profile-create.md#interactive-create) wizard using the `yc init` command or following these steps:
{% if audience != "internal" %}

1. Get an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).

{% else %}

1. Get an OAuth token.

{% endif %}

1. [Create a profile](../profile/profile-create.md#create).
1. Specify your OAuth `token` in the token parameter:
   ```
   yc config set token <OAuth token>
   ```

The OAuth token is saved in the profile configuration for automatically authenticating.

{% endif %}

{% if product == "cloud-il" %}

If you don't have the {{ yandex-cloud }} command line interface, [install it](../install-cli.md).

To authenticate using a Google account:

1. Launch the profile creation wizard:

   ```
   yc init \
     --endpoint {{ api-host }}:443 \
     --federation-endpoint {{ console-host }} \
     --federation-id google
   ```
1. Select the profile you want to set up authentication for or create a new one.
   ```
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```
1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue.

   ```
   You are going to be authenticated via federation-id 'google'.
   Your federation authentication web site will be opened.
   After your successful authentication, you will be redirected to '{{ link-console-main }}'.

   Press 'enter' to continue...
   ```

   {% include [include](../../../_includes/cli/success-auth-via-federation.md) %}

1. Go back to the command-line interface to finish creating the profile.

1. At the command prompt, select one of the clouds from the list of those you have access to:

   {% include [include](../../../_includes/cli/choose-cloud.md) %}

   If only one cloud is available, it's selected automatically.

1. Select the default folder:

   {% include [include](../../../_includes/cli/choose-folder.md) %}

1. Select the default availability zone for {{ compute-full-name }}:

   ```
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   Which zone do you want to use as a profile default?
   [1] {{ region-id }}-a
   [2] Don't set default zone
   Please enter your numeric choice: 1
   ```

1. View your CLI profile settings:
   ```
   yc config list
   endpoint: {{ api-host }}:443
   federation-id: google
   ...
   ```

{% endif %}