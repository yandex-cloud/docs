# Обзор сервиса Yandex Smart Web Security

Smart Web Security позволяет защитить инфраструктуру от информационных угроз на прикладном уровне L7 модели OSI. Например, [DDoS-атак](../../glossary/ddos.md), ботов, SQL-инъекций. Дополнительно можно подключить защиту от DDoS-атак на уровнях L3 и L4 с помощью [Yandex DDoS Protection](../../vpc/ddos-protection/index.md).

Smart Web Security — это набор инструментов для защиты инфраструктуры разного уровня сложности и масштаба. Защита заключается в очистке входящего трафика от вредоносного. Трафик проверяется правилами и условиями фильтрации в профиле безопасности. Очищенный трафик можно дополнительно обработать правилами профиля ARL, чтобы снизить нагрузку на приложение.

Профиль безопасности может содержать:

* Базовые правила — для простой фильтрации трафика по заданным условиям.
* Правила Smart Protection — для автоматической защиты от DDoS-атак при помощи алгоритмов машинного обучения и поведенческого анализа.
* Правила профиля WAF — для защиты от эксплуатации уязвимостей веб-приложения или сайта. Правила блокируют множество известных угроз, например SQL-инъекции и командные инъекции, межсайтовый скриптинг и другие. В профиль WAF можно добавить несколько наборов правил: [OWASP Core Rule Set](https://owasp.org/www-project-modsecurity-core-rule-set/) (CRS), [Yandex Ruleset](waf.md#yandex-ruleset) и [ML WAF (Yandex Malicious Score)](waf.md#yandex-ml-ruleset).
* Встроенную [Yandex SmartCaptcha](../../smartcaptcha/index.md) — для проверки типа [CAPTCHA](https://ru.wikipedia.org/wiki/Капча) от ботов и спама.
* Списки фильтрации IP-адресов — для разрешения или блокировки запросов от указанных IP-адресов.

Профиль ARL содержит правила для ограничения количества запросов к защищаемому ресурсу по различным условиям.

Профиль безопасности можно подключить к разным типам ресурсов:

* [Виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) или [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) для защиты ресурсов, использующих Yandex Application Load Balancer. 
* API-шлюз [API Gateway](../../api-gateway/concepts/index.md) для защиты API ваших приложений.
* [Домен](domain-protect.md) для защиты вашего сайта или веб-приложения, расположенного в Yandex Cloud, в вашей внутренней инфраструктуре или на других хостингах.

Smart Web Security позволяет создать несколько профилей безопасности и комбинировать в них различные наборы инструментов защиты.

## Принцип работы {#how-it-works}

Smart Web Security проверяет HTTP-запросы к защищаемому ресурсу через виртуальный хост L7-балансировщика на соответствие [правилам](rules.md), заданным в [профиле безопасности](profiles.md). В зависимости от результатов проверки запросы направляются к виртуальному хосту, блокируются или отправляются в сервис [Yandex SmartCaptcha](../../smartcaptcha/index.md) для дополнительной верификации.

![schema](../../_assets/smartwebsecurity/schema.svg)

Для защиты ваших веб-приложений от внешних угроз в Smart Web Security также реализован [Web Application Firewall (WAF)](waf.md).

Для контроля и ограничения нагрузки на веб-приложения используется [Advanced Rate Limiter (ARL)](arl.md).

## Мониторинг и аудит {#monitoring-audit}

Логи Smart Web Security передаются в сервис [Yandex Cloud Logging](../../logging/index.md).

Метрики Smart Web Security передаются в сервис [Yandex Monitoring](../../monitoring/index.md).

Аудитные логи Smart Web Security передаются в сервис [Yandex Audit Trails](../../audit-trails/index.md).

{% note info %}

Чтобы сделать вашу защиту более эффективной, мы используем информацию об HTTP-запросах для развития моделей машинного обучения (ML). Вы можете отключить использование этой информации в [консоли управления](https://console.yandex.cloud) при создании профиля безопасности или позднее в его настройках.

{% endnote %}

## Рекомендации по настройке Application Load Balancer {#alb-settings-recommendation}

Для улучшения защиты ваших приложений от DDoS-атак следуйте дополнительным рекомендациям:

* Настройте [автомасштабирование](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) — это позволяет динамически адаптироваться к увеличенной нагрузке и перераспределять трафик оптимальным образом.
* Разместите ресурсные единицы в нескольких [зонах доступности](../../overview/concepts/geo-scope.md).
* Используйте защищенный протокол HTTPS — [настройте обработчик](../../application-load-balancer/concepts/application-load-balancer.md#listener) для автоматического перенаправления запросов с HTTP на HTTPS.
* Обеспечьте защиту на более низком уровне модели OSI — [включите](../tutorials/alb-with-ddos-protection/console.md) базовую защиту от DDoS-атак на уровнях L3-L4, что поможет предотвратить часть атак на более ранней стадии.

Эти меры в дополнение к настройке Smart Web Security помогут повысить устойчивость ваших сервисов к потенциальным угрозам и обеспечат безопасную работу приложений.


#### См. также {#see-also}

* [Защита облаков в России: основные тенденции и тренды киберугроз в 2025 году](https://yandex.cloud/ru/blog/posts/2025/04/cloud-protection)
* [Как настроить защиту веб‑приложения в облаке с помощью Yandex Smart Web Security](https://yandex.cloud/ru/blog/smart-web-security-how-to)
* [Yandex SWS и CDN: защита и ускорение сайтов для компаний любого масштаба](https://yandex.cloud/ru/blog/sws-cdn-cloudflare-alternative)
* [Что такое SOC: центр мониторинга кибербезопасности](https://yandex.cloud/ru/blog/soc-security-operations-center)
* [Как защитить сайт от накрутки посещаемости и заблокировать ботов](https://yandex.cloud/ru/blog/how-to-stop-bots)