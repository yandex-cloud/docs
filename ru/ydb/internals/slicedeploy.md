---
sourcePath: overlay/internals/slicedeploy.md
---
# Deploy to Developer Slices

## Введение
В данной статье описано средство деплоя конфигурации и бинарников KiKiMR на тестовые кластера aka Dev Slices. Данный режим удобен в первую очередь разработчикам, так как:

1. Не требует ничего, кроме подготовленного slice, хотя может и сама из svn (hg) собрать необходимые таргеты в аркадии (kikimr, nbs).
2. Позволяет работать разработчику в режиме "пофиксить баг, обновить кластер, подебажить кластер".
```
$ ya make
$ kikimr_slice update -c cluster.yaml --svn
```
В качестве подхода к построению конфигурации программа `kikimr_slice` использует подход описанный [здесь](slicedeploy.md).

## Подготовка кластера
Для того, чтобы kikimr_slice мог работать на кластере, кластер должен быть соответствующим образом подготовлен:

1. Должны быть установлены пакеты из [шаблона](https://z2.yandex-team.ru/meta_control_panel?configId=KIKIMR_INFRA_TEST) в Z2. <span style="color:red;">(Актуально ли, у меня 403)</span>
2. Должен быть установлен пакет "yandex-search-kikimr-kikimr-bin". После установки этого пакета остановить или стартовать сервис kikimr можно через "`sudo service kikimr start`".
3. 'yandex-search-kikimr-multitenancy-class-scripts' -- для работы с тенантами
4. yandex-search-kikimr-blockstore-{server,client,conf,init,logging,plugin} -- для работы с nbs.

## Программа kikimr\_slice
Программа автоматизирует некоторые действия с кластером KiKiMR, например, такие как:

* остановка/запуск сервисов KiKiMR
* deploy новых бинарников или конфигурации на кластер
* форматирование дисков

Программа живет в [аркадии](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/tools/kikimr_slice).
Программа имеет подробный help по вызову `kikimr_slice -h`.
Программа позволяет запустить кластер одной командой по описанию кластера в yaml-формате.
Стоит отметить, что сейчас программа делает deploy "на коленке" при помощи scp и ssh, но она должна стать заменой `basic_kikimr.bash` (который работает также).
