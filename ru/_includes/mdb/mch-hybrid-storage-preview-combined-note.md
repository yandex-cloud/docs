{% note info %}
  
  Гибридное хранилище находится на стадии [Preview](https://cloud.yandex.ru/docs/overview/concepts/launch-stages). Плата за использование хранилища [{{ objstorage-name }}](../../storage) не взимается.
  
  На стадии Preview разрешается использовать этот тип хранилища только в кластерах с [выключенной отказоустойчивостью](../../managed-clickhouse/operations/zk-hosts.md). В такоми кластере хосты {{ ZK }} не добавляются и в каждом шарде можно разместить только один хост {{ CH }}. На стадии General Availability это ограничение будет снято.
  
  {% endnote %}