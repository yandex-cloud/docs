# Отключить {{ ai-studio-name }}

Чтобы отключить {{ ai-studio-name }}, сначала отключите {{ agent-atelier-name }}, затем {{ model-gallery-name }}.

{% note warning %}

При отключении удаляются данные компонентов {{ ai-studio-name }}, включая содержимое их бакетов и постоянных томов. Повторное включение не восстанавливает удаленные данные. Заранее сохраните необходимые данные и конфигурацию за пределами {{ ai-studio-name }}.

{% endnote %}

## Отключить {{ agent-atelier-name }} {#disable-agent-atelier}

1. Установите `spec.enabled: false` в существующем ресурсе:

   ```bash
   kubectl patch agentatelierconfig main --type=merge -p '{"spec":{"enabled":false}}'
   ```

1. Дождитесь завершения удаления установки:

   ```bash
   kubectl wait --for=delete componentinstallation/agent-atelier-main --timeout=30m
   ```

   Время удаления зависит в том числе от объема данных. Если ожидание завершилось по таймауту, проверьте состояние установки командой `kubectl get componentinstallation agent-atelier-main`. Не отключайте {{ model-gallery-name }} до завершения отключения {{ agent-atelier-name }}.

## Отключить {{ model-gallery-name }} {#disable-model-gallery}

1. Установите `spec.enabled: false` в существующем ресурсе:

   ```bash
   kubectl patch modelgalleryconfig main --type=merge -p '{"spec":{"enabled":false}}'
   ```

1. Дождитесь завершения удаления установки:

   ```bash
   kubectl wait --for=delete componentinstallation/model-gallery-main --timeout=30m
   ```

   При необходимости проверьте состояние установки командой `kubectl get componentinstallation model-gallery-main`.

До завершения отключения {{ ai-studio-name }} оставьте {{ objstorage-name }}, {{ iam-name }} и {{ mpg-name }} включенными. Эти компоненты также могут использоваться другими сервисами кластера.

## Что дальше {#whats-next}

* [{#T}](configure.md)
* [{{ ai-studio-name }}](../../concepts/components/ai-studio.md)
