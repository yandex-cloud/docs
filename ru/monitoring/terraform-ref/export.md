# Monitoring Terraform Export

Вы можете мигрировать существующие ресурсы {{ monitoring-short-name }} из других инструментов, чтобы не писать конфигурации самостоятельно. Для этого:
1. Выберите нужные ресурсы и воспользуйтесь [HTTP API для выгрузки конфигураций](#api).
1. Добавьте выгруженные конфигурации в файлы `*.tf`.
1. Примените конфигурацию, выполнив команду из директории, в которой лежат файлы:
    ```
    terraform apply
    ```
1. Ресурсы добавятся в состояние Terraform и будут управляться Terraform-конфигурацией.   

## API для выгрузки конфигураций {#api}

Ресурс|API выгрузки|
------|--------
Проекты | [Один проект](https://solomon.yandex-team.ru/swagger-ui/index.html#/projects/getTerraformSpecUsingGET_1)
Роли в проекте |  [Все роли](https://solomon.yandex-team.ru/swagger-ui/index.html#/roles-public-controller/getTerraformSpecUsingGET_3)
Алерты | [Один алерт](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting/getTerraformAlertSpecUsingGET), [Все алерты в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting/getTerraformSpecUsingGET)
Ресурсы сервис-провайдера | [Один ресурс](https://solomon.yandex-team.ru/swagger-ui/index.html#/service-provider-resource-controller/getTerraformResourceSpecUsingGET), [Все ресурсы в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/service-provider-resource-controller/getTerraformResourcesSpecUsingGET)
Каналы | [Один канал](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting/getTerraformChannelSpecUsingGET), [Все каналы в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting/getTerraformChannelsSpecUsingGET)
Эскалации | [Одна эскалация](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting/getTerraformEscalationSpecUsingGET), [Все эскалации в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting/getTerraformEscalationsSpecUsingGET)
Дашборды | [Один дашборд](https://solomon.yandex-team.ru/swagger-ui/index.html#/dashboard-terraform-controller/getTerraformDashboardSpecUsingGET)
Кластеры | [Один кластер](https://solomon.yandex-team.ru/swagger-ui/index.html#/clusters/getTerraformClusterSpecUsingGET), [Все кластеры в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/terraform-controller/getTerraformClustersSpecUsingGET)
Сервисы | [Один сервис](https://solomon.yandex-team.ru/swagger-ui/index.html#/services/getTerraformServiceSpecUsingGET), [Все сервисы в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/terraform-controller/getTerraformServicesSpecUsingGET)
Шарды | [Один шард](https://solomon.yandex-team.ru/swagger-ui/index.html#/shards/getTerraformShardSpecUsingGET), [Все шарды в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/terraform-controller/getTerraformShardsSpecUsingGET)
Быстрые ссылки | [Все быстрые ссылки в проекте](https://solomon.yandex-team.ru/swagger-ui/index.html#/quick-links-v-3-controller/getTerraformSpecUsingGET_2)