---
title: Редактировать пользовательское правило в {{ sd-full-name }}
description: 'Из этой инструкции вы узнаете, как изменить параметры пользовательского правила безопасности: название, описание, критичность, рекомендации по исправлению и другое.'
---

# Редактировать пользовательское правило

Для работы с [пользовательскими правилами](../../concepts/custom-rules.md) необходима [роль](../../security/kspm-roles.md) `security-deck.rules.editor` или выше в окружении.

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. На вкладке **Пользовательские** в строке с правилом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/custom-rules.md)
* [{#T}](create-custom-rule.md)
* [{#T}](delete-custom-rule.md)
* [{#T}](../custom-rules-sets/index.md)
