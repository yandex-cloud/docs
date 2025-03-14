{% list tabs group=instruction %}

- Интерфейс {{ yq-name }} {#yquery}

  1. Перейдите в [консоль управления]({{link-console-main}}) и откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_yq }}**.
  1. На вкладке **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Создайте соединение со следующими параметрами:
      * **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** — `forms-connection`.
      * **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** — `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection-bucket.title }}** — имя [созданного ранее](#create-s3-bucket) бакета.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `forms-integration-sa`.
  1. В открывшемся окне задайте параметры привязки к данным:
      * **{{ ui-key.yql.yq-binding-form.connection-type.title }}** — `{{ objstorage-name }}`.
      * **{{ ui-key.yql.yq-binding-form.connection.title }}** — `forms-connection`.
      * **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** — `/<идентификатор_формы>/`.
        Вы можете скопировать идентификатор:
          * В разделе **{{ ui-key.yacloud.storage.bucket.switch_files }}** бакета {{ objstorage-name }}. Название папки, в которой расположен файл с результатами заполнения формы, соответствует ее идентификатору.
          * В адресной строке [интерфейса {{ forms-name }}]({{ link-forms-b2b }}) на странице просмотра или редактирования формы.        
      * **{{ ui-key.yql.yq-binding-form.binding-format.title }}** — `json_each-row`.
      * **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** — создайте колонки для полей, которые вы задали в форме.
        Чтобы {{ yq-name }} определил колонки самостоятельно, нажмите кнопку **{{ ui-key.yql.yq-binding-form.title_infer-columns }}**.

{% endlist %}
