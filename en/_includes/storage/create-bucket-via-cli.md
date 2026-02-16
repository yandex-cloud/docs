1. View the description of the CLI command to create a bucket:

    ```bash
    yc storage bucket create --help
    ```

1. Create a bucket in the default folder:

    ```bash
    yc storage bucket create --name <bucket_name>
    ```

    Where `--name` is the name of the bucket. This is a required parameter. For more information, see [Bucket naming rules](../../storage/concepts/bucket.md#naming).

    
    By default, a bucket with a dot in the name is only available over HTTP. To provide HTTPS support for your bucket, [upload](../../storage/operations/hosting/certificate.md) your own security certificate to {{ objstorage-name }}.


    Result:

    ```text
    name: example
    folder_id: b1gmit33ngp6********
    anonymous_access_flags:
    read: false
    list: false
    default_storage_class: STANDARD
    versioning: VERSIONING_DISABLED
    max_size: "53687091200"
    acl: {}
    created_at: "2022-12-16T14:05:12.196007Z"
    ```

    {% cut "Optional parameters" %}

    * `--default-storage-class`: [Storage class](../../storage/concepts/storage-class.md). The possible values are:
    * `standard`: Standard storage. It is installed by default.
    * `cold`: Cold storage.
    * `ice`: Ice storage.

    <q>Cold</q> classes are designed to store [objects](../../storage/concepts/object.md) that you plan to use less frequently for longer periods of time. The <q>colder</q> the storage, the cheaper it is to store data in, but the more expensive it is to read from and write to it.

    * `--max-size`: Maximum bucket size, in bytes. The default value is `0` (unlimited).
    * Parameters for enabling [public access](../../storage/security/public-access.md) to a bucket:
    * `--public-read`: Enables public read access to bucket objects.
    * `--public-list`: Enables public view access to the list of bucket objects.
    * `--public-config-read`: Enables public read access to bucket settings.

    By default, public access to the bucket is disabled.

    {% include [public-access-warning](./security/public-access-warning.md) %}

    * Parameters to configure the bucket [ACL](../../storage/concepts/acl.md):
    * `--acl`: Predefined ACL. For a list of possible values, see [Predefined ACLs](../../storage/concepts/acl.md#predefined-acls). You cannot use this parameter together with `--grants`.
    * `--grants`: This parameter configures permissions for individual users, [service accounts](../../iam/concepts/users/service-accounts.md), [user groups](../../organization/concepts/groups.md), and [public groups](../../storage/concepts/acl.md#public-groups) (a group of all internet users or a group of all authenticated {{ yandex-cloud }} users). You cannot use this parameter together with `--acl`. The parameter value is specified in the following format: `grant-type=<permission_grantee_type>,grantee-id=<grantee_ID>,permission=<permission_type>`, where:
        * `grant-type`: Permission grantee type. The possible values are:
        * `grant-type-account`: User, [service account](../../iam/concepts/users/service-accounts.md), or [user group](../../organization/concepts/groups.md).
        * `grant-type-all-authenticated-users`: [Public group](../../storage/concepts/acl.md#public-groups) that includes all authenticated {{ yandex-cloud }} users.
        * `grant-type-all-users`: Public group that includes all internet users.
        * `grantee-id`: ID of the user, service account, or user group you need to grant a permission to. It is specified only if `grant-type=grant-type-account`.
        * `permission`: ACL permission type. The possible values are `permission-full-control`, `permission-write`, and `permission-read`. Learn more about permissions in [Permission types](../../storage/concepts/acl.md#permissions-types).

        To configure multiple permissions, specify the `--grants` parameter multiple times.

    By default, an empty ACL is created for each new bucket.

    {% endcut %}

    Learn more about the `yc storage bucket create` command in the [YC CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/create.md).