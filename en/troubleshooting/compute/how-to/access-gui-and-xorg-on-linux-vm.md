# Setting up GUI and graphic environment on Linux VMs



## Issue description {#case-description}

* You need to use graphical applications on VM instances with Linux OS

## Solution {#case-resolution}

There are three options that allow you to use a graphical desktop environment on Linux VMs:

* Use VNC or RDP To do this:
   1. Install a desktop environment
   2. After this, install xrdp or a VNC server (for connecting via RDP or VNC, respectively)
       We recommend using a combination of a VNC server that listens only to localhost, and an SSH tunnel: in this case, you will eliminate the risk of attackers connecting to your VM via VNC, as well as encrypt your VNC traffic. The guide [at this link](https://habr.com/ru/company/ua-hosting/blog/273201/) might help you.

* Forward Xorg to your local computer. There are also numerous articles online on how to do this. Use [Xming](https://sourceforge.net/projects/xming/) for Windows:
   1. Install a desktop environment
   2. Set up Xorg forwarding in your SSH client and connect to the VM
   3. Start the graphical application from the terminal.

* Use Terraform to create a VM with an installed graphical environment, like [here](https://nikolaymatrosov.medium.com/rdp-на-ubuntu-в-yandex-cloud-c9d7870a47cc).

* Use Docker image with pre-installed desktop environment LXDE and x11vnc VNC-server
   1. Install Docker.
   2. Run ready-to-use lightweight Ubuntu image:
```
docker run -p 6080:80 -e HTTP_PASSWORD=<your password> -v /dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc
```
   3. Forward 6080 port to your machine.
   4. Open http://<address>:6080 in browser and authenicate with login root and your password. Use left menu for clipboard and keystrokes (such as Ctrl, Alt, Win, Tab).
   5. Install and start graphical application.

{% note alert %}

Our technical support does not provide advice on the setup and use of third-party software on VM instances.
Yandex Cloud users are solely responsible for administering operating systems, setting up third-party software, and writing code in various programming languages.

{% endnote %}
