1. [Создайте](../../storage/operations/buckets/create.md) бакет.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) нужную роль сервисному аккаунту, например `storage.editor`. Подробнее о ролях см. в разделе [{#T}](../../storage/security/index.md).

       
   {% include [encryption-roles](../storage/encryption-roles.md) %}


   {% note tip %}

   Назначить роль сервисному аккаунту можно на каталог или на бакет. Если роль выдана на каталог, то у графического клиента будет доступ ко всем бакетам в каталоге. Если роль выдана на бакет, то доступ будет только к этому бакету. Для обеспечения гранулярного доступа, назначайте сервисному аккаунту роль на конкретный бакет.

   {% endnote %}

1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

        
    {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}


