# Создание подключения к AppMetrica

## Подключение к AppMetrica {#appmetrica-connection}

Чтобы создать подключение к AppMetrica:

{% if audience == "internal" %}

1. Перейдите на [страницу подключений](https://datalens.yandex-team.ru/connections).

{% else %}

1. Перейдите на [страницу подключений](https://datalens.yandex.ru/connections).

{% endif %}

1. Нажмите кнопку **Создать**, выберите **Connection**.
1. Выберите подключение **AppMetrica**.
1. В поле после имени папки задайте имя подключения. Имя может быть произвольным.
1. Укажите параметры подключения:

   * **OAuth-токен**. Нажмите кнопку **Получить токен** или укажите вручную [OAuth-токен](#get-oauth-token) для доступа к данным AppMetrica.
   * **Приложение**. Укажите одно или несколько приложений для подключения. Вы можете выбрать их из списка или указать вручную через запятую.
   * **Точность**. Задайте точность данных (сэмплирование). Вы можете изменить точность после создания подключения.

     {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

1. Включите опцию **Автоматически создать дашборд, чарты и датасет над подключением**, если хотите получить дашборд со стандартным набором чартов.
1. Нажмите **Создать**.

{% include [datalens-appmetrica-note](../../../_includes/datalens/datalens-appmetrica-note.md) %}

Для датасета на основе подключения AppMetrica доступны следующие группы метрик:

- Установки
- Аудитории
- Клиентские события
- Push-кампании
- Аудитории + соц.дем 

{% if audience != "internal" %}

Подключение к AppMetrica не поддерживает [материализацию](../../concepts/dataset/settings.md#materialization) и [публичный доступ](../../concepts/datalens-public.md) к объектам, созданным на его основе. Чтобы поделиться дашбордом или чартом, созданным на основе данного подключения, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% endif %}

{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}
