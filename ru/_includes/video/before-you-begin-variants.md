Чтобы начать работать с {{ video-name }}:

{% list tabs group=cloud_user %}

- Новый пользователь {#new}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе. Если у вас еще нет аккаунта, [создайте](https://yandex.ru/support/passport/authorization/registration.html) его.
  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. На главной странице сервиса подтвердите, что ознакомились с [Условиями использования](https://yandex.ru/legal/cloud_termsofuse/?lang=ru) и принимаете их и нажмите кнопку **Войти**.
  1. Создайте [платежный аккаунт](../../billing/operations/create-new-account.md).

- Уже использую {{ yandex-cloud }} {#already}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе.
  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите один из вариантов:

     * Если у вас уже есть организация, выберите ее в выпадающем меню и нажмите **{{ ui-key.yacloud_video.organization.action_open-cloud-video }}**.

       {% note info %}

       Для активации экземпляра {{ video-name }} нужна роль `admin` или `owner`. Подробнее про роли в разделе [{#T}](../../organization/security/index.md).

       {% endnote %}

     * Если у вас есть облако, но нет организации, нажмите **Открыть Cloud Center**. В открывшемся окне введите название и описание организации и нажмите **Создать организацию и Cloud Video**. Работа с организациями описана в разделе [Начало работы с организациями](../../organization/quickstart.md).
   1. Убедитесь, что у вас есть _минимальная_ [роль](../../video/security/index.md#video-editor) `video.editor` в организации для работы с {{ video-name }}.

{% endlist %}

{% note info %}

Создание нового платежного аккаунта доступно только пользователям с учетной записью [Яндекс ID](https://yandex.ru/support/id/index.html) или [{{ yandex-360 }}](https://360.yandex.ru/). [Федеративные](../../iam/concepts/users/accounts.md#saml-federation) учетные записи для этого не подходят.

Для привязки платежного аккаунта у пользователя должны быть [роли](../../video/security/index.md#service-roles):

* на платежный аккаунт — `billing.accounts.editor` или выше;
* на организацию с {{ video-short-name }} — [`video.admin`](../../video/security/index.md#video-admin) или роли, включающие ее полномочия, например `{{ roles-organization-owner }}`.

{% endnote %}

Если у вас возник технический вопрос по работе сервиса, обратитесь в [службу поддержки]({{ link-console-support }}) {{ yandex-cloud }}.
