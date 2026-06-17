# Просмотр назначенных ролей

Чтобы посмотреть права аккаунта на ресурс, необходимо получить список ролей, назначенных на этот ресурс и на родительские ресурсы. Назначенные роли [наследуются](../../concepts/access-control/index.md#inheritance) от родительского ресурса дочернему. Например, если вы хотите узнать, какие права у аккаунта на каталог, посмотрите роли:

1. На этот каталог.
1. На облако, которому принадлежит каталог.
1. На организацию, которой принадлежит облако.

Список наследованных ролей на каталог или облако можно посмотреть в консоли управления в разделе **Права доступа** соответствующего каталога или облака.

[Узнайте](../../concepts/access-control/resources-with-access-control.md), на какие ресурсы можно назначать роли.

{% note info %}

Даже если [операция](../../../api-design-guide/concepts/about-async.md) с ресурсами [сервисов](../../../overview/concepts/services.md) Yandex Cloud разрешена [ролью](../../concepts/access-control/roles.md), ее выполнение может быть заблокировано, если для [организации](../../../organization/concepts/organization.md), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) создана [политика авторизации](../../concepts/access-control/access-policies.md), запрещающая эту операцию.

{% endnote %}

Чтобы посмотреть назначенные роли:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть роли [пользователя с аккаунтом на Яндексе](../../concepts/users/accounts.md#passport), [федеративного](../../concepts/users/accounts.md#saml-federation), [локального](../../concepts/users/accounts.md#local) пользователя или [сервисного аккаунта](../../concepts/users/service-accounts.md) на облако:

    1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите облако.
    1. Перейдите на вкладку **Права доступа**.
    1. Найдите в списке нужного пользователя. Назначенные ему роли указаны в столбце **Роли**.

  Чтобы посмотреть роли [сервисного аккаунта](../../concepts/users/service-accounts.md) на каталог и его дочерние ресурсы:

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Роли сервисного аккаунта перечислены в поле **Роли в каталоге**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Получите идентификатор аккаунта:
      1. [Инструкция](../sa/get-id.md) для сервисных аккаунтов.
      1. [Инструкция](../../../organization/operations/users-get.md) для пользователей с аккаунтом на Яндексе, федеративных и локальных пользователей.
  1. Получите идентификатор или имя желаемого ресурса.
  1. Посмотрите, какие роли назначены на ресурс:
     
     ```bash
     yc <имя_сервиса> <категория_ресурса> list-access-bindings <имя_или_идентификатор_ресурса>
     ```
     
     Где:
     
     * `<имя_сервиса>` — имя сервиса, которому принадлежит ресурс, например `resource-manager`.
     * `<категория_ресурса>` — категория ресурса, например `folder`.
     * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Вы можете указать ресурс по имени или идентификатору.
     
     Например, посмотрите кому и какие роли назначены на каталог `default`:
     
     ```bash
     yc resource-manager folder list-access-bindings default
     ```
     
     Результат:
     
     ```text
     +---------------------+----------------+----------------------+
     |       ROLE ID       |  SUBJECT TYPE  |      SUBJECT ID      |
     +---------------------+----------------+----------------------+
     | editor              | serviceAccount | ajepg0mjas06******** |
     | viewer              | userAccount    | aje6o61dvog2******** |
     +---------------------+----------------+----------------------+
     ```

        В ответе сервера найдите все строки, где в субъекте указан идентификатор требуемого аккаунта, а также где в качестве субъекта указаны [публичные группы](../../concepts/access-control/public-group.md) `All users` и `All authenticated users`.
    1. Повторите предыдущие два шага для всех родительских ресурсов.

- API {#api}

    1. Получите идентификатор аккаунта:
        1. [Инструкция](../sa/get-id.md) для сервисных аккаунтов.
        1. [Инструкция](../../../organization/operations/users-get.md) для пользователей с аккаунтом на Яндексе, федеративных и локальных пользователей.
    1. Получите идентификатор или имя желаемого ресурса.
    1. Посмотрите, кому и какие роли назначены на ресурс с помощью метода REST API `listAccessBindings`. Например, чтобы посмотреть роли на каталог `b1gvmob95yys********`:
       
       ```bash
       export FOLDER_ID=b1gvmob95yys********
       export IAM_TOKEN=CggaATEVAgA...
       curl \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
       ```
       
       Результат:
       
       ```json
       {
         "accessBindings": [
         {
           "subject": {
             "id": "ajei8n54hmfh********",
             "type": "userAccount"
           },
           "roleId": "editor"
         }
         ]
       }
       ```

        В ответе сервера найдите все строки, где в субъекте указан идентификатор требуемого аккаунта, а также где в качестве субъекта указаны [публичные группы](../../concepts/access-control/public-group.md) `All users` и `All authenticated users`.
    1. Повторите предыдущие два шага для всех родительских ресурсов.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Отзыв роли на ресурс](revoke.md)
* [Назначение роли](grant.md)