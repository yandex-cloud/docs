# Изменить реестр

Узнайте, как изменить:
* [Имя реестра](#update-name).
* [Метку реестра](#update-label).
* [Доступ для IP-адресов](#access-ip).

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [Получить информацию об имеющихся реестрах](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить имя [реестра](../../concepts/registry.md):
  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Container Registry**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis-vertical.svg) в строке реестра, который требуется изменить.
  1. В открывшемся меню нажмите кнопку **Редактировать**.
  1. В открывшемся окне укажите нужное имя реестра.
  1. (опционально) Измените метки.
  1. Нажмите кнопку **Изменить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените имя реестра:

  ```bash
  yc container registry update my-reg --new-name new-reg
  ```

  Результат:

  ```text
  id: crp3qleutgks********
  folder_id: b1g88tflru0e********
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```

- API {#api}

  Чтобы изменить имя реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md).

{% endlist %}

## Изменить метку реестра {#update-label}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените метку реестра (не путайте с тегами [Docker-образа](../../concepts/docker-image.md)):

  ```bash
  yc container registry update new-reg --labels new_label=test_label
  ```

  Результат:

  ```text
  id: crp3qleutgks********
  folder_id: b1g88tflru0e********
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```

- API {#api}

  Чтобы изменить метку реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/index.md).

{% endlist %}

## Настроить доступ для IP-адресов {#access-ip}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы добавить или удалить [IP-адрес](../../../vpc/concepts/address.md) и настроить доступ к реестру:
  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Container Registry**.
  1. Нажмите на имя нужного реестра, затем выберите вкладку ![ip-address.svg](../../../_assets/console-icons/shield.svg) **Доступ  для IP-адресов** и нажмите кнопку **Настроить**.
  1. Нажмите кнопку **Добавить** и укажите IP-адрес и право на действие с реестром — `PULL` (позволяет скачивать Docker-образы из реестра) или `PUSH` (позволяет загружать Docker-образы в реестр).
  1. Нажмите значок ![image](../../../_assets/console-icons/xmark.svg) в строке IP-адреса, права доступа с которого требуется удалить.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Добавьте IP-адрес для разрешения доступа:

  ```bash
  yc container registry add-ip-permissions \
    --name my-reg \
    --pull <IP-адрес_с_доступом_к_PULL> \
    --push <IP-адрес_с_доступом_к_PUSH>
  ```

  Удалите доступ для IP-адреса:

  ```bash
  yc container registry remove-ip-permissions \
    --name my-reg \
    --pull <IP-адрес_с_доступом_к_PULL> \
    --push <IP-адрес_с_доступом_к_PUSH>
  ```

- API {#api}

  Чтобы добавить, изменить или удалить IP-адрес и настроить права доступа к [реестру](../../concepts/registry.md), воспользуйтесь методом [updateIpPermission](../../api-ref/Registry/updateIpPermission.md) для ресурса [Registry](../../api-ref/Registry/index.md).

{% endlist %}