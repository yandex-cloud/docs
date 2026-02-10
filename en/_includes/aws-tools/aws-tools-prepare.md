{% list tabs group=auth_keys %}

- IAM token authentication {#iam-token}

  1. [Create a service account](../../iam/operations/sa/create.md).
  1. [Assign to the service account the roles](../../iam/operations/sa/assign-role-for-sa.md) required for your project, e.g., [storage.editor](../../storage/security/index.md#storage-editor) for a bucket (to work with a particular bucket) or a folder (to work with all buckets in this folder). For more information about roles, see [Access management with {{ iam-full-name }}](../../storage/security/index.md).

            
      {% include [encryption-roles](../storage/encryption-roles.md) %}


  1. Get an IAM token for the created service account. For more information, see [{#T}](../../iam/operations/iam-token/create-for-sa.md).

      {% include [s3-api-auth-sa-impersonation-tip](../../_includes/storage/s3-api-auth-sa-impersonation-tip.md) %}


- Static key authentication {#static-key}

  1. [Create a service account](../../iam/operations/sa/create.md).
  1. [Assign to the service account the roles](../../iam/operations/sa/assign-role-for-sa.md) required for your project, e.g., [storage.editor](../../storage/security/index.md#storage-editor) for a bucket (to work with a particular bucket) or a folder (to work with all buckets in this folder). For more information about roles, see [Access management with {{ iam-full-name }}](../../storage/security/index.md).

            
      {% include [encryption-roles](../storage/encryption-roles.md) %}


  1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

      
      {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}



  To access the HTTP API directly, you need static key authentication, which is supported by the tools listed in [{#T}](../../storage/tools/index.md).

  
  {% include [store-aws-key-in-lockbox](../storage/store-aws-key-in-lockbox.md) %}


{% endlist %}