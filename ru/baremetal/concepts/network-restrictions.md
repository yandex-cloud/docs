# Ограничения в сетях {{ baremetal-name }}

В сетях {{ baremetal-name }} действует ряд ограничений.

## MAC-адреса {#mac-addresses}

Если вам требуется большее количество MAC-адресов на один порт, обратитесь в [техническую поддержку]({{ link-console-support }}) и опишите задачи, для которых необходимо изменение.

Вид ограничения | Количество
--- | ---
MAC-адресов на один порт | 5

## MTU и MSS {#mtu-mss}

В сервисе действуют следующие ограничения MTU и MSS:

Вид ограничения | Значение, байт
--- | ---
MTU в публичной сети | 1500
MSS в публичной сети | 1460
MTU в приватной сети | 8910
MSS в приватной сети | 8870

## Полоса пропускания {#bandwidth}

В публичной сети действует ограничение полосы пропускания на 1 Гбит/с для всех серверов, в том числе серверов с сетевыми картами на 10 Гбит/c.

Вид ограничения | Значение, Гбит/с
--- | ---
Полоса пропускания в публичной сети | 1 

## Storm Control {#storm-control}

В сервисе действуют следующие ограничения широковещательного трафика:

Вид ограничения | Значение,</br>пакетов/с (pps)
--- | ---
Broadcast | 100
UnknownUnicast | 100
Multicast | 100