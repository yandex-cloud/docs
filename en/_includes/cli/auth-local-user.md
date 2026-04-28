To authenticate using a [local user account](../../iam/concepts/users/accounts.md#local):

1. Launch the profile creation wizard:

   {% list tabs %}

   - User pool
   
     1. Get your user pool ID from your administrator.
     1. Launch the profile creation wizard:

                  
         ```bash
         yc init --userpool-id=<user_pool_ID>
         ```



   - Email

      1. Get your email address:
         1. Go to the [My account]({{ link-my-account }}) portal.
         1. In the left-hand panel, select ![alt](../../_assets/console-icons/passport.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.profile_8kyBA }}**.
         1. Copy the email address from the **{{ ui-key.yacloud_org.my-account.ProfilePage.contacts_subheader }}** section.
      1. Launch the profile creation wizard:

                  
         ```bash
         yc init --username=<email_address>
         ```



   {% endlist %}

1. Select the profile you want to set up authentication for or create a new one.

   ```text
   Welcome! This command will take you through the configuration process.
   Pick desired action:
   [1] Re-initialize this profile 'default' with new settings
   [2] Create a new profile
   ```

1. The CLI prompts you to continue authentication in the browser. Press **Enter** to continue.

   ```text
   You are going to be authenticated via userpool-id 'ek0auknfc0mh********'.
   Your userpool authentication web site will be opened.
   After your successful authentication, you will be redirected to cloud console.

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
   
   {% list tabs %}

   - User pool
   
      
      ```bash
      userpool-id: ek0auknfc0mh********
      subject-id: ek00cd1m8hdd8********
      cloud-id: b1g159pa15cd********
      folder-id: b1g8o9jbt58********
      compute-default-zone: {{ region-id }}-b
      ```



   - Email
      
      ```bash
      subject-id: b1g159pa15cd********
      username: <email_address>
      folder-id: b1g8o9jbt58********
      compute-default-zone: {{ region-id }}-b
      ```



   {% endlist %}