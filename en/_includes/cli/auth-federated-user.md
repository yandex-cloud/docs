{% if audience != "internal" %}
To authenticate using an [SAML-compatible identity federation](../../organization/add-federation.md):
{% else %}
To authenticate using an SAML-compatible identity federation:
{% endif %}
1. Get your federation ID from your administrator.
1. Launch the profile creation wizard:

   {% if product == "yandex-cloud" %}

   ```
   yc init --federation-id=<federation ID>
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```
   yc init \
     --endpoint {{ api-host }}:443 \
     --federation-endpoint {{ console-host }} \
     --federation-id <federation ID>
   ```

   {% endif %}

1. Select the profile you want to set up authentication for or create a new one.
   ```
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```
1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue.

   ```
   You are going to be authenticated via federation-id 'aje1f0hsgds3aas2f6ai2'.
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

   {% include [include](choose-zone.md) %}

1. View your CLI profile settings:

   {% if product == "yandex-cloud" %}

   ```
   yc config list
   federation-id: aje1f0hs6ojais2f6ai2
   ...
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```
   yc config list
   endpoint: {{ api-host }}:443
   federation-id: aje1f0hs6ojais2f6ai2
   ...
   ```

   {% endif %}
