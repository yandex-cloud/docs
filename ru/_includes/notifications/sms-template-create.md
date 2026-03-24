Чтобы создать шаблон SMS:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать шаблон.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. На панели слева выберите ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.cns.label_channels }}** и выберите канал с [индивидуальным отправителем](../../notifications/concepts/sms.md#individual-sender), в котором вы хотите создать шаблон.
  1. В меню слева выберите ![square-chart-bar](../../_assets/console-icons/square-chart-bar.svg) **{{ ui-key.yacloud.cns.local.label_templates_26VqM }}** и нажмите кнопку **{{ ui-key.yacloud.cns.SMSChannel.Templates.action_create-sms-template_e6hBJ }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.field_name_c6Q4T }}** задайте имя шаблона.
      1. В поле **{{ ui-key.yacloud.cns.SMSChannel.SelectTemplateType.field_type_furT8 }}** выберите тип создаваемого шаблона:

          {% include [sms-template-types](./sms-template-types.md) %}

      1. В поле **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.field_text_e8S2V }}** укажите тело шаблона.

          Текст SMS-уведомлений должен в точности соответствовать шаблону: совпадать должны регистр символов, количество и тип пробелов, а также в тексте не должно быть неописанных специальных символов.

          Подробнее о требованиях к шаблонам читайте в разделе [{#T}](../../notifications/concepts/sms.md#template-contents).
      1. В поле **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.field_message_sijJZ }}** введите пример текста SMS-уведомления, которое планируется отправлять и которое должно соответствовать создаваемому шаблону.

          Вы не сможете создать шаблон, если пример сообщения не будет соответствовать заданному выше шаблону.
      1. Нажмите кнопку **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.button_create_b5P5S }}**.

{% endlist %}

После создания новый шаблон SMS перейдет в [статус](../../notifications/concepts/sms.md#template-status) `Registering` и будет отправлен на регистрацию у операторов связи. При этом будет создано обращение в [службу поддержки]({{ link-console-support }}). Регистрация шаблона занимает от двух до четырех недель. По завершении регистрации шаблона всеми операторами связи шаблон перейдет в статус `Active`, и вы сможете им пользоваться.