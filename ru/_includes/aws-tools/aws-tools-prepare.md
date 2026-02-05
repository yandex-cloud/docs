{% list tabs group=auth_keys %}

- Аутентификация с помощью IAM-токена {#iam-token}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
  1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../../storage/security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях см. на странице [Управление доступом с помощью {{ iam-full-name }}](../../storage/security/index.md).

            
      {% include [encryption-roles](../storage/encryption-roles.md) %}


  1. Получите IAM-токен для созданного сервисного аккаунта. Подробнее читайте в инструкции [{#T}](../../iam/operations/iam-token/create-for-sa.md).

      {% include [s3-api-auth-sa-impersonation-tip](../../_includes/storage/s3-api-auth-sa-impersonation-tip.md) %}


- Аутентификация с помощью статического ключа {#static-key}

  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
  1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../../storage/security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях см. на странице [Управление доступом с помощью {{ iam-full-name }}](../../storage/security/index.md).

            
      {% include [encryption-roles](../storage/encryption-roles.md) %}


  1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

      
      {% include [get-static-key-info](../../_includes/storage/get-static-key-result.md) %}



  Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [{#T}](../../storage/tools/index.md).
  
  {% include [statickey-access-note](../../_includes/storage/statickey-access-note.md) %}

  
  {% include [store-aws-key-in-lockbox](../storage/store-aws-key-in-lockbox.md) %}


{% endlist %}