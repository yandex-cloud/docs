# Терминирование TLS-соединений


[L7-балансировщики](../../application-load-balancer/concepts/application-load-balancer.md) [{{ alb-full-name }}](../../application-load-balancer/) могут _терминировать_ TLS-соединения: отправлять клиентам сертификаты, дешифровать входящий трафик для отправки [бэкендам](../../application-load-balancer/concepts/backend-group.md) и шифровать ответы бэкендов для отправки клиентам. Далее вы узнаете, как настроить балансировщик, чтобы он терминировал TLS-соединения с помощью [сертификата](../../certificate-manager/concepts/index.md) из [{{ certificate-manager-full-name }}](../../certificate-manager/) и перенаправлял HTTP-запросы на HTTPS.

В качестве примера используется доменное имя `my-site.com`, которое будет связано с IP-адресом L7-балансировщика с помощью [записей DNS](../../dns/concepts/resource-record.md) в [{{ dns-full-name }}](../../dns/).

Вы можете создать инфраструктуру для терминирования TLS-соединений с помощью одного из инструментов:
* [Консоль управления](../../tutorials/security/tls-termination/console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления {{ yandex-cloud }}.
* [{{ TF }}](../../tutorials/security/tls-termination/terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации {{ TF }} с репозитория GitHub, а затем разверните инфраструктуру с помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}).