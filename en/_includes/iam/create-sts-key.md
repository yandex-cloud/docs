# Creating a temporary access key using {{ sts-name }}

With [{{ sts-name }}](../../iam/concepts/authorization/sts.md), you can get temporary keys for limited access to {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md).

Temporary access keys as an authentication method are only supported in [{{ objstorage-name }}](../../storage/).

You must have _at least_ the following roles:

* To create a service account and get access keys for it: [iam.serviceAccounts.admin](../../iam/roles-reference.md#iam-serviceAccounts-admin) for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). If you want to use an existing service account, the `iam.serviceAccounts.admin` role for that service account will be enough.

* To assign the required role to the service account: [storage.admin](../../storage/security/index.md#storage-admin) for a bucket or folder. Alternatively, you can use the `FULL_CONTROL` permission in the bucket's [ACL](../../storage/security/acl.md).

If you have a primitive [admin](../../iam/roles-reference.md#admin) role for a folder, you do not need to assign any additional roles.


To get a temporary access key:

1. [Create](../../iam/operations/sa/create.md) a service account. You can also use an existing service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to the service account the required [role](../../storage/security/index.md#roles-list), e.g., [storage.viewer](../../storage/security/index.md#storage-viewer), for the bucket or folder you want to access with a temporary key.

    {% note info %}

    Assign a role for a folder if you want to have access to all buckets in the folder using the service account.

    {% endnote %}

    The selected role must include all the permissions you want to grant using temporary keys.

    {% include [sts-sa-access-backets-list](sts-sa-access-backets-list.md) %}

    Alternatively, you can use [ACL](../../storage/security/acl.md) permissions for a bucket.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key for the service account.
1. [Install and configure](../../storage/tools/aws-cli.md) the AWS Command Line Interface (AWS CLI).
1. Describe the [access policy](../../storage/concepts/policy.md) configuration as a [data schema](../../storage/s3/api-ref/policy/scheme.md) in JSON format.

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
    * `Version`: (Optional) Version of the access policy description, e.g., `2012-10-17`.
    * `Statement`: Bucket policy rules:
      * `Sid`: (Optional) Custom rule ID, e.g., `all`, `Statement Allow`, or `Statement Deny`.
      * `Effect`: Denies or allows the requested action. The possible values are `Allow` and `Deny`.
      * `Principal`: The possible value is `*`. This parameter is required for compatibility with [AWS S3 API](../../storage/s3/index.md).
      * `Action`: [Action](../../storage/s3/api-ref/policy/actions.md) to perform when the policy is triggered, e.g., `s3:GetObject`, `s3:PutObject`, or `*`.
      * `Resource`: Resource to perform the action with. The possible values are: 
        * `arn:aws:s3:::<bucket_name>`: Bucket.
        * `arn:aws:s3:::<bucket_name>/<object_key>`: Bucket object.
        * `arn:aws:s3:::<bucket_name>/<prefix>*`: All objects in the bucket whose keys start with a prefix, e.g., `arn:aws:s3:::samplebucket/some/path/*`. A prefix can be empty, e.g., `arn:aws:s3:::samplebucket/*`, in which case the rule will apply to all bucket objects.
    
        A bucket resource does not include resources of all its objects. To make sure a bucket policy rule refers to the bucket and all objects, specify them as separate resources, e.g., `arn:aws:s3:::samplebucket` and `arn:aws:s3:::samplebucket/*`.

      If you apply an access policy without rules when creating temporary access keys, access by temporary key will be denied.

    {% endcut %}

    Once complete, save the configuration to a file named `policy.json`.

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
      * `--role-arn`: Description of at least 20 characters. You can use Latin letters, numbers, `_` and `-`.
      * `--role-session-name`: Unique key name. You can use Latin letters, numbers, `_` and `-`.
      * `--duration-seconds`: Key lifetime in seconds, which cannot exceed `43200`.
      * `--policy file://`: Path to the access policy file.

      For more information about the `aws sts assume-role` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sts/assume-role.html).

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

1. Add the resulting temporary access key parameters to the environment variables for the user to whom you want to grant access permissions to the bucket:

    ```bash
    export AWS_ACCESS_KEY_ID=<key_ID>
    export AWS_SECRET_ACCESS_KEY=<secret_key>
    export AWS_SESSION_TOKEN=<session_token>
    ```

1. To test access to a bucket, save the object from the prefix of the bucket that was accessed to the client device:

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


#### See also {#see-also}

* [{#T}](../../storage/security/overview.md)