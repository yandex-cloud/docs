* **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}** — на одном хосте {{ KF }} одновременно размещаются [брокер](../../../managed-kafka/concepts/brokers.md) и контроллер метаданных {{ kraft-short-name }}. При этом в кластере создаются только три хоста {{ KF }} в одной из конфигураций:
  * три хоста находятся в одной [зоне доступности](../../../overview/concepts/geo-scope.md);
  * каждый хост расположен в отдельной зоне доступности.
  
  Задать количество хостов-брокеров вручную нельзя.

* **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}** — брокер и контроллер метаданных {{ kraft-short-name }} размещаются на отдельных хостах. При создании кластера с несколькими хостами, в него добавляются три отдельных хоста {{ kraft-short-name }}.

  Количество хостов-брокеров задается вручную.

Хосты {{ kraft-short-name }} нельзя удалить. Количество хостов {{ kraft-short-name }} фиксировано.