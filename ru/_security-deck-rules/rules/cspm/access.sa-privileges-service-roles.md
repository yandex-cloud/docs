### Сервисным аккаунтам назначены минимальные привилегии на уровне сервиса {#sa-privileges-service-roles}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | access.sa-privileges-service-roles ||
|#

#### Описание

Следуйте принципу минимальных привилегий и [назначайте сервисному аккаунту](https://yandex.cloud/ru/docs/iam/operations/roles/grant) только те роли, которые необходимы для функционирования сервиса.

Правило обнаруживает сервисные аккаунты со следующими ролями в пределах сервисов:

* `compute.admin`
* `storage.admin`
* `iam.serviceAccounts.admin`
* `vpc.admin`
* `k8s.admin`
* `lockbox.admin`
* `kms.admin`

#### Инструкции и решения по выполнению

**Инструкции и решения по выполнению:**

* [Отзовите](https://yandex.cloud/ru/docs/security-deck/operations/ciem/revoke-permissions) избыточные доступы у сервисного аккаунта с помощью сервиса Security Deck.
* [Отзовите](https://yandex.cloud/ru/docs/iam/operations/roles/revoke) избыточные права у сервисного аккаунта с помощью сервиса IAM.
