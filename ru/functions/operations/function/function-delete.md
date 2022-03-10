# Удаление функции

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Удалить функцию

{% list tabs %}

- Консоль управления
  
    Чтобы удалить [функцию](../../concepts/function.md):
    1. Откройте раздел **{{ sf-name }}** в каталоге, где требуется удалить функцию.
    1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) в строке функции, которую требуется удалить.
    1. В открывшемся меню нажмите кнопку **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
  
- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Удалите функцию:
    
    ```
    yc serverless function delete <имя функции>
    ```
    Результат:
    ```
    done (1s)    
    id: b09kk2ujb8js23f73b06
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-13T13:21:40.022Z"
    name: my-functions
    log_group_id: eolq9ac97486t34iut5q
    http_invoke_url: https://functions.yandexcloud.net/b09kk2ujb8js23f73b06
    status: DELETING
    ```

- Terraform

    {% include [terraform-definition](../../../_includes/tutorials/terraform-definition.md) %}

    Подробнее о Terraform [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Если вы создавали функцию с помощью Terraform, вы можете удалить ее:

    1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
    2. Удалите ресурсы с помощью команды:
       ```
       terraform destroy
       ```
       
       {% note alert %}
       
       Terraform удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.
       
       {% endnote %}
      
    3. Подтвердите удаление ресурсов.

- Yandex Cloud Toolkit

    Удалить функцию можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
