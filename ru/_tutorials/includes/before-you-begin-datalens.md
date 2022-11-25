Чтобы начать работать с {{ datalens-short-name }}:

{% if product == "yandex-cloud" %}

{% list tabs %}

- Новый пользователь

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе. Если у вас еще нет аккаунта, [создайте](https://yandex.ru/support/passport/authorization/registration.html) его.
  1. Откройте [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
  1. Нажмите **Открыть DataLens**.
  1. Нажмите **Войти**.

- Уже использую {{ yandex-cloud }}

  1. [Войдите]({{ link-passport-login }}) в ваш аккаунт на Яндексе.
  1. Откройте [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
  1. Нажмите **Открыть DataLens**.
  1. Выберите один из вариантов:

     * Если у вас уже есть организация, выберите ее в выпадающем меню на вкладке **Организации** и нажмите **Открыть DataLens**.
       
       {% note info %}

       Для активации экземпляра {{ datalens-short-name }} пользователю нужна роль `admin` или `owner`. Подробнее про роли см. в разделе [{#T}](../../organization/roles.md).

       {% endnote %}

     * Если у вас есть облако, но нет организации, нажмите **Добавить новый DataLens**. В открывшемся окне введите название и описание организации и нажмите **Создать организацию и DataLens**. Подробнее о работе с организациями см. в разделе [Начало работы с организациями](../../organization/quick-start.md).

{% endlist %}

Если у вас возник технический вопрос по работе сервиса, обратитесь в [службу поддержки]({{ link-console-support }}) {{ yandex-cloud }}. Чтобы спросить совета, обсудить решение вашей задачи или лучшие практики работы сервиса, напишите в чат [{{ datalens-short-name }}](https://t.me/YandexDataLens) в Telegram. 

{% endif %}

{% if product == "cloud-il" %}

1. Перейдите в [консоль управления]({{ link-console-main }}) и войдите в {{ yandex-cloud }}.
1. Откройте [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. Создайте [воркбук](../../datalens/concepts/index.md#workbooks-and-collections) — контейнер для хранения сущностей {{ datalens-short-name }}.
    1. Нажмите **Создать** → **Создать воркбук**.
    1. Укажите название воркбука.
    1. Нажмите **Создать**.

Если у вас возник технический вопрос по работе сервиса, обратитесь в [службу поддержки]({{ link-console-support }}) {{ yandex-cloud }}.

{% endif %}