# Удалить сетевой балансировщик

{% list tabs %}

- Консоль управления
  
  Чтобы удалить [сетевой балансировщик](../concepts/index.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить балансировщик.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. В строке балансировщика, который требуется удалить, нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
  1. Подтвердите действие.
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../../cli/quickstart.md#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для удаления сетевого балансировщика:
  
     ```
     yc load-balancer network-load-balancer delete --help
     ```
  
  1. Получите список всех балансировщиков:
  
     ```
     yc load-balancer network-load-balancer list
     ```
	 
	 Результат:
	 
	 ```
     +----------------------+--------------------+-------+
     |          ID          | NAME               |  ...  |
     +----------------------+------+-------------+-------+
     ...
     | b7r97ah2jn5rmo6k1dsk | test-load-balancer |  ...  |
     ...
     +----------------------+------+-------------+-------+
     ```
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного балансировщика.
  1. Удалите балансировщик:
  
     ```
     yc load-balancer network-load-balancer delete b7r97ah2jn5rmo6k1dsk
     ```
  
  
- API
  
  Удалить сетевой балансировщик можно с помощью метода API [delete](../api-ref/NetworkLoadBalancer/delete.md).
  
- Terraform

  {% include [terraform-definition](../../_includes/tutorials/terraform-definition.md) %}

  Подробнее о Terraform [читайте в документации](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали сетевой балансировщик с помощью Terraform, вы можете удалить его:

   1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
   1. Удалите ресурсы с помощью команды:

      ```
      terraform destroy
      ```
      
      {% note alert %}
      
      Terraform удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.
      
      {% endnote %}
    
    3. Подтвердите удаление ресурсов.

{% endlist %}

## Примеры {examples}

### Удаление сетевого балансировщика из указанного каталога {from-folder}

{% list tabs %}

- CLI
  
  Чтобы удалить сетевой балансировщик из другого каталога, используйте флаги `--folder-id` или `--folder-name`.
  
  ```
  yc load-balancer network-load-balancer delete test-load-balancer --folder-id b1gnbfd11bq5g5vnjgr4
  ```
  
  ```
  yc load-balancer network-load-balancer delete test-load-balancer --folder-name test-folder
  ```
  
{% endlist %}