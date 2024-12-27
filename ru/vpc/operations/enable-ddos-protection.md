# Включить защиту от DDoS-атак

[Защита от DDoS-атак](../ddos-protection/index.md) включается при [создании](../../compute/quickstart/quick-create-linux.md) виртуальной машины и [резервировании](get-static-ip.md) публичных IP-адресов.

Адреса с защитой выделяются из отдельного пула, поэтому включить или выключить защиту на ранее зарезервированном адресе невозможно.

## Включение защиты от DDoS-атак при создании виртуальной машины {#enable-on-vm-creation}
{% list tabs group=instructions %}

- Консоль управления {#console}

	В момент настройки сети на новой виртуальной машине выберите автоматически назначаемый публичный IP-адрес или выберите адрес из списка зарезервированных. 

	После выбора адреса выберите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**.

{% endlist %}

## Включение защиты от DDoS-атак при резервировании адреса {#enable-on-reservation}

{% list tabs group=instructions %}

- Консоль управления {#console}

	Чтобы зарезервировать защищенный статический IP-адрес:

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется зарезервировать адрес.
	1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
	1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
	1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
	1. Выберите зону доступности, в которой нужно зарезервировать адрес.
	1. Выберите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**.
	1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием статического публичного IP-адреса, добавив поле `ddos_protection_provider`:

     ```hcl
     resource "yandex_vpc_address" "addr" {
       name = "exampleAddress"
       external_ipv4_address {
         zone_id                  = "{{ region-id }}-a"
         ddos_protection_provider = "qrator"
       }
     }
     ```

     Где `ddos_protection_provider` — параметр, включающий защиту от DDoS-атак. Возможные значения: `qrator`.

     Более подробную информацию о параметрах ресурса `yandex_vpc_address` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_address).

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить включение защиты от DDoS-атак при резервировании адреса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc address list
     ```

{% endlist %}
