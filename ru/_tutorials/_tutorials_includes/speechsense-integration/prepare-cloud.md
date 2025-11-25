## Подготовьте облако к работе {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с {{ yandex-cloud }}, см. в документе [Начало работы с {{ yandex-cloud }}](../../../getting-started/).
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account), если платежный аккаунт находится в статусе `TRIAL_ACTIVE`, [активируйте платную версию](../../../billing/operations/activate-commercial.md) аккаунта.
1. [Назначьте](../../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль `speech-sense.spaces.creator`.

    {% include [note-managing-roles](../../../_includes/mdb/note-managing-roles.md) %}


### Создайте сервисный аккаунт {#create-sa}

Создайте сервисный аккаунт с [ролью](../../../speechsense/security/index.md#speechsense-data-editor) `speech-sense.data.editor` для доступа amoCRM к проекту {{ speechsense-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `speechsense`.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите `speech-sense.data.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}


### Создайте API-ключ для сервисного аккаунта {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `speechsense`.
  1. На панели сверху нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** нажмите **{{ ui-key.yacloud_portal.filters.action_select-all }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ — они понадобятся позднее.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

{% endlist %}


### Создайте пространство и привяжите платежный аккаунт {#create-space}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
  1. Введите название [пространства](../../../speechsense/concepts/resources-hierarchy.md#space).
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
  1. [Привяжите платежный аккаунт](../../../speechsense/operations/space/link-ba.md) к пространству для оплаты {{ speechsense-name }}.

      {% include [manage-ba-note](../../../_includes/speechsense/manage-ba-note.md) %}

{% endlist %}


### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в [новое пространство](#create-space).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yc-ui-talkanalytics.team.add-from-organization-key-value }}**.
  1. Скопируйте идентификатор [созданного ранее сервисного аккаунта](#create-sa) `speechsense` и вставьте в строку поиска.
  1. Выберите сервисный аккаунт `speechsense` и укажите роль [{{ roles-speechsense-data-editor }}](../../../speechsense/security/index.md#speechsense-data-editor). Эта роль позволит сервисному аккаунту загружать данные в {{ speechsense-name }}.
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.add }}**.

{% endlist %}