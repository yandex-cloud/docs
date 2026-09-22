---
title: Удалить пользовательское правило в {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как удалить пользовательское правило безопасности, если оно больше не требуется для проверки инфраструктуры.
---

# Удалить пользовательское правило

Для работы с [пользовательскими правилами](../../concepts/custom-rules.md) необходима [роль](../../security/cspm-roles.md) `security-deck.rules.editor` или выше.

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Перейдите на вкладку **Пользовательские**.
  1. Справа от правила нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/custom-rules.md)
* [{#T}](create-custom-rule.md)
* [{#T}](edit-custom-rule.md)
* [{#T}](../custom-rules-sets/index.md)
