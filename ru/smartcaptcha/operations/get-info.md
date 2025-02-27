---
title: Как получить информацию о капче
description: Следуя данной инструкции, вы сможете получить информацию о капче {{ captcha-full-name }}.
---

# Получить информацию о капче

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [капча](../concepts/validation.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Выберите капчу. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о капче.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [капче](../concepts/validation.md):

     ```bash
     yc smartcaptcha captcha get --help
     ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}

  1. Получите подробную информацию о капче, указав ее имя или идентификатор:

     ```bash
     yc smartcaptcha captcha get <идентификатор_капчи>
     ```

     Результат:

      ```text
     id: bpne29ifsca8********
     folder_id: b1geoelk7fld********
     cloud_id: b1gia87mbaom********
     client_key: ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
     created_at: "2025-02-24T17:16:13.034742Z"
     name: test
     allowed_sites:
       - example.com
     complexity: MEDIUM
     pre_check_type: CHECKBOX
     challenge_type: IMAGE_TEXT
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [капче](../concepts/validation.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_smartcaptcha_captcha" "my-captcha" {
        captcha_id = "<идентификатор_капчи>"
      }

      output "my-сlient-key" {
        value = data.yandex_smartcaptcha_captcha.my-captcha.client_key
      }
      ```

      Где:

      * `data "yandex_smartcaptcha_captcha"` — описание капчи в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "ref_description"` — выходная переменная, которая содержит информацию о [клиентском ключе](../concepts/keys) (`client_key`):
         * `value` — возвращаемое значение.

     Вместо `client_key` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_smartcaptcha_captcha` см. в [документации провайдера]({{ tf-provider-datasources-link }}/smartcaptcha_captcha).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      my-сlient-key = ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
      ...
      ```

- API {#api}

  Чтобы получить подробную информацию о [капче](../concepts/validation.md), воспользуйтесь методом REST API [get](../api-ref/Captcha/get.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [CaptchaService/Get](../api-ref/grpc/Captcha/get.md).

{% endlist %}