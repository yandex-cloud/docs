To authenticate using a [SAML-compatible identity federation](../../organization/concepts/add-federation.md):

1. Get your federation ID from your administrator.
1. Launch the profile creation wizard:

   

   
   ```bash
   yc init \
      --federation-endpoint auth.cloud.yandex.com \
      --federation-id <federation_ID>
   ```




1. Select the profile you want to set up authentication for or create a new one.

   ```text
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```

1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue.

   ```text
   You are going to be authenticated via federation-id 'aje1f0hsgds3a********'.
   Your federation authentication web site will be opened.
   After your successful authentication, you will be redirected to '{{ link-console-main }}'.

   Press 'enter' to continue...
   ```

   {% include [include](success-auth-via-federation.md) %}

1. Go back to the command line interface to finish creating the profile.

1. Select one of the [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud) from the list of those you have access to:

   {% include [include](choose-cloud.md) %}

   If there is only one cloud available, it will be selected automatically.

1. Select the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

   {% include [include](choose-folder.md) %}

1. To select the default [availability zone](../../overview/concepts/geo-scope.md) for [{{ compute-name }}](../../compute/), type `Y`. To skip the setup, type `n`.

   ```bash
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   ```

   If you typed `Y`, select the availability zone:

   
   {% include [include](choose-zone.md) %}



1. View your CLI profile settings:

   ```bash
   yc config list
   ```

   Result:

   
   ```bash
   federation-id: aje1f0hs6oja********
   cloud-id: b1g159pa15cd********
   folder-id: b1g8o9jbt58********
   compute-default-zone: {{ region-id }}-b
   ```


