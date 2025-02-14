{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. На вкладке **{{ ui-key.yacloud.cns.type_sms }}** выберите тип отправителя **{{ ui-key.yacloud.cns.sender_sms-individual }}**.
  1. Укажите желаемое текстовое имя отправителя и нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

После этого будет автоматически сформирована заявка в техническую поддержку на регистрацию текстового имени отправителя.

{% include [registration-duration-warning](registration-duration-warning.md) %}

Когда регистрация завершится, вы получите ответ от технической поддержки о предоставлении доступа к каналу с индивидуальным отправителем.