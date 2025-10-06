Для работы с кластерами {{ dataproc-name }}:

1. [Укажите в настройках проекта](../../datasphere/operations/projects/update.md) следующие параметры:

   * [Каталог по умолчанию](../../resource-manager/concepts/resources-hierarchy.md#folder) для интеграции с другими сервисами {{ yandex-cloud }}. В нем будет развернут кластер {{ dataproc-name }} в рамках текущих [квот](../../data-proc/concepts/limits.md) облака, а стоимость использования кластера будет списана с платежного аккаунта облака.
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `vpc.user`, от имени которого {{ ml-platform-name }} будет работать с сетью кластера {{ dataproc-name }}.
   * [Подсеть](../../vpc/concepts/network.md#subnet) для связи {{ ml-platform-name }} с кластером {{ dataproc-name }}. Кластеру {{ dataproc-name }} необходим доступ в интернет, поэтому в подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md). После указания подсети время выделения вычислительных ресурсов может быть увеличено.

1. Создайте [сервисного агента](../../iam/concepts/service-control.md#service-agent):

   1. Чтобы разрешить сервисному агенту работать в {{ ml-platform-name }}, попросите администратора или владельца вашего облака выполнить команду в {{ yandex-cloud }} CLI:
   
      ```bash
      yc iam service-control enable datasphere --cloud-id <идентификатор_облака>
      ```
   
      Где `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которым вы будете работать в сообществе {{ ml-platform-name }}.

   1. Создайте сервисный аккаунт с ролями:

      * `dataproc.agent` — для использования кластеров {{ dataproc-name }}.
      * `dataproc.admin`— для создания кластеров из шаблонов {{ dataproc-name }}.
      * `vpc.user` — для работы с сетью кластера {{ dataproc-name }}.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. В настройках сообщества в блоке **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}** нажмите **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** и выберите созданный сервисный аккаунт.
   
{% note warning %}

Постоянный кластер {{ dataproc-name }} должен иметь настройку `livy:livy.spark.deploy-mode : client`.

{% endnote %}
