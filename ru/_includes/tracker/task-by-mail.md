{% list tabs %}

- На произвольном почтовом сервере

   1. На любом почтовом сервере заведите почтовый адрес для очереди. Все письма, которые поступят на этот адрес, станут задачами в очереди.
  
   1. {% include [go to settings](transition-page.md) %}

   1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

   1. Выберите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-aliases }}**.

   1. Нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesEmptyList.action-configure-mail }}**.
  
   1. Настройте почтовый ящик для получения писем:

      1. В разделе **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-settings-title }}**, в поле **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-address }}**, укажите почтовый адрес, который вы завели на шаге 1, вместе с доменом, например, `{{ example-account }}`. Поле **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-login }}** заполнится автоматически.
      1. В поле **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-password }}** укажите пароль для почтового адреса. Если выбранный почтовый сервер позволяет контролировать доступ к почтовому ящику с помощью пароля приложения, укажите в этом поле пароль приложения для почтовых клиентов. [Узнать больше о паролях приложений в документации Яндекс ID]({{ link-yandex }}/support/id/authorization/app-passwords.html). 
      1. Укажите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-imap }}** и **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-port }}** почтового сервера — это необходимо для сбора писем. Узнать эти данные можно в параметрах учетной записи почты.
      1. Чтобы включить шифрование с помощью протокола SSL, активируйте опцию **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-ssl }}**.
      1. Если требуется обрабатывать письма не только от сотрудников организации, но и от внешних пользователей, активируйте настройку **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-allow-external }}**.
     
         {% cut "Дополнительные параметры" %}
   
         * **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-incoming-folder }}** — создайте папку для писем от {{ tracker-name }} и укажите ее название. Из писем, поступающих в эту папку, будут автоматически создаваться задачи в очереди.
         * **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-archive-folder }}** — создайте папку для архивации писем от {{ tracker-name }} и укажите ее название.
         * **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-process-messages-from }}** — укажите дату. Письма, пришедшие до указанной даты, не обрабатываются и автоматически попадают в **Папку для архива**.

         {% note alert %}

         Используйте отдельные папки для сбора входящих писем и для их архивации.

         {% endnote %}

         {% endcut %}

      1. Проверьте созданное подключение.

   1. Укажите параметры, с которыми будут создаваться задачи из почты: тип задачи и [компоненты](../../tracker/manager/components.md).
  
   1. Если вы хотите, чтобы комментарии из задачи также отправлялись в виде писем, настройте почтовый ящик для отправки писем:
      1. В разделе **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-settings-title }}** нажмите ![](../../_assets/tracker/svg/add-address.svg) **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesStateList.action-add-mail }}**.
      1. В поле **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-login }}** укажите почту, с которой будут отправляться письма — комментарии из задачи, например, `{{ example-account }}`.
      1. В поле **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-password }}** укажите пароль для почтового адреса.
      1. Укажите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-smtp }}** и **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-port }}** — это необходимо для работы исходящей почты. Узнать эти данные можно в параметрах учетной записи почты.
      1. Чтобы включить шифрование с помощью протокола SSL, активируйте опцию **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.send-mail-ssl }}**.
      1. Настройте **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.signature-settings-title }}** для отправляемых писем. Обязательно укажите **{{ ui-key.startrek.ui_components_page-queue-admin_Signature.alias-title }}**: по нему вы сможете различать подписи в общем списке. Получатели письма увидят псевдоним вместо имени отправителя письма.
      1. Проверьте, что все работает: нажмите ![](../../_assets/tracker/svg/send-email.svg) **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesFormSendPanel.test-mail-button }}**.
  
   1. Нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.save-button }}**. Почтовый адрес, который вы создали для очереди, заработает в течение часа после создания.

   1. Включите отправку комментариев в виде писем из задачи:
      1. В настройках очереди выберите раздел **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--main }}**. 
      1. Нажмите **{{ ui-key.startrek.blocks-desktop_b-queue-form.advanced-settings-show }}** и в блоке **{{ ui-key.startrek.blocks-desktop_b-queue-form.mail }}** активируйте опцию **{{ ui-key.startrek.blocks-desktop_b-queue-form.mail-checkbox }}**.

  {% note tip %}

  Чтобы сотрудники организации могли создавать задачи по почте, настройте для них [доступ к очереди](../../tracker/manager/queue-access.md).

  {% endnote %}

- На домене в {{ yandex-360 }}

  1. {% include [go to settings](transition-page.md) %} 

  1. В правом верхнем углу нажмите ![](../../_assets/tracker/svg/queue-settings.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

  1. Выберите **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-aliases }}**.
   
  1. Проверьте, настроен ли у вашей организации в {{ ya-360 }} [почтовый домен]({{ support-business-domain }}). Если нет, нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesStateList.action-domain }}** — откроется {{ ya-360 }}, и вы сможете создать домен. Если у вас уже настроен почтовый домен в другом сервисе, вы можете создать для него поддомен и [подключить в {{ ya-360 }}]({{ support-business-domain }}).
  
  1. Нажмите **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesEmptyList.action-configure-mail }}**.
  
  1. Настройте почтовый ящик для получения и отправки писем:
     1. В поле **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-address }}** укажите новый почтовый адрес, который будет использоваться только для очереди.
     1. Если требуется обрабатывать письма не только от сотрудников организации, но и от внешних пользователей, активируйте настройку **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesCreateForm.mail-allow-external }}**.
  
  1. Укажите параметры, с которыми должны создаваться задачи очереди: [тип задачи](../../tracker/manager/add-ticket-type.md) и [компоненты](../../tracker/manager/components.md).
  
  1. Настройте подписи для отправляемых писем. Обязательно укажите **{{ ui-key.startrek.ui_components_page-queue-admin_Signature.alias-title }}** — по нему вы сможете различать подписи в общем списке. Получатели письма увидят псевдоним вместо имени отправителя письма. Проверьте, что все работает: отправьте тестовое письмо.

  1. Нажмите **{{ ui-key.startrek.blocks-desktop_b-form-new-component.button-create }}**. Почтовый адрес, который вы создали для очереди, заработает в течение часа после создания.

  {% note tip %}

  Чтобы сотрудники организации могли создавать задачи по почте, настройте для них [доступ к очереди](../../tracker/manager/queue-access.md).

  {% endnote %}

{% endlist %}