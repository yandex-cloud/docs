# Creating a temporary access key using {{ sts-name }}

With [{{ sts-name }} restricted](../../iam/concepts/authorization/sts.md), you can get temporary keys for access to {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md).

Authentication with temporary access keys is only supported in [{{ objstorage-name }}](../../storage/).

You must have _at least_ the following roles:

* [iam.serviceAccounts.admin](../../iam/roles-reference.md#iam-serviceAccounts-admin) for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a service account and get access keys for it. If you want to use an existing service account, the `iam.serviceAccounts.admin` role for that service account will be enough.

* [storage.admin](../../storage/security/index.md#storage-admin) for a bucket or folder to assign the required role to the service account. Alternatively, you can use the `FULL_CONTROL` permission in the bucket's [ACL](../../storage/security/acl.md).

If you have a primitive [admin](../../iam/roles-reference.md#admin) role for a folder, you do not need to assign any additional roles.


To get a temporary access key:

1. [Create](../../iam/operations/sa/create.md) a service account. You can also use an existing service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) it the required [role](../../storage/security/index.md#roles-list), e.g., [storage.viewer](../../storage/security/index.md#storage-viewer), for the bucket or folder you want to access with a temporary key.

    {% note info %}

    Assign a role for a folder if you want to have access to all buckets in the folder using the service account.

    {% endnote %}

    The selected role must include all the permissions you want to grant using temporary keys.

    {% include [sts-sa-access-backets-list](sts-sa-access-backets-list.md) %}

    Alternatively, you can use [ACL](../../storage/security/acl.md) permissions for the bucket.
1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key for the service account.
1. [Install and configure](../../storage/tools/aws-cli.md) the AWS Command Line Interface (AWS CLI).
1. Describe the [bucket policy](../../storage/concepts/policy.md) configuration as a [data schema](../../storage/s3/api-ref/policy/scheme.md) in JSON format.

    {% include [sts-for-one-bucket.md](sts-for-one-bucket.md) %}

    {% include [sts-sa-scope-note](sts-sa-scope-note.md) %}

    {% cut "Policy example" %}

    This policy allows a temporary key user to get objects from the specified bucket [prefix](../../storage/concepts/object.md#folder):

    ```json
    {
      "Version": "2012-10-17",
      "Statement": {
        "Sid": "all",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/<prefix>"
      }
    }
    ```

    Where:
    * `Version`: Version of the bucket policy description, e.g., `2012-10-17`. This is an optional property.
    * `Statement`: Bucket policy rules:
      * `Sid`: Custom rule ID, e.g., `all`. `Statement Allow`, or `Statement Deny`. This is an optional property.
      * `Effect`: Denies or allows the requested action. The possible values are `Allow` and `Deny`.
      * `Principal`: Valid value is `*`. This setting is required for compatibility with the [AWS S3 API](../../storage/s3/index.md).
      * `Action`: [Action](../../storage/s3/api-ref/policy/actions.md) to perform when the policy triggers, e.g., `s3:GetObject`, `s3:PutObject`, or `*`.
      * `Resource`: Resource to perform the action with. The valid values are: 
        * `arn:aws:s3:::<bucket_name>`: Bucket.
        * `arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.
        * `arn:aws:s3:::<bucket_name>/<prefix>*`: All objects in the bucket whose keys start with a prefix, e.g., `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`, in which case the rule will apply to all bucket objects.
    
        A bucket resource does not include resources of all its objects. To make sure a bucket policy rule applies to the bucket and all its objects, specify them as separate resources, e.g., `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`.

      If you apply a bucket policy without rules when creating temporary access keys, access with a temporary key will be denied.

    {% endcut %}

    Save the final configuration to a file named `policy.json`.

    {% include [sts-object-acl-note](sts-object-acl-note.md) %}

1. Get a temporary access key:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      Run this command:

      ```bash
      aws --endpoint https://{{ sts-host }}/ sts assume-role \
        --role-arn <description> \
        --role-session-name <key_name> \
        --duration-seconds <key_lifetime> \
        --policy file://policy.json
      ```

      Where:
      * `--endpoint`: {{ sts-name }} endpoint.
      * `--role-arn`: Custom description of at least 20 characters. You can use Latin letters, numbers, `_` and `-`.
      * `--role-session-name`: Unique key name. You can use Latin letters, numbers, `_` and `-`.
      * `--duration-seconds`: Key lifetime in seconds, which cannot exceed `43200`.
      * `--policy file://`: Path to the bucket policy file.

      For more information about the `aws sts assume-role` command, see [this AWS guide](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sts/assume-role.html).

      Result:

      ```json
      {
          "Credentials": {
              "AccessKeyId": "YCAJEkNuezZyt4b**********",
              "SecretAccessKey": "YCMUWwxFAnZ**********...",
              "SessionToken": "s1.9euelZqPjcj**********...",
              "Expiration": "2024-02-29T23:30:53+00:00"
          },
          "AssumedRoleUser": {
              "Arn": "a1234567891234567890/test-2"
          },
          "PackedPolicySize": 0,
          "SourceIdentity": ""
      }
      ```

      Where:
      * `AccessKeyId`: Key ID (same as the static key ID).
      * `SecretAccessKey`: Secret key.
      * `SessionToken`: Session token.

      Save these parameters.

    {% endlist %}

1. Set the temporary access key parameters as environment variables for the user you want to grant bucket access permissions:

    ```bash
    export AWS_ACCESS_KEY_ID=<key_ID>
    export AWS_SECRET_ACCESS_KEY=<secret_key>
    export AWS_SESSION_TOKEN=<session_token>
    ```

1. To test access to the bucket, save an object from the bucket prefix you granted access to on the client device:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      aws --endpoint https://{{ s3-storage-host }} s3 cp \
        s3://<bucket_name>/<prefix><object_name> ./
      ```

      Result:

      ```text
      download: s3://<bucket_name>/<prefix><object_name> to ./<object_name>
      ```

    {% endlist %}
