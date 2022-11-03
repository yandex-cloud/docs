# Масштабирование контейнера

Вы можете задать количество подготовленных экземпляров.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

Подробнее о [масштабировании контейнера](../concepts/container.md#scaling) в {{ serverless-containers-name }}.

## Посмотреть настройки масштабирования {#list}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер. Количество подготовленных экземпляров отображается в блоке **Ревизии**, в строке с активной ревизией контейнера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть настройки масштабирования контейнера, выполните команду:

    ```
    yc serverless container revision get container-id=flhqle7d5o**********
    ```

    Где `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.

    Результат:

    ```
    id: flhqle7d5o**********
	container_id: flhqle7d5o**********
	created_at: "2022-09-14T12:48:55.914Z"
	image:
	  image_url: cr.cloud-preprod.yandex.net/crtrvt9l6f**********/billing-test
	  image_digest: sha256:e3aaa4c9af7d99ea5e4e4236bc540a3cc826d1f1344a601ddb9cbc**********
	resources:
	  memory: "134217728"
	  cores: "1"
	  core_fraction: "100"
	execution_timeout: 10s
	service_account_id: bfbdkhbl8f**********
	status: ACTIVE
	provision_policy:
	  min_instances: "1"
    ```

    Количество подготовленных экземпляров отображается в поле `min_instances`.

{% endlist %}

## Добавить настройки масштабирования {#add}

Настройки масштабирования не могут превышать [квоты](../concepts/limits.md#serverless-containers-quotas).

{% include [provisioned-instances-time](../../_includes/functions/provisioned-instances-time.md)%}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Настройки** укажите количество подготовленных экземпляров.
    1. Нажмите кнопку **Создать ревизию**.

- CLI

    Чтобы добавить настройки масштабирования для контейнера, выполните команду:

    ```
    yc serverless container revision deploy \
	  --container-id <идентификатор_контейнера> \
	  --image <URL_Docker-образа> \
	  --cores 1 \
	  --memory 1GB \
	  --execution-timeout 3s \
	  --service-account-id <идентификатор_сервисного_аккаунта> \
	  --min-instances 1
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--execution-timeout` — таймаут. По умолчанию — 3 секунды.
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.
    * `--min-instances` — количество подготовленных экземпляров.


    Результат:

    ```
    id: bbajn5q2d74c********
	container_id: bba3fva6ka5g********
	created_at: "2021-07-09T15:04:55.135Z"
	image:
	  image_url: cr.yandex/crpd3cicopk7********/test-container:latest
	  image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
	resources:
	  memory: "1073741824"
	  cores: "1"
	execution_timeout: 3s
	service_account_id: ajeqnasj95o7********
	status: ACTIVE
	provision_policy:
	  min_instances: "1"
    ```

{% endlist %}

## Удалить настройки масштабирования {#delete}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Настройки** укажите количество подготовленных экземпляров равным `0`.
    1. Нажмите кнопку **Создать ревизию**.

- CLI

    Чтобы удалить настройки масштабирования для контейнера, создайте новую ревизию контейнера и укажите параметр `min-instances` равным `0`:

    ```
    yc serverless container revision deploy \
	  --container-id <идентификатор_контейнера> \
	  --image <URL_Docker-образа> \
	  --cores 1 \
	  --memory 1GB \
	  --execution-timeout 3s \
	  --service-account-id <идентификатор_сервисного_аккаунта> \
	  --min-instances 0
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--cores` — количество ядер, которые доступны контейнеру.
    * `--memory` — требуемая память. По умолчанию — 128 МБ.
    * `--execution-timeout` — таймаут. По умолчанию — 3 секунды.
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.
    * `--min-instances` — количество подготовленных экземпляров.

    Результат:

    ```
    id: bbajn5q2d74c********
	container_id: bba3fva6ka5g********
	created_at: "2021-07-09T15:04:55.135Z"
	image:
	  image_url: cr.yandex/crpd3cicopk7********/test-container:latest
	  image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
	resources:
	  memory: "1073741824"
	  cores: "1"
	execution_timeout: 3s
	service_account_id: ajeqnasj95o7********
	status: ACTIVE
    ```

{% endlist %}
