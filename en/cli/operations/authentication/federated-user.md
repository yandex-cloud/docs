# Authenticating as a federated user

If you don't have the Yandex.Cloud command line interface, [install it](../install-cli.md).

To authenticate using an [SAML-compatible identity federation](../../../iam/concepts/users/identity-federations.md):

1. Get your federation ID from your administrator.

1. Launch the profile creation wizard:

    ```
    yc init --federation-id=<federation ID>
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
    You are going to be authenticated via federation-id 'aje1f0hsgds3aas2f6ai2'.
    Your federation authentication web site will be opened.
    After your successful authentication, you will be redirected to 'https://console.cloud.yandex.com'.

    Press 'enter' to continue...
    ```

    {% include [include](../../../_includes/cli/success-auth-via-federation.md) %}

1. Go back to the command-line interface to finish creating the profile.

1. Select the default folder:

   ```
   Please choose a folder to use:
    [1] folder1 (id = cvatao4faoe2bmdrg22b)
    [2] folder2 (id = tao4faoe2cvabmdrg22b)
    [3] Create a new folder
   Please enter your numeric choice: 1
   ```

1. Select the default availability zone for the {{ compute-full-name }} service:

   ```
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   Which zone do you want to use as a profile default?
    [1] ru-central1-a
    [2] ru-central1-b
    [3] ru-central1-c
    [4] Don't set default zone
   Please enter your numeric choice: 2
   ```

1. View your CLI profile settings:

   ```
   $ yc config list
   federation-id: aje1f0hs6ojais2f6ai2
   ...
   ```

