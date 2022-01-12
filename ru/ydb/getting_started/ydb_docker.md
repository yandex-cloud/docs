---
sourcePath: overlay/getting_started/ydb_docker.md
---
{% include [intro.md](_includes/ydb_docker/01_intro.md) %}

{% if audience != "external" %}

{% note info "Рецепт YDB" %}

Для тестов в Аркадии рекомендуется использовать [рецепт YDB](ydb_recipe.md)

{% endnote %}

{% endif %}

{% include [install.md](_includes/ydb_docker/02_install.md) %}

{% if audience != "external" %}

Внутри Yandex нужно использовать образ контейнера из Registry: ``registry.yandex.net/yandex-docker-local-ydb:stable``. Чтобы скачать самую актуальную версию образа,
выполните команду:

```bash
sudo docker pull registry.yandex.net/yandex-docker-local-ydb:stable
```

{% endif %}

{% include [start.md](_includes/ydb_docker/03_start.md) %}

{% if audience != "external" %}

При использовании образа контейнера из Registry внутри Yandex запуск образа выполняется следующей командой:

```bash
sudo docker run --hostname localhost -e YDB_LOCAL_SURVIVE_RESTART=true -dp 2135:2135 registry.yandex.net/yandex-docker-local-ydb:stable
```

{% endif %}

{% include [request.md](_includes/ydb_docker/04_request.md) %}

{% if audience != "external" %}

Аналогичным образом можно использовать ``ya ydb`` для доступа к данным в контейнере, например:

```bash
ya ydb -e localhost:2135 -d /local  table query execute -q 'select 1;'
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

{% endif %}

{% include [stop.md](_includes/ydb_docker/05_stop.md) %}

{% include [license.md](_includes/ydb_docker/06_license.md) %}

