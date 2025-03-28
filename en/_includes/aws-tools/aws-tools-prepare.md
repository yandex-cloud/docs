1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign to the service account the roles](../../iam/operations/sa/assign-role-for-sa.md) required for your project, e.g., [storage.editor](../../storage/security/index.md#storage-editor) for a bucket (to work with a particular bucket) or a folder (to work with all buckets in this folder). For more information about roles, see [Access management with {{ iam-full-name }}](../../storage/security/index.md).

        
    {% include [encryption-roles](../storage/encryption-roles.md) %}


1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}


