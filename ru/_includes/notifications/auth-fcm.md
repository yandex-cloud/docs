Вы можете аутентифицироваться на мобильной платформе FCM с помощью _HTTP v1 API_ или _Legacy API_:
* Для аутентификации с помощью HTTP v1 API вам понадобится **Ключ сервисного аккаунта Google Cloud в формате JSON**. С помощью ключа генерируются временные токены OAuth 2.0 для аутентификации запросов в FCM HTTP v1 API. Можно получить в консоли управления Google Cloud.
* Для аутентификации с помощью Legacy API вам понадобится **API-ключ** (server key). Можно получить в консоли управления Firebase.

{% note info %}

Версия HTTP v1 API является предпочтительной, так как с июня 2024 года Legacy API [не будет поддерживаться FCM](https://firebase.google.com/docs/cloud-messaging/migrate-v1).

{% endnote %}

Подробнее см. в [документации Firebase](https://firebase.google.com/docs/cloud-messaging/android/client).