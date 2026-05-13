# Создание L7-балансировщика Yandex Application Load Balancer с профилем безопасности Yandex Smart Web Security

С помощью сервиса Yandex Smart Web Security вы можете защитить инфраструктуру от [DDoS-атак](../../../glossary/ddos.md) и ботов на уровне приложений (L7).

Вы создадите тестовый веб-сервер, развернете [L7-балансировщик](../../../application-load-balancer/concepts/application-load-balancer.md) Application Load Balancer, который будет распределять трафик на тестовый веб-сервер, и защитите созданную инфраструктуру с помощью [профиля безопасности](../../concepts/profiles.md) Smart Web Security.

Вы можете создать инфраструктуру для L7-балансировщика Application Load Balancer с профилем безопасности с помощью следующих инструментов:

* [Консоль управления](console.md) — используйте консоль управления Yandex Cloud, чтобы создать инфраструктуру в пошаговом режиме.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).