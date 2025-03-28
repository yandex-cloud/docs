---
title: Как создать капчу в {{ captcha-full-name }}
description: Следуя данной инструкции, вы сможете создать капчу.
---

# Создать капчу

{{ captcha-name }} позволяет создавать [капчи](../concepts/validation.md) нескольких уровней сложности для разных входящих запросов. Уровень сложности запроса определяется по базовым параметрам входящего трафика.

При создании капчи вы можете:

* Подключить капчу к нескольким сайтам.
* Настроить внешний вид капчи: фон, состояния и ошибки, стиль кнопки **Я не робот**.
* Выбрать тип задания и сложность прохождения капчи.
* Показывать разные варианты капчи в зависимости от параметров входящего запроса. Например, выбрать разную капчу для пользователей из разных регионов.

{% include [user-data-to-ml](../../_includes/smartcaptcha/user-data-to-ml.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Нажмите **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}**.

     ![screen01](../../_assets/smartcaptcha/create-captcha/screen01.png)

  1. Укажите **{{ ui-key.yacloud.common.name }}** создаваемой капчи:

      {% include [name-format](../../_includes/smartcaptcha/name-format.md) %}

  1. (Опционально) Выберите [**{{ ui-key.yacloud.smartcaptcha.label_no-hostname-check }}**](../concepts/domain-validation.md).
  1. Введите **{{ ui-key.yacloud.smartcaptcha.label_allowed-sites }}** в формате IP-адресов или доменных имен. Указывайте адрес без протокола и без `/` в конце, например, `example.com`.

     Капча будет работать и во всех поддоменах указанных доменных имен.

  1. Настройте **{{ ui-key.yacloud.smartcaptcha.label_section-style }}** кнопки **Я не робот** и окна с заданием:
     * `{{ ui-key.yacloud.smartcaptcha.value_config-standard }}` — внешний вид по умолчанию.
     * `Серый`.
     * `Темная тема`.
     * `Синий`.

      В разделе **{{ ui-key.yacloud.smartcaptcha.label_section-customization }}** вы можете задать свои параметры окна задания и других элементов: через форму или через описание стилей в формате `JSON`.

      Все изменения будут отображаться в окне предпросмотра.

     ![screen02](../../_assets/smartcaptcha/create-captcha/screen02.png)

  1. Настройте **Варианты заданий**. Вы можете указать только капчу по умолчанию или добавить дополнительные [варианты](../concepts/captcha-variants.md), если по разным входящим запросам нужно показывать разную капчу.
  
  1. Для варианта **По умолчанию** укажите:
      * **{{ ui-key.yacloud.smartcaptcha.label_main-challenge }}** — тип [основного задания](../concepts/tasks.md#main-task), которое предлагается решить пользователю.
      * **{{ ui-key.yacloud.smartcaptcha.label_additional-challenge }}** — тип [дополнительного задания](../concepts/tasks.md#additional-task), которое предлагается решить пользователю.
      * **{{ ui-key.yacloud.smartcaptcha.label_complexity }}** — [сложность](../concepts/tasks.md#task-difficulty) задания, которое увидит пользователь:
      * `{{ ui-key.yacloud.smartcaptcha.value_complexity-easy }}` — простое задание.
      * `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}` — задание среднего уровня сложности.
      * `{{ ui-key.yacloud.smartcaptcha.value_complexity-hard }}` — сложное задание.
      * `{{ ui-key.yacloud.smartcaptcha.value_complexity-force_hard }}` — сложное задание с дополнительным вопросом. От пользователя требуется решение дополнительного задания, вне зависимости от результатов выполнения основного задания.

        Пример задания можно посмотреть в окне предпросмотра.

        {% include [note-preview-captcha-variants](../../_includes/smartcaptcha/note-preview-captcha-variants.md) %}

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
            * `Host` — домен, на который пришел запрос.
           
         * Нажмите кнопку **Добавить**.
          
            Чтобы удалить правило, нажмите ![options](../../_assets/console-icons/trash-bin.svg). Правило по умолчанию удалить нельзя.

     1. Таким же способом добавьте другие варианты капчи и правила для входящего трафика.

  1. (Опционально) Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**.
   
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

     ![screen03](../../_assets/smartcaptcha/create-captcha/screen03.png)

  Капча отобразится на странице сервиса в разделе **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания капчи:

     ```bash
     yc smartcaptcha captcha create --help
     ```

  1. Создайте капчу:

     ```bash
     yc smartcaptcha captcha create \
       --name <имя_капчи>
       --turn-off-hostname-check \
       --allowed-site <первый_хост>,<второй_хост> \
       --style-json '<внешний_вид_капчи>' \
       --pre-check-type <тип_основного_задания> \
       --challenge-type <тип_дополнительного_задания> \
       --complexity <сложность_задания> \
       --override-variants-file <путь_к_файлу_с_правилами>.yaml \
       --security-rules-file <путь_к_файлу_с_вариантами>.yaml
     ```
 
     Где:
     * `--name` — имя капчи.
     * `--turn-off-hostname-check` — [отключение проверки домена](../concepts/domain-validation.md). Необязательный параметр.
     * `--allowed-site` — список хостов в формате IP-адресов или доменных имен. Указывайте адрес без протокола и без `/` в конце, например, `example.com`. Капча будет работать и во всех поддоменах указанных доменных имен. Необязательный параметр.
     * `--style-json` — внешний вид окна задания и других элементов в формате `JSON`. Подробнее смотрите в `JSON`, сгенерированном с помощью [консоли управления]({{ link-console-main }}). Необязательный параметр.
     * `--pre-check-type` — тип [основного задания](../concepts/tasks.md#main-task) по умолчанию, которое предлагается решить пользователю.
     * `--challenge-type` — тип [дополнительного задания](../concepts/tasks.md#additional-task) по умолчанию, которое предлагается решить пользователю.
     * `--complexity` — [сложность](../concepts/tasks.md#task-difficulty) задания по умолчанию. Возможные значения:
       * `EASY` — простое задание.
       * `MEDIUM` — задание среднего уровня сложности.
       * `HARD` — сложное задание.
       * `FORCE_HARD` — сложное задание с дополнительным вопросом. От пользователя требуется решение дополнительного задания, вне зависимости от результатов выполнения основного задания.
 
       {% include [note-preview-captcha-variants](../../_includes/smartcaptcha/note-preview-captcha-variants.md) %}
 
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
                 - es
       ```
 
       Где:
       * `name` — имя правила.
       * `priority` — приоритет правила от `1` до `999999`.
         
         Правила проверяются в порядке приоритета от меньшего к большему: `1`, `2` и так далее. Если трафик соответствует нескольким правилам, к нему применится первое сработавшее правило.
 
       * `description` — описание правила. Необязательный параметр.
       * `override_variant_uuid` — идентификатор варианта задания, которое будет отображаться в случае соответствия трафика правилу. Если параметр не указан, будет отображаться задание по умолчанию.
       * `condition` — одно или несколько [условий для входящего трафика](../concepts/captcha-variants.md#traffic-conditions). Необязательный параметр.
 
       {% endcut %}
 
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

  {% include [cli-creation-result](../../_includes/smartcaptcha/cli-creation-result.md) %}

- Terraform {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать капчу:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

     {% include [tf-creation-configuration](../../_includes/smartcaptcha/tf-creation-configuration.md) %}

     Где:
     * `name` — имя капчи.
     * `style_json` — внешний вид окна задания и других элементов в формате `JSON`. Подробнее смотрите в `JSON`, сгенерированном с помощью [консоли управления]({{ link-console-main }}). Необязательный параметр.
     * `complexity` — [сложность](../concepts/tasks.md#task-difficulty) задания по умолчанию, которое увидит пользователь. Возможные значения:
       * `EASY` — простое задание.
       * `MEDIUM` — задание среднего уровня сложности.
       * `HARD` — сложное задание.
       * `FORCE_HARD` — сложное задание с дополнительным вопросом. От пользователя требуется решение дополнительного задания, вне зависимости от результатов выполнения основного задания.

       {% include [note-preview-captcha-variants](../../_includes/smartcaptcha/note-preview-captcha-variants.md) %}

     * `pre_check_type` — тип [основного задания](../concepts/tasks.md#main-task) по умолчанию, которое предлагается решить пользователю.
     * `challenge_type` — тип [дополнительного задания](../concepts/tasks.md#additional-task) по умолчанию, которое предлагается решить пользователю.
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

     Более подробную информацию о параметрах ресурса `yandex_smartcaptcha_captcha`, см. в [документации провайдера]({{ tf-provider-resources-link }}/smartcaptcha_captcha).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc smartcaptcha captcha list
     ```

- API {#api}

  Чтобы создать капчу, воспользуйтесь методом REST API [create](../../smartcaptcha/api-ref/Captcha/create.md) для ресурса [Captcha](../../smartcaptcha/api-ref/Captcha/index.md) или вызовом gRPC API [Captcha/Create](../../smartcaptcha/api-ref/grpc/Captcha/create.md).

{% endlist %}
