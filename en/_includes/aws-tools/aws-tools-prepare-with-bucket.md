1. [Create a bucket](../../storage/operations/buckets/create.md).
1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the required role to the service account, e.g., `storage.editor`. For more information about roles, see [{#T}](../../storage/security/index.md).

       
   {% include [encryption-roles](../storage/encryption-roles.md) %}


   {% note tip %}

   You can assign a role for a folder or a bucket to a service account. A role for a folder gives the GUI client access to all the buckets in the folder. A role for a bucket gives the client access only to this particular bucket. For granular access, assign a role for a particular bucket.

   {% endnote %}

1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

        
    {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}


