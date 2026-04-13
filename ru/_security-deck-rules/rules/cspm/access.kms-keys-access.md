### Права на управление ключами в KMS выданы уполномоченным пользователям {#kms-keys-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.kms-keys-access ||
|#

#### Описание

Чтобы сократить риск компрометации пользовательских учетных данных, рекомендуется выдавать пользователям и сервисным аккаунтам гранулярные доступы к конкретным ключам сервиса Yandex Key Management Service. Подробнее читайте в разделе [Управление доступом в Key Management Service](https://yandex.cloud/ru/docs/kms/security/).

Правило проверяет права доступа к ключам KMS и выводит список всех пользователей, которым назначены следующие роли:

* `admin`, `editor`, `kms.admin`, `kms.editor` или `kms.keys.encrypterDecrypter` на организацию, облака или каталоги;
* `kms.keys.encrypterDecrypter` или `kms.editor` на ключи KMS.

#### Инструкции и решения по выполнению

При выдаче прав доступа к ключам KMS рекомендуется следовать следующим принципам:

* Для доступа к сервису Yandex Key Management Service необходимо использовать [IAM-токен](https://yandex.cloud/ru/docs/iam/concepts/authorization/iam-token).
* В случае автоматизации работы с KMS рекомендуется создать [сервисный аккаунт](https://yandex.cloud/ru/docs/iam/concepts/users/service-accounts) и выполнять команды и скрипты от его имени. Если вы используете виртуальные машины, получите IAM-токен для сервисного аккаунта через механизм [назначения сервисного аккаунта](https://yandex.cloud/ru/docs/compute/operations/vm-connect/auth-inside-vm) виртуальной машине. Другие способы получения IAM-токена для сервисного аккаунта приведены в статье [Получение IAM-токена для сервисного аккаунта](https://yandex.cloud/ru/docs/iam/operations/iam-token/create-for-sa) документации Yandex Identity and Access Management.
* Рекомендуется выдавать пользователям и сервисным аккаунтам гранулярные доступы на конкретные ключи сервиса KMS. Подробнее см. статью [Управление доступом в Key Management Service](https://yandex.cloud/ru/docs/kms/security/) документации KMS.

Подробнее о мерах безопасности при управлении доступом читайте в статье [Аутентификация и управление доступом](https://yandex.cloud/ru/docs/security/standard/authentication).
