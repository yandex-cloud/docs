{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с {{ search-api-name }}, или [создайте новый](../../resource-manager/operations/folder/create.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_search-api }}**.
  1. Заполните поля формы: 
       * Выберите **{{ ui-key.yacloud.component.ip-address-form.label_field-search-type }}** — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`, `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` или `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`.
       * Задайте как минимум один доверенный IP-адрес, с которого вы будете отправлять запросы к поисковой базе Яндекса.

           Отправлять запросы к API v1 сервиса {{ search-api-name }} можно только с одного из IP-адресов, добавленных в настройки сервиса при регистрации. При попытке выполнить запрос с незарегистрированного IP-адреса этот запрос будет отклонен.

  1. Нажмите кнопку **{{ ui-key.yacloud.component.ip-address-form.label_button-save }}**.

  Позднее вы сможете изменить тип поиска и список доверенных IP-адресов. Для этого в [консоли управления]({{ link-console-main }}) перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_search-api }}** и в правом верхнем углу экрана нажмите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.search-api.overview.label_button-edit }}**.

{% endlist %}