# Создать образ на основе виртуальной машины {{ compute-name }}

Чтобы создать [пользовательский образ](../../concepts/images.md#custom-images) {{ cloud-desktop-name }} из [виртуальной машины](../../../compute/concepts/vm.md) {{ compute-name }}:
1. Если у вас еще нет ВМ, [создайте](../../../compute/operations/vm-create/create-linux-vm.md) ее.
1. Обратитесь в [техническую поддержку]({{ link-console-support }}) для подключения ВМ к {{ cloud-desktop-name }}.
1. [Создайте](../../../compute/operations/image-create/create-from-disk.md) образ из диска ВМ.
1. Добавьте образ в {{ cloud-desktop-name }}:

    {% list tabs %}

    - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан образ.
      1. В списке сервисов выберите **{{ cloud-desktop-name }}**.
      1. На панели слева выберите ![image](../../../_assets/cloud-desktop/images.svg) **Образы**.
      1. Нажмите кнопку **Добавить образ**.
      1. В поле **Источник образа** выберите **{{ compute-name }}**.
      1. В поле **Образ {{ compute-name }}** выберите образ, созданный ранее.
      1. Введите имя образа.
      1. Нажмите кнопку **Добавить**.

    {% endlist %}
