# Creating a profile

There are two ways to create a profile:
- [Creating an empty profile and adding parameters manually](#create).

   This creates and activates an empty profile: you have to [add all the parameters separately](manage-properties.md).
- [Wizard-based profile creation with basic parameters](#interactive-create).

   The CLI suggests setting the basic profile parameters step-by-step. You can use this method to redefine the parameters of an existing profile. This method doesn't work for service accounts.

## Creating an empty profile and adding parameters manually {#create}

Create a profile with the `test` name:
1. Run the command:
   
   ```
   yc config profile create test
   ```
   
   Result:
   
   ```
   Profile 'test' created and activated
   ```
   
{% if product == "cloud-il" %}

1. Add the hostname and the port for sending requests to {{ yandex-cloud }} to the profile:
   
   ```
   yc config set endpoint {{ api-host }}:443
   ```
   
{% endif %}

1. Add the necessary profile parameters, such as a folder:

   ```
   yc config set folder-id <folder ID>
   ```

   View the full [list of profile parameters](../../concepts/core-properties.md) and learn how to [manage](manage-properties.md) them.

## Wizard-based profile creation with basic parameters {#interactive-create}

{% if product == "cloud-il" %}

Wizard-based profile creation is available:

* For users with Google accounts: 
  
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

You can't run the `yc init` command without `--endpoint`, `--federation-endpoint`, or `--federation-id` parameters.

{% endif %}

{% if product == "yandex-cloud" %}

If you use the wizard to create a profile, the CLI prompts you to enter the basic profile parameters step-by-step:
- Profile name.
- OAuth token.
- The cloud you have access rights to.
- Default folder.
- Default availability zone where {{ compute-full-name }} resources are created.

You can stop profile creation at any time. All the settings you entered before stopping are saved to the profile.

### Get an OAuth token {#get-token}

Get an OAuth token: click **Allow** in [Yandex.OAuth]({{ link-cloud-oauth }}).

### Create a profile {#create-profile}

To create a profile:
1. Execute the `yc init` command.
1. Enter your OAuth token:

   If it's not your first time running the `yc init` command, this step is omitted.

   ```
   Please go to {{ link-cloud-oauth }}
    in order to obtain OAuth token.

   Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
   ```
1. Choose an action: create a new profile or update the parameters of the current profile.

   When the CLI installation is complete, you already have the `default` profile. The CLI prompts you to create a new profile or edit the parameters of the current profile.

   ```
   Welcome! This command will take you through the configuration process.
   Pick desired action:
    [1] Re-initialize this profile 'default' with new settings
    [2] Create a new profile
   ```

   Depending on the option you choose, you are prompted for the profile name or OAuth token, respectively.
1. Enter a name for the new profile:

   ```
   Enter profile name. Names start with a lower case letter and contain only lower case letters a-z, digits 0-9, and hyphens '-':
   ```
1. Enter your OAuth token:

   ```
   Please go to {{ link-cloud-oauth }}
   in order to obtain OAuth token.

   Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
   ```
1. At the command prompt, select one of the clouds from the list of those you have access to:

   {% include [include](../../../_includes/cli/choose-cloud.md) %}

1. Select the default folder:

   ```
   Please choose a folder to use:
   [1] folder1 (id = cvatao4faoe2bmdrg22b)
   [2] folder2 (id = tao4faoe2cvabmdrg22b)
   [3] Create a new folder
   Please enter your numeric choice: 1
   ```
1. Select the default availability zone for {{ compute-full-name }}:

   ```
   Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
   Which zone do you want to use as a profile default?
   [1] {{ region-id }}-a
   [2] {{ region-id }}-b
   [3] {{ region-id }}-c
   [4] Don't set default zone
   Please enter your numeric choice: 2
   ```

### View your profile settings {#get}

Run the command:

```
yc config profile get <profile name>
token: AQAAAAAV6O...
cloud-id: b1gvl...
folder-id: b1g88...
```

{% endif %}

