# Включить {{ ai-studio-name }}

Для работы [{{ ai-studio-name }}](../../concepts/components/ai-studio.md) включите компоненты {{ objstorage-name }}, {{ model-gallery-name }} и {{ agent-atelier-name }}.

## Перед началом работы {#before-you-begin}

1. Убедитесь, что образы {{ model-gallery-name }} и {{ agent-atelier-name }} доступны в реестре, который использует кластер. Если нужных образов нет в локальном реестре, [загрузите их](install-images.md).
1. Убедитесь, что кластер соответствует [требованиям к инфраструктуре](../../concepts/components/ai-studio.md#infrastructure) для выбранного набора моделей.
1. Убедитесь, что на этапе развертывания кластера для рабочих узлов с GPU [включена поддержка {{ nvidia }} GPU](../../concepts/components/gpu.md#enable). Дождитесь готовности компонента {{ gpu-operator }}.
1. Проверьте, что включены [зависимости {{ ai-studio-name }}](../../concepts/components/ai-studio.md#dependencies). Если {{ objstorage-name }} отключен, включите его в существующем ресурсе `StorageConfig`:

   ```bash
   kubectl patch storageconfig main --type=merge -p '{"spec":{"enabled":true}}'
   ```

   Дождитесь готовности хранилища. Проверьте состояние установки командой `kubectl get componentinstallation storage-main`: поле `PHASE` должно принять значение `Ready`.

## Включить {{ model-gallery-name }} {#enable-model-gallery}

{% note info %}

Установка {{ model-gallery-name }} может занять больше часа из-за большого размера образов моделей. Учитывайте это при планировании установки и дождитесь готовности компонента, прежде чем включать {{ agent-atelier-name }}.

{% endnote %}

1. Сохраните [пример конфигурации](../../concepts/components/ai-studio.md#model-gallery-configuration) в файл `modelgalleryconfig.yaml`.
1. Настройте набор моделей и ресурсы. Пример включает Embeddings, Ethics и YandexGPT 5 Lite: для них нужны один A100 80 GB и два H100 80 GB. Перед включением других моделей проверьте доступность дополнительных GPU, CPU, RAM и дискового пространства.
1. Сверьте значения `nodeSelector` с метками узлов кластера:

   ```bash
   kubectl get nodes -L nvidia.com/gpu.product
   ```

1. Примените манифест:

   ```bash
   kubectl apply -f modelgalleryconfig.yaml
   ```

1. Проверьте состояние установки:

   ```bash
   kubectl get componentinstallation model-gallery-main
   ```

   Дождитесь значения `Ready` в поле `PHASE`. При ошибке проверьте поле `MESSAGE` в выводе команды.

## Включить {{ agent-atelier-name }} {#enable-agent-atelier}

1. Сохраните [пример конфигурации](../../concepts/components/ai-studio.md#agent-atelier-configuration) в файл `agentatelierconfig.yaml`.
1. Если Code Interpreter не нужен, установите `spec.settings.codeInterpreter.enabled: false`. Для его использования проверьте, что включен {{ certificate-manager-name }}, и выделите [ресурсы для сессий](../../concepts/components/ai-studio.md#code-interpreter-resources).
1. Примените манифест:

   ```bash
   kubectl apply -f agentatelierconfig.yaml
   ```

1. Проверьте состояние установки:

   ```bash
   kubectl get componentinstallation agent-atelier-main
   ```

   Дождитесь значения `Ready` в поле `PHASE` установки.

## Открыть веб-интерфейс {#open-ui}

После завершения установки веб-интерфейс {{ ai-studio-name }} доступен по адресу `https://aistudio.sys.<домен_кластера>`. Для входа используйте учетные данные {{ iam-name }}.

## Изменить настройки {#configure}

Чтобы изменить набор моделей, ресурсы или параметры Code Interpreter, отредактируйте соответствующий ресурс:

```bash
kubectl edit modelgalleryconfig main
kubectl edit agentatelierconfig main
```

Описание параметров приведено в разделе [Конфигурация](../../concepts/components/ai-studio.md#configuration).

## Что дальше {#whats-next}

* [{#T}](disable.md)
* [{{ ai-studio-name }}](../../concepts/components/ai-studio.md)
