Чтобы подключить к {{ tracker-name }} собственный сервер:

1. {% include [make sure you are admin](make-sure-admin.md) %}

1. {% include [path to the repository](repository-path.md) %}

1. В поле **{{ ui-key.startrek.blocks-desktop_repository-modal.platform }}** выберите платформу, к которой подключен ваш сервер.

1. В поле **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog_fields_UrlField.server-url-label }}** укажите адрес вашего сервера до любого доступного по токену репозитория.

1. В поле **{{ ui-key.startrek.ui_components_admin-repositories_ConnectRepositoryDialog.token-label }}** укажите токен для подключения к вашему серверу.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_repository-modal.button--connect }}**.

1. Убедитесь, что статус репозиториев отображается в {{ tracker-name }} как **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_repositories.status--success }}**.
