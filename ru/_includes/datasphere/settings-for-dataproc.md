Для работы с кластерами {{ dataproc-name }} [укажите в настройках проекта](../../datasphere/operations/projects/update.md) следующие параметры:
* [Каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) для интеграции с другими сервисами {{ yandex-cloud }}. В нем будет развернут кластер {{ dataproc-name }} в рамках текущих [квот](../../data-proc/concepts/limits.md) облака, а стоимость использования кластера будет списана с платежного аккаунта облака.
* [Подсеть](../../vpc/concepts/network.md#subnet) для связи {{ ml-platform-name }} с кластером {{ dataproc-name }}. Кластеру {{ dataproc-name }} необходим доступ в интернет, поэтому в подсети должен быть настроен [NAT-шлюз](../../vpc/concepts/gateways.md#nat-gateway).

  {% include [subnet-create](../../_includes/subnet-create.md) %}

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого {{ ml-platform-name }} будет создавать и управлять кластерами. Сервисному аккаунту понадобятся следующие роли:
   * `dataproc.agent` — для создания и использования кластеров {{ dataproc-name }}.
   * `vpc.user` — для работы с сетью кластера {{ dataproc-name }}.
   * `{{ roles-datasphere-project-developer }}` — для работы с проектом {{ ml-platform-name }}.