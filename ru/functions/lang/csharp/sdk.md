# Использование SDK для функции на С#

Среда выполнения не содержит предустановленной библиотеки для работы с [API {{ yandex-cloud }}](../../../api-design-guide/). Для ее использования требуется добавить [зависимость](dependencies.md) в приложение на С#. Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/dotnet-sdk).

[SDK (Software Development Kit)]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SDK){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Software_development_kit){% endif %} позволяет управлять ресурсами {{ yandex-cloud }} от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции.