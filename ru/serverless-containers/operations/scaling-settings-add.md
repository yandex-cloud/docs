# Добавить настройки масштабирования контейнеру

Вы можете задать количество подготовленных экземпляров.

{% include [provisioned-instances-price](../../_includes/serverless-containers/provisioned-instances-price.md) %}

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
	  image_url: {{ registry }}/crpd3cicopk7********/test-container:latest
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

- API

  Добавить настройки масштабирования для контейнера можно с помощью метода API [deployRevision](../containers/api-ref/Container/deployRevision.md).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}
