# Зарезервировать статический публичный IP-адрес

Вы можете зарезервировать публичный статический IP-адрес, чтобы потом использовать его для доступа к облачным ресурсам.

{% note info %}

Обратите внимание на [правила тарификации](../pricing.md#prices-public-ip) неактивных статических публичных адресов.

{% endnote %}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором нужно зарезервировать адрес.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Нажмите **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. В открывшемся окне:
       * В поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** выберите зону доступности, в которой нужно зарезервировать адрес.
       * (Опционально) В блоке **{{ ui-key.yacloud.vpc.addresses.popup-create_field_advanced }}** включите опции **{{ ui-key.yacloud.vpc.addresses.popup-create_field_ddos-protection-provider }}** и **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
   1. Нажмите **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.
  
- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Просмотрите описание команды CLI для резервирования адреса:

      ```bash
      yc vpc address create --help
      ```

   1. Зарезервируйте адрес, указав зону доступности:

      ```bash
      yc vpc address create --external-ipv4 zone={{ region-id }}-a
      ```

      Результат:

      ```bash
      id: e9b6un9gkso6********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-01-19T17:52:42Z"
      external_ipv4_address:
        address: 178.154.253.52
        zone_id: {{ region-id }}-a
        requirements: {}
      reserved: true
      ```

      Статический публичный IP-адрес зарезервирован.

- API

  Чтобы зарезервировать статический публичный IP-адрес, воспользуйтесь методом REST API [create](../api-ref/Address/create.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Create](../api-ref/grpc/address_service.md#Create).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя статического публичного IP-адреса. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `deletion_protection` — защита статического публичного IP-адреса от удаления. Пока опция включена, IP-адрес удалить невозможно. Значение по умолчанию `false`.
     * `external_ipv4_address` — описание ipv4-адреса:
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_address" "addr" {
       name = "<имя_статического_публичного_IP-адреса>"
       deletion_protection = "<защита_от_удаления:_true_или_false>"
       external_ipv4_address {
         zone_id = "<зона_доступности>"
       }
     }
     ```
     
     Более подробную информацию о параметрах ресурса `yandex_vpc_address` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_address).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc address list
     ```

{% endlist %}
