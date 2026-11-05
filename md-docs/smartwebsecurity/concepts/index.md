[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > Концепции > Обзор

# Обзор сервиса Yandex Smart Web Security

Smart Web Security защищает веб-приложения от угроз на прикладном уровне L7 модели OSI: [DDoS-атак](../../glossary/ddos.md), ботов и эксплуатации уязвимостей, например SQL-инъекций.

На [прокси-серверах Smart Web Security](domain-protect.md#proxy) автоматически включена [Network Protection](network-protection.md) — защита от DDoS-атак на сетевом (L3) и транспортном (L4) уровнях. Если вы подключаете профиль безопасности к собственному L7-балансировщику Application Load Balancer, защиту на этих уровнях можно включить отдельно с помощью [Yandex DDoS Protection](../../vpc/ddos-protection/index.md).

Входящий трафик проверяется по правилам профиля безопасности. В профиле можно настроить:

* Базовые правила — для простой фильтрации трафика по заданным условиям.
* Правила Smart Protection — для автоматической защиты от DDoS-атак на уровне L7 при помощи алгоритмов машинного обучения и поведенческого анализа.
* Правила профиля Cloud WAF — для защиты от эксплуатации уязвимостей веб-приложения или сайта. Правила блокируют множество известных угроз, например SQL-инъекции и командные инъекции, межсайтовый скриптинг и другие. В профиль Cloud WAF можно добавить несколько наборов правил: [OWASP Core Rule Set](https://owasp.org/www-project-modsecurity-core-rule-set/) (CRS), [Yandex Ruleset](waf.md#yandex-ruleset) и [ML WAF (Yandex Malicious Score)](waf.md#yandex-ml-ruleset).
* Проверку в [Yandex SmartCaptcha](../../smartcaptcha/index.md) — для защиты от ботов с помощью [CAPTCHA](https://ru.wikipedia.org/wiki/Капча).
* Фильтрацию по спискам IP-адресов — для разрешения или блокировки запросов от указанных адресов.

Чтобы снизить нагрузку на приложение, к профилю безопасности можно подключить профиль Advanced Rate Limiter (ARL). Его правила ограничивают количество запросов, прошедших проверку профилем безопасности.

Помимо Cloud WAF, для защиты веб-приложений можно использовать SolidWall WAF. Его правила настраивают и сопровождают аналитики сервиса. SolidWall WAF подключается только через домены: в отдельном профиле создают приложение и добавляют к нему домены. Порядок подключения описан в [руководстве по настройке](../tutorials/solidwall-waf.md).

Профиль безопасности можно подключить к разным типам ресурсов:

* [Виртуальный хост](../../application-load-balancer/concepts/http-router.md#virtual-host) или [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) для защиты ресурсов, использующих Yandex Application Load Balancer. 
* API-шлюз [API Gateway](../../api-gateway/concepts/index.md) для защиты API ваших приложений.
* [Домен](domain-protect.md) для защиты вашего сайта или веб-приложения, расположенного в Yandex Cloud, в вашей внутренней инфраструктуре или на других хостингах.

Smart Web Security позволяет создать несколько профилей безопасности и комбинировать в них различные наборы инструментов защиты.

## Принцип работы {#how-it-works}

Smart Web Security проверяет HTTP-запросы к защищаемому ресурсу на соответствие [правилам](rules.md), заданным в [профиле безопасности](profiles.md). Профиль безопасности можно подключить к [виртуальному хосту L7-балансировщика](../operations/host-connect.md#host), [домену](../operations/host-connect.md#domain) или [API-шлюзу](../operations/host-connect.md#gateway). В зависимости от результатов проверки запросы направляются к защищаемому ресурсу, блокируются или отправляются в сервис [Yandex SmartCaptcha](../../smartcaptcha/index.md) для дополнительной верификации.

![schema](../../_assets/smartwebsecurity/schema.svg)

Для защиты ваших веб-приложений от внешних угроз в Smart Web Security также реализован [Web Application Firewall (WAF)](waf.md).

Для контроля и ограничения нагрузки на веб-приложения используется [Advanced Rate Limiter (ARL)](arl.md).

## Мониторинг и аудит {#monitoring-audit}

[Метрики](../operations/monitoring.md) Smart Web Security передаются в сервис [Yandex Monium](../../monium/index.md) и доступны в разделе **Мониторинг** сервиса Smart Web Security.

Логи профилей безопасности передаются в [Yandex Monium](../../monium/index.md), логи прокси-серверов — в [Yandex Cloud Logging](../../logging/index.md). [Просматривать логи](../operations/configure-logging.md#view-logs) можно в интерфейсе Smart Web Security и соответствующего сервиса логирования.

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


#### Полезные ссылки {#see-also}

* [Yandex Security: запускаем направление для защиты любой инфраструктуры](https://yandex.cloud/ru/blog/yandex-security-scale-2026)
* [Защита от DDoS на уровнях L3, L4 и L7: гайд с практическими советами](https://yandex.cloud/ru/blog/l3-l4-l7-ddos-protection)
* [Защита облаков в России: основные тенденции и тренды киберугроз в 2025 году](https://yandex.cloud/ru/blog/posts/2025/04/cloud-protection)
* [Как настроить защиту веб‑приложения в облаке с помощью Yandex Smart Web Security](https://yandex.cloud/ru/blog/smart-web-security-how-to)
* [Yandex SWS и CDN: защита и ускорение сайтов для компаний любого масштаба](https://yandex.cloud/ru/blog/sws-cdn-cloudflare-alternative)
* [Что такое SOC: центр мониторинга кибербезопасности](https://yandex.cloud/ru/blog/soc-security-operations-center)
* [Как защитить сайт от накрутки посещаемости и заблокировать ботов](https://yandex.cloud/ru/blog/how-to-stop-bots)