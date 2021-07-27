---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Веб-интерфейсы компонентов {{ dataproc-name }}

Пользовательские веб-интерфейсы некоторых компонентов {{dataproc-name}}, например Hadoop, Spark, Yarn и Zeppelin, доступны на `MASTER`-узле кластера. Эти интерфейсы могут быть использованы:

* для управления и мониторинга ресурсов кластеров — YARN Resource Manager и HDFS Name Node;
* для просмотра статуса и отладки заданий — Spark History и JobHistory;
* для совместной работы, экспериментов или ad-hoc операций — Apache Zeppelin.

Более подробно об интерфейсах читайте на странице [{#T}](./interfaces.md).

Вы можете подключиться к веб-интерфейсам компонентов {{ dataproc-name }} либо с помощью [промежуточной виртуальной машины](./interfaces.md), либо с помощью UI Proxy в {{dataproc-name}} версии 1.2 и выше.

UI proxy — это механизм, который позволяет проксировать интерфейс компонентов кластера с шифрованием HTTP-трафика и аутентификацией через IAM {{ yandex-cloud }}. Чтобы получить доступ к интерфейсам, пользователь должен быть авторизован в {{ yandex-cloud }}, иметь права на просмотр кластера и обладать ролью `dataproc.user`.

UI Proxy по умолчанию отключен. Чтобы воспользоваться UI Proxy, включите его при создании или настройке кластера.

Интерфейсы:
| Сервис                   | URL                                                                                           |
|--------------------------|-----------------------------------------------------------------------------------------------|
| HDFS Name Node           | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/hdfs/       |
| YARN Resource Manager    | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/yarn/       |
| Livy                     | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/livy/       |
| YARN Application History | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/jobhistory/ |
| Hive Server2             | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/hive/       |
| Zeppelin                 | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/zeppelin/   |
| Oozie                    | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/oozieui/    |

{% note warning %}

Для использования UI Proxy может потребоваться дополнительная [настройка групп безопасности](../operations/connect.md).

{% endnote %}
