# Создание подключения к Metrica

## Подключение к Metrica {#metrica-connection}

Чтобы создать подключение к Metrica:


1. Перейдите на [страницу подключений](https://datalens.yandex.ru/connections).


1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **Metrica**.
1. Укажите параметры подключения:

   * **Имя подключения**. Задайте имя подключения. Имя может быть произвольным.
   * **OAuth-токен**. Нажмите кнопку **Получить токен** или укажите вручную [OAuth-токен](#get-oauth-token) для доступа к данным Яндекс Метрики.
   * **Счетчик**. Укажите один или несколько счетчиков для подключения. Вы можете выбрать их из списка или указать вручную через запятую.
    
     {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}
        
1. Нажмите **Подключить**. Подключение появится в списке.

{% include [datalens-metrica-note](../../../_includes/datalens/datalens-metrica-note.md) %}


Подключение к Metrica API не поддерживает [публичный доступ](../../concepts/datalens-public.md) к объектам, созданным на его основе. Чтобы поделиться дашбордом или чартом, созданным на основе данного подключения, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}


{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}
