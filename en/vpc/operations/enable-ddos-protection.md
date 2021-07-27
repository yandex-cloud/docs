---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Enable protection from DDoS attacks

To enable DDoS protection:

{% list tabs %}

- Management console
  
  You can enable protection from DDoS attacks when  [creating](../../compute/quickstart/quick-create-linux) a virtual machine and reserving public IP addresses.
  
  ## Enabling DDoS protection when creating a virtual machine {#enable-on-vm-creation}
  
  When configuring the network on a new virtual machine, select the automatically assigned public IP address or select an address from the list of reserved addresses.
  
  After selecting the address, select the **DDoS protection** option.
  
  ## Enabling DDoS protection when reserving IP addresses {#enable-on-reservation}
  
  To reserve a protected static IP address:
  
  1. Open the **Virtual Private Cloud** section in the folder where you want to reserve the address.
  1. Go to the **IP addresses** tab.
  1. Click **Reserve address**.
  1. Select the availability zone where you want to reserve the address.
  1. Select **DDoS protection**
  1. Click **Reserve address**.
  
{% endlist %}

