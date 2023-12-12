# Настроить MTU при включении защиты от DDoS-атак

При включении защиты [{{ ddos-protection-full-name }}](./enable-ddos-protection.md) рекомендуется всегда задавать значение MTU равным `1450` байт.

{% note alert %}

Если вы включите {{ ddos-protection-name }} и оставите значение MTU по умолчанию, возможны потери сетевого трафика.

{% endnote %}

Подробнее о параметрах MTU и MSS в {{ yandex-cloud }} читайте в разделе [{#T}](../concepts/mtu-mss.md).

## Настроить MTU {#set-mtu}

### На ВМ с Ubuntu Linux 20.04 или 22.04 {#ubuntu}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH:

   ```
   ssh <имя_пользователя>@<IP-адрес_ВМ>
   ```

1. Задайте значение MTU равным `1450` с помощью команды `netplan`. Выполните команду:

   ```
   sudo netplan set ethernets.eth0.mtu=1450 && sudo netplan apply
   ```

1. Проверьте новые значения MTU и MSS:

   ```
   ip link show eth0 | grep mtu
   ss -i | grep mss
   ```

### На рабочих узлах кластера {{ managed-k8s-name }} {#managed-kubernetes}

1. Создайте YAML-манифест DaemonSet следующего содержания:

   ```yml
   ---
   apiVersion: "apps/v1"
   kind: DaemonSet
   metadata:
     name: mtu-fix
     namespace: kube-system
     labels:
       k8s-app: mtu-fix
       version: 1v
   spec:
     selector:
       matchLabels:
         k8s-app: mtu-fix
     template:
       metadata:
         labels:
           k8s-app: mtu-fix
       spec:
         hostPID: true
         hostNetwork: true
         containers:
         - name: mtu-fix
           image: cr.yandex/crpjfmfou6gflobbfvfv/ipfixik:0.1.0
           command:
             - bash
             - -c
             - |
               ip link set dev eth0 mtu 1450
               sleep infinity
           imagePullPolicy: Always
           securityContext:
             privileged: true
           resources:
             limits:
               memory: 200Mi
             requests:
               cpu: 100m
               memory: 200Mi          
           volumeMounts:
           - mountPath: /sys/
             name: sys
           - mountPath: /proc/
             name: proc
         volumes:
         - name: sys
           hostPath:
             path: /sys/
             type: Directory
         - name: proc
           hostPath:
             path: /proc/
             type: Directory
   ```
    
   Сохраните его в файл с любым именем, например `ds-mtu-fix.yml`.

1. Примените созданный манифест в кластере {{ managed-k8s-name }}:

   ```bash
   kubectl -f ds-mtu-fix.yml
   ```

1. [Подключитесь](../../managed-kubernetes/operations/node-connect-ssh.md) к любому рабочему узлу в кластере по протоколу SSH и проверьте значения MTU и MSS:

   ```
   ssh <имя_пользователя>@<IP-адрес_рабочего_узла>
   ip link show eth0 | grep mtu
   ss -i | grep mss
   ```

### На ВМ с Windows Server {#windows-server}

1. [Подключитесь](../../compute/operations/vm-connect/rdp.md) к ВМ с Windows Server по протоколу RDP и запустите Windows PowerShell.

1. Уточните название интерфейса на котором необходимо изменить MTU:

   ```
   netsh interface ipv4 show subinterfaces
   ```

1. Задайте значение MTU равным `1450` для нужного сетевого интерфейса, в примере это `Ethernet 2`:

   ```
   netsh interface ipv4 set subinterface "Ethernet 2" mtu=1450 store=persistent
   ```

1. Проверьте, что значение MTU изменилось:

   ```
   netsh interface ipv4 show subinterfaces
   ```
