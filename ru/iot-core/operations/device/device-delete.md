# Удаление устройства

Для обращения к [устройству](../../concepts/index.md#device) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [{#T}](device-list.md).

{% list tabs %}

- Консоль управления

   Чтобы удалить устройство:

   1. В [консоли управления](https://console.cloud.yandex.ru/) выберите каталог, из которого вы хотите удалить устройство.
   1. Выберите сервис **{{ iot-name }}**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **Удалить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Удалите устройство:

      ```
      $ yc iot device delete my-device
      ```

  1. Проверьте, что устройство действительно удалено:

      ```
      $ yc iot device list --registry-name my-registry
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- Terraform

  {% include [terraform-definition](../../../solutions/_solutions_includes/terraform-definition.md) %}

  Подробнее о Terraform [читайте в документации](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали устройство с помощью Terraform, вы можете удалить его:

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
