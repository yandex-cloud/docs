# Configuring printing from {{ cloud-desktop-full-name }} to a local printer in Linux


This guide will help you configure file printing from [{{ cloud-desktop-full-name }}](../../cloud-desktop/) to a printer connected to a local Linux machine. The solution is built around a shared folder: print jobs from the cloud environment are saved to a shared folder, the local system intercepting and sending them to a physical printer.

{% note info %}

This guide gives an example of connecting a virtual printer for printing into a PDF file. To use a printer connected to your local machine (server), add that printer on the [CUPS](https://docs.freebsd.org/en/articles/cups/) print server. In which case you will not have to install the `printer-driver-cups-pdf` PDF printing driver, set up `/etc/cups/cups-pdf.conf`, create the `/tmp/cups-pdf-output` folder, or use the PDF verification section.

{% endnote %}

To configure printing from a {{ cloud-desktop-name }} desktop on a local printer in Linux:

1. [Get your cloud ready](#before-you-begin).
1. [Prepare the infrastructure](#create-infrastructure).
1. [Configure the local machine](#config-local).
1. [Configure the desktop](#config-desktop).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for using the desktop’s computing resources, disks, and for outbound traffic (see [{{ cloud-desktop-full-name }} pricing](../../cloud-desktop/pricing.md)).
* Fee for [NAT gateway](../../vpc/concepts/gateways.md) usage and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Prepare the infrastructure {#create-infrastructure}

If you do not have a desktop yet, create one:

1. Create a [network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md) for the desktop.
1. [Set up](../../vpc/operations/create-nat-gateway.md) a NAT gateway for the desktop.
1. [Create](../../cloud-desktop/operations/desktop-groups/create.md) a desktop group. When creating it, select an image with a Linux-based OS, e.g., Ubuntu 20.04.
1. [Create](../../cloud-desktop/operations/desktops/create.md) a desktop.


## Configure the local machine {#config-local}

Configure your local machine to receive files from the desktop.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Install the necessary tools:

      * The [inotify-tools](https://github.com/inotify-tools/inotify-tools/blob/master/README.md) utility.
      * [CUPS](https://en.wikipedia.org/wiki/CUPS) print server.
      * The printer-driver-cups-pdf package for virtual PDF print checks. To configure a physical printer, install that printer’s driver.
      * The [Samba]https://en.wikipedia.org/wiki/Samba_(software) package.

      Do it by running these commands:

      ```bash
      sudo apt update
      sudo apt install inotify-tools cups printer-driver-cups-pdf samba
      ```

  1. Create a shared folder at `/srv/printdrop` and set up access permissions for it:

      ```bash
      sudo mkdir -p /srv/printdrop
      sudo chown lp:lp /srv/printdrop
      sudo chmod 0770 /srv/printdrop
      ```

      This folder will be used for file exchange between the desktop and the local machine.

  1. Set up Samba:
      1. Open `/etc/samba/smb.conf`:

          ```bash
          sudo nano /etc/samba/smb.conf
          ```

      1. Add this code at the end of the file:

          ```text
          [printdrop]
            path = /srv/printdrop
            browseable = yes
            writable = yes
            guest ok = yes
            force user = lp
            force group = lp
            create mask = 0660
            directory mask = 0770
          ```

  1. Configure CUPS:
      1. Open `/etc/cups/cups-pdf.conf`:

          ```bash
          sudo nano /etc/cups/cups-pdf.conf
          ```

      1. Find the `Out ${HOME}/PDF` or `#Out ${HOME}/PDF` line and replace it with the following:

          ```text
          Out /tmp/cups-pdf-output
          ```

  1. Create a folder at `/tmp/cups-pdf-output` and set up access to it:

      ```bash
      sudo mkdir -p /tmp/cups-pdf-output
      sudo chown lp:lp /tmp/cups-pdf-output
      sudo chmod 755 /tmp/cups-pdf-output
      ```

      This folder will store files sent for printing.

     {% note info %}
    
     For a physical printer, you do not need to configure `/etc/cups/cups-pdf.conf` and `/tmp/cups-pdf-output`. Add a printer to CUPS using the `http://localhost:631` admin interface by selecting **Administration → Add Printer** or using the `lpadmin` command. Then, use the `lpstat -p` command to get the queue (physical printer) name.
    
     {% endnote %}

  1. Configure the service to watch the shared folder:
      1. Create a file named `print-watcher.sh`:

          ```bash
          sudo nano /usr/local/bin/print-watcher.sh
          ```

      1. Paste this code into the `print-watcher.sh` file:

          ```text
          #!/bin/bash
          WATCH_DIR="/srv/printdrop"
            PRINTER="PDF" # locally installed printer
            USER="lp" # user the print is initiated for
            inotifywait -m -e close_write,moved_to --format '%w%f' "$WATCH_DIR" | while read FILE; do
              if [[ "${FILE,,}" == *.pdf ]]; then
                lp -U "$USER" -d "$PRINTER" "$FILE" && rm -f "$FILE"
              fi
            done
          ```
         {% note info %}
    
         For a physical printer, in the PRINTER="PDF" parameter, replace PDF with the physical printer (queue) name.
    
         {% endnote %}

      1. Make the file executable:

          ```bash
          sudo chmod +x /usr/local/bin/print-watcher.sh
          ```

      1. Create a service file named `print-watcher.service`:

          ```bash
          sudo nano /etc/systemd/system/print-watcher.service
          ```
      
      1. Paste this code into the `print-watcher.service` file:

          ```text
          [Unit]
            Description=Watch printdrop and print files
            
            [Service]
            ExecStart=/usr/local/bin/print-watcher.sh
            Restart=always
            User=lp
            Group=lp
            
            [Install]
            WantedBy=multi-user.target
          ```

  1. Activate the service and restart the printing and file exchange services:

      ```bash
      sudo systemctl daemon-reload
      sudo systemctl restart cups
      sudo systemctl restart smbd
      sudo systemctl enable --now print-watcher.service
      ```

      Result:

      ```text
      Created symlink /etc/systemd/system/multi-user.target.wants/print-watcher.service → /etc/systemd/system/print-watcher.service.
      ```

  1. Run this command to test the service:

      ```bash
      systemctl status print-watcher.service
      ```

      Result:

      ```text
      ● print-watcher.service - Watch printdrop and print files
          Loaded: loaded (/etc/systemd/system/print-watcher.service; enabled; preset: enabled)
          Active: active (running) since ...
          ...
      ```

  1. Save the public IPv4 address of your local machine. One way to learn it is by using [Yandex Internetometer](https://yandex.com/internet/). You will need this address to mount the shared folder on your desktop.

{% endlist %}


## Configure the desktop {#config-desktop}

Configure the desktop to send files to the local machine.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../../cloud-desktop/operations/desktops/connect.md) to the desktop.
  1. Install the CUPS server and the cifs-utils package:

        ```bash
        sudo apt update
        sudo apt install cups
        sudo apt-get install cifs-utils
        ```

  1. Configure the backend for the virtual printer:
      1. Create a file named `/usr/lib/cups/backend/printdrop`:

          ```bash
          sudo nano /usr/lib/cups/backend/printdrop
          ```

      1. Paste this code into the file:

          ```text
          #!/bin/bash
          export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
          if test "$#" = "0"; then
            echo 'file printdrop:/printdrop "PrintDrop" "/printdrop"'
            exit 0
          fi

          DROP_DIR="/home/<desktop_user_name>/printdrop"
          mkdir -p /tmp/cups-shared

          JOBFILE="$6"  # if CUPS provides the file as an argument
          TS=$(date +%s)-$RANDOM
          OUT="$DROP_DIR/job-$TS.pdf"
          SHARED_OUT="/tmp/cups-shared/job-$TS.pdf"

          if [ -n "$JOBFILE" ] && [ -f "$JOBFILE" ]; then
            cp "$JOBFILE" "$SHARED_OUT"
            chmod -R 777 /tmp/cups-shared
            sudo -u <desktop_user_name> /usr/local/bin/copy-as-user.sh "$SHARED_OUT" "$OUT"
          else
            cat - > "$SHARED_OUT"
            sudo -u <desktop_user_name> /usr/local/bin/copy-as-user.sh "$SHARED_OUT" "$OUT"
          fi
          ```

          Specify the name of the desktop user you will use to send files for printing.

      1. Set up access to the file:

          ```bash
          sudo chmod 755 /usr/lib/cups/backend/printdrop
          sudo chown root:root /usr/lib/cups/backend/printdrop
          ```

  1. Set up access to the shared folder:
      1. Create a file named `/usr/local/bin/copy-as-user.sh`:

          ```bash
          sudo nano /usr/local/bin/copy-as-user.sh
          ```

      1. Paste the helper script code:

          ```text
          #!/bin/bash
          mv "$1" "$2.tmp"
          mv "$2.tmp" "$2"
          ```

      1. Set up access to the file:

          ```bash
          sudo chmod +x /usr/local/bin/copy-as-user.sh
          sudo chown root:root /usr/local/bin/copy-as-user.sh
          ```

      1. Set up permissions:

          ```bash
          sudo visudo
          ```

      1. At the end of the file that opens, paste this line:

          ```text
          lp ALL=(<desktop_user_name>) NOPASSWD: /usr/local/bin/copy-as-user.sh
          ```

          Specify the name of the desktop user you will use to send files for printing.

  1. Create a virtual printer and activate it:

      ```bash
      sudo lpadmin -p DropPrinter -E -v printdrop:/printdrop
      sudo cupsenable DropPrinter
      sudo cupsaccept DropPrinter
      ```

      You will now see a message that a new printer was added.

  1. Create a folder for shared folder mounting:

      ```bash
      sudo mkdir -p ~/printdrop
      ```

  1. Mount the shared folder:

      ```bash
      sudo mount -t cifs //<local_machine_IP_address>/printdrop ~/printdrop -o guest,uid=$(id -u),gid=$(id -g)
      ```

      Specify the IPv4 address you saved earlier.

{% endlist %}


## Check the result {#check-result}

To check the result, send a PDF file for printing.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. On your desktop, create or [download](https://pdfobject.com/pdf/sample.pdf) any PDF file.
  1. On your desktop, send the PDF file for printing by selecting the new virtual printer.

      You will now see a message that the file was added to the printing queue.

  1. On your local machine, check the printing queue of the virtual PDF printer.

{% endlist %}


### Troubleshooting {#errors}

For troubleshooting, use the following commands on your local machine:

{% list tabs group=operating_system %}

- Linux {#linux}

  * Viewing CUPS logs related to incoming print jobs:

      ```bash
      sudo tail -n 10 /var/log/cups/access_log
      ```

      Result:

      ```text
      ...
      localhost - - [15/Nov/2025:21:55:01 +0000] "POST /printers/PDF HTTP/1.1" 200 394 Create-Job successful-ok
      localhost - - [15/Nov/2025:21:55:01 +0000] "POST /printers/PDF HTTP/1.1" 200 408591 Send-Document successful-ok
      ```

  * To view CUPS error logs:

      ```bash
      sudo tail -n 10 /var/log/cups/error_log
      ```

      Detailed entries report errors:

      ```text
      ...
      W [15/Nov/2025:21:55:01 +0000] [Job 34] Backend cups-pdf returned status 5 (cancel job)
      ```

  * To view the PDF files created by the virtual printer:

      ```bash
      sudo ls -l /tmp/cups-pdf-output/
      ```

      Result:

      ```text
      total 472
      -rw------- 1 lp lp 239840 Nov 17 19:37 job-1763408227-8471-job_2.pdf
      ...
      ```

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
1. [Delete the desktop](../../cloud-desktop/operations/desktops/delete.md).

Optionally, delete the [subnets](../../vpc/operations/subnet-delete.md), [network](../../vpc/operations/network-delete.md), and the [desktop group](../../cloud-desktop/operations/desktop-groups/delete.md).