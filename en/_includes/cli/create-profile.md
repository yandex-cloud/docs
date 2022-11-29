{% if product == "yandex-cloud" %}

To authenticate as a user:
1. Get an OAuth token from Yandex.OAuth.
   1. Click the [link]({{ link-cloud-oauth }}). If the application requests access to data, grant it. This is required to get a token.
   1. Copy the token to the clipboard or save it.
1. Run the `yc init` command to configure your CLI profile.
1. Enter your OAuth token when prompted by the command. If it's not your first time running the `yc init` command, this step is omitted.

   ```bash
   Please go to {{ link-cloud-oauth }}
    in order to obtain OAuth token.

   Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
   ```
1. At the command prompt, select one of the clouds from the list of those you have access to:

   {% include [include](choose-cloud.md) %}

   If only one cloud is available, it's selected automatically.
1. Select the default folder:

   {% include [include](choose-folder.md) %}

{% if audience == "internal" %}

1. Disable the default availability zone selection for {{ compute-full-name }}:

   ```bash
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] N
   ```
{% else %}

1. Select the default availability zone for {{ compute-full-name }}:

   {% include [include](choose-zone.md) %}

{% endif %}

1. View your CLI profile settings:

   ```bash
   yc config list
   ```

   Result:

   ```bash
   token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
   cloud-id: b1g159pa15cddlv5mvcr
   folder-id: b1g8o9jbt587mbadu25k
   ```

{% endif %}

{% if product == "cloud-il" %}

1. Launch the profile creation wizard:

   ```bash
   yc init \
     --endpoint {{ api-host }}:443 \
     --federation-endpoint {{ console-host }} \
     --federation-id google
   ```
1. Select the profile you want to set up authentication for or create a new one.

   ```bash
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```
1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue.

   ```bash
   You are going to be authenticated via federation-id 'google'.
   Your federation authentication web site will be opened.
   After your successful authentication, you will be redirected to '{{ link-console-main }}'.

   Press 'enter' to continue...
   ```

   {% include [include](success-auth-via-federation.md) %}

1. Go back to the command-line interface to finish creating the profile.

1. At the command prompt, select one of the clouds from the list of those you have access to:

   {% include [include](choose-cloud.md) %}

   If only one cloud is available, it's selected automatically.

1. Select the default folder:

   {% include [include](choose-folder.md) %}

1. Select the default availability zone for {{ compute-full-name }}:

   ```bash
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   Which zone do you want to use as a profile default?
   [1] {{ region-id }}-a
   [2] Don't set default zone
   Please enter your numeric choice: 1
   ```

1. View your CLI profile settings:

   ```bash
   yc config list
   ```

   Result:

   ```bash
   federation-id: google
   endpoint: {{ api-host }}:443
   ...
   ```

{% endif %}


{% endlist %}