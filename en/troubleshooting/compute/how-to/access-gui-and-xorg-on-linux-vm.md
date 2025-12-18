# How to set up GUI and graphical environment on VMs running Linux




## Case description {#case-description}

You need to use graphical applications on VM instances running Linux.

## Solution {#case-resolution}

There are several options that allow you to use a graphical desktop environment on Linux VMs:

{% list tabs %}

- Access by VNC/RDP

  You can connect to a VM over remote access protocols, such as VNC or RDP. To do this, follow these steps:

  1. Install the desktop environment.
  1. Install the `xrdp` or `tightvncserver` package to connect over RDP or VNC, respectively.

  We recommend combining the use of a VNC server only listening to `localhost`, and an SSH tunnel. Thus you will prevent interception of a VNC session to your VM, encrypt VNC traffic, and exclude one of the possible ways of compromising access to your VM. 

  Check [this guide](https://habr.com/ru/company/ua-hosting/blog/273201/) to set up an SSH tunnel.

- X-session forwarding

  You can forward a GUI of an application running within an Xorg session on your VM, to your local computer. There are numerous articles online on how to do this. For Microsoft Windows®, you can use the [Xming](https://sourceforge.net/projects/xming/) server:

  1. Install any desktop environment (e.g., KDE, Gnome, XFCE, LXQT, Cinnamon, etc.) on your VM. You can just install the metapackage of the desktop environment you need. All required dependencies, including Xorg, will be installed automatically.
  1. Set up Xorg forwarding in your SSH client and connect to the VM.
  1. Start the graphical application from within the SSH session.
  1. The GUI of the application you need will be rendered in a separate window.

- {{ TF }}

  You can use {{ TF }} to create a VM with the pre-installed graphical environment. You can use the basic {{ TF }} scenario [from this article](https://nikolaymatrosov.medium.com/rdp-%D0%BD%D0%B0-ubuntu-%D0%B2-yandex-cloud-c9d7870a47cc) to write your own configuration.

- Docker

  1. [Install Docker](/container-registry/operations/configure-docker).
  1. Run a ready-made lightweight Ubuntu image with the pre-installed LXDE graphical environment and x11vnc VNC server:
  
      ```
      docker run -p 127.0.0.1:6080:80 -e HTTP_PASSWORD=<your_password> -v /dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc
      ```

  1. After running a container, forward port `6080` to your VM.
  1. Open `http://<address>:6080` in your browser and sign in using the `root` login and your password. Use the left-hand menu for clipboard and pressing additional keys (`Ctrl`, `Alt`, `Win`, and `Tab`).
  1. Install and run the graphical application.

{% endlist %}

{% note alert %}

Our support team does not provide advice on the setup and use of third-party software on VM instances. {{ yandex-cloud }} users are solely responsible for administering operating systems, setting up third-party software, and writing code in various programming languages.

{% endnote %}
