Чтобы подключить к {{ tracker-name }} собственный сервер:

1. {% include [make sure you are admin](make-sure-admin.md) %}

1. {% include [path to the repository](repository-path.md) %}

1. В поле **Платформа** выберите платформу, к которой подключен ваш сервер.

1. В поле **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog_fields_UrlField.server-url-label }}** укажите адрес вашего сервера до любого доступного по токену репозитория.

1. Получите на GitLab OAuth-токен для своего репозитория. Подробную инструкцию о том, как получить токен, читайте в [документации GitLab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token). Для корректной работы {{ tracker-name }} при настройке разрешения включите опции **read_repository** и **read_api**.

1. В поле **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog.token-label }}** укажите токен для подключения к вашему серверу.

1. Нажмите кнопку **Подключить**.

1. Убедитесь, что статус репозиториев отображается в {{ tracker-name }} как **Подключен**.
