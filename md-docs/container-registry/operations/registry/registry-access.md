# Настроить доступ к реестру

Для [реестра](../../concepts/registry.md) можно настроить политики доступа с конкретных [IP-адресов](../../../vpc/concepts/address.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан реестр.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр, доступ к которому нужно настроить.
  1. На панели слева нажмите ![IP-access](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.cr.registry.label_ip-permissions }}**.
  1. Нажмите **{{ ui-key.yacloud.cr.registry.button_update-ip-permissions }}**.
  1. Введите IP-адрес и укажите действие. PULL — разрешение на скачивание, PUSH — разрешение на загрузку [Docker-образов](../../concepts/docker-image.md) в реестр.
  1. Если нужно настроить доступ для нескольких IP-адресов, нажмите **{{ ui-key.yacloud.common.add }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Посмотрите список доступных реестров, их имена и идентификаторы:

     ```bash
     yc container registry list
     ```

     Результат:

     ```text
     +----------------------+--------+----------------------+
     |          ID          |  NAME  |      FOLDER ID       |
     +----------------------+--------+----------------------+
     | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
     +----------------------+--------+----------------------+
     ```

  1. Задайте настройки доступа к реестру:

     ```bash
     yc container registry set-ip-permissions <имя_реестра> \
       --pull <IP-адрес> \
       --push <IP-адрес>
     ```

     Где:
     * `--pull` — флаг, разрешающий скачивание [Docker-образов](../../concepts/docker-image.md) из реестра.
     * `--push` — флаг, разрешающий загрузку Docker-образов в реестр.

     Более подробную информацию о команде смотрите в [справочнике CLI](../../../cli/cli-ref/container/cli-ref/registry/set-ip-permissions.md).

     Выполнение этой команды приведет к удалению всех существующих разрешений для IP-адресов. Чтобы продолжить, введите значение `yes` и нажмите **Enter**.

     Результат:

     ```text
     WARN: All current ip permissions will be deleted. Are you sure?[y/N]
     ```

  1. Проверьте назначенные ограничения:

     ```bash
     yc container registry list-ip-permissions <имя_реестра>
     ```

     Результат:

     ```text
     +--------+-----------+
     | ACTION |    IP     |
     +--------+-----------+
     | PULL   | 10.1.2.11 |
     | PUSH   | 10.1.2.11 |
     +--------+-----------+
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле {{ TF }} настройки доступа к реестру.

     ```hcl
     resource "yandex_container_registry_ip_permission" "my_ip_permission" {
       registry_id = <идентификатор_реестра>
       push        = [ "<IP-адрес>", "<IP-адрес>" ]
       pull        = [ "<IP-адрес>", "<IP-адрес>" ]
     }
     ```

     Где:
     * `my_registry` — идентификатор реестра. Если в конфигурации уже есть ресурс [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry), вы можете указать на него, например `yandex_container_registry.my_registry.id`.
     * `pull` — IP-адреса, с которых разрешено скачивание [Docker-образов](../../concepts/docker-image.md) из реестра. Необязательный параметр.
     * `push` — IP-адреса, с которых разрешена загрузка Docker-образов в реестр. Необязательный параметр.

     Более подробную информацию о параметрах `yandex_container_registry_ip_permission` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/container_registry_ip_permission).
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc container registry list-ip-permissions <имя_реестра>
     ```

{% endlist %}