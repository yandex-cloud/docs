# Настроить доступ к реестру

Для [реестра](../../concepts/registry.md) можно настроить политики доступа с конкретных [IP-адресов](../../../vpc/concepts/address.md).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан реестр.
  1. В списке сервисов выберите **{{ container-registry-name }}**.
  1. Выберите реестр, доступ к которому нужно настроить.
  1. На панели слева нажмите ![IP-access](../../../_assets/container-registry/ip-access.svg) **Доступ для IP-адресов**.
  1. Нажмите **Настроить**.
  1. Введите IP-адрес и укажите действие. PULL — разрешение на скачивание, PUSH — разрешение на загрузку Docker-образов в реестр.
  1. Если нужно настроить доступ для нескольких IP-адресов, нажмите **Добавить**.
  1. Нажмите кнопку **Сохранить**.

- CLI

  1. Посмотрите список доступных реестров, их имена и идентификаторы:

     ```bash
     yc container registry list
     ```

     Результат:

     ```bash
     +----------------------------+---------------+--------------------------+
     |        ID                  |    NAME       |   FOLDER ID              |
     +----------------------------+---------------+--------------------------+
     |  <идентификатор_реестра>   | <имя_реестра> | <идентификатор_каталога> |
     +----------------------------+---------------+--------------------------+
     ```

  1. Задайте настройки доступа к реестру.

     ```bash
     yc container registry set-ip-permissions <имя_реестра> \
       --pull <IP-адрес> \
       --push <IP-адрес>
     ```

     Где:
     * `--pull` — флаг, разрешающий скачивание [Docker-образов](../../concepts/docker-image.md) из реестра.
     * `--push` — флаг, разрешающий загрузку Docker-образов в реестр.

     Более подробную информацию о команде смотрите в [справочнике CLI](../../../cli/cli-ref/managed-services/container/registry/set-ip-permissions).

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

     ```bash
     +--------+------------+
     | ACTION |    IP      |
     +--------+------------+
     | PULL   | <IP-адрес> |
     | PUSH   | <IP-адрес> |
     +--------+------------+
     ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Опишите в конфигурационном файле {{ TF }} настройки доступа к реестру.
  
     ```hcl
     resource "yandex_container_registry_ip_permission" "my_ip_permission" {
       registry_id = <идентификатор_реестра>
       push        = [ "<IP-адрес>", "<IP-адрес>" ]
       pull        = [ "<IP-адрес>", "<IP-адрес>" ]
     }
     ```
  
      Где:
   
      * `my_registry` — идентификатор реестра. Если в конфигурации уже есть ресурс [yandex_container_registry]({{ tf-provider-link }}/container_registry), вы можете указать на него, например `yandex_container_registry.my_registry.id`.
      * `pull` — IP-адреса, с которых разрешено скачивание Docker-образов из реестра. Необязательный параметр.
      * `push` — IP-адреса, с которых разрешена загрузка Docker-образов в реестр. Необязательный параметр.
      
      Более подробную информацию о параметрах `yandex_container_registry_ip_permission` в Terraform см. в [документации провайдера]({{ tf-provider-link }}/container_registry_ip_permission).

  1. Создайте ресурсы:
  
      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc container registry list-ip-permissions <имя_реестра>
     ```

{% endlist %}
