# Создать пустой диcк

Вы можете создать пустой диск заданного размера.

{% list tabs %}

- Консоль управления
  
  1. В консоли управления выберите каталог, в котором нужно создать диск.
  1. Выберите сервис **{{ compute-name }}**.
  1. На странице **Виртуальные машины** перейдите на вкладку **Диски**.
  1. Нажмите кнопку **Создать диск**.
  1. Введите имя диска.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Если требуется, добавьте произвольное описание диска.
  1. Укажите нужный размер диска.
  1. Нажмите кнопку **Сохранить диск**.
  
- CLI
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для создания дисков:
  
      ```
      $ yc compute disk create --help
      ```
  
  1. Создайте диск в каталоге по умолчанию:
  
      ```
      $ yc compute disk create \
          --name first-disk \
          --size 10 \
          --description "my first disk via yc"
      ```
  
      Данная команда создаст диск размером 10 ГБ с именем `first-disk` и описанием `my first disk via yc`.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Получите список дисков в каталоге по умолчанию:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
      Получите тот же список c большим количеством деталей в формате YAML:
  
      ```
      $ yc compute disk list --format yaml
  
      - id: fhm4aq4hvq5g3nepvt9b
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: ru-central1-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5folrc3lsaf
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: ru-central1-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5la74mlde
          status: READY
          source_image_id: fdvk34al8k5nltb58shr
          instance_ids:
          - fhm5b617fjnj44ovhcun
      ```

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер Яндекс.Облака](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

  Чтобы создать пустой диск:

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_disk`.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_disk" "disk-1" {

       name = "empty-disk"
       type = "network-hdd"
       zone = "<зона доступности>"
       size = "<размер диска в ГБ>"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     2. Выполните проверку с помощью команды:

        ```
        $ terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  3. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        $ terraform apply
        ```

     2. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}
