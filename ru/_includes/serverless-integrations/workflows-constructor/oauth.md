* `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_description_lockbox }}`, чтобы хранить OAuth-токен приложения в секрете, и в блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_properties_lockbox_properties_name_view_spec_layout_title }}** выберите секрет, его [версию](../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен OAuth-токен.

    Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.
  
* `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_description_plain }}`, чтобы хранить OAuth-токен приложения в спецификации в виде текста, и в поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_properties_plain_properties_token_view_spec_layout_title }}** введите OAuth-токен.

    {% note warning %}

    Хранить OAuth-токен в открытом виде в тексте спецификации небезопасно.

    {% endnote %}
