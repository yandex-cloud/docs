# Формы

В сервисе [Яндекс.Формы]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %} можно настроить интеграцию с {{ tracker-name }}, чтобы автоматически создавать задачи на основании данных, полученных через форму.

Форму можно опубликовать по прямой ссылке, разместить на сайте или вики-странице. С помощью таких форм задачи могут создавать даже те пользователи, у которых нет доступа {{ tracker-name }}. Например, формы удобно использовать, чтобы [принимать обращения пользователей в службу поддержки](../support-process.md#form) или заявки на обслуживание.

Чтобы использовать форму как шаблон для быстрого создания типовых задач, [встройте форму на страницу создания задачи в {{ tracker-name }}](attach-form.md).

Чтобы настроить форму для создания задач:

1. {% if audience == "external" %}Перейдите в сервис [Яндекс.Формы]({{ link-forms }}). Если сервис не подключен, обратитесь к администратору вашей организации.{% else %}Перейдите в сервис [Яндекс.Формы]({{ link-forms-ya }}).{% endif %}

1. [Создайте]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/new-form.html){% else %}(https://yandex.com/support/connect-forms/common/new-form.html){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/new-form.html){% endif %} новую форму.
    Настройте ее так, чтобы собрать данные, которые необходимы для создания задачи.

1. Настройте [интеграцию с {{ tracker-name }}]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/create-task.html){% else %}(https://yandex.com/support/connect-forms/common/create-task.html){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/create-task.html){% endif %}:

    1. Укажите очередь и другие параметры задачи.

    1. В поле **Описание задачи** добавьте ответы на вопросы формы.

    1. Чтобы сохранить в параметрах задачи ответ на определенный вопрос формы, в настройках интеграции добавьте поле задачи, нажмите **Переменные** → **Ответ на вопрос** и выберите вопрос. 
        Если в параметрах задачи нет нужного вам поля, вы можете его [создать](../user/create-param.md).

    1. Сохраните параметры интеграции.
    Форма будет отправлять в {{ tracker-name }} ответы пользователя, а {{ tracker-name }} создаст на их основе задачу.

    {% if audience == "internal" %}

    {% note tip %}

    Если через форму нужно создать задачу с [чеклиcтом](../user/checklist.md), используйте интеграцию [<q>HTTP.Запрос в ручку</q>](https://doc.yandex-team.ru/forms/external/http-request.html#http-request__resolve-problems-checklist).

    {% endnote %}

    {% endif %}

{% if audience == "external" %}

1. Настройте [доступ к заполнению формы]{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/restrictions.html#restrictions__sec_access){% else %}(https://yandex.com/support/connect-forms/common/restrictions.html#restrictions__sec_access){% endif %}.
    По умолчанию форму могут заполнять все пользователи. Вы можете разрешить заполнение формы только сотрудникам вашей организации.

{% endif %}

1. [Опубликуйте]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% else %}(https://yandex.com/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/publish.html){% endif %} форму. Форма будет доступна по ссылке, указанной в поле **Ссылка**.

Опубликованную форму можно [встроить в вики-страницу](https://doc.yandex-team.ru/forms/external/publish.html#publish__section_xvx_g2c_tbb), [разместить на сайте](https://doc.yandex-team.ru/forms/external/publish.html#publish__section_c21_gdb_42b) или [добавить на страницу создания задачи](../manager/attach-form.md) в интерфейсе {{ tracker-name }}.

Подробнее о сервисе Яндекс.Формы читайте в [Справке]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/){% else %}(https://yandex.com/support/connect-forms/){% endif %}{% else %}(https://doc.yandex-team.ru/forms/){% endif %}.


