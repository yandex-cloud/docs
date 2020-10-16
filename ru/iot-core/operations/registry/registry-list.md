# Получение информации о реестре

Чтобы узнать `ID` или `NAME` реестра, получите список реестров в каталоге или подробную информацию о реестре.

## Получить список реестров в каталоге {#registry-list}

{% list tabs %}

- Консоль управления

   Чтобы просмотреть список реестров в каталоге:

   1. В [консоли управления](https://console.cloud.yandex.ru/) выберите каталог, в котором вы хотите получить список реестров.
   1. Выберите сервис **{{ iot-name }}**.

   В окне **Реестры** отобразится список реестров.

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [registry-list](../../../_includes/iot-core/registry-list.md) %}
  
{% endlist %}


## Получить подробную информацию о реестре {#registry-get}

Для обращения к реестру используйте параметры `ID` или `NAME` из [предыдущего](#registry-list) пункта.

{% list tabs %}

- Консоль управления

   Чтобы получить подробную информацию о реестре:

   1. В [консоли управления](https://console.cloud.yandex.ru/) выберите каталог, в котором вы хотите получить подробную информацию о реестре.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.

   В окне **Обзор** отобразится подробная информация о реестре.
   
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Получите подробную информацию о реестре:
  
  ```
  $ yc iot registry get my-registry
  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```
  
{% endlist %}
