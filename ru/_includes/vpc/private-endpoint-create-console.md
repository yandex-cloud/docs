1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы хотите настроить сервисное подключение.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.vpc.switch_private-endpoints }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.vpc.private-endpoint.label_create-private-endpoint }}**.
1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_name }}** укажите название сервисного подключения. Требования к названию:

     {% include [name-format](../../_includes/name-format.md) %}

1. (Опционально) В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_description }}** добавьте описание.
1. (Опционально) Добавьте [метки](../../storage/concepts/tags.md):

   1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
   1. Введите метку в формате `ключ: значение`.
   1. Нажмите **Enter**.

1. В блоке **{{ ui-key.yacloud.vpc.private-endpoint.label_network-section }}**:

   1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_network }}** укажите сеть, для которой хотите создать сервисное подключение.
   1. Чтобы назначить случайный приватный IP-адрес, в поле **{{ ui-key.yacloud.vpc.private-endpoint.field_address-type }}** выберите `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_auto }}`.
   1. Чтобы зарезервировать список адресов:
   
      1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_address-id }}** выберите `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_list }}`.
      1. Нажмите **Зарезервировать**.
      1. В открывшемся окне:

         * Укажите имя и описание IP-адреса.
         * Выберите [подсеть](../../vpc/concepts/network.md#subnet).
         * Назначьте внутренний IPv4-адрес, например `172.16.0.3`.
         * Активируйте опцию **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**, чтобы адрес нельзя было удалить, пока вы не выключите защиту.
         * Добавьте метки.
         * Нажмите **{{ ui-key.yacloud.common.create }}**.
         * Повторите шаги для резервирования дополнительных IP-адресов.

   1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_service }}** выберите **{{ ui-key.yacloud.vpc.private-endpoint.label_endpoint-service_object-storage }}**.
   1. (Опционально) Активируйте опцию **{{ ui-key.yacloud.vpc.private-endpoint.label_dns-field-text }}**, чтобы при включении создать дополнительную DNS-запись A-типа для публичного [FQDN сервиса](../../vpc/concepts/address.md#fqdn). В ней будет указан внутренний IP-адрес, выделенный для сервисного подключения.

      {% include [private-endpoint-create-dns](private-endpoint-create-dns.md) %}

1. Нажмите **{{ ui-key.yacloud.common.create }}**.