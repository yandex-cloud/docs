#### iam.auditor {#auditor}

В роль `iam.auditor` входят разрешения на получение метаинформации об объектах, операциях и ресурсах:

* [федерация](../iam/concepts/federations.md);
* операции и списки операций;
* квоты;
* пользователи;
* списки доступных ролей;
* сервисные аккаунты;
* права на сервисный аккаунт;
* каталог;
* облако;
* ключи для [JWT](../iam/operations/iam-token/create-for-sa.md#via-jwt) авторизации, [авторизованные ключи](../iam/concepts/authorization/key.md) и {% if lang == "ru" and audience != "internal" %}[SSH-ключи](../glossary/ssh-keygen.md){% else %}SSH-ключи{% endif %};
* [API-ключи](../iam/concepts/authorization/api-key.md) и списки API-ключей для сервисного аккаунта;
* [статические ключи](../iam/concepts/authorization/access-key.md) и списки статических ключей для сервисного аккаунта.


