# Настроить защиту от удаления

Чтобы предотвратить случайное удаление статического публичного IP-адреса, [включите для него защиту от удаления](#enable-deletion-protection).

Если защита вам больше не нужна, вы можете [отключить ее](#disable).

## Включить защиту от удаления {#enable-deletion-protection}

{% list tabs %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором зарезервирован адрес.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. В строке с нужным IP-адресом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vpc.addresses.button_action-enable-protection }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_enable-protection }}**.

- CLI {#cli}

    {% include [include](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Просмотрите описание команды CLI для изменения атрибутов адреса:

        ```bash
        yc vpc address update --help
        ```

    1. Получите список адресов в каталоге:

        ```bash
        yc vpc address list
        ```

        Результат:

        ```text
        +----------------------+------+---------------+----------+------+
        |          ID          | NAME |    ADDRESS    | RESERVED | USED |
        +----------------------+------+---------------+----------+------+
        | e2l46k8conff******** |      | 84.201.177.41 | false    | true |
        +----------------------+------+---------------+----------+------+
        ```

    1. Включите защиту от удаления:

        ```bash
        yc vpc address update --deletion-protection <имя_или_идентификатор_адреса>
        ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Откройте актуальный конфигурационный файл с описанием инфраструктуры.

    1. Добавьте к описанию адреса параметр `deletion_protection`:


       ```hcl
       resource "yandex_vpc_address" "addr" {
         ...
         deletion_protection = true
         ...
       }
       ```

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Примените изменения.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы включить защиту IP-адреса от удаления, воспользуйтесь методом REST API [update](../api-ref/Address/update.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Update](../api-ref/grpc/Address/update.md) и передайте в запросе:

  * Идентификатор адреса, для которого нужно отключить защиту, в параметре `addressId`.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Имя параметра `deletionProtection` в параметре `updateMask`.
  * Значение `true` в параметре `deletionProtection`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Отключить защиту от удаления {#disable}

{% list tabs %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором зарезервирован адрес.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. В строке с нужным IP-адресом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vpc.addresses.button_action-disable-protection }}**.
   1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_disable-protection }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Просмотрите описание команды CLI для изменения атрибутов адреса:

      ```bash
      yc vpc address update --help
      ```

  1. Получите список адресов в каталоге:

      ```bash
      yc vpc address list
      ```

      Результат:

      ```text
      +----------------------+------+---------------+----------+------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED |
      +----------------------+------+---------------+----------+------+
      | e2l46k8conff******** |      | 84.201.177.41 | false    | true |
      +----------------------+------+---------------+----------+------+
      ```

  1. Отключите защиту от удаления:

      ```bash
      yc vpc address update --deletion-protection=false <имя_или_идентификатор_адреса>
      ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Откройте актуальный конфигурационный файл с описанием инфраструктуры.

    1. В описании адреса измените значение параметра `deletion_protection` на `false`:


       ```hcl
       resource "yandex_vpc_address" "addr" {
         ...
         deletion_protection = false
         ...
       }
       ```

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Примените изменения.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы отключить защиту IP-адреса от удаления, воспользуйтесь методом REST API [update](../api-ref/Address/update.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Update](../api-ref/grpc/Address/update.md) и передайте в запросе:

  * Идентификатор адреса, для которого нужно отключить защиту, в параметре `addressId`.

    {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

    {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  * Имя параметра `deletionProtection` в параметре `updateMask`.
  * Значение `false` в параметре `deletionProtection`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
