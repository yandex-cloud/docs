### Регулярно проводится аудит прав доступа пользователей и сервисных аккаунтов с использованием Yandex Security Deck CIEM {#access-check-bindings}

#|
|| **kind** | **severity** | **ID** ||
|| manual | information | access.check-bindings ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Правило требует ручной проверки. После проведения проверки отметьте ее выполнение вручную.

{% endnote %}

В целях обеспечения безопасности данных и облачной инфраструктуры необходимо регулярно проводить аудит прав доступа, имеющихся у пользователей и сервисных аккаунтов.

[Модуль диагностики доступов](https://center.yandex.cloud/security/iam-diagnostics/) или CIEM (Cloud Infrastructure Entitlement Management) — это инструмент, позволяющий централизованно просматривать полный список доступов [субъектов](https://yandex.cloud/ru/docs/iam/concepts/access-control/#subject): пользователей, сервисных аккаунтов, [групп пользователей](https://yandex.cloud/ru/docs/organization/concepts/groups), [системных групп](https://yandex.cloud/ru/docs/iam/concepts/access-control/system-group) и [публичных групп](https://yandex.cloud/ru/docs/iam/concepts/access-control/public-group) к [ресурсам](https://yandex.cloud/ru/docs/iam/concepts/access-control/resources-with-access-control) организации. Этот инструмент также позволяет легко отзывать у субъектов лишние доступы.

Подробнее см. в разделе [Модуль диагностики доступов (CIEM)](https://yandex.cloud/ru/docs/security-deck/concepts/ciem).

#### Рекомендации

**Инструкции и решения по выполнению:**

Используйте [Модуль диагностики доступов](https://yandex.cloud/ru/docs/security-deck/concepts/ciem) (CIEM), чтобы централизованно просматривать полный список прав доступа индивидуальных [субъектов](https://yandex.cloud/ru/docs/iam/concepts/access-control/#subject) и групп к [ресурсам](https://yandex.cloud/ru/docs/iam/concepts/access-control/resources-with-access-control) организации и отзывать лишние доступы.

Чтобы начать работать с модулем CIEM, воспользуйтесь инструкциями:

* [Просмотреть список доступов субъекта](https://yandex.cloud/ru/docs/security-deck/operations/ciem/view-permissions)
* [Отозвать доступ у субъекта](https://yandex.cloud/ru/docs/security-deck/operations/ciem/revoke-permissions)
