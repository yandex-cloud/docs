# Обзор сервиса {{ sws-full-name }}

{{ sws-full-name }} — сервис для защиты от [DDoS-атак](../../glossary/ddos.md) и ботов на прикладном уровне L7 [модели OSI](https://ru.wikipedia.org/wiki/Сетевая_модель_OSI).

Сервис можно подключить к [виртуальным хостам](../../application-load-balancer/concepts/http-router.md#virtual-host) [{{ alb-full-name }}](../../application-load-balancer/).

Функциональность сервиса сводится к проверке HTTP-запросов к защищаемому ресурсу через виртуальный хост L7-балансировщика на соответствие [правилам](rules.md), заданным в [профиле безопасности](profiles.md). В зависимости от результатов проверки запросы направляются к виртуальному хосту, блокируются или отправляются в сервис [{{ captcha-full-name }}](../../smartcaptcha/) для дополнительной верификации.

![schema](../../_assets/smartwebsecurity/schema.svg)

{% include [realized-waf-concept](../../_includes/smartwebsecurity/realized-waf-concept.md) %}

{% include [realized-arl-concept](../../_includes/smartwebsecurity/realized-arl-concept.md) %}

{% include [note-preview-waf-arl](../../_includes/smartwebsecurity/note-preview-waf-arl.md) %}

Логи {{ sws-name }} передаются в сервис [{{ cloud-logging-full-name }}](../../logging/).

Метрики {{ sws-name }} передаются в сервис [{{ monitoring-full-name }}](../../monitoring/).

Аудитные логи {{ sws-name }} передаются в сервис [{{ at-full-name }}](../../audit-trails/).

## Рекомендации по настройке {{ alb-name }} {#alb-settings-recommendation}

Для улучшения защиты ваших приложений от DDoS-атак следуйте дополнительным рекомендациям:

* Настройте [автомасштабирование](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) — это позволяет динамически адаптироваться к увеличенной нагрузке и перераспределять трафик оптимальным образом.

* Разместите ресурсные единицы в нескольких [зонах доступности](../../overview/concepts/geo-scope.md).

* Используйте защищенный протокол HTTPS — [настройте обработчик](../../application-load-balancer/concepts/application-load-balancer.md#listener) для автоматического перенаправления запросов с HTTP на HTTPS.

* Обеспечьте защиту на более низком уровне модели OSI — [включите](../tutorials/alb-with-ddos-protection/console.md) базовую защиту от DDoS-атак на уровнях L3-L4, что поможет предотвратить часть атак на более ранней стадии.

Эти меры в дополнение к настройке {{ sws-name }} помогут повысить устойчивость ваших сервисов к потенциальным угрозам и обеспечат безопасную работу приложений.
