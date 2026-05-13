# Автоматическое сканирование Docker-образа при загрузке


{% note info %}

Автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](../../concepts/docker-image.md) на наличие уязвимостей при загрузке в [Yandex Container Registry](../../index.md) можно включить в [настройках сканера уязвимостей](../../operations/scanning-docker-image.md#automatically) без создания [функций](../../../functions/concepts/function.md) и [триггеров](../../../functions/concepts/trigger/index.md) [Yandex Cloud Functions](../../../functions/index.md).

{% endnote %}

В этом руководстве вы создадите [реестр](../../concepts/registry.md) Container Registry для хранения Docker-образа и настроите автоматическое сканирование на уязвимости, при загрузке образа в реестр. С помощью триггера Cloud Functions будут отслеживаться изменения в реестре и при загрузке Docker-образа в реестр, будет вызываться функция для запуска сканирования.

Вы можете настроить и провести [сканирование](../../concepts/vulnerability-scanner.md) Docker-образа на наличие уязвимостей при загрузке в Container Registry с помощью инструментов:

* [Консоль управления, CLI и API](console.md) — используйте консоль управления Yandex Cloud, CLI или API, чтобы создать инфраструктуру в пошаговом режиме.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform с репозитория GitHub, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).