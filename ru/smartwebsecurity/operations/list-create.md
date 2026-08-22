---
title: Как создать, изменить, удалить черный или белый список IP-адресов, номеров ASN, регулярных выражений или строковых значений
description: Следуя данной инструкции, вы сможете управлять списками IP-адресов, номеров ASN, регулярных выражений или строковых значений.
---

# Управление списками

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

Вы можете управлять только [пользовательскими списками](../concepts/lists.md#user-rules). Предустановленные [списки {{ yandex-cloud }}](../concepts/lists.md#yc-rules) изменять нельзя.


## Создать список {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}** и нажмите **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-list }}**.
  1. Выберите тип списка:

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_ip_7TYwL }}` — IP-адреса, диапазоны адресов или префиксы в формате [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация). Примеры:

          ```text
          111.222.33.44
          2001:0db8:85a3:0000:0000:8a2e:5678:1234
          10.123.1.1/32
          10::1234:1abc:1/64
          1.2.0.0-1.2.1.1
          ```

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_asn_oyhKw }}` — номера [автономных систем](https://ru.wikipedia.org/wiki/Автономная_система_(Интернет)). Примеры:

          ```text
          AS64512
          AS4294967294
          15169
          1.10
          ```

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_regexp_eLHPr }}` — [регулярные выражения](../concepts/conditions.md#regular-expressions), например для анализа заголовка `User-Agent`. Примеры:

          ```text
          User-Agent:\s*
          \\[\'\"\.\;]
          a{100,}
          --.*
          ```

      * `{{ ui-key.yacloud.smart-web-security.MatchListForm.item-type_string_hGRJK }}` — текстовые строки, например идентификаторы. Примеры:

          ```text
          fev4ct8l9infabcd1234
          id345678
          ```

  1. Введите имя и описание списка.
  1. При необходимости добавьте метку.
  1. Нажмите **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-match-list }}** и затем **{{ ui-key.yacloud.smart-web-security.MatchListTable.button_add-to-list_1kKXh }}**.
  1. Введите значения в список вручную или загрузите их из файла TXT или CSV.

     В списке или в файле каждое значение указывайте с новой строки. Дополнительно можно добавить описание через запятую без пробела:

     ```text
     <значение_1>,<описание_1>
     <значение_2>,<описание_2>
     <значение_3>
     <значение_4>
     ```

     При загрузке файла прежний список не сохранится, а будет заменен на новый.

  1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

Теперь при добавлении правила в [профиле безопасности](rule-add.md) или [ARL](arl-rule-add.md) вы можете выбрать созданный список.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для создания списка:

     ```bash
     yc smartwebsecurity match-list match-list create --help
     ```

  1. Создайте список, указав тип и значения:

     ```bash
     yc smartwebsecurity match-list match-list create \
       --name <имя_списка> \
       --description "<описание_списка>" \
       --item-type <тип_значений> \
       --items '[{"value": "<значение_1>", "description": "<описание_1>"}, {"value": "<значение_2>"}]'
     ```

     Где:

     * `--name` — имя списка.
     * `--description` — описание списка. Необязательный параметр.
     * `--item-type` — тип значений в списке:

       * `ip` — IP-адреса, диапазоны адресов или префиксы в формате [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация);
       * `asn` — номера [автономных систем](https://ru.wikipedia.org/wiki/Автономная_система_(Интернет));
       * `reg-exp` — [регулярные выражения](../concepts/conditions.md#regular-expressions);
       * `str` — текстовые строки.

     * `--items` — значения списка в формате JSON: `value` — значение, `description` — его описание. Необязательный параметр, значения можно [добавить позже](#update-values).

  Подробнее о команде `yc smartwebsecurity match-list match-list create` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/match-list/match-list/create.md).

  Теперь при добавлении правила в [профиле безопасности](rule-add.md) или [ARL](arl-rule-add.md) вы можете выбрать созданный список.

{% endlist %}


## Скачать список {#download}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Нажмите строку с нужным списком.
  1. Перейдите на вкладку **{{ ui-key.yacloud.smart-web-security.label_match-list_ip_qG1ho }}**.
  1. Нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.smart-web-security.MatchListActions.button_download_bdcBp }}**.

      Список будет сохранен в формате CSV.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список имеющихся списков в каталоге по умолчанию:

     ```bash
     yc smartwebsecurity match-list match-list list
     ```

  1. Получите значения нужного списка, указав его идентификатор:

     ```bash
     yc smartwebsecurity match-list match-list get <идентификатор_списка> --format yaml
     ```

  Подробнее о команде `yc smartwebsecurity match-list match-list get` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/match-list/match-list/get.md).

{% endlist %}


## Изменить параметры списка {#update-params}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil-to-line](../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yacloud.smart-web-security.MatchListActions.button_rename_r3ma9 }}**.
  1. Измените имя и описание списка, добавьте или удалите метки.
  1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для изменения списка:

     ```bash
     yc smartwebsecurity match-list match-list update --help
     ```

  1. Получите список имеющихся списков в каталоге по умолчанию:

     ```bash
     yc smartwebsecurity match-list match-list list
     ```

  1. Измените параметры списка, указав его идентификатор:

     ```bash
     yc smartwebsecurity match-list match-list update <идентификатор_списка> \
       --name <новое_имя_списка> \
       --description "<новое_описание_списка>" \
       --labels <ключ_метки>=<значение_метки>
     ```

     Изменятся только те параметры, которые вы передали в команде.

  Подробнее о команде `yc smartwebsecurity match-list match-list update` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/match-list/match-list/update.md).

{% endlist %}

## Изменить список значений {#update-values}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Нажмите строку с нужным списком.
  1. Перейдите на вкладку **{{ ui-key.yacloud.smart-web-security.label_match-list_ip_qG1ho }}**.

      * Чтобы изменить описание для одного или нескольких значений, выберите их и на панели внизу нажмите ![image](../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_action-edit-description }}**.
      * Чтобы удалить одно или несколько значений, выберите их и нажмите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      * Чтобы отредактировать список в текстовом формате или загрузить новый файл со списком:

          1. Нажмите ![pencil-to-square](../../_assets/console-icons/pencil-to-square.svg) **{{ ui-key.yacloud.smart-web-security.MatchListActions.button_edit-list-items_2JFvu }}**.
          1. Отредактируйте список или загрузите новый файл.
          1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список имеющихся списков в каталоге по умолчанию:

     ```bash
     yc smartwebsecurity match-list match-list list
     ```

  1. Получите текущие значения нужного списка, указав его идентификатор:

     ```bash
     yc smartwebsecurity match-list match-list get <идентификатор_списка> --format yaml
     ```

  1. Передайте новые значения списка:

     ```bash
     yc smartwebsecurity match-list match-list update <идентификатор_списка> \
       --items '[{"value": "<значение_1>", "description": "<описание_1>"}, {"value": "<значение_2>"}]'
     ```

     Где `--items` — значения списка в формате JSON: `value` — значение, `description` — его описание. Необязательный параметр.

     {% note warning %}

     Новые значения полностью заменят прежний список значений.

     {% endnote %}

  Подробнее о команде `yc smartwebsecurity match-list match-list update` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/match-list/match-list/update.md).

{% endlist %}

## Удалить список {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список имеющихся списков в каталоге по умолчанию:

     ```bash
     yc smartwebsecurity match-list match-list list
     ```

  1. Удалите список, указав его идентификатор:

     ```bash
     yc smartwebsecurity match-list match-list delete <идентификатор_списка>
     ```

  1. Чтобы убедиться, что список удален, повторно выполните команду:

     ```bash
     yc smartwebsecurity match-list match-list list
     ```

  Подробнее о команде `yc smartwebsecurity match-list match-list delete` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/match-list/match-list/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/lists.md)
* [{#T}](../concepts/conditions.md)
* [{#T}](rule-add.md)
* [{#T}](arl-rule-add.md)
