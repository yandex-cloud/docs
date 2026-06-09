# Покинуть организацию

Если вы пользователь [с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport), вы можете самостоятельно покинуть организацию. 

{% note info %}

Для данной инструкции необходимо использовать [CLI](../../cli/index.md), если выполнено одно или более из следующих условий:
* в настройках организации [включена](hide-user-info.md) опция **{{ ui-key.yacloud_org.organization.security-settings.OtherSecuritySettingsForm.title_hide-users-list_9eW2W }}**;
* применяется [политика авторизации](../../iam/concepts/access-control/access-policies.md) `organization.denyUserListing`, которая запрещает просматривать список пользователей организации.

{% endnote %}

Чтобы покинуть организацию: 

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Если вы состоите в нескольких организациях, [выберите](manage-organizations.md#switch-to-another-org) нужную.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}** и найдите вашего пользователя.

      При необходимости воспользуйтесь строкой поиска или фильтром вверху страницы.
  1. В строке с вашим пользователем нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите выход из организации.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для выхода из организации:

     ```bash
     yc organization-manager organization leave --help
     ```

  1. Чтобы покинуть организацию, выполните команду, указав [идентификатор](organization-get-id.md) этой организации:

     ```bash
     yc organization-manager organization leave <идентификатор_организации>
     ```

{% endlist %}

Обратите внимание, вы потеряете доступ ко всем облакам и другим ресурсам, принадлежащим организации. Чтобы этого избежать, вы можете [перенести](../../resource-manager/operations/cloud/change-organization.md) облако в другую организацию. Для этого у вас должна быть [роль](../../resource-manager/security/index.md#resource-manager-clouds-owner) `{{ roles-cloud-owner }}` на переносимое облако и [роль](../security/index.md#organization-manager-organizations-owner) `{{ roles-organization-owner }}` на организацию, в которую вы это облако собираетесь перенести.

Чтобы закрыть доступ к облакам организации, которую вы не собираетесь покидать, обратитесь к администратору соответствующего облака.

Если у вас возникли проблемы с исключением пользователя из организации, обратитесь в [техническую поддержку]({{ link-console-support }}).