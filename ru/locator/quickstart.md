# Как начать работать c {{ locator-short-name }}

Этот раздел описывает, как определить местоположение устройства с помощью {{ locator-short-name }} API.

## Перед началом

1. [Получите идентификатор каталога](../resource-manager/operations/folder/get-id.md), на который у вас есть роль `editor` или выше. Подробнее о необходимых ролях в разделе [Управление доступом](security/index.md).

    Если каталога еще нет, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}
1. Получите IAM-токен, необходимый для аутентификации (чтобы получить IAM-токен для сервисного аккаунта, воспользуйтесь другой [инструкцией](../iam/operations/iam-token/create-for-sa.md)):

    {% list tabs %}

    - CLI

      ```
      yc iam create-token
      ```

    - API

      {% include [create-iam-token-api-steps](../_includes/iam/create-iam-token-api-steps.md) %}

    {% endlist %}

1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.

## Определите местоположение устройства

1. Создайте файл с телом запроса, например `body.json`.
    В запросе передайте всю информацию, доступную устройству:
    1. Доступные точки доступа Wi-Fi.
    2. Сигналы сетей мобильной связи.
    3. IP-адрес устройства.

    Подробное описание формата запроса смотрите в описании метода [getLocation](api-ref/Locator/getLocation.md).

    **body.json:**
    ```json
    {
        "folder_id": "b1gvmob95yysaplct532",
        "cell_towers": [{
            "mobile_country_code": 250,
            "mobile_network_code": 2,
            "cell_id": 197403650,
            "location_area_code": 9900,
            "signal_strength": -80
        }],
        "wifi_access_points": [{
            "bssid": "2CD02D814C80",
            "signal_strength": -68
        }],
        "ip":"95.108.173.231"
    }
    ```

1. Отправьте запрос на распознавание с помощью метода [getLocation](api-ref/Locator/getLocation.md) и сохраните ответ в файл, например `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://locator.{{ api-host }}/locator/v1/getLocation
    ```

    Если сервис успешно определит местоположение, он вернет ответ с координатами точки и радиусом погрешности:

    ```json
    {
        "location": {
            "latitude": 55.743675,
            "longitude": 37.5646301,
            "precision": 701.71643
        }
    }
    ```

    Если местоположение определить не удалось, сервис вернет [сообщение об ошибке](api-ref/errors-handling.md).