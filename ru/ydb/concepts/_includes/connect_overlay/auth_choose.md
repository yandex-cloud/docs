---
sourcePath: ru/ydb/overlay/concepts/_includes/connect_overlay/auth_choose.md
---
Чтобы подготовить данные для аутентификации в БД {{ ydb-short-name }} {{ yandex-cloud }} для выбранного режима, выполните следующие шаги:

{% list tabs %}

- Access Token

  * В режиме Access Token применяется [IAM токен Yandex.Cloud](../../../../iam/concepts/authorization/iam-token.md), процедура получения которого описана в статье [получение IAM-токена для аккаунта на Яндексе](../../../../iam/operations/iam-token/create.md).

- Refresh Token

  * В режиме Refresh Token применяется [OAuth-токен пользовательской учетной записи на Яндексе](../../../../iam/concepts/authorization/oauth-token.md), который можно получить [по ссылке]({{ link-cloud-oauth }}).

- Service Account Key

  * В режиме Service Account Key применяется файл с [авторизованным ключом](../../../../iam/concepts/authorization/key.md) [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md).

      [Создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт. Назначьте ему роль `viewer` или `viewer` + `editor` в зависимости от того, какой доступ к базам данных в выбранном каталоге должен быть предоставлен.

      [Создайте авторизованный ключ](../../../../iam/operations/authorized-key/create.md) сервисного аккаунта и сохраните его в файл.
  
- Metadata

  * В режиме Metadata применяется [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), привязанный к виртуальной машине, где вы запускаете свое приложение или команды {{ ydb-short-name }} CLI, или к функции {{ sf-full-name }}, где вы выполняете свой прикладной код.

      [Создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт и назначьте ему роль `viewer` или `viewer` + `editor` в зависимости от того, какой доступ к базам данных в выбранном каталоге должен быть предоставлен.

      Привяжите сервисный аккаунт [к виртуальной машине](../../../../compute/operations/vm-connect/auth-inside-vm#link-sa-with-instance.md), или [к функции {{ sf-full-name }}](../../../../functions/operations/function/function-create.md).

{% endlist %}

О том как использовать полученные артефакты, читайте в разделе [Конфигурация аутентификации на клиенте](#client-config) ниже по тексту этой статьи.
