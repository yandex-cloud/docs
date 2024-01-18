# Как начать работать с {{ translate-short-name }}

{{ translate-full-name }} предоставляет API для интеграции технологий перевода в свои приложения. Если вы хотите использовать для перевода графический интерфейс, воспользуйтесь [Яндекс Переводчиком](https://translate.yandex.ru/).

В этом разделе вы научитесь переводить текст, используя {{ translate-name }} API.

{% include [curl](../_includes/curl.md) %}

Больше примеров на разных языках программирования доступно в [пошаговых инструкциях](operations/index.md). 

О том, как создать сервисный аккаунт и API-ключ для интеграции {{ translate-full-name }} в свое приложение, см. [{#T}](operations/sa-api-key.md).

## Перед началом работы {#before-begin}

1. На странице [**Биллинг**]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).

1. Получите данные вашего аккаунта для авторизации:

    {% include [user-auth](../_includes/translate/user-auth.md) %}

## Перевести текст {#translate-text}

{% list tabs group=programming_language %}

- Bash {#bash}

    {% include [translate](../_includes/translate/translate-bash.md) %}

{% endlist %}

#### Что дальше {#what-is-next}

* [Узнайте подробнее о сервисе](concepts/index.md)
* [Посмотрите другие примеры](operations/index.md)
* [Прочитайте про способы аутентификации в API](api-ref/authentication.md)