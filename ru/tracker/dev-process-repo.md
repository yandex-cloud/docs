# Подключить репозиторий к {{ tracker-name }}

Если вы используете сервисы GitHub, GitLab или Bitbucket, вы можете подключить ваши репозитории к {{ tracker-name }} и привязывать коммиты к задачам. Это позволит при необходимости найти изменения в коде, связанные с определенной задачей.

Чтобы подключить репозиторий:

1. Убедитесь, что вы авторизованы в {{ tracker-name }} как [администратор](role-model.md).

1. {% include [path to the repository](../_includes/tracker/repository-path.md) %} 

1. Выберите сервис, в котором расположен репозиторий, и укажите данные для подключения:

    - Ссылку на репозиторий.

    - Для закрытых репозиториев GitHub и GitLab — токен. Для публичных репозиториев указывать токен не нужно.

    - Для репозитория Bitbucket — ваш логин на Bitbucket и специально созданный пароль для {{ tracker-name }}.

    Подробнее о параметрах подключения читайте в разделе [{#T}](user/add-repository.md).

1. Чтобы на странице задачи отображались связанные коммиты, в настройках вашей очереди включите соответствующую опцию:

    1. Откройте [страницу очереди](user/queue.md).
    1. В правом верхнем углу страницы нажмите ![](../_assets/tracker/svg/settings.svg) **Настройки очереди**.
    1. Перейдите на вкладку **Интеграции**.
    1. В блоке **Коммиты** активируйте опцию.

Чтобы связать коммит с задачей в {{ tracker-name }}, в комментарии к коммиту укажите [ключ задачи](user/create-ticket.md#key).

