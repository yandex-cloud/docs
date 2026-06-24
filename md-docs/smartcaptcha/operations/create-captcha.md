# Создать капчу

SmartCaptcha позволяет создавать [капчи](../concepts/validation.md) нескольких уровней сложности для разных входящих запросов. Уровень сложности запроса определяется по базовым параметрам входящего трафика.

При создании капчи вы можете:

* Подключить капчу к нескольким сайтам.
* Настроить внешний вид капчи: фон, состояния и ошибки, стиль кнопки **Я не робот**, светлую и темную тему.
* Выбрать тип задания и сложность прохождения капчи.
* Показывать разные варианты капчи в зависимости от параметров входящего запроса. Например, выбрать разную капчу для пользователей из разных регионов.

{% note info %}

Чтобы сделать вашу защиту более эффективной, мы используем информацию об HTTP-запросах для развития моделей машинного обучения (ML). Вы можете отключить использование этой информации в [консоли управления](https://console.yandex.cloud) при создании капчи или позднее в ее настройках.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Yandex SmartCaptcha**.
  1. Нажмите **Создать капчу**.

  1. Укажите **Имя** создаваемой капчи:

      * длина — от 2 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md):

     1. Нажмите **Добавить метку**.
     1. Введите метку в формате `ключ: значение`.
     1. Нажмите **Enter**.
  1. (Опционально) Выберите [**Отключить проверку домена**](../concepts/domain-validation.md).
  1. Введите **Список хостов** в формате IP-адресов или доменных имен. Указывайте адрес без протокола и без `/` в конце, например, `example.com`.

     Капча будет работать и во всех поддоменах указанных доменных имен.

  1. Настройте **Внешний вид** кнопки **Я не робот** и окна с заданием:
     * (Опционально) Включите опцию **Динамическая цветовая схема**, если хотите включить автоматическое изменение цветовой схемы капчи в зависимости от темы браузера.

     * В разделах **Настройка стандартной цветовой схемы** и **Настройка тёмной цветовой схемы** вы можете задать свои параметры окна задания и других элементов: через форму или через описание стилей в формате `JSON`.

      Все изменения будут отображаться в окне предпросмотра.

     ![step4-8](../../_assets/smartcaptcha/create-captcha/step4-8.png)

  1. Настройте **Варианты заданий**. Вы можете указать только капчу по умолчанию или добавить дополнительные [варианты](../concepts/captcha-variants.md), если по разным входящим запросам нужно показывать разную капчу.
  
  1. Для варианта **По умолчанию** укажите:
      * **Основное задание** — тип [основного задания](../concepts/tasks.md#main-task), которое предлагается решить пользователю.
      * **Дополнительное задание** — тип [дополнительного задания](../concepts/tasks.md#additional-task), которое предлагается решить пользователю.
      * **Сложность** — [сложность](../concepts/tasks.md#task-difficulty) задания, которое увидит пользователь:
      * `Легкая` — простое задание.
      * `Средняя` — задание среднего уровня сложности.
      * `Высокая` — сложное задание.
      * `Максимальная` — сложное задание с дополнительным вопросом. От пользователя требуется решение дополнительного задания, вне зависимости от результатов выполнения основного задания.

        Пример задания можно посмотреть в окне предпросмотра.

        {% note info %}
        
        Функциональность вариантов заданий и правил показа находится на стадии [Preview](../../overview/concepts/launch-stages.md).
        
        {% endnote %}

  1. Чтобы по разным запросам показывать разную капчу:
     1. Нажмите кнопку **Добавить вариант** и задайте настройки аналогично капче по умолчанию.

        Чтобы удалить вариант, нажмите ![options](../../_assets/console-icons/trash-bin.svg). Если вариант используется в правиле показа, удалить его нельзя

     1. Добавьте [правила для входящего трафика](../concepts/captcha-variants.md#captcha-view-rules), которые будут определять, какой вариант капчи показывать:
         * Нажмите кнопку **Добавить правило**.
         * Введите имя и описание правила.
         * Выберите вариант капчи.
         * Укажите приоритет правила от `1` до `999999`.
          
            Правила проверяются в порядке приоритета от меньшего к большему: `1`, `2` и так далее. Если трафик соответствует нескольким правилам, к нему применится первое сработавшее правило.
          
         * Укажите одно или несколько [условий для входящего трафика](../concepts/captcha-variants.md#traffic-conditions):
            * `IP` — IP-адрес, диапазон адресов или регион IP-адресов;
            * `HTTP header` — строка в заголовке HTTP;
            * `URI` — путь входящего запроса к сайту;
            * `Host` — домен, на который пришел запрос;
            * `Metadata` — [дополнительные данные](../concepts/captcha-variants.md#metadata), передаваемые с фронтенда.
           
         * Нажмите кнопку **Добавить**.
          
            Чтобы удалить правило, нажмите ![options](../../_assets/console-icons/trash-bin.svg). Правило по умолчанию удалить нельзя.

     1. Таким же способом добавьте другие варианты капчи и правила для входящего трафика.

     ![step10-11](../../_assets/smartcaptcha/create-captcha/step10-11.png)

  1. (Опционально) Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **Обучение ML-моделей**.
   
  1. Нажмите **Создать**.

     ![step12-13](../../_assets/smartcaptcha/create-captcha/step12-13.png)

  Капча отобразится на странице сервиса в разделе **Список капч**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания капчи:

     ```bash
     yc smartcaptcha captcha create --help
     ```

  1. Создайте капчу:

     ```bash
     yc smartcaptcha captcha create \
       --name <имя_капчи> \
       --turn-off-hostname-check \
       --allowed-site <первый_хост>,<второй_хост> \
       --pre-check-type <тип_основного_задания> \
       --challenge-type <тип_дополнительного_задания> \
       --style-json '{"light":"<объект_json>", "dark":"<объект_json>"}' \
       --complexity <сложность_задания> \
       --security-rules-file <путь_к_файлу_с_вариантами>.yaml \
       --override-variants-file <путь_к_файлу_с_правилами>.yaml
     ```
 
     Где:
     * `--name` — имя капчи.
     * `--turn-off-hostname-check` — [отключение проверки домена](../concepts/domain-validation.md). Необязательный параметр.
     * `--allowed-site` — список хостов в формате IP-адресов или доменных имен. Указывайте адрес без протокола и без `/` в конце, например, `example.com`. Капча будет работать и во всех поддоменах указанных доменных имен. Необязательный параметр.
     * `--pre-check-type` — тип [основного задания](../concepts/tasks.md#main-task) по умолчанию, которое предлагается решить пользователю. Возможные значения:
       * `CHECKBOX` — чекбокс.
       * `SLIDER` — слайдер.
     * `--challenge-type` — тип [дополнительного задания](../concepts/tasks.md#additional-task) по умолчанию, которое предлагается решить пользователю. Возможные значения:
       * `IMAGE_TEXT` — распознавание текста.
       * `SILHOUETTES` — силуэт.
       * `KALEIDOSCOPE` — калейдоскоп.
     * `--style-json` — настройки цветовой темы в формате `JSON`. Чтобы настроить динамическую цветовую схему, используйте ключи `light` и `dark` со значениями в виде отдельных JSON-объектов. Цветовую схему обоих типов можно настроить в [консоли управления](https://console.yandex.cloud) и скопировать в формате JSON на вкладке `JSON`. Необязательный параметр. Подробнее в [примере](#with-rules).
     * `--complexity` — [сложность](../concepts/tasks.md#task-difficulty) задания по умолчанию. Возможные значения:
       * `EASY` — простое задание.
       * `MEDIUM` — задание среднего уровня сложности.
       * `HARD` — сложное задание.
       * `FORCE_HARD` — сложное задание с дополнительным вопросом. От пользователя требуется решение дополнительного задания, вне зависимости от результатов выполнения основного задания.
 
       {% note info %}
       
       Функциональность вариантов заданий и правил показа находится на стадии [Preview](../../overview/concepts/launch-stages.md).
       
       {% endnote %}
 
     * `--override-variants-file` — путь к файлу в формате `YAML` с [вариантами](../concepts/captcha-variants.md) заданий. Необязательный параметр.
 
       {% cut "Пример файла с вариантами заданий" %}
 
       ```yaml
       - uuid: <идентификатор_варианта_1>
         description: <описание_варианта_1>
         complexity: <сложность_задания>
         pre_check_type: <основное_задание>
         challenge_type: <дополнительное_задание>
       - uuid: <идентификатор_варианта_2>
         description: <описание_варианта_2>
         complexity: <сложность_задания>
         pre_check_type: <основное_задание>
         challenge_type: <дополнительное_задание>
       ```
 
       Где:
       * `uuid` — уникальный идентификатор варианта задания.
       * `description` — описание варианта задания. 
       * `complexity` — сложность задания, которое увидит пользователь.
       * `pre_check_type` — тип основного задания, которое предлагается решить пользователю.
       * `challenge_type` — тип дополнительного задания, которое предлагается решить пользователю.
 
       {% endcut %}
     
     * `--security-rules-file` — путь к файлу в формате `YAML` с [правилами для входящего трафика](../concepts/captcha-variants.md#captcha-view-rules), которые будут определять, какой вариант капчи показывать. Необязательный параметр.
 
       {% cut "Пример файла с правилами для входящего трафика" %}
 
       ```yaml
       - name: <название_правила_1>
         priority: "<приоритет_правила_1>"
         description: <описание_правила_1>
         override_variant_uuid: <идентификатор_варианта_задания>
         condition:
           host:
             hosts:
               - exact_match: example.com
               - exact_match: example.net
       - name: <название_правила_2>
         priority: "<приоритет_правила_2>"
         description: <описание_правила_2>
         override_variant_uuid: <идентификатор_варианта_задания>
         condition:
           source_ip:
             geo_ip_match:
               locations:
                 - ru
                 - kz
       ```
 
       Где:
       * `name` — имя правила.
       * `priority` — приоритет правила от `1` до `999999`.
         
         Правила проверяются в порядке приоритета от меньшего к большему: `1`, `2` и так далее. Если трафик соответствует нескольким правилам, к нему применится первое сработавшее правило.
 
       * `description` — описание правила. Необязательный параметр.
       * `override_variant_uuid` — идентификатор варианта задания, которое будет отображаться в случае соответствия трафика правилу. Если параметр не указан, будет отображаться задание по умолчанию.
       * `condition` — одно или несколько [условий для входящего трафика](../concepts/captcha-variants.md#traffic-conditions). Необязательный параметр.
 
       {% endcut %}

  Результат:
  
  ```text
  id: bpnd6cm6qpr5********
  folder_id: b1g0ijbfaqsn********
  cloud_id: b1gia87mbaom********
  client_key: ysc1_2lla0Yn6dhlnEaTv2QNg2BhuA8Nqlyk4L7pZk3dz********
  created_at: "2025-03-02T21:38:48.830498Z"
  name: my-first-captcha
  allowed_sites:
    - exmaple.ru
    - exmaple.kz
  complexity: MEDIUM
  style_json: '{"focus-color":"rgb(250, 192, 0)","base-background-color":"#fff"}'
  turn_off_hostname_check: true
  pre_check_type: CHECKBOX
  challenge_type: IMAGE_TEXT
  security_rules:
    - name: rule1
      priority: "11"
      description: My first security rule.
      condition:
        host:
          hosts:
            - exact_match: example.com
            - exact_match: example.net
      override_variant_uuid: variant-1
    - name: rule2
      priority: "12"
      condition:
        source_ip:
        geo_ip_match:
          locations:
            - ru
            - kz
      override_variant_uuid: variant-2
  override_variants:
    - uuid: variant-1
      description: override variant 1
      complexity: EASY
      pre_check_type: CHECKBOX
      challenge_type: SILHOUETTES
    - uuid: variant-2
      description: override variant 2
      complexity: HARD
      pre_check_type: SLIDER
      challenge_type: KALEIDOSCOPE
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать капчу:

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_smartcaptcha_captcha" "<имя_капчи>" {
       name                    = "<имя_капчи>"
       turn_off_hostname_check = True  
       complexity              = "<сложность_задания>"
       pre_check_type          = "<тип_основного_задания>"
       challenge_type          = "<тип_дополнительного_задания>"
     
       style_json = jsonencode({
         light    = jsonencode(<объект_json>)
         dark = jsonencode(<объект_json>)
       })
     
       allowed_sites = [
         "<первый_хост>",
         "<второй_хост>"
       ]
     
       # Первый вариант задания
       override_variant {
         uuid        = "<идентификатор_варианта_1>"
         description = "<описание_варианта_1>"
     
         complexity     = "<сложность_задания>"
         pre_check_type = "<основное_задание>"
         challenge_type = "<дополнительное_задание>"
       }
     
       # Второй вариант задания 
       override_variant {
         uuid        = "<идентификатор_варианта_2"
         description = "<описание_варианта_2>"
     
         complexity     = "<сложность_задания>"
         pre_check_type = "<основное_задание>"
         challenge_type = "<дополнительное_задание>"
       }
     
       # Первое правило
       security_rule {
         name                  = "<название_правила_1>"
         priority              = <приоритет_правила_1>
         description           = "<описание_правила_1>"
         override_variant_uuid = "<идентификатор_варианта_задания>"
     
         condition {
           host {
             hosts {
               exact_match = "example.com"
             }
             hosts {
               exact_match = "example.net"
             }
           }
         }
       }
     
       # Второе правило
       security_rule {
         name                  = "<название_правила_2>"
         priority              = <приоритет_правила_2>
         description           = "<описание_правила_2>"
         override_variant_uuid = "<идентификатор_варианта_задания>"
     
         condition {
           source_ip {
             geo_ip_match {
               locations = ["ru", "kz"]
             }
           }
         }
       }
     }
     ```

     Где:
     * `name` — имя капчи.
     * `turn_off_hostname_check` — [отключение проверки домена](../concepts/domain-validation.md). Необязательный параметр.     
     * `complexity` — [сложность](../concepts/tasks.md#task-difficulty) задания по умолчанию, которое увидит пользователь. Возможные значения:
       * `EASY` — простое задание.
       * `MEDIUM` — задание среднего уровня сложности.
       * `HARD` — сложное задание.
       * `FORCE_HARD` — сложное задание с дополнительным вопросом. От пользователя требуется решение дополнительного задания, вне зависимости от результатов выполнения основного задания.

       {% note info %}
       
       Функциональность вариантов заданий и правил показа находится на стадии [Preview](../../overview/concepts/launch-stages.md).
       
       {% endnote %}

     * `pre_check_type` — тип [основного задания](../concepts/tasks.md#main-task) по умолчанию, которое предлагается решить пользователю. Возможные значения:
       * `CHECKBOX` — чекбокс.
       * `SLIDER` — слайдер.
     * `challenge_type` — тип [дополнительного задания](../concepts/tasks.md#additional-task) по умолчанию, которое предлагается решить пользователю. Возможные значения:
       * `IMAGE_TEXT` — распознавание текста.
       * `SILHOUETTES` — силуэт.
       * `KALEIDOSCOPE` — калейдоскоп.
     * `style_json` — настройки цветовой темы в формате `JSON`. Чтобы настроить динамическую цветовую схему, используйте ключи `light` и `dark` со значениями в виде отдельных JSON-объектов. Цветовую схему обоих типов можно настроить в [консоли управления](https://console.yandex.cloud) и скопировать в формате JSON на вкладке `JSON`. Необязательный параметр.
     * `allowed_sites` — список хостов в формате IP-адресов или доменных имен. Указывайте адрес без протокола и без `/` в конце, например, `example.com`. Капча будет работать и во всех поддоменах указанных доменных имен. Необязательный параметр.
     * `override_variant` — блок с описанием [варианта](../concepts/captcha-variants.md) задания. Необязательный параметр.
       * `uuid` — уникальный идентификатор варианта задания.
       * `description` — описание варианта задания. Необязательный параметр.
       * `complexity` — сложность задания, которое увидит пользователь.
       * `pre_check_type` — тип основного задания, которое предлагается решить пользователю.
       * `challenge_type` — тип дополнительного задания, которое предлагается решить пользователю.
     * `security_rule` — блок с описанием [правила для входящего трафика](../concepts/captcha-variants.md#captcha-view-rules), которое будет определять, какой вариант капчи показывать. Необязательный параметр.
       * `name` — имя правила.
       * `priority` — приоритет правила от `1` до `999999`.

         Правила проверяются в порядке приоритета от меньшего к большему: `1`, `2` и так далее. Если трафик соответствует нескольким правилам, к нему применится первое сработавшее правило.

       * `description` — описание правила. Необязательный параметр.
       * `override_variant_uuid` — идентификатор варианта задания, которое будет отображаться в случае соответствия трафика правилу. Если параметр не указан, будет отображаться задание по умолчанию.
       * `condition` — одно или несколько [условий для входящего трафика](../concepts/captcha-variants.md#traffic-conditions). Необязательный параметр.

     Подробнее о параметрах ресурса `yandex_smartcaptcha_captcha` в [документации провайдера](../../terraform/resources/smartcaptcha_captcha.md).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc smartcaptcha captcha list
     ```

- API {#api}

  Чтобы создать капчу, воспользуйтесь методом REST API [create](../api-ref/Captcha/create.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [Captcha/Create](../api-ref/grpc/Captcha/create.md).

{% endlist %}

## Примеры {#examples}

### Создание капчи для всех запросов {#without-rules}

Создайте простую капчу без правил для входящего трафика с именем `simple-captcha`.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc smartcaptcha captcha create simple-captcha
  ```

  Результат:
  ```text
  id: bpn7pri980fs********
  folder_id: b1g0ijbfaqsn********
  cloud_id: b1gia87mbaom********
  client_key: ysc1_BFhJblC4DfttmEV6ORqfZK99DuaTQyYxPoF4V6yp********
  created_at: "2025-05-29T05:29:05.373420Z"
  name: simple-captcha
  complexity: MEDIUM
  pre_check_type: CHECKBOX
  challenge_type: IMAGE_TEXT
  ```

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры ресурса:

     ```hcl
     resource "yandex_smartcaptcha_captcha" "simple-captcha" {
       name           = "simple-captcha"
       complexity     = "HARD"
       pre_check_type = "SLIDER"
       challenge_type = "IMAGE_TEXT"
     }
     ```

     Подробнее о параметрах ресурса `yandex_smartcaptcha_captcha` в [документации провайдера](../../terraform/resources/smartcaptcha_captcha.md).

  1. Создайте капчу:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/Captcha/create.md) и передайте в теле запроса идентификатор каталога и имя капчи:

  ```json
  {
    "folderId": "b1g0ijbfaqsn********",
    "name": "simple-captcha"
  }
  ```

{% endlist %}

### Создание капчи с правилами входящего трафика и настроенной цветовой схемой {#with-rules}

Создайте капчу с правилами входящего трафика с тестовыми характеристиками:

* Имя: `advanced-captcha`.
* Проверка домена: отключена.
* Внешний вид, описанный в файле `style.json`:

  * Стандартная цветовая схема:

    ```json
    {
        "text-color-primary": "#1e1f20",
        "base-background-color": "#c7d0d6",
        "popup-image-container-background-color": "#aab4ba",
        "base-checkbox-background-color": "#5a7080",
        "base-checkbox-background-color-checked": "#5a7080",
        "base-checkbox-border": "2px solid #5a7080",
        "base-checkbox-spin-color": "#5a7080",
        "popup-textinput-background-color": "#c7d0d6",
        "popup-action-button-background-color": "#5a7080",
        "popup-action-button-background-color-hover": "#485863"
    }
    ```

  * Динамическая цветовая схема:
  
    ```json
    {
      "light": {
        "text-color-primary": "#1e1f20",
        "base-background-color": "#c7d0d6",
        "popup-image-container-background-color": "#aab4ba",
      },
      "dark": {
        "text-color-primary": "#e6e8eb",
        "base-background-color": "#2b2f34",
        "popup-image-container-background-color": "#1f2328",
      }
    }
    ```

* Список хостов: `example.ru`, `example.kz`.
* Параметры задания по умолчанию:
  * Сложность задания: `HARD`.
  * Тип основного задания: `SLIDER`.
  * Тип дополнительного задания: `IMAGE_TEXT`.
* Параметры первого варианта задания:
  * Уникальный идентификатор варианта: `variant-1`.
  * Описание варианта: `Simple variant`.
  * Сложность задания: `EASY`.
  * Тип основного задания: `CHECKBOX`.
  * Тип дополнительного задания: `SILHOUETTES`.
* Параметры второго варианта задания:
  * Уникальный идентификатор варианта: `variant-2`.
  * Описание варианта: `Hard variant`.
  * Сложность задания: `HARD`.
  * Тип основного задания: `SLIDER`.
  * Тип дополнительного задания: `KALEIDOSCOPE`.
* Параметры первого правила для входящего трафика:
  * Имя правила: `rule-1`.
  * Приоритет правила: `11`.
  * Описание правила: `My first security rule`.
  * Идентификатор варианта задания: `variant-1`.
  * Условия для входящего трафика: хост совпадает с `example.com` или `example.net`.
* Параметры второго правила для входящего трафика:
  * Имя правила: `rule-2`.
  * Приоритет правила: `12`.
  * Описание правила: `My second security rule`.
  * Идентификатор варианта задания: `variant-2`.
  * Условия для входящего трафика: IP принадлежит региону `ru` или `kz`.

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc smartcaptcha captcha create \
    --name advanced-captcha \
    --turn-off-hostname-check \
    --allowed-site example.ru,example.kz \
    --style-json "$(cat ./style.json)" \
    --pre-check-type CHECKBOX \
    --challenge-type IMAGE_TEXT \
    --complexity HARD \
    --override-variants-file captcha-variants.yaml \
    --security-rules-file captcha-rules.yaml
  ```

  {% cut "Файл с вариантами заданий `captcha-variants.yaml`" %}

  ```yaml
  - uuid: variant-1
    description: Simple variant
    complexity: EASY
    pre_check_type: CHECKBOX
    challenge_type: SILHOUETTES
  - uuid: variant-2
    description: Hard variant
    complexity: HARD
    pre_check_type: SLIDER
    challenge_type: KALEIDOSCOPE
  ```

  {% endcut %}
  
  {% cut "Файл с правилами для входящего трафика `captcha-rules.yaml`" %}

  ```yaml
  - name: rule1
    priority: "11"
    description: My first security rule
    override_variant_uuid: variant-1
    condition:
      host:
        hosts:
          - exact_match: example.com
          - exact_match: example.net
  - name: rule2
    priority: "12"
    description: My second security rule
    override_variant_uuid: variant-2
    condition:
      source_ip:
        geo_ip_match:
          locations:
            - ru
            - kz
  ```

  {% endcut %}

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры ресурса с описанием вариантов заданий и правил для входящего трафика:

     ```hcl
     resource "yandex_smartcaptcha_captcha" "advanced-captcha" {
       name                    = "advanced-captcha"
       turn_off_hostname_check = true
       style_json              = "${file("style.json")}"
       complexity              = "HARD"
       pre_check_type          = "SLIDER"
       challenge_type          = "IMAGE_TEXT"
     
       allowed_sites = [
         "example.ru",
         "example.kz"
       ]
     
       override_variant {
         uuid        = "variant-1"
         description = "Simple variant"
     
         complexity     = "EASY"
         pre_check_type = "CHECKBOX"
         challenge_type = "SILHOUETTES"
       }
     
       override_variant {
         uuid        = "variant-2"
         description = "Hard variant"
     
         complexity     = "HARD"
         pre_check_type = "SLIDER"
         challenge_type = "KALEIDOSCOPE"
       }
     
       security_rule {
         name                  = "rule-1"
         priority              = 11
         description           = "My first security rule"
         override_variant_uuid = "variant-1"
     
         condition {
           host {
             hosts {
               exact_match = "example.com"
             }
             hosts {
               exact_match = "example.net"
             }
           }
         }
       }
     
       security_rule {
         name                  = "rule-2"
         priority              = 12
         description           = "My second security rule"
         override_variant_uuid = "variant-2"
     
         condition {
           source_ip {
             geo_ip_match {
               locations = ["ru", "kz"]
             }
           }
         }
       }
     }
     ```

     Подробнее о параметрах ресурса `yandex_smartcaptcha_captcha` в [документации провайдера](../../terraform/resources/smartcaptcha_captcha.md).

  1. Создайте капчу:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

- API {#api}

  Воспользуйтесь методом API [create](../api-ref/Captcha/create.md) и передайте в теле запроса:
  
  ```json
  {
    "folderId": "b1g0ijbfaqsn********",
    "name": "advanced-captcha",
    "allowedSites": [
      "example.ru",
      "example.kz"
    ],
    "complexity": "HARD",
    "styleJson": "styleJson": "{\"text-color-primary\": \"#1e1f20\", \"base-background-color\": \"#c7d0d6\", \"popup-image-container-background-color\": \"#aab4ba\", \"base-checkbox-background-color\": \"#5a7080\", \"base-checkbox-background-color-checked\": \"#5a7080\", \"base-checkbox-border\": \"2px solid #5a7080\", \"base-checkbox-spin-color\": \"#5a7080\", \"popup-textinput-background-color\": \"#c7d0d6\", \"popup-action-button-background-color\": \"#5a7080\", \"popup-action-button-background-color-hover\": \"#485863\" }",
    "turnOffHostnameCheck": "TRUE",
    "preCheckType": "SLIDER",
    "challengeType": "IMAGE_TEXT",
    "securityRules": [
      {
        "name": "rule-1",
        "priority": "11",
        "description": "My first security rule",
        "condition": {
          "host": {
            "hosts": [
              { "exactMatch": "example.com" },
              { "exactMatch": "example.net" }
            ]
          }
        },
        "overrideVariantUuid": "variant-1"
      },
      {
        "name": "rule-2",
        "priority": "12",
        "description": "My second security rule",
        "condition": {
          "geoIpMatch": {
            "ipRangesMatch": {
              "locations": [
                "ru",
                "kz"
              ]
            }
          }
        },
        "overrideVariantUuid": "variant-2"
      }
    ],
    "overrideVariants": [
      {
        "uuid": "variant-1",
        "description": "Simple variant",
        "complexity": "EASY",
        "preCheckType": "CHECKBOX",
        "challengeType": "SILHOUETTES"
      },
      {
        "uuid": "variant-2",
        "description": "Hard variant",
        "complexity": "HARD",
        "preCheckType": "SLIDER",
        "challengeType": "SILHOUETTES"
      }
    ]
  }
  ```

{% endlist %}