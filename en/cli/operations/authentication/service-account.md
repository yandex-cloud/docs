# Authenticating as a service account

Learn how to authenticate in the CLI:

- [As the service account](#auth-as-sa).
- [As a service account from inside a VM](#vm-auth-as-sa).

## Before you start {#before-begin}

1. [Authenticate in the CLI as a user](user.md).
1. If you don't have a service account, [create one](../../../iam/operations/sa/create.md) and [set up its access rights](../../../iam/operations/sa/assign-role-for-sa.md).

## Authenticate as a service account {#auth-as-sa}

1. Get a list of service accounts that exist in your cloud:

    ```
    $ yc iam service-account --folder-id <folder ID> list
    +----------------------+------------+
    |          ID          |    NAME    |
    +----------------------+------------+
    | aje3932acd0c5ur7dagp | default-sa |
    +----------------------+------------+
    ```

1. Create an authorized key for the service account and save it to the file `key.json`:

    ```
    $ yc iam key create --service-account-name default-sa --output key.json
    id: aje83v701b1un777sh40
    service_account_id: aje3932acd0c5ur7dagp
    created_at: "2019-08-26T12:31:25Z"
    key_algorithm: RSA_2048
    ```

1. Add the service account authorized key to the CLI profile.

    1. Create a new CLI profile:

        ```
        $ yc config profile create sa-profile
        ```

    1. Add an authorized key:

        ```
        $ yc config set service-account-key key.json
        ```

1. Make sure that the service account parameters are added correctly:

    ```
    $ yc config list
    service-account-key:
      id: aje83v701b1un777sh40
      service_account_id: aje3932acd0c5ur7dagp
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      public_key: |
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBg...
        -----END PUBLIC KEY-----
      private_key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvwIBAD...
        -----END PRIVATE KEY-----
    ```

1. Configure your profile to run commands.

    {% include [add-folder](../../../_includes/cli-add-folder.md) %}

## Authenticate as a service account from inside a VM {#vm-auth-as-sa}

The authentication process from inside a VM is simplified for a service account:

1. [Link your service account](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to a virtual machine.

1. Authenticate from inside a VM:

    1. Connect to the virtual machine [over SSH](../../../compute/operations/vm-connect/ssh.md) or [via RDP](../../../compute/operations/vm-connect/rdp.md).

    1. {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Create a new profile:

        ```
        yc config profile create my-robot-profile
        ```

1. Configure your profile to run commands.

    {% include [add-folder](../../../_includes/cli-add-folder.md) %}

Read more about working with Yandex.Cloud from a VM in the section [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

#### See also

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

