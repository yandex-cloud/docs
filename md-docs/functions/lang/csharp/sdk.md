[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Разработка на .NET Core](index.md) > Использование SDK

# Использование SDK для функции на .NET Core

Среда выполнения не содержит предустановленной библиотеки для работы с [API Yandex Cloud](../../../api-design-guide/index.md). Для ее использования требуется добавить [зависимость](dependencies.md) в приложение на .NET Core. Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/dotnet-sdk).

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет управлять ресурсами Yandex Cloud от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции.