# Удалить ноду

{% note warning %}

При развертывании и эксплуатации моделей вы платите за время работы каждого инстанса ноды — от момента запуска до момента удаления.

Если развернутый сервис вам больше не нужен, удалите ноду.

{% endnote %}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В строке с нужной [нодой](../../concepts/deploy/index.md#node) нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите ![Delete](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Во всплывающем окне нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.submit }}**.

{% note warning %}

Фактически [удаление ресурсов](../../../overview/concepts/data-deletion.md) может занимать до 72 часов.

{% endnote %}