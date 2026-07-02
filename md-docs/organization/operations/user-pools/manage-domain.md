[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Управление пулами пользователей > Настроить домен в пуле пользователей

# Управление доменами в пуле пользователей


[Домен](../../concepts/domains.md) дает возможность аутентифицироваться через систему [Login Discovery](../../concepts/domains.md#login-discovery). При аутентификации пользователь с вашим доменом будет перенаправлен в ваш [пул пользователей](../../concepts/user-pools.md).

## Привязать домен {#add}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей** и выберите нужный пул пользователей.
  1. В верхнем правом углу нажмите **Добавить домен**.
  1. Введите имя домена.
  1. Нажмите **Добавить**.

  Чтобы использовать домен для добавления новых пользователей, [подтвердите](validate-domain.md) его.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для привязки домена к пулу пользователей:

     ```bash
     yc organization-manager idp userpool domain add --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain add <идентификатор_пула> <домен>
      ```

      Результат:

      ```text
      done (1s)
      domain: example. com
      status: NEED_TO_VALIDATE
      status_code: organization/domain-diagnostics#need-to-validate
      created_at: "2025-10-09T06:40:18.704791371Z"
      validated_at: "1970-01-01T00:00:00Z"
      challenges:
      - created_at: "2025-10-09T06:40:18.704791371Z"
      updated_at: "2025-10-09T06:40:18.704791371Z"
      type: DNS_TXT
      status: PENDING
      dns_challenge:
      name: _yandexcloud-challenge. example. com
      type: TXT
      value: TlHc5HKJDeQIgPqaoiiSXxgy3CWFD+MLMJJP********
      ```

      Сохраните значение поля `value`, оно понадобится для [подтверждения домена](validate-domain.md).

- API {#api}

  Воспользуйтесь методом REST API [Userpool.AddDomain](../../idp/api-ref/Userpool/addDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/AddDomain](../../idp/api-ref/grpc/Userpool/addDomain.md).

{% endlist %}

## Подтвердить домен {#validate}

Для добавления пользователей можно использовать только подтвержденные домены.

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Выберите домен, который необходимо подтвердить.
  1. В открывшемся блоке будет указана информация для прохождения процедуры проверки прав на домен.
  1. После прохождения процедуры нажмите **Подтвердить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.  

  1. Подтвердите, что домен принадлежит вам:

     1. Перейдите в раздел управления DNS-записями на сайте DNS-провайдера вашего домена:
     1. Добавьте TXT-запись со следующими параметрами:

        * **Host** или **Subdomain** — `_yandexcloud-challenge`
        * **Text** или **Value** — значение поля `value`, полученное после [привязки домена](add-domain.md).

     1. Дождитесь обновления записей в системе DNS. Обновление может занять до 72 часов.

  1. Посмотрите описание команды CLI для подтверждения домена в [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain validate --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain validate <идентификатор_пула> <домен> \
        --name <домен>
      ```

      Например, подтвердите домен `my-domain.ru` в федерации `my-federation`:

      ```bash
      yc organization-manager federation saml validate-domain my-federation \
        --domain my-domain.ru
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.ValidateDomain](../../idp/api-ref/Userpool/validateDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/ValidateDomain](../../idp/api-ref/grpc/Userpool/validateDomain.md).

{% endlist %}

## Получить список доменов {#list}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.
  1. В блоке **Домены** отобразится список всех доступных доменов.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [доменов](../../concepts/domains.md) в [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain list <идентификатор_пула>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.ListDomains](../../idp/api-ref/Userpool/listDomains.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/ListDomains](../../idp/api-ref/grpc/Userpool/listDomains.md).

{% endlist %}

## Посмотреть информацию о домене {#get}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей**.
  1. В списке [пулов пользователей](../../concepts/user-pools.md) выберите нужный пул.
  1. В блоке **Домены** нажмите на название нужного [домена](../../concepts/domains.md).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра информации о [домене](../../concepts/domains.md) в [пуле пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain get --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool domain get <идентификатор_пула> <домен>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.GetDomain](../../idp/api-ref/Userpool/getDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/GetDomain](../../idp/api-ref/grpc/Userpool/getDomain.md).

{% endlist %}

## Удалить домен {#delete}

Нельзя удалить домен по умолчанию или домен, к которому привязаны пользователи.

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. В блоке **Домены** рядом с необходимым доменом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление домена.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления домена из [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool domain delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool domain delete <идентификатор_пула> <домен>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.DeleteDomain](../../idp/api-ref/Userpool/deleteDomain.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/DeleteDomain](../../idp/api-ref/grpc/Userpool/deleteDomain.md).

{% endlist %}