
  To get authenticated using a [Yandex account](../../iam/concepts/index.md#passport):

  1. Get an OAuth token in [Yandex ID](https://yandex.ru/dev/id/doc/en/concepts/ya-oauth-intro):

     1. Click the [link]({{ link-cloud-oauth }}). If the application requests access to data, grant it. This is required to get a token.

     1. Copy the token to the clipboard or save it.

  1. To initialize CLI profile setup, run this command:

      ```bash
      yc init
      ```


  1. Select the profile you want to set up authentication for or create a new one. If it is your first time running the `yc init` command, this step will be skipped.

     ```bash
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     Please enter your numeric choice: 1
     ```

  1. Enter the previously obtained OAuth token when prompted by the command:

     ```bash
     Please go to {{ link-cloud-oauth }}
     in order to obtain OAuth token.

     Please enter OAuth token: y0_AgA ... wvs7N4
     ```

  1. Select one of the [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud) from the list of those you have access to:

     {% include [include](choose-cloud.md) %}

     If there is only one cloud available, it will be selected automatically.

  1. Select the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

     {% include [include](choose-folder.md) %}

  
  1. To select the default [availability zone](../../overview/concepts/geo-scope.md) for [{{ compute-name }}](../../compute/), type `Y`. To skip the setup, type `n`.

     ```bash
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
     ```

     If you typed `Y`, select the appropriate availability zone:

     {% include [include](choose-zone.md) %}


  1. View your CLI profile settings:

     ```bash
     yc config list
     ```

     Result:

     ```bash
     token: y0_AgA...wvs7N4
     cloud-id: b1g159pa15cd********
     folder-id: b1g8o9jbt58********
     compute-default-zone: {{ region-id }}-b
     ```


