# Регионы

Регион — географическая область, которая объединяет [зоны доступности](geo-scope.md). Каждый регион имеет свою инфраструктуру и [набор сервисов](services.md).

Регион пользователя зависит от консоли управления, в которой он регистрировался. Пользователь видит в консоли управления только сервисы и ресурсы выбранного региона.

В Yandex Cloud доступны следующие регионы:

Регион | Россия | Казахстан
--- | --- | ---
Зоны доступности | `ru-central1-a`<br/>`ru-central1-b`<br/>`ru-central1-d`<br/>`ru-central1-e` | `kz1-a`
Консоль управления | [https://console.yandex.cloud](https://console.yandex.cloud) | [https://kz.console.yandex.cloud](https://kz.console.yandex.cloud)
Оплата ресурсов | [Тарифы для региона Россия](https://yandex.cloud/ru/prices) | [Тарифы для региона Казахстан](https://yandex.cloud/ru-kz/prices)
Сервис Yandex Cloud Billing | [https://center.yandex.cloud/billing](https://center.yandex.cloud/billing) | [https://kz.center.yandex.cloud/billing](https://kz.center.yandex.cloud/billing)
Эндпоинт Yandex Object Storage | https://storage.yandexcloud.net | https://storage.yandexcloud.kz

В разных регионах разные:

* адреса эндпоинтов Yandex Cloud API:
    * [адреса эндпоинтов API в регионе Россия](../../api-design-guide/concepts/endpoints.md)
    * [адреса эндпоинтов API в регионе Казахстан](../../api-design-guide/concepts/endpoints.md)
* настройки профиля Yandex Cloud CLI:
    * [Инструкция по созданию профиля CLI в регионе Россия](../../cli/operations/profile/profile-create.md)
    * [Инструкция по созданию профиля CLI в регионе Казахстан](../../cli/operations/profile/profile-create.md)

Пользовательские данные хранятся внутри региона и доступны только внутри него. Например, бакеты Yandex Object Storage, созданные в регионе Россия, недоступны в регионе Казахстан.

Пользователь может войти в консоль управления каждого региона. Чтобы начать работу в новом регионе, нужно зарегистрироваться и создать платежный аккаунт в регионе:
* [Инструкция для региона Россия](../quickstart)
* [Инструкция для региона Казахстан](../quickstart)

## Управляемая организация в другом регионе {#controlled-org}

{% note info %}

Функциональность находится на стадии [Preview](launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

[Управляемая организация](../../organization/concepts/controlled-org.md) позволяет разместить ресурсы в другом регионе, не регистрируя для этого отдельную организацию. Вместо этого вы можете [подключить](../../organization/operations/add-region.md) регион к основной организации, чтобы управлять ресурсами в разных регионах через единый интерфейс.

Ресурсы в разных регионах изолированы друг от друга. Данные хранятся в тех регионах, в которых созданы использующие их ресурсы.

Подключение региона Казахстан доступно только для владельца организации — пользователя с ролью `organization-manager.organizations.owner`.