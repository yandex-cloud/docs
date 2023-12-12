# Включить программно-ускоренную сеть

Вы можете включить [программно-ускоренную сеть](../concepts/software-accelerated-network.md) при создании или изменении [виртуальной машины](../../glossary/vm.md).

{% note warning %}

Функциональность доступна только по согласованию с вашим аккаунт-менеджером.

{% endnote %}

Чтобы включить программно-ускоренную сеть на существующей ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. В строке с нужной ВМ нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instances.button_action-stop }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
  1. Подождите пока ВМ перейдет в статус `Stopped`, нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите опцию **{{ ui-key.yacloud.component.compute.resources.label_sw-accelerated-net }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.button_action-start }}** в правом верхнем углу.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

      ```bash
      yc compute instance update --help
      ```

  1. Получите список ВМ в каталоге по умолчанию:

      {% include [compute-instance-list](../../compute/_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ и остановите ее. Например, чтобы остановить ВМ с именем `first-instance`, выполните команду:

      ```bash
      yc compute instance stop first-instance
      ```

  1. Включите программно-ускоренную сеть:

      1. Выполните команду:

          ```bash
          yc compute instance update first-instance \
            --network-settings type=software-accelerated
          ```

          Где `--network-settings` — флаг, который переключает тип сети.

          Результат:

          ```text
          id: fhm0b28lgfp4********
          folder_id: b1gbnv36zqf5********
          created_at: "2023-05-24T09:28:11Z"
          name: first-instance
          zone_id: {{ region-id }}-a
          platform_id: standard-v3
          resources:
            memory: "2147483648"
            cores: "2"
            core_fraction: "100"
          status: STOPPED
          ...
          network_settings:
            type: SOFTWARE_ACCELERATED
          placement_policy: {}
          ```

      1. Запустите ВМ:

          ```bash
          yc compute instance start first-instance
          ```

  Чтобы выключить программно-ускоренную сеть, остановите ВМ и выполните команду:

    ```bash
    yc compute instance update first-instance \
      --network-settings type=standard
    ```

{% endlist %}
