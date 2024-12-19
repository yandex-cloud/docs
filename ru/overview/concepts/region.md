# Регионы

Регион — географическая область, которая объединяет [зоны доступности](geo-scope.md). Каждый регион имеет свою инфраструктуру и [набор сервисов](services.md).

Регион пользователя зависит от консоли управления, в которой он регистрировался. Пользователь видит в консоли управления только сервисы и ресурсы выбранного региона.

В {{ yandex-cloud }} доступны следующие регионы:

Регион | Россия | Казахстан
--- | --- | ---
Зоны доступности | `{{ region-id }}-a`<br/>`{{ region-id }}-b`<br/>`{{ region-id }}-d` | `kz1-a`
Консоль управления | [https://console.yandex.cloud](https://console.yandex.cloud) | [https://kz.console.yandex.cloud](https://kz.console.yandex.cloud)
Оплата ресурсов | [Тарифы для региона Россия](https://yandex.cloud/ru/prices) | [Тарифы для региона Казахстан](https://yandex.cloud/ru-kz/prices)
Сервис {{ billing-name }} | [https://billing.yandex.cloud](https://billing.yandex.cloud) | [https://kz.billing.yandex.cloud](https://kz.billing.yandex.cloud)
Эндпоинт {{ objstorage-full-name }} | https://storage.yandexcloud.net | https://storage.yandexcloud.kz

В разных регионах разные:

* адреса эндпоинтов {{ yandex-cloud }} API;
* настройки профиля {{ yandex-cloud }} CLI:
    * [Инструкция по созданию профиля CLI в регионе Россия](https://yandex.cloud/ru/docs/cli/operations/profile/profile-create)
    * [Инструкция по созданию профиля CLI в регионе Казахстан](https://yandex.cloud/ru-kz/docs/cli/operations/profile/profile-create)

Пользовательские данные хранятся внутри региона и доступны только внутри него. Например, бакеты {{ objstorage-full-name }}, созданные в регионе Россия, недоступны в регионе Казахстан.

Пользователь может войти в консоль управления каждого региона. Чтобы начать работу в новом регионе, нужно зарегистрироваться и создать платежный аккаунт в регионе:
* [Инструкция для региона Россия](https://yandex.cloud/ru/docs/overview/quickstart)
* [Инструкция для региона Казахстан](https://yandex.cloud/ru-kz/docs/overview/quickstart)

