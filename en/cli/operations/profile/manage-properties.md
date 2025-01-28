# Managing profile parameters

You can manage your profile parameters in the following ways: 
- [Add or change a profile parameter](#set).
- [Delete a profile parameter](#unset).
- [Run a command with parameters from another profile](#another-profile).

## Add or change a profile parameter {#set}

To add or change a profile parameter, use the command: 

```
yc config set <parameter_name> <parameter_value>
```

For example, change the default folder:
1. [Get information about the current profile parameters](profile-list.md#profile-get).
1. Change the default folder (the `folder-id` parameter): 

    ```
    yc config set folder-id b1g5bhjofg7o********
    ```
1. Link an organization to a profile:

    ```
    yc config set organization-id bpfaidqca8vd********
    ```
1. Make sure the parameters have actually changed:

   ```bash
   yc config list
   ```

   Result:

   ```text
   token: y0_AgAAA...Njwvs7N4
   cloud-id: b1gj9ja2h4ct********
   folder-id: b1g5bhjofg7o********
   organization-id: bpfaidqca8vd********
   ```
    
View the full [list of profile parameters](../../concepts/core-properties.md). You can also change your profile parameters using the [profile wizard](profile-create.md#interactive-create).

## Delete a profile parameter {#unset}

To delete a profile parameter, use the command: 

```
yc config unset <parameter_name>
```

For example, unlink the default organization from a profile:

1. [Get information about the current profile parameters](profile-list.md#profile-get).
1. Unlink the default organization (the `organization-id` parameter): 

    ```
    yc config unset organization-id
    ```
1.  Make sure the parameter has been actually deleted:
    
    ```bash
    yc config list
    ```

    Result:

    ```text
    token: y0_AgAAA...Njwvs7N4
    cloud-id: b1gj9ja2h4ct********
    folder-id: b1g5bhjofg7o********
    ```
    
## Run a command with parameters from another profile {#another-profile}

To run the command with the parameters of a different profile, add the `--profile <profile_name>` parameter to the command.

For example, view the `test` profile parameters without activating it: 

```bash
yc config list --profile test
```

Result:

```text
token: y0_AgAAA...Kjwgs7h3
cloud-id: b15jlj22h4ct********
folder-id: b1grb2jo7g7o********
```