# Настройте облако

При регистрации в {{ yandex-cloud }} для пользователя будет создано _облако_ — отдельное рабочее пространство, для которого этот пользователь будет назначен владельцем. В облаке будет создан каталог `default` и сеть `default`.

Владелец может создавать в этом облаке новые каталоги и ресурсы, а также управлять правами доступа к ним.

## Создайте каталог

{% list tabs %}

- Консоль управления

  {% include [create-folder](../../_includes/create-folder.md) %}

- CLI

  1. Посмотрите описание команды создания каталога:

      ```
      $ yc resource-manager folder create --help
      ```

  1. Создайте новый каталог:

      * с именем и без описания:
          ```
          $ yc resource-manager folder create \
              --name new-folder
          ```

          Требования к имени каталога:

          {% include [name-format](../../_includes/name-format.md) %}

      * с именем и описанием:

          ```
          $ yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API

  Чтобы создать каталог, воспользуйтесь методом [create](../../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md).

{% endlist %}

## Измените каталог {#change-folder}

Через консоль управления можно изменить только имя каталога. Чтобы изменить его описание, используйте CLI или API.

{% list tabs %}

- Консоль управления

  1. Выберите каталог на [стартовой странице]({{ link-console-main }}) консоли управления. На этой странице отображаются каталоги для выбранного облака. Если необходимо, [переключитесь на другое облако](../../resource-manager/operations/cloud/switch-cloud.md).
  1. Нажмите значок ![image](../../_assets/options.svg) напротив каталога и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Введите новое имя каталога.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders.popup-edit_button_save }}**.

- CLI

  1. Посмотрите описание команды изменения каталога:

      ```
      $ yc resource-manager folder update --help
      ```
  1. Если вы знаете идентификатор или имя каталога, переходите к следующему шагу. Если нет, то узнайте это одним из способов:

      * Получите список каталогов:

          ```
          $ yc resource-manager folder list
          +----------------------+--------------------+--------+--------+-------------+
          |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
          +----------------------+--------------------+--------+--------+-------------+
          | b1gppulhhm2aaufq9eug | yet-another-folder |        | ACTIVE |             |
          | b1gvmob95yysaplct532 | default            |        | ACTIVE |             |
          +----------------------+--------------------+--------+--------+-------------+
          ```

      * Если вы знаете идентификатор ресурса, который принадлежит нужному каталогу, получите идентификатор каталога из информации об этом ресурсе:

          ```
          $ yc <SERVICE-NAME> <RESOURCE> get <RESOURCE-ID>
          ```

          где:
          * `<SERVICE-NAME>` — имя сервиса, например `compute`.
          * `<RESOURCE>` — категория ресурса, например `instance`.
          * `<RESOURCE-ID>` — идентификатор ресурса.

          Например, виртуальная машина `fhmp74bfis2aim728p2a` принадлежит каталогу `b1gpvjd9ir42nsng55ck`:

          ```
          $ yc compute instance get fhmp74bfis2ais728p2a
          id: fhmp74bfis2ais728p2a
          folder_id: b1gpvjd9ia42nsng55ck
          ...
          ```
  1. Измените параметры каталога, например имя и описание. Вы можете указать изменяемый каталог по имени или идентификатору.

      ```
      $ yc resource-manager folder update default \
          --new-name myfolder \
          --description "this is my default-folder"
      ```

      Команда переименует каталог `default` в `myfolder` и обновит его описание.

      Требования к имени каталога:

      {% include [name-format](../../_includes/name-format.md) %}



- API

  Чтобы изменить каталог, воспользуйтесь методом [update](../../resource-manager/api-ref/Folder/update.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md).
  
{% endlist %}