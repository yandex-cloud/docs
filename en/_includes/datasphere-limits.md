#### Quotas {#datasphere-quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of projects per cloud | 5 |
| Number of docker images per cloud | 3 |

{% if region == "ru" %}
   
   {% note info %}
   
   On June 20, 2021, restrictions on the use of VMs with GPUs, available by default for individuals, will take effect. To use a VM with a g1.1 GPU configuration, top up your billing account balance to at least ₽500, or write to Support and tell us about your task.
   
   {% endnote %}

{% endif %}

{% if region == "int" %}

   {% note info %}
   
   On June 20, 2021, restrictions on the use of VMs with GPUs, available by default for individuals, will take effect. To use a VM with a g1.1 GPU configuration, top up your billing account balance to at least $10, or write to Support and tell us about your task.
   
   {% endnote %}

{% endif %}

Type of limit | Value
----- | -----
g1.4 VMs available for use | 0
c1.80 VMs available for use | 0

#### Limits {#datasphere-limits}

| Type of limit | Value |
----- | ----- 
The maximum amount of data that is stored in the {{ ml-platform-name }} | 300 GB