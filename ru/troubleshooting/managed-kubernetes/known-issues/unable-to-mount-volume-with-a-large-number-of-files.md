# Устранение ошибки timed out waiting for the condition при монтировании тома с большим количеством файлов


## Описание проблемы {#issue-description}

При запуске пода возникает ошибка

```bash
Warning FailedMount 49s kubelet Unable to attach or mount volumes: unmounted volumes=[jenkins-home], unattached volumes jenkins-home jenkins config kube-api-access-2ldxk sc-config-volume admin-secret jenkins-additional-secrets jenkins-cache tmp-volume[]: timed out waiting for the condition
```

## Диагностика и воспроизведение

Проанализируйте системные журналы:

```bash
journalctl -t kernel --no-pager --since "today"
journalctl --system --no-pager --since "today"
journalctl -u kubelet --no-pager --since "today"
```

В журналах системного сервиса `kubelet` в момент времени, близкий к запуску проблемного пода, появляется сообщение `If the volume has a lot of files then setting volume ownership could be slow...`

## Решение {#issue-resolution}

Причина долгого монтирования заключается в большом количестве файлов на целевой ФС. По умолчанию конфигурация `fsgroup` рекурсивно устанавливается при каждом монтировании тома. Подробности по ошибке приведены [на странице ее обсуждения в git-репозитории Kubernetes](https://github.com/kubernetes/kubernetes/issues/69699).

Рекомендуем настроить контекста безопасности для пода с использованием [следующей инструкции](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods).
