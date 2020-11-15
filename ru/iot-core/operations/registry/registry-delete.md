# Удаление реестра

{% note warning %}

Удалить можно только пустой реестр. Не забудьте [удалить устройства из реестра](../device/device-delete.md) перед началом операции.

{% endnote %}

Для обращения к [реестру](../../concepts/index.md#registry) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

{% list tabs %}

- Консоль управления

   Чтобы удалить реестр:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить реестр.
   1. Выберите сервис **{{ iot-name }}**.
   1. Справа от имени удаляемого реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите реестр:

      ```
      $ yc iot registry delete my-registry
      ```

  1. Проверьте, что реестр удален:

      ```
      $ yc iot registry list
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- Terraform

  {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

  Подробнее о Terraform [читайте в документации](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали реестр с помощью Terraform, вы можете удалить его:

   1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
   2. Удалите ресурсы с помощью команды:
      ```
      $ terraform destroy
      ```
      
      {% note alert %}
      
      Terraform удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.
      
      {% endnote %}
    
    3. Подтвердите удаление ресурсов.

{% endlist %}
