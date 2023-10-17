#### iam.editor {#iam-editor}

Роль `iam.editor` включает все разрешения, предоставляемые ролью `iam.viewer`, а также следующие разрешения на управление сервисными аккаунтами и каталогами:

* создание, изменение и удаление ключей для [JWT](../iam/operations/iam-token/create-for-sa.md#via-jwt) авторизации, [авторизованных ключей](../iam/concepts/authorization/key.md);
* создание, изменение и удаление [статических ключей](../iam/concepts/authorization/access-key.md) доступа;
* создание и удаление [SSH-ключей](../glossary/ssh-keygen.md).