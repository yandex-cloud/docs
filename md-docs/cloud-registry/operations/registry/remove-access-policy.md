# Удалить политику доступа к реестру

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
  1. Перейдите в сервис **Cloud Registry**.
  1. Выберите реестр.
  1. Перейдите на вкладку **Доступ для IP-адресов**.
  1. Нажмите кнопку **Настроить доступ**.
  1. В строке с политикой доступа, которую вы хотите удалить, нажмите ![trash-bin](../../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Удалите политику доступа к реестру:

     ```bash
     yc cloud-registry registry remove-ip-permissions <имя_или_идентификатор_реестра> \
       --pull <IP-адрес> \
       --push <IP-адрес>
     ```

     Где:
     * `--pull` — флаг, разрешающий скачивание [артефактов](../../concepts/artifacts/index.md) из реестра.
     * `--push` — флаг, разрешающий загрузку артефактов в реестр.

     Результат:

     ```text
     done (1s)
     ```

     Чтобы удалить все настроенные политики доступа к реестру и сразу задать новые, используйте команду `yc cloud-registry registry set-ip-permissions`.

- API {#api}

  Чтобы удалить политику доступа к реестру, воспользуйтесь методом REST API [updateIpPermissions](../../api-ref/Registry/updateIpPermissions.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/UpdateIpPermissions](../../api-ref/grpc/Registry/updateIpPermissions.md).

{% endlist %}