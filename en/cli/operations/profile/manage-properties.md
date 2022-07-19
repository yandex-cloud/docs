# Managing profile parameters

You can manage your profile parameters in the following ways:
- [Add or change a profile parameter](#set).
- [Delete a profile parameter](#unset).
- [Run a command with parameters from another profile](#another-profile).

## Add or change a profile parameter {#set}

To add or change a profile parameter, use the command:

```
yc config set <parameter name> <parameter value>
```

For example, change the default folder:
1. [Get information about the current profile parameters](profile-list.md#profile-get).
1. Change the default folder (`folder-id` parameter):
   ```
   yc config set folder-id b1g68...
   ```
1. Make sure that the parameter changed:

   {% if product == "yandex-cloud" %}

   ```
   yc config list
   token: AQAAAAAV6O...
   cloud-id: b1gvl...
   folder-id: b1g68...
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```
   yc config list
   cloud-id: b1gvl...
   folder-id: b1g68...
   ```

   {% endif %}

View the full [list of profile parameters](../../concepts/core-properties.md). You can also change your profile parameters using the [profile wizard](profile-create.md#interactive-create).

## Delete a profile parameter {#unset}

To delete a profile parameter, use the command:

```
yc config unset <parameter name>
```

For example, delete the default folder:
1. [Get information about the current profile parameters](profile-list.md#profile-get).
1. Delete the default folder (`folder-id` parameter):
   ```
    config unset folder-id
   ```
1. Make sure that the parameter was deleted:

   {% if product == "yandex-cloud" %}

   ```
   yc config list
   token: AQAAAAAV6O...
   cloud-id: b1gvl...
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```
   yc config list
   cloud-id: b1gvl...
   ```

   {% endif %}

## Run a command with parameters from another profile {#another-profile}

To run a command using parameters from a different profile, add the `--profile <profile name>` parameter to the command.

For example, view the `test` profile parameters without activating it:

{% if product == "yandex-cloud" %}

```
yc config list --profile test
token: AQAAAAAV6O...
cloud-id: aoegt...
folder-id: aoek4...
```

{% endif %}

{% if product == "cloud-il" %}

```
yc config list --profile test
cloud-id: aoegt...
folder-id: aoek4...
```

{% endif %}
