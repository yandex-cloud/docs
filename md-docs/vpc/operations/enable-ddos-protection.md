# Включить защиту от DDoS-атак

[Защита от DDoS-атак](../ddos-protection/index.md) включается при [создании](../../compute/quickstart/quick-create-linux.md) виртуальной машины и [резервировании](get-static-ip.md) публичных IP-адресов.

Адреса с защитой выделяются из отдельного пула, поэтому включить или выключить защиту на ранее зарезервированном адресе невозможно.

## Включение защиты от DDoS-атак при создании виртуальной машины {#enable-on-vm-creation}
{% list tabs group=instructions %}

- Консоль управления {#console}

	В момент настройки сети на новой виртуальной машине выберите автоматически назначаемый публичный IP-адрес или выберите адрес из списка зарезервированных. 

	После выбора адреса выберите опцию **Защита от DDoS-атак**.

{% endlist %}

## Включение защиты от DDoS-атак при резервировании адреса {#enable-on-reservation}

{% list tabs group=instructions %}

- Консоль управления {#console}

	Чтобы зарезервировать защищенный статический IP-адрес:

	1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где требуется зарезервировать адрес.
	1. Перейдите в сервис **Virtual Private Cloud**.
	1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **Публичные IP-адреса**.
	1. Нажмите кнопку **Зарезервировать публичный IP-адрес**.
	1. Выберите зону доступности, в которой нужно зарезервировать адрес.
	1. Выберите опцию **Защита от DDoS-атак**.
	1. Нажмите кнопку **Зарезервировать**.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием статического публичного IP-адреса, добавив поле `ddos_protection_provider`:

     ```hcl
     resource "yandex_vpc_address" "addr" {
       name = "exampleAddress"
       external_ipv4_address {
         zone_id                  = "ru-central1-a"
         ddos_protection_provider = "qrator"
       }
     }
     ```

     Где `ddos_protection_provider` — параметр, включающий защиту от DDoS-атак. Возможные значения: `qrator`.

     Более подробную информацию о параметрах ресурса `yandex_vpc_address` в Terraform см. в [документации провайдера](../../terraform/resources/vpc_address.md).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить включение защиты от DDoS-атак при резервировании адреса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc address list
     ```

{% endlist %}