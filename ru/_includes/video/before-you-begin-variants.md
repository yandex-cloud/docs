Чтобы начать работать с {{ video-name }}:

{% list tabs group=cloud_user %}

- Новый пользователь {#new}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе. Если у вас еще нет аккаунта, [создайте](https://yandex.ru/support/passport/authorization/registration.html) его.
  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Заполните заявку на доступ к [Preview-версии](../../overview/concepts/launch-stages.md).

     Дождитесь подтверждения заявки.

  1. На главной странице сервиса подтвердите, что ознакомились с [Условиями использования](https://yandex.ru/legal/cloud_termsofuse/?lang=ru) и принимаете их и нажмите кнопку **Войти**.
  1. Создайте [платежный аккаунт](../../billing/operations/create-new-account.md).

- Уже использую {{ yandex-cloud }} {#already}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе.
  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Заполните заявку на доступ к [Preview-версии](../../overview/concepts/launch-stages.md).
  1. Выберите один из вариантов:

     * Если у вас уже есть организация, выберите ее в выпадающем меню и нажмите **Открыть Cloud Video**.

       {% note info %}

       Для активации экземпляра {{ video-name }} нужна роль `admin` или `owner`. Подробнее про роли см. в разделе [{#T}](../../organization/security/index.md).

       {% endnote %}

     * Если у вас есть облако, но нет организации, нажмите **Открыть Cloud Center**. В открывшемся окне введите название и описание организации и нажмите **Создать организацию и Cloud Video**. Подробнее о работе с организациями см. в разделе [Начало работы с организациями](../../organization/quickstart.md).
   1. Убедитесь, что у вас есть _минимальная_ [роль](../../video/security/index.md#video-editor) `video.editor` в организации для работы с {{ video-name }}.

{% endlist %}

Если у вас возник технический вопрос по работе сервиса, обратитесь в [службу поддержки]({{ link-console-support }}) {{ yandex-cloud }}.
