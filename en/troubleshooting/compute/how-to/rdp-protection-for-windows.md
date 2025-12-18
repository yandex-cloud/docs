# How to secure RDP connections on Microsoft Windows®


## Case description {#case-description}

You need to provide extra security for RDP connections on Microsoft Windows®.

## Solution {#case-resolution}

{{ yandex-cloud }} has no out-of-the-box solutions to secure RDP connections using additional user authentication tools.

We recommend [using a VPN connection to {{ yandex-cloud }}](../../../tutorials/routing/ipsec/ipsec-vpn.md). Alternatively, you can provide extra [security for your RDP connection on the OS level](https://www.mvps.net/docs/how-to-secure-remote-desktop-rdp/) or use the [two-factor authentication](https://winitpro.ru/index.php/2022/01/18/2fa-v-windows-multiotp/).