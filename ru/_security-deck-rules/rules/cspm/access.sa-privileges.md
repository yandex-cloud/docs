### Сервисным аккаунтам назначены минимальные привилегии {#sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.sa-privileges ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Данное правило требуется для ручной проверки. После проверки необходимых привилегий отметьте ее выполнение вручную.

{% endnote %}

Следуйте принципу минимальных привилегий и [назначайте сервисному аккаунту](https://yandex.cloud/ru/docs/iam/operations/roles/grant) только те роли, которые необходимы для функционирования приложения.

#### Инструкции и решения по выполнению

* [Посмотрите](https://yandex.cloud/ru/docs/security-deck/operations/ciem/view-permissions) полный список доступов сервисного аккаунта с помощью сервиса Yandex Security Deck.
* [Отзовите](https://yandex.cloud/ru/docs/security-deck/operations/ciem/revoke-permissions) избыточные доступы у сервисного аккаунта с помощью сервиса Security Deck.
* [Удалите](https://yandex.cloud/ru/docs/iam/operations/roles/revoke) избыточные права у сервисного аккаунта с помощью сервиса IAM.