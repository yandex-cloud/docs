# Создание ресурса

Чтобы создать [ресурс](../../concepts/resource.md):

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. Если у вас еще нет CDN-ресурсов, нажмите кнопку **Подключиться к провайдеру**. Подключение происходит автоматически.

  1. Нажмите кнопку **Создать ресурс**.

  1. В блоке **Контент** выберите **Запрос контента** `Из одного источника` или `Из группы источников`:

      * При запросе контента `Из одного источника` выберите **Тип источника**: `Сервер`, `Бакет` или `L7-балансировщик`. Укажите источник. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).

      * При запросе контента `Из группы источников` выберите [группу источников](../../concepts/origins.md#groups) или создайте новую:
          * Нажмите кнопку **Создать новую**.
          * Введите **Название группы**.
          * Настройте **Источники**:
              * Укажите **Тип источника**: `Сервер`, `Бакет` или `L7-балансировщик`. Подробнее о типах см. в разделе [{#T}](../../concepts/origins.md).
              * Укажите источник.
              * Выберите **Приоритет**: `Основной` или `Резервный`. Подробнее о приоритетах см. в разделе [{#T}](../../concepts/origins.md#groups).
          * Добавьте другие источники, если необходимо.
          * Нажмите кнопку **Создать**. В поле **Группа источников** вы увидите название созданной группы.

     Подробнее см. в разделе [{#T}](../../concepts/origins.md).

  1. В блоке **Доменные имена для раздачи контента** введите **Доменное имя**. Вы можете добавить более одного **Доменного имени**. Поддерживаются имена с символами не из ASCII, например кириллическими, и [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode). Первое имя считается основным.

     {% note warning %}

     После создания ресурса изменить основное имя будет невозможно.

     {% endnote %}
      
     В настройках вашего DNS-хостинга создайте для указанных доменных имен CNAME-записи со значением, которое отображается внизу блока **Доменные имена для раздачи контента**. Подробнее см. в разделе [{#T}](../../concepts/resource.md#hostnames).

  1. В блоке **Дополнительно**:

      1. Выберите **Протокол для источников**.
      1. Выберите способ переадресации клиентов: `Не использовать`, `С HTTP на HTTPS` или `С HTTPS на HTTP`.
      1. Включите или выключите **Доступ конечных пользователей к контенту**.
      1. Если вы выбрали протокол `HTTP`, то в поле **Тип сертификата** выберите `Не использовать`. В других случаях выберите сертификат `Let's Encrypt®` или `Свой сертификат`. Подробнее см. в разделе [{#T}](../../concepts/clients-to-servers-tls.md).
      1. Выберите значение **Заголовка Host**: `Основное доменное имя`, `Как у клиента` или выберите `Свое значение` и введите **Значение заголовка**. Подробнее см. в разделе [{#T}](../../concepts/servers-to-origins-host.md).

  1. Нажмите кнопку **Создать**.

- CLI
  
  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Если вы создаете первый ресурс, сначала подключитесь к провайдеру:

      ```bash
      yc cdn provider activate --type gcore
      ```

  1. Посмотрите описание команды CLI для создания ресурсов:

      ```bash
      yc cdn resource create --help
      ```

  1. Получите список групп источников в каталоге:

      ```bash
      yc cdn origin-group list --format yaml
      ```
  
      Результат:

      ```bash
      - id: "90209"
        folder_id: somefolder7p3l5eobbd
        name: test-group-1
        use_next: true
        origins:
        - id: "561547"
          origin_group_id: "90209"
          source: www.example2.com
          enabled: true
          backup: true
        - id: "561546"
          origin_group_id: "90209"
          source: www.example1.com
          enabled: true
      - id: "90208"
        folder_id: b1g86q4m5vej8lkljme5
        name: test-group
        use_next: true
        origins:
        - id: "561545"
          origin_group_id: "90208"
          source: www.a2.com
          enabled: true
          backup: true
        - id: "561544"
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
        ```      

  1. Создайте ресурс:
  
      ```bash
      yc cdn resource create <доменное имя ресурса> \
        --origin-group-id <идентификатор группы источников> \
        --origin-protocol <протокол для источников>
      ```

      * Вместо группы источников `--origin-group-id` можно указать доменное имя источника, используя флаг `--origin-custom-source`.
      * Для `--origin-protocol` доступны значения `HTTP`, `HTTPS` и `MATCH` (как у клиента).

      Подробнее о команде `yc cdn resource create`  см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }}

  Поставщик CDN должен быть активирован до использования ресурсов CDN. Сделать это можно в [консоли управления]({{ link-console-main }}) или с помощью команды [YC CLI](../../../cli/quickstart.md):

  ```
  yc cdn provider activate --folder-id <идентификатор каталога> --type gcore
  ```

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

      
      ```hcl
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "0.69.0"
          }
        }
      }

      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<идентификатор облака>"
        folder_id = "<идентификатор каталога>"
        zone      = "<зона доступности>"
      }

      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
      }
      ```



      Где:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — флаг, указывающий на доступ к контенту для конечных пользователей. `True` — контент из CDN будет доступен клиентам. Необязательный параметр, значение по умолчанию: `true`.
      * `origin_protocol` — протокол для источников. Необязательный параметр, значение по умолчанию: `http`.
      * `secondary_hostnames` — дополнительные доменные имена. Необязательный параметр.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.

      Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/cdn_resource).

  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.

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

     Проверить изменение CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```

{% endlist %}

Создание ресурса занимает около 15 минут.

## Примеры {#examples}

{% list tabs %}

- CLI
  
  Создайте ресурс с протоколом HTTP:

    ```bash
    yc cdn resource create testexample.com \
      --origin-group-id 90209 \
      --origin-protocol HTTP
    ```

    Результат:

    ```bash
    id: someidkfjqjfl325fw

    ...

    cname: testexample.com
    active: true

    ...

    origin_group_id: "90209"
    origin_group_name: test-group-1
    origin_protocol: HTTP
    ssl_certificate:
    type: DONT_USE
    status: READY
    ```

{% endlist %}
