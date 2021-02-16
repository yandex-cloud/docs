# Использовать форму как шаблон для создания задач

{% note warning %}

По умолчанию настройка очереди доступна только ее владельцу.

{% endnote %}

С помощью сервиса Яндекс.Формы вы можете настроить свою форму для создания задач и встроить ее в интерфейс {{ tracker-name }}. Такая форма будет отображаться на странице создания задачи рядом со стандартной. Она поможет пользователям создавать задачи по определенному шаблону, не отвлекаясь на лишние поля и параметры.

## Шаг 1. Создайте и настройте форму {#section_ovd_5hl_1gb}

1. {% if audience == "external" %}Перейдите в сервис [Яндекс.Формы]({{ link-forms }}). Если сервис не подключен, обратитесь к администратору вашей организации.{% else %}Перейдите в сервис [Яндекс.Формы]({{ link-forms }}).{% endif %}

1. [Создайте]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/new-form.html){% else %}(https://yandex.com/support/connect-forms/common/new-form.html){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/new-form.html){% endif %} новую форму с нуля или используйте шаблон **Задача для {{ tracker-name }}**.
   
   Настройте ее поля так, чтобы собрать данные, которые необходимы для создания задачи.

1. Настройте название формы. Название будет отображаться в интерфейсе {{ tracker-name }} при создании задачи.

1. Настройте для формы [интеграцию с {{ tracker-name }}]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/create-task.html){% else %}(https://yandex.com/support/connect-forms/common/create-task.html){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/create-task.html){% endif %}.

1. [Опубликуйте]{% if audience == "external" %}{% if locale == "ru" %}(https://yandex.ru/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% else %}(https://yandex.com/support/connect-forms/common/publish.html#publish__section_lmk_gvb_tbb){% endif %}{% else %}(https://doc.yandex-team.ru/forms/external/publish.html){% endif %} форму и скопируйте ссылку на форму из поля **Ссылка**.

## Шаг 2. Подключите форму к очереди {#section_xxj_fll_1gb}

1. Перейдите в [{{ tracker-name }}]{% if audience == "external" %}({{ link-tracker }}){% else %}({{ link-tracker-ya }}){% endif %}.

1. Откройте [страницу очереди](../user/queue.md).

1. Слева от имени очереди выберите ![](../../_assets/tracker/icon-settings.png) → **Администрирование**.

1. В разделе **Интеграция форм** нажмите кнопку **Добавить форму**.

1. Вставьте ссылку на форму.

1. Добавьте название и описание формы. Они будут видны в окне выбора формы при создании задачи.

1. Нажмите кнопку **Добавить**.

