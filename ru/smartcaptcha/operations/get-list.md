---
title: Как получить список капч
description: Следуя данной инструкции, вы сможете посмотреть список доступных капч {{ captcha-full-name }}.
---

# Получить список капч

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список [капч](../concepts/validation.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. На странице **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}** отобразится список доступных капч.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для просмотра списка [капч](../concepts/validation.md):

      ```bash
      yc smartcaptcha captcha list --help
      ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}

- API {#api}

  Чтобы посмотреть список [капч](../concepts/validation.md), воспользуйтесь методом REST API [list](../api-ref/Captcha/list.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [CaptchaService/List](../api-ref/grpc/Captcha/list.md).

{% endlist %}