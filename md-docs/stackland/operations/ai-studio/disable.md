[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > AI Studio > Отключить AI Studio

# Отключить AI Studio

Чтобы отключить AI Studio, сначала отключите Agent Atelier, затем Model Gallery.

{% note warning %}

При отключении удаляются данные компонентов AI Studio, включая содержимое их бакетов и постоянных томов. Повторное включение не восстанавливает удаленные данные. Заранее сохраните необходимые данные и конфигурацию за пределами AI Studio.

{% endnote %}

## Отключить Agent Atelier {#disable-agent-atelier}

1. Установите `spec.enabled: false` в существующем ресурсе:

   ```bash
   kubectl patch agentatelierconfig main --type=merge -p '{"spec":{"enabled":false}}'
   ```

1. Дождитесь завершения удаления установки:

   ```bash
   kubectl wait --for=delete componentinstallation/agent-atelier-main --timeout=30m
   ```

   Время удаления зависит в том числе от объема данных. Если ожидание завершилось по таймауту, проверьте состояние установки командой `kubectl get componentinstallation agent-atelier-main`. Не отключайте Model Gallery до завершения отключения Agent Atelier.

## Отключить Model Gallery {#disable-model-gallery}

1. Установите `spec.enabled: false` в существующем ресурсе:

   ```bash
   kubectl patch modelgalleryconfig main --type=merge -p '{"spec":{"enabled":false}}'
   ```

1. Дождитесь завершения удаления установки:

   ```bash
   kubectl wait --for=delete componentinstallation/model-gallery-main --timeout=30m
   ```

   При необходимости проверьте состояние установки командой `kubectl get componentinstallation model-gallery-main`.

До завершения отключения AI Studio оставьте Object Storage, Identity and Access Management и Managed Service for PostgreSQL включенными. Эти компоненты также могут использоваться другими сервисами кластера.

## Что дальше {#whats-next}

* [Включить AI Studio](configure.md)
* [AI Studio](../../concepts/components/ai-studio.md)