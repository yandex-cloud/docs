# Управление хостами кластера Apache Kafka®

Вы можете получать список хостов-брокеров в кластере {{ KF }}.

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

## Получить список хостов в кластере {#list-hosts}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список хостов в кластере, выполните команду :

  ```bash
  {{ yc-mdb-kf }} cluster list-hosts <имя кластера>
  ```

  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Воспользуйтесь методом API [listHosts](../api-ref/Cluster/listHosts.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
