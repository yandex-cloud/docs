# Терминирование TLS-соединений


[L7-балансировщики](../../../application-load-balancer/concepts/application-load-balancer.md) [Yandex Application Load Balancer](../../../application-load-balancer/index.md) могут _терминировать_ TLS-соединения: отправлять клиентам сертификаты, дешифровать входящий трафик для отправки [бэкендам](../../../application-load-balancer/concepts/backend-group.md) и шифровать ответы бэкендов для отправки клиентам. Далее вы узнаете, как настроить балансировщик, чтобы он терминировал TLS-соединения с помощью [сертификата](../../../certificate-manager/concepts/index.md) из [Yandex Certificate Manager](../../../certificate-manager/index.md) и перенаправлял HTTP-запросы на HTTPS.

В качестве примера используется доменное имя `my-site.com`, которое будет связано с IP-адресом L7-балансировщика с помощью [записей DNS](../../concepts/resource-record.md) в [Yandex Cloud DNS](../../index.md).

Вы можете создать инфраструктуру для терминирования TLS-соединений с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать инфраструктуру в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform с репозитория GitHub, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).