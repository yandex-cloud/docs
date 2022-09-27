# Создание группы источников

Чтобы создать [группу источников](../../concepts/origins.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать группу ресурсов.
  1. Выберите сервис **{{ cdn-short-name }}**.
  1. На панели слева выберите ![image](../../../_assets/cdn/origin-groups.svg) **Группы источников**.
  1. Нажмите кнопку **Создать группу источников**.
  1. Введите название группы.
  1. Настройте **Источники**:
     * Укажите **Тип источника**: `Сервер`, `Бакет` или `L7-балансировщик`. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).
     * Укажите источник.
     * Выберите **Приоритет**: `Основной` или `Резервный`. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
     * Добавьте другие источники, если необходимо.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы источников:

     ```
     yc cdn origin-group create --help
     ```

  1. Создайте группу источников в каталоге по умолчанию:

     ```
     yc cdn origin-group create --name <имя группы> \
       --origin source=<IP-адрес или доменное имя источника>,enabled=true \
       --origin source=<IP-адрес или доменное имя источника>,enabled=true,backup=true
     ```

     Где `origin` — спецификация источника:
     * `source` — IP-адрес или доменное имя источника.
     * `enabled` — флаг, указывающий, включен ли источник.
     * `backup` — флаг, указывающий, является ли источник резервным. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).

     Результат:

     ```
     id: "89018"
     folder_id: b1g86q4m5vej8lkljme5
     name: test-group
     use_next: true
     origins:
     - id: "559295"
       origin_group_id: "89018"
       source: www.example2.com
       enabled: true
       backup: true
     - id: "559294"
       origin_group_id: "89018"
       source: www.example1.com
       enabled: true
     ```

     Подробнее о команде `yc cdn origin-group create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/origin-group/create.md).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_cdn_origin_group`:

     Пример структуры конфигурационного файла:

     
     ```
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности по умолчанию>"
     }

     resource "yandex_cdn_origin_group" "my_group" {
       name = "<имя группы>"
       use_next = true
       origin {
        source = "<IP-адрес или доменное имя источника 1>"
       }
       origin {
        source = "<IP-адрес или доменное имя источника 2>"
       }
       origin {
        source = "<IP-адрес или доменное имя источника 3>"
        backup = false
       }
     }
     ```



     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/cdn_origin_group).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Создайте группу источников.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

{% endlist %}
