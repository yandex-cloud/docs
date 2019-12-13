Запишите IAM-токен в переменную с помощью CLI и используйте токен в других запросах из командной строки. Пример запроса на получение списка облаков:

{% list tabs %}

- Bash

  ```bash
  $ export IAM_TOKEN=`yc iam create-token`
  $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

- Powershell

  ```
  $IAM_TOKEN=yc iam create-token
  curl.exe -H "Authorization: Bearer $IAM_TOKEN" https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
  ```

{% endlist %}
