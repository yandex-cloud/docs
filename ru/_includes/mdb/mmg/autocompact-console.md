Перепаковка выполняется во время [окна обслуживания](../../../storedoc/concepts/maintenance.md#maintenance-window) не чаще одного раза в неделю. В кластерах с одним хостом перепаковка не выполняется.

Для перепаковки отбираются коллекции, у которых процент раздувания не меньше, чем **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-bloat-percent_gCgoZ }}**. Если предварительная оценка показывает, что перепаковка отобранных коллекций позволит освободить не менее, чем **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-target-free-space_tB2yk }}**, то перепаковка выполняется.

Задайте параметры перепаковки:

* **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-target-free-space_tB2yk }}** — минимальный суммарный объем дискового пространства в мегабайтах, который должен освободиться при перепаковке коллекций. Значение по умолчанию — `10` МБ.
* **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-bloat-percent_gCgoZ }}** — минимальный процент раздувания коллекции, при котором коллекция отбирается для перепаковки. Значение по умолчанию — `10%`.

Чтобы выполнять перепаковку на хосте-мастере, включите опцию **{{ ui-key.yacloud.mongodb.ClusterForm.AdditionalSection.field_autocompact-compaction-type_jdXAN }}**. Перед перепаковкой хоста-мастера роль мастера переключается на другой хост. Если опция отключена, перепаковка хоста-мастера не выполняется.
