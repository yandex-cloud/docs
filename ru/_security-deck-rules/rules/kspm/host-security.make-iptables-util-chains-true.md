### Kubelet разрешено управлять iptables {#host-security.make-iptables-util-chains-true}

#|
|| **kind** | **severity** | **ID** ||
|| HostSecurity | Medium | host-security.make-iptables-util-chains-true ||
|#

#### Описание

Разрешите Kubelet управлять iptables.
Kubelet может автоматически управлять необходимыми изменениями в iptables в зависимости от того, как вы выбираете сетевые параметры для подов. 
Рекомендуется разрешить kubelet управлять изменениями в iptables. 
Это гарантирует, что конфигурация iptables остается синхронизированной с конфигурацией сети подов. 
Ручная настройка iptables с динамическими изменениями конфигурации сети подов может помешать связи между подами/контейнерами и внешним миром. 
Ваши правила iptables могут быть слишком ограничительными или слишком открытыми.

#### Рекомендации

**Для проведения аудита вручную:**

Выполните следующую команду на каждом узле:
```
ps -ef | grep kubelet
```
Если аргумент `--make-iptables-util-chains` существует, убедитесь, что он установлен в значение *true*.
Если аргумент `--make-iptables-util-chains` не существует и есть файл конфигурации Kubelet, указанный параметром `--config`, убедитесь, что файл не устанавливает `makeIPTablesUtilChains` в значение *false*.

**Исправление:**

Если используется файл конфигурации Kubelet, отредактируйте файл, чтобы установить `makeIPTablesUtilChains: true`.
Если используются аргументы командной строки, отредактируйте файл службы kubelet `/etc/kubernetes/kubelet.conf` на каждом рабочем узле и удалите аргумент `--make-iptables-util-chains` из переменной `KUBELET_SYSTEM_PODS_ARGS`.
В зависимости от вашей системы перезапустите службу kubelet. 
Например:
```
systemctl daemon-reload
systemctl restart kubelet.service
```
