## FQDN хостов {{ KF }}

Для подключения к хосту потребуется его [FQDN](../../concepts/network.md#hostname) — доменное имя. Его можно получить несколькими способами:

* [Запросите список хостов в кластере](../cluster-hosts.md#list-hosts).
* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста-брокера. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-connect }}**.
* Посмотрите FQDN в консоли управления:

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.
