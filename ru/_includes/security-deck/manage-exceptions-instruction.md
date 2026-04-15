* **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}** — вариант действия для создаваемого исключения:

    {% include [cspm-exception-types](./cspm-exception-types.md) %}

* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** — ресурсы, которые требуется исключить при проверке правил безопасности:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](../../security-deck/concepts/workspace.md).
    * `Выбранные ресурсы` — чтобы исключить из проверки только явно заданную часть ресурсов.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** — правила контроля безопасности модуля, для которых не должны проводиться проверки выбранных ресурсов:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам безопасности.
    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие явно заданному набору правил.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** — причина, по которой создается исключение. Указывается в свободной текстовой форме.