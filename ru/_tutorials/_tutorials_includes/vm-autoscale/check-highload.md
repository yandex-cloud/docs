Чтобы проверить работу автоматического масштабирования группы ВМ, нужно создать повышенную нагрузку на CPU каждой ВМ. В файле `specification.yaml` в параметре `scale_policy.auto_scale.cpu_utilization_rule.utilization_target` указано значение `40` — целевой уровень нагрузки 40% CPU. Если превысить целевую нагрузку, количество ВМ в группе увеличится.
1. Создайте повышенную нагрузку на группу ВМ.

   Для этого сохраните скрипт с именем `load.sh` в домашнюю директорию. Скрипт в течение 10 минут в 12 потоков отправляет запросы к группе ВМ. При этом у каждой ВМ используется по 20% CPU на каждое ядро, обрабатывающее запрос. Группа ВМ в каждый момент времени будет загружена на 240% CPU. Скрипт специально выполняет несколько параллельных запросов по 20% CPU, а не один в 240% CPU, чтобы запросы равномерно распределялись между ВМ в группе.

   ```bash
   EXTERNAL_IP=$(yc load-balancer network-load-balancer get group-balancer --format=json | jq -r .listeners[0].address)

   wrk -H "Connection: close" -t12 -c12 -d10m "http://$EXTERNAL_IP/burn-cpu?time=5000&load=20"
   ```

1. Запустите скрипт:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sh load.sh
     ```

     Результат:

     ```text
     Running 10m test @ http://130.193.56.111/burn-cpu?time=5000&load=20
       12 threads and 12 connections
       Thread Stats   Avg      Stdev     Max   +/- Stdev
     ...
     Requests/sec: 15.04
     Transfer/sec: 3.20KB
     ```

   {% endlist %}

1. Посмотрите нагрузку:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали группу ВМ `auto-group`.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева нажмите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
     1. Выберите группу ВМ `auto-group`.
     1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
        На графике **Number of instance in zone** отображены изменения количества ВМ в каждой зоне доступности. На графике **Average CPU utilization in zone** — средняя CPU-нагрузка в каждой зоне доступности.
     1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
        На странице отображены сообщения о действиях в рамках автоматического масштабирования группы ВМ.

     Суммарная нагрузка в 240% CPU равномерно распределилась между двумя ВМ в двух зонах доступности и превысила целевой уровень нагрузки в 40% CPU. [{{ compute-full-name }}](../../../compute/) создал по дополнительной ВМ в каждой зоне доступности и в группе стало четыре ВМ. Когда скрипт перестал создавать CPU-нагрузку, {{ compute-name }} автоматически уменьшил количество ВМ в группе до двух.

   {% endlist %}