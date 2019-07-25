# Удаление функции

{% include [yc-function-list](../../_includes/serverless-functions/function-list.md) %}

{% list tabs %}

- Консоль управления
  
    Чтобы удалить [функцию](../concepts/function.md):
    1. Откройте раздел **Serverless Functions** в каталоге, где требуется удалить функцию.
    1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке функции, которую требуется удалить.
    1. В открывшемся меню нажмите кнопку **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
  
- CLI
  
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    Удалите функцию:
    
    ```
    $ yc serverless function delete my-functions
    
    id: b09kk2ujb8js23f73b06
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486t34iut5q
    http_invoke_url: https://functions.cloud-preprod.yandex.net/b09kk2ujb8js23f73b06
    ```

{% endlist %}
