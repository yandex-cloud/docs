Configure [MTU](../../vpc/concepts/mtu-mss.md) on both VMs:

   ```bash
   ETH_NIC=eth0
   sudo iptables -t mangle -A FORWARD -i ${ETH_NIC} -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
   sudo iptables -t mangle -A FORWARD -o ${ETH_NIC} -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
   echo "net.ipv4.ip_no_pmtu_disc = 1" | sudo tee -a /etc/sysctl.conf
   sudo sysctl -p /etc/sysctl.conf
   ``` 

  {% note warning %}

  If you keep the default MTU value, network traffic losses may possibly occur.

  {% endnote %}