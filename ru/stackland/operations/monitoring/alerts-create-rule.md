# Создать правило алертинга

Чтобы создать новое правило алертинга:

* Откройте Grafana по ссылке вида `https://grafana.sys.{{ cluster-domain }}` и войдите с вашим именем пользователя и паролем.
* Откройте вкладку **Alert rules**.
* Создайте новое правило алерта: нажмите кнопку **New alert rule**.
* В блоке **Enter alert rule name** укажите название правила алерта.
* В блоке **Define query and alert condition** укажите запрос, который будет использоваться для определения проблемы. Для создания запросов используется язык [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
* В блоке **Set evaluation behavior** укажите, как часто будет проверяться запрос и как долго будет отслеживаться проблема.
* В блоке **Configure labels and notifications** укажите каналы, по которым будут отправляться уведомления о проблеме.
* В блоке **Configure notification message** укажите шаблон сообщения, который будет использоваться при отправке уведомления. Примеры синтаксиса шаблонов см. в [документации Prometheus](https://prometheus.io/docs/alerting/latest/notifications/).
* Нажмите кнопку **Save rule and exit**, чтобы сохранить правило алерта.

Новый алерт появится на странице **Alert rules**.
