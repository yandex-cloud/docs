{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится реестр.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите реестр.
   1. На странице **Обзор** отобразится подробная информация о реестре.

- CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Получите подробную информацию о реестре:

  ```
  yc iot registry get <имя реестра>
  ```

  Результат:

  ```
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

- API

  Получить подробную информацию о реестре можно с помощью метода API [get](../../iot-core/api-ref/Registry/get).

{% endlist %}
