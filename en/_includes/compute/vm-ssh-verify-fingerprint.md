{% note tip %}

Before entering `yes`, make sure that the key fingerprint (`fingerprint`) you see in the terminal matches the SSH key fingerprint on the VM. This will protect the connection from server spoofing.


{% cut "View SSH key fingerprint on the VM" %}

1. [Get](../../compute/operations/vm-info/get-serial-port-output.md) the VM serial port output.
1. In the output, find the section that starts with the `BEGIN SSH HOST KEY FINGERPRINTS` line and ends with the `END SSH HOST KEY FINGERPRINTS` line. In this section, for each encryption algorithm (`ED25519`, `ECDSA`, and `RSA`) there is a fingerprint in `SHA256:...` format.
1. Compare the fingerprint for the algorithm of interest with the fingerprint shown by the SSH client in the terminal. The algorithm is stated in the SSH client message.

{% endcut %}

If the fingerprints match, proceed with the connection. If the fingerprints differ, cancel the connection and check the VM and network settings.

{% endnote %}
