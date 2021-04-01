{% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

Подробнее о Terraform [читайте в документации](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

Если вы создавали кластер с помощью Terraform, вы можете удалить его:

 1. В командной строке перейдите в каталог, в котором расположен конфигурационный файл Terraform.
 2. Удалите ресурсы с помощью команды:
    ```
    terraform destroy
    ```
    
    {% note alert %}
    
    Terraform удалит все ресурсы, которые были созданы с его помощью: кластеры, сети, подсети, виртуальные машины и т. д.
    
    {% endnote %}
  
  3. Подтвердите удаление ресурсов.