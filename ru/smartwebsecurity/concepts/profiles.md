# Профили безопасности

_Профиль безопасности_ — основной элемент сервиса {{ sws-name }}. Профиль состоит из набора [правил](rules.md), каждое из которых содержит [условия](conditions.md) для применения определенных [действий](rules.md#rule-action) к HTTP-запросам, приходящим к защищаемому ресурсу через [виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md).

Для создания профилей предусмотрены варианты:
  * _{{ ui-key.yacloud.smart-web-security.title_default-template }}_. Преднастроенный профиль содержит:
    * [базовое правило](rules.md#base-rules) по умолчанию, включенное для всего трафика;
    * [правило Smart Protection](rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_.
  * _{{ ui-key.yacloud.smart-web-security.title_no-template }}_. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика.

Чтобы задействовать {{ sws-name }}, [подключите профиль безопасности](../operations/host-connect.md) к виртуальному хосту L7-балансировщика, трафик с которого распределяется на защищаемые ресурсы. Если балансировщик управляется [Ingress-контроллером](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, то подключать профиль безопасности следует с помощью [аннотации ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md).

## Анализ тела запроса

В профиле безопасности можно включить инспекцию тела запроса, чтобы повысить производительность и безопасность веб-приложения. Ограничение максимального размера тела запроса помогает предотвратить избыточное потребление ресурсов и смягчить последствия DoS/DDoS-атак, когда злоумышленники отправляют большие запросы для исчерпания ресурсов сервера.

При настройке профиля безопасности можно выбрать действие при превышении максимального размера тела запроса:

* `{{ ui-key.yacloud.smart-web-security.waf.label_analyze-request-body-action-ignore }}` — используется, когда легитимное приложение часто отправляет большие запросы.
* `{{ ui-key.yacloud.smart-web-security.waf.label_analyze-request-body-action-deny }}` — универсальный и безопасный подход. Сервис блокирует запросы более 8 КБ, что уменьшает риск атак. При блокировке запроса сервис вернет ошибку `403`.

## Схема профилей и правил

На схеме ниже показана взаимосвязь профилей и правил в {{ sws-name }}. Главный элемент сервиса — профиль безопасности, в котором можно настроить базовые правила и Smart Protection. Дополнительно можно подключить профиль WAF (через правило WAF), профиль ARL и {{ captcha-name }}.

![profiles-rules](../../_assets/smartwebsecurity/profiles-rules.svg)

#### См. также {#see-also}

* [Управление профилями безопасности](../operations/index.md#profiles)
* [Как настроить Ingress-контроллер и тестовые приложения](../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps)
