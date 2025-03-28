# Удалить капчу

В этом разделе вы узнаете, как удалить [капчу](../concepts/validation.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
    1. Выберите капчу и нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.
    1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления капчи:

      ```bash
      yc smartcaptcha captcha delete --help
      ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}
  1. Удалите капчу, указав ее имя или идентификатор:

      ```bash
      yc smartcaptcha captcha delete <имя_или_идентификатор_капчи>
      ```

      {% include [cli-creation-result](../../_includes/smartcaptcha/cli-creation-result.md) %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   Чтобы удалить капчу, созданную с помощью {{ TF }}:

   1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием ресурса `yandex_smartcaptcha_captcha`:

      {% cut "Пример описания капчи в конфигурации {{ TF }}" %}

      {% include [tf-creation-configuration](../../_includes/smartcaptcha/tf-creation-configuration.md) %}

      {% endcut %}

   1. Примените изменения:
      
      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      Проверить удаление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc smartcaptcha captcha list
      ```

- API {#api}

   Чтобы удалить капчу, воспользуйтесь методом REST API [delete](../../smartcaptcha/api-ref/Captcha/delete.md) для ресурса [Captcha](../../smartcaptcha/api-ref/Captcha/index.md) или вызовом gRPC API [Captcha/Delete](../../smartcaptcha/api-ref/grpc/Captcha/delete.md).

{% endlist %}

[Ключи](../concepts/keys.md) удаленной капчи прекратят действовать. Сервис вернет сообщения об ошибке в ответ на все запросы с этими ключами.
