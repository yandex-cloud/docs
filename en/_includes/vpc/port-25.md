{{ yandex-cloud }} automatically blocks traffic sent from {{ vpc-name }} public IPs to TCP port 25 of any servers on the internet and {{ compute-full-name }} VMs. The only exception is the traffic sent to Yandex Mail email servers, which is allowed and not blocked.

{{ yandex-cloud }} can provide a special public IP address with TCP port 25 opened upon request to the support team if you follow the [Acceptable Use Policy](https://yandex.ru/legal/cloud_aup/?lang=en). In case you violate the Policy, {{ yandex-cloud }} can block outgoing traffic on TCP port 25 again.

For public IPs that are already in use, port 25 cannot be opened.