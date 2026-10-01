---
title: Настройка политики доступа по странам
description: Следуя данной инструкции, вы сможете настроить доступ к CDN-ресурсу по странам.
---

# Настройка политики доступа по странам

С помощью [политики доступа по странам](../../concepts/geo-acl.md) можно разрешить или запретить доступ к CDN-ресурсу для пользователей из указанных стран.

{% include [geo-policy-warning](../../../_includes/cdn/geo-policy-warning.md) %}

Чтобы настроить политику доступа по странам:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. [Перейдите]({{ link-console-main }}/link/cdn) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.cdn.label_resource-security }}**.
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите опцию **Доступ по странам**.
  1. В поле **Политика доступа** выберите:

      * `Запретить для указанных стран` — запретить доступ к ресурсу из стран, перечисленных в поле **Список стран**, и разрешить из остальных стран.
      * `Разрешить только для указанных стран` — разрешить доступ к ресурсу только из стран, перечисленных в поле **Список стран**, и запретить из остальных стран.

  1. В поле **Список стран** укажите через запятую двухбуквенные [коды стран](../../concepts/geo-acl.md#country-codes) в верхнем регистре, например `RU, KZ`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- REST API {#rest-api}

  Чтобы настроить политику, добавьте блок `geoAcl` при использовании метода [create](../../api-ref/Resource/create.md) или [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md):

  ```json
  "geoAcl": {
    "enabled": "boolean",
    "mode": "string",
    "countries": [
      "string"
    ]
  }
  ```

  Где:

  * `enabled` — включение политики доступа по странам.
  * `mode` — тип политики:
      * `MODE_ALLOW` — разрешить доступ только из стран, указанных в параметре `countries`.
      * `MODE_DENY` — запретить доступ из стран, указанных в параметре `countries`.

  * `countries` — список двухбуквенных [кодов стран](../../concepts/geo-acl.md#country-codes) в верхнем регистре.

- gRPC API {#grpc-api}

  Чтобы настроить политику, добавьте блок `geo_acl` при использовании вызова [ResourceService/Create](../../api-ref/grpc/Resource/create.md) или [ResourceService/Update](../../api-ref/grpc/Resource/update.md):

  ```json
  "geo_acl": {
    "enabled": "bool",
    "mode": "Mode",
    "countries": [
      "string"
    ]
  }
  ```

  Где:

  * `enabled` — включение политики доступа по странам.
  * `mode` — тип политики:
      * `MODE_ALLOW` — разрешить доступ только из стран, указанных в параметре `countries`.
      * `MODE_DENY` — запретить доступ из стран, указанных в параметре `countries`.

  * `countries` — список двухбуквенных [кодов стран](../../concepts/geo-acl.md#country-codes) в верхнем регистре.

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/geo-acl.md)
* [{#T}](create-resource.md)
