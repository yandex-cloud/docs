# Bitbucket

В [задачах {{ tracker-name }}](../about-tracker.md#zadacha) можно автоматически добавлять ссылки на коммиты из Bitbucket, указывая [ключ](../glossary.md#key) нужной задачи в комментарии к коммиту. Ссылки будут размещаться на вкладке **{{ ui-key.startrek-backend.fields.issue.commits-key-value }}**.

## Подключить репозиторий {#repo}

Чтобы подключить репозиторий на [Bitbucket](https://bitbucket.org) к {{ tracker-name }}:

1. {% include [make sure you are admin](../../_includes/tracker/make-sure-admin.md) %}

1. {% include [path to the repository](../../_includes/tracker/repository-path.md) %}

1. В поле **Платформа** выберите Bitbucket.

1. Создайте для {{ tracker-name }} пароль на Bitbucket. С помощью этого пароля {{ tracker-name }} сможет подключаться к вашим репозиториям.
    - Авторизуйтесь на Bitbucket.
    - Нажмите на свое фото в левом нижнем углу и выберите **Bitbucket settings**.
    - Выберите **App passwords** в блоке **Access management**.
    - Нажмите **Create app password**.
    - Придумайте название для пароля, например `Tracker integration password`.
    - Настройте разрешения для пароля. Для правильной работы с {{ tracker-name }} необходимо, чтобы опция **read** в блоке **Repositories** была включена:
        ![](../../_assets/tracker/bitbucket-password-settings.png)
    - Нажмите кнопку **Create**.
    - Скопируйте пароль в буфер обмена.

        {% note alert %}

        Значение пароля отображается только один раз. Если закрыть страницу, вы больше не сможете его просмотреть.

        {% endnote %}

1. Укажите адрес репозитория в формате `https://bitbucket.org/<логин_владельца_репозитория>/<имя_репозитория>` и ваш логин на Bitbucket.

1. Вставьте пароль, который вы создали для доступа {{ tracker-name }} к Bitbucket. Ваш личный пароль от Bitbucket для этого не подойдет.

1. Нажмите кнопку **Подключить**.

1. Убедитесь, что статус репозитория отображается в {{ tracker-name }} как **Подключен**.

{% include [commits](../../_includes/tracker/add_commits.md) %}

## Собственный сервер {#on-premise}

{% include [on-premise server](../../_includes/tracker/on-premise-server.md) %}
