---
title: How to create a profile in the {{ yandex-cloud }} CLI
description: Follow this guide to create a profile in the CLI.
---

# Creating a profile

There are two ways to create a profile:

- [Wizard-based profile creation with basic parameters](#interactive-create).

    The CLI suggests setting the basic profile parameters step-by-step. You can use this method to redefine the parameters of an existing profile. This method doesn't work for service accounts.

- [Creating an empty profile and adding parameters manually](#create).

    This creates and activates an empty profile which you have to [set up manually](manage-properties.md).

## Wizard-based profile creation with basic parameters {#interactive-create}

In interactive mode, the CLI will prompt you to set basic parameters step-by-step:
* Profile name.
* The cloud you have access rights to.
* Default folder.
* Default availability zone where {{ compute-full-name }} resources are created.

You can stop profile creation at any time. All the settings you entered before stopping are saved to the profile.


If you are not connected to the management console yet, log in to the [console]({{ link-console-main }}) and accept the user agreement by clicking **Log in**.

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

    {% include [include](../../../_includes/cli/passport-profile-create.md) %}

- Federated account {#federated-account}

    {% include [include](../../../_includes/cli/auth-federated-user.md) %}

- Local user account {#local-account}

    {% include [include](../../../_includes/cli/auth-local-user.md) %}

{% endlist %}

## Creating an empty profile and adding parameters manually {#create}

Create a profile named `test`:
1. Run this command: 
  
   ```bash
   yc config profile create test
   ```

   Result:

   ```text
   Profile 'test' created and activated
   ```

1. Specify the necessary profile parameters, e.g., a folder:

    ```bash
    yc config set folder-id <Folder_ID>
    ```

    View the full [list of profile parameters](../../concepts/core-properties.md) and learn how to [manage](manage-properties.md) them.
