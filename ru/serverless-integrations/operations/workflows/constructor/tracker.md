---
title: Добавить обращение к {{ tracker-full-name }} API в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить обращение к {{ tracker-full-name }} API в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Обращение к {{ tracker-full-name }} API

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![tracker-icon](../../../../_assets/tracker-icon.svg) **{{ tracker-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ tracker-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. (Опционально) Если API {{ tracker-full-name }} использует нестандартный эндпоинт, в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_endpoint_view_spec_layout_title }}** измените значение, заданное по умолчанию.
      1. В секции **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_view_spec_layout_title }}** укажите [OAuth-токен приложения]({{ link-tracker-cloudless }}concepts/access#about_OAuth) или [секрет](../../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в котором сохранен этот токен. Выберите:

          {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_view_spec_layout_title }}** выберите тип организации, к которой подключен {{ tracker-name }}: `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_description_cloud }}` или `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_description_yandex }}`, либо оставьте значение `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_description_none }}`, чтобы не указывать организацию.

          Если вы указали тип организации, в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_properties_cloud_view_spec_layout_title }}** укажите ее идентификатор.

          Подробнее об организациях см. в [документации Yandex Tracker]({{ link-tracker-cloudless }}enable-tracker).
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_view_spec_layout_title }}** выберите действие, которое нужно выполнить с задачами {{ tracker-name }}:

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_get_issue }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_get_issue_properties_key_view_spec_layout_title }}** укажите [ключ]({{ link-tracker-cloudless }}glossary#rus-k) – уникальный идентификатор задачи.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_create_issue }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_queue_view_spec_layout_title }}** укажите идентификатор [очереди]({{ link-tracker-cloudless }}queue-intro), в которой будет создаваться задача.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_title_view_spec_layout_title }}** задайте название создаваемой задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_parent_view_spec_layout_title }}** укажите ключ родительской задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_description_view_spec_layout_title }}** задайте описание создаваемой задачи.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_view_spec_layout_title }}** при необходимости укажите [спринты]({{ link-tracker-cloudless }}manager/create-agile-sprint), в которые нужно добавить задачу. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_none }}`, чтобы не добавлять задачу в спринты.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_array }}`, чтобы добавить спринты по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_simple }}`, чтобы добавить спринты в виде JSON-массива или jq-шаблона.

          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_type_view_spec_layout_title }}** укажите [тип]({{ link-tracker-cloudless }}glossary#rus-t) создаваемой задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_priority_view_spec_layout_title }}** укажите приоритет создаваемой задачи.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_followers_view_spec_layout_title }}** при необходимости укажите пользователей, которых нужно добавить в наблюдатели создаваемой задачи. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_none }}`, чтобы не добавлять наблюдателей.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_array }}`, чтобы добавить наблюдателей, указав их логины или идентификаторы по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_simple }}`, чтобы добавить наблюдателей, указав их логины или идентификаторы в виде JSON-массива или jq-шаблона.

          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_assignee_view_spec_layout_title }}** укажите логин или идентификатор пользователя — исполнителя создаваемой задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_author_view_spec_layout_title }}** укажите логин или идентификатор пользователя — автора создаваемой задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_additional_properties_view_spec_layout_title }}** при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) задайте дополнительные поля создаваемой задачи в формате `<Название_поля>`:`<Значение_поля>`.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_update_issue }}`" %}

          {% note info %}

          Если вы не зададите новые значения для опциональных полей, они останутся прежними.

          {% endnote %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_key_view_spec_layout_title }}** укажите [ключ]({{ link-tracker-cloudless }}glossary#rus-k) задачи, которую нужно изменить.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_title_view_spec_layout_title }}** задайте новое название изменяемой задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_parent_view_spec_layout_title }}** укажите новый ключ родительской задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_description_view_spec_layout_title }}** задайте новое описание изменяемой задачи.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_view_spec_layout_title }}** при необходимости измените спринты, в которые входит задача. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_none }}`, чтобы не изменять спринты, в которые входит задача.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_set }}`, чтобы заменить все текущие спринты, в которые входит задача, на новые. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать новые спринты по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать новые спринты в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_add }}`, чтобы добавить новые спринты к тем, в которые уже входит задача. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы добавить спринты по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы добавить спринты в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_remove }}`, чтобы удалить задачу из спринтов. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать спринты, из которых нужно удалить задачу, по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать спринты, из которых нужно удалить задачу, в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_replace }}`, чтобы заменить текущие спринты, в которые входит задача, на указанные. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_replace_description_key_value }}`, чтобы задать правила, по которым нужно обновить спринты, при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) в формате `<Исходное_значение>`:`<Новое_значение>`, где `<Исходное_значение>` — текущий спринт, в который входит задача, `<Новое_значение>` — спринт, на который нужно заменить текущий.
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_replace_description_plain }}`, чтобы задать правила, по которым нужно обновить спринты, в виде JSON-объекта или jq-шаблона.

          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_type_view_spec_layout_title }}** задайте новый тип изменяемой задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_priority_view_spec_layout_title }}** задайте новый приоритет изменяемой задачи.
          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_view_spec_layout_title }}** при необходимости измените наблюдателей, которые добавлены в задачу. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_none }}`, чтобы не изменять наблюдателей задачи.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_set }}`, чтобы заменить всех текущих наблюдателей задачи на новых. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** выберите

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать новых наблюдателей, указав их логины или идентификаторы по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать новых наблюдателей, указав их логины или идентификаторы в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_add }}`, чтобы добавить новых наблюдателей к уже имеющимся в задаче. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы добавить наблюдателей, указав их логины или идентификаторы по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы добавить наблюдателей, указав их логины или идентификаторы в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_remove }}`, чтобы удалить наблюдателей из задачи. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать наблюдателей, которых нужно удалить из задачи, указав их логины или идентификаторы по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * Выберите `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать наблюдателей, которых нужно удалить из задачи, указав их логины или идентификаторы в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_replace }}`, чтобы заменить текущих наблюдателей задачи на указанных. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_replace_description_key_value }}`, чтобы задать правила, по которым нужно обновить наблюдателей, при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) в формате `<Исходное_значение>`:`<Новое_значение>`, где `<Исходное_значение>` — логин или идентификатор текущего наблюдателя задачи, `<Новое_значение>` — логин или идентификатор наблюдателя, на которого нужно заменить текущего.
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать правила, по которым нужно обновить наблюдателей, в виде JSON-объекта или jq-шаблона.

          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_additional_properties_view_spec_layout_title }}** измените дополнительные поля задачи. Для этого нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) и в появившемся блоке настроек:
          
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_key_view_spec_placeholder }}** введите название поля, значения которого нужно изменить.
              1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_set }}`, чтобы заменить все текущие значения поля на новые. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** выберите:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать новые значения поля по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать новые значения поля в виде JSON-массива или jq-шаблона.

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_add }}`, чтобы добавить новые значения поля к уже имеющимся. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** выберите:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы добавить значения поля по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы добавить значения поля в виде JSON-массива или jq-шаблона.

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_remove }}`, чтобы удалить значения поля. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** выберите:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать значения поля, которые нужно удалить, по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать значения поля, которые нужно удалить, в виде JSON-массива или jq-шаблона.

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_replace }}`, чтобы заменить текущие значения поля на указанные. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** выберите:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_replace_description_key_value }}`, чтобы задать правила, по которым нужно обновить значения поля, при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) в формате `<Исходное_значение>`:`<Новое_значение>`, где `<Исходное_значение>` — текущее значение поля, `<Новое_значение>` — значение поля, на которое нужно заменить текущее.
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать правила, по которым нужно обновить значения поля, в виде JSON-объекта или jq-шаблона.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_link_issues }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_link_issues_properties_key_view_spec_layout_title }}** укажите ключ первой задачи, для которой нужно создать связь.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_link_issues_properties_link_key_view_spec_layout_title }}** укажите ключ второй задачи, которую нужно связать с первой.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_link_issues_properties_relationship_view_spec_layout_title }}** укажите тип связи, которую нужно установить между задачами.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_list_issues }}`" %}

          1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_view_spec_layout_title }}** выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_queue }}`, чтобы вернуть задачи из указанной очереди. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_queue_view_spec_layout_title }}** введите [ключ очереди]({{ link-tracker-cloudless }}glossary#rus-k), задачи из которой нужно вернуть.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_keys }}`, чтобы вернуть задачи с указанными ключами. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_keys_view_spec_layout_title }}** выберите:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}`, чтобы задать ключи задач по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}`, чтобы задать ключи задач в виде JSON-массива или jq-шаблона.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_filter }}`, чтобы вернуть задачи с указанными значениями полей.

                  1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_issue_properties_view_spec_layout_title }}** при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) задайте поля, по которым нужно фильтровать задачи, и значения этих полей.
                  1. (Опционально) Чтобы сортировать возвращаемые задачи, в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_sort_view_spec_layout_title }}** выберите `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_sort_description_on }}` и укажите название поля, по которому будет выполняться сортировка. При необходимости включите опцию **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_sort_properties_on_properties_order_view_spec_layout_title }}**, чтобы сортировать задачи в порядке убывания.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_query }}`, чтобы вернуть задачи по указанному фильтру на [языке запросов]({{ link-tracker-cloudless }}user/query-filter) {{ tracker-full-name }}.

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_page_size_view_spec_layout_title }}** задайте количество задач, которые будут помещаться на одной [странице]({{ link-tracker-cloudless }}common-format#displaying-results) с результатами поиска.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_page_number_view_spec_layout_title }}** задайте номер страницы с результатами, которую необходимо получить.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_update_issue_status }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_status_properties_key_view_spec_layout_title }}** укажите [ключ]({{ link-tracker-cloudless }}glossary#rus-k) задачи, статус которой нужно изменить.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_status_properties_transition_view_spec_layout_title }}** укажите идентификатор перехода задачи.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_additional_properties_view_spec_layout_title }}** при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) задайте дополнительные поля задачи и их значения, которые нужны, чтобы выполнить переход.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_create_comment }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_key_view_spec_layout_title }}** укажите [ключ]({{ link-tracker-cloudless }}glossary#rus-k) задачи, в которую нужно добавить комментарий.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_text_view_spec_layout_title }}** укажите текст добавляемого комментария.
          1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_view_spec_layout_title }}** задайте пользователей, которых нужно призвать в задачу в добавляемом комментарии. Выберите:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_description_none }}`, чтобы никого не призывать.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_description_array }}`, чтобы задать логины или идентификаторы призываемых в комментарии пользователей по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_description_simple }}`, чтобы задать логины или идентификаторы призываемых пользователей в виде JSON-массива или jq-шаблона.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_update_comment }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_id_view_spec_layout_title }}** укажите идентификатор комментария, который нужно изменить.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_issue_key_view_spec_layout_title }}** укажите [ключ]({{ link-tracker-cloudless }}glossary#rus-k) задачи, в которой находится изменяемый комментарий.
          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_text_view_spec_layout_title }}** укажите измененный текст комментария.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_list_comments }}`" %}

          1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_key_view_spec_layout_title }}** укажите [ключ]({{ link-tracker-cloudless }}glossary#rus-k) задачи, комментарии из которой нужно получить.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_id_view_spec_layout_title }}** укажите идентификатор комментария, начиная с которого будут возвращены комментарии из задачи. В ответе будут возвращены комментарии, созданные позднее указанного комментария, не включая сам указанный комментарий.
          1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_comments_properties_page_size_view_spec_layout_title }}** задайте максимальное количество комментариев, которые могут быть возвращены в ответе.

          {% endcut %}

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/tracker.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
