# Профили безопасности

_Профиль безопасности_ — основной элемент сервиса {{ sws-name }}. Профиль состоит из набора [правил](rules.md), каждое из которых содержит [условия](conditions.md) для применения определенных [действий](rules.md#rule-action) к HTTP-запросам, приходящим к защищаемому ресурсу через [виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md).

Для создания профилей предусмотрены варианты:
  * _{{ ui-key.yacloud.smart-web-security.title_default-template }}_. Преднастроенный профиль содержит:
    * [базовое правило](rules.md#base-rules) по умолчанию, включенное для всего трафика;
    * [правило Smart Protection](rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_.
  * _{{ ui-key.yacloud.smart-web-security.title_no-template }}_. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика.

Чтобы задействовать {{ sws-name }}, [подключите профиль безопасности](../operations/host-connect.md) к виртуальному хосту L7-балансировщика, трафик с которого распределяется на защищаемые ресурсы. Если балансировщик управляется [Ingress-контроллером](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, то подключать профиль безопасности следует с помощью [аннотации ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md).

#### См. также {#see-also}

* [Управление профилями безопасности](../operations/index.md#profiles)
* [Как настроить Ingress-контроллер и тестовые приложения](../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps)
