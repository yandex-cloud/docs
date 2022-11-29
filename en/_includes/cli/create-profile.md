
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


1. Select the default availability zone for {{ compute-full-name }}:

   {% include [include](choose-zone.md) %}


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




{% endlist %}