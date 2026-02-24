### Администратор облака имеет инструкцию по действиям в случае компрометации секретов его облака {#admin-secrets-leak-mitigation}

#|
|| **kind** | **severity** | **ID** ||
|| manual | information | procedure.admin-secrets-leak-mitigation ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Выполните рекомендации и отметьте проверку как выполненная.

{% endnote %}

В Yandex Cloud по умолчанию для всех включен [Secret Scanning Service](https://yandex.cloud/ru/docs/security/operations/search-secrets).
Он обнаруживает облачные структурированные секреты в открытом доступе в следующих источниках:

* в публичных репозиториях Github;
* в поисковом индексе Яндекса;
* в Helm-чартах Kubernetes маркетплейса.

Список облачных секретов для обнаружения:

* Yandex Cloud Session Cookie;
* Yandex Cloud IAM token;
* Yandex Cloud API Key;
* Yandex Passport OAuth token;
* Yandex Cloud AWS API compatible Access Secret;
* Yandex Cloud SmartCaptcha Server Key;
* Lockbox структурированные секреты.

Сервис автоматически уведомляет клиента о найденном секрете, который относится к его инфраструктуре:

* по электронной почте;
* с помощью [событий Yandex Audit Trails](https://yandex.cloud/ru/docs/audit-trails/concepts/events).

#### Инструкции и решения по выполнению

* Убедитесь, что:
  * [Контактные данные ответственного за организацию актуальны](https://yandex.cloud/ru/docs/security/standard/authentication#org-contacts)
  * [Включен сервис Yandex Audit Trails на уровне организации](https://yandex.cloud/ru/docs/security/standard/audit-logs#audit-trails)
  * [Администратор ознакомлен с инструкцией по действиям при компрометации секретов](https://yandex.cloud/ru/docs/security/operations/search-secrets#secret-is-leaked)