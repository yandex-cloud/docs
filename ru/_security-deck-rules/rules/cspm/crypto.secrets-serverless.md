### Для Serverless Containers и Cloud Functions используются секреты Lockbox {#secrets-serverless}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | crypto.secrets-serverless ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет использование секретов Lockbox в serverless функциях и контейнерах.

{% endnote %}

При работе с Serverless Containers или Cloud Functions часто возникает необходимость использовать секрет (токен, пароль и т.д.).

Если указать секретную информацию в переменных окружения, она может быть доступна для просмотра любому пользователю облака с правами на просмотр и использование функции и влечет за собой риски ИБ.

Рекомендуется использовать для этих целей интеграцию Serverless с Lockbox. Вы можете указать конкретный секрет из сервиса Yandex Lockbox и сервисный аккаунт с правами на данный секрет для использования его в функции или контейнере.

Рекомендуется убедиться, что секреты используются именно таким образом.

#### Инструкции и решения по выполнению

* Удалите секретные данные из env и воспользуйтесь функционалом интеграции с Lockbox:
  * Передать секреты Yandex Lockbox в контейнер: https://yandex.cloud/ru/docs/serverless-containers/operations/lockbox-secret-transmit
  * Передать секреты Yandex Lockbox в функцию: https://yandex.cloud/ru/docs/functions/operations/function/lockbox-secret-transmit