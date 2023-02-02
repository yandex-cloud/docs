# Посмотреть настройки масштабирования контейнера

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

- API

  Посмотреть настройки масштабирования контейнера можно с помощью метода API [getRevision](../containers/api-ref/Container/getRevision.md).

{% endlist %}

{% include [scaling](../../_includes/serverless-containers/see-also-scaling.md) %}