# Configuring printing from {{ cloud-desktop-full-name }} to a local printer in Linux


This guide will help you configure file printing from [{{ cloud-desktop-full-name }}](../../cloud-desktop/) to a printer connected to a local machine running Linux. The solution is based on using a shared folder: printing jobs from the cloud environment are saved to the shared folder, and the local system intercepts and transfers them to a physical printer.

{% note info %}

This guide provides an example of connecting a virtual printer to printing into a PDF file. To use a printer connected to your local machine (server), add that printer on the [CUPS](https://docs.freebsd.org/en/articles/cups/) print server. You will not have to install the `printer-driver-cups-pdf` PDF printing driver.

{% endnote %}

To configure printing from a {{ cloud-desktop-name }} desktop on a local printer in Linux:

1. [Get your cloud ready](#before-you-begin).
1. [Prepare the infrastructure](#create-infrastructure).
1. [Configure your local machine](#config-local).
1. [Configure the desktop](#config-desktop).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for using the desktop’s computing resources, disks, and outbound traffic (see [{{ cloud-desktop-full-name }} pricing](../../cloud-desktop/pricing.md)).
* Fee for [NAT gateway](../../vpc/concepts/gateways.md) usage and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Set up your infrastructure {#create-infrastructure}

If you do not have a desktop yet, create one:

1. Create a [network](../../vpc/operations/network-create.md) and [subnet](../../vpc/operations/subnet-create.md) for the desktop.
1. [Set up](../../vpc/operations/create-nat-gateway.md) a NAT gateway for the desktop.
1. [Create](../../cloud-desktop/operations/desktop-groups/create.md) a desktop group. When creating it, select an image with a Linux-based OS, e.g., Ubuntu 20.04.

    {% note info %}

    We recommend using the same or close OS versions on the local machine and remote desktop. Using different versions, e.g., Ubuntu 20.04 with Ubuntu 24.04, may cause compatibility errors.

    {% endnote %}

1. [Create](../../cloud-desktop/operations/desktops/create.md) a desktop.


## Configure your local machine {#config-local}

Configure your local machine to receive files from the desktop.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Install the necessary tools:

      * [CUPS](https://en.wikipedia.org/wiki/CUPS) print server.
      * printer-driver-cups-pdf package to verify printing on a virtual PDF printer. To configure a physical printer, install that printer’s driver.

      Do it by running these commands:

      ```bash
      sudo apt update
      sudo apt install cups printer-driver-cups-pdf
      ```

  1. Create a file named `install-print-watcher.sh` and paste this script code into it:

      {% cut "install-print-watcher.sh" %}

      ```bash
      #!/usr/bin/env bash
      # install-print-watcher.sh
      # Install print-watcher service and script.
      set -euo pipefail

      WATCH_DIR="/srv/printdrop"
      PRINTER=""
      PRINT_USER=""
      FW_DIR="yc-print"

      show_help() {
        cat <<EOF
      Usage: $0 [--dir DIR] [--printer NAME] [--user USER] [--fwdir FW_DIR] [--yes|-y]
        --dir DIR        directory to watch (default: /srv/printdrop)
        --printer NAME   CUPS printer name (or empty for DEFAULT printer)
        --user USER      username
        --fwdir FW_DIR   forwarding directory name (default: $FW_DIR)
        -y, --yes        do not ask for confirmation
        -h, --help       show this help
      EOF
      }

      # parse args
      CONFIRM=yes
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --dir) WATCH_DIR="$2"; shift 2 ;;
          --printer) PRINTER="$2"; shift 2 ;;
          --user) PRINT_USER="$2"; shift 2 ;;
          --fwdir) FW_DIR="$2"; shift 2 ;;
          -y|--yes) CONFIRM=no; shift ;;
          -h|--help) show_help; exit 0 ;;
          *) echo "Unknown arg: $1"; show_help; exit 1 ;;
        esac
      done

      if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root (sudo)." >&2
        exit 1
      fi

      echo "Install print-watcher with parameters:"
      echo "  WATCH_DIR: $WATCH_DIR"
      echo "  PRINTER:   $PRINTER"
      echo "  USER:      $PRINT_USER"
      echo "  FW_DIR:    $FW_DIR"
      if [[ "$CONFIRM" != "no" ]]; then
        read -rp "Continue? [y/N] " ans
        case "${ans,,}" in y|yes) ;; *) echo "Aborted."; exit 1 ;; esac
      fi

      timestamp() { date +%Y%m%d%H%M%S; }

      # detect package manager
      PKG_MGR=""
      if command -v apt-get >/dev/null 2>&1; then
        PKG_MGR="apt"
      elif command -v dnf >/dev/null 2>&1; then
        PKG_MGR="dnf"
      elif command -v yum >/dev/null 2>&1; then
        PKG_MGR="yum"
      elif command -v pacman >/dev/null 2>&1; then
        PKG_MGR="pacman"
      elif command -v zypper >/dev/null 2>&1; then
        PKG_MGR="zypper"
      fi

      install_packages() {
        echo "Installing packages: cups, inotify-tools (if available) and freerdp using $PKG_MGR"
        case "$PKG_MGR" in
          apt)
            apt-get update
            apt-get install -y --no-install-recommends cups inotify-tools freerdp2-x11
            ;;
          dnf)
            dnf install -y cups inotify-tools xfreerdp || true
            ;;
          yum)
            yum install -y cups inotify-tools freerdp2-x11 || true
            ;;
          pacman)
            pacman -Sy --noconfirm cups inotify-tools freerdp2-x11 || true
            ;;
          zypper)
            zypper --non-interactive install cups inotify-tools freerdp2-x11 || true
            ;;
          *)
            echo "Package manager not detected. Please install 'cups' and 'inotify-tools' manually." >&2
            ;;
        esac
      }

      install_packages

      # create/watch directory
      if [[ ! -d "$WATCH_DIR" ]]; then
        mkdir -p "$WATCH_DIR"
        echo "Created $WATCH_DIR"
      fi

      # try to set ownership to lp:lp and permissions
      chown lp:lp "$WATCH_DIR" || echo "Warning: cannot chown $WATCH_DIR to lp:lp (maybe lp does not exist)"
      chmod 0777 "$WATCH_DIR" || true
      echo "Adjusted ownership/permissions for $WATCH_DIR"

      # paths
      SCRIPT_PATH="/usr/local/bin/print-watcher.sh"
      SERVICE_PATH="/etc/systemd/system/print-watcher.service"

      backup_if_exists() {
        local f="$1"
        if [[ -e "$f" ]]; then
          local bak="${f}.bak.$(timestamp)"
          mv "$f" "$bak"
          echo "Backed up existing $f -> $bak"
        fi
      }
      # write desktop file for freerdp
      set +u

      cat  <<EOF > /usr/share/applications/freerdp.desktop
      [Desktop Entry]
      Version=1.0
      Name=XFreeRDP
      Comment=XFreeRDP
      Exec=bash -c '/usr/bin/xfreerdp \$1 /drive:$FW_DIR,$WATCH_DIR ; read -p pressEnter' dummy %F
      Path=/usr/bin
      #for any error being visible after app closed
      Terminal=true
      Type=Application
      Categories=GTK;GNOME;X-GNOME-NetworkSettings;Network;
      Keywords=remote desktop;rdp;vnc;nx;ssh;spice;xdmcp;
      EOF

      set -u

      # register application associations
      cat  <<EOF > /usr/share/mime/packages/freerdp.xml
      <?xml version="1.0" encoding="utf-8"?>
      <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
      <mime-type type="application/x-freerdp">
        <comment>XFreeRDP file</comment>
        <glob pattern="*.rdp"/>
        <glob pattern="*.rdpx"/>
        <glob pattern="*.RDP"/>
      </mime-type>   
      </mime-info>
      EOF

      xdg-mime install --novendor --mode system /usr/share/mime/packages/freerdp.xml
      update-mime-database /usr/share/mime

      # assign mime-type to desktop application
      if [[ "$(sudo -u $PRINT_USER xdg-mime query default application/x-freerdp)" != "freerdp.desktop" ]]
      then
        echo "setting mime type to freerdp.desktop"
        sudo -u $PRINT_USER xdg-mime default freerdp.desktop application/x-remmina 
        sudo -u $PRINT_USER xdg-mime default freerdp.desktop application/x-freerdp
      else
        echo "freerdp mime type has been already set to freerdp.desktop"
      fi

      # write watcher script
      backup_if_exists "$SCRIPT_PATH"
      cat > "$SCRIPT_PATH" <<'EOF'
      #!/usr/bin/env bash
      # /usr/local/bin/print-watcher.sh
      set -euo pipefail

      usage() {
        cat <<E
      Usage: $0 [-d WATCH_DIR] [-p PRINTER] [-u USER]
      E
        exit 1
      }

      # defaults
      WATCH_DIR="${WATCH_DIR:-/srv/printdrop}"
      PRINTER="${PRINTER:-PDF}"
      USER="${USER:-username}"

      while getopts "d:p:u:h" opt; do
        case "$opt" in
          d) WATCH_DIR="$OPTARG" ;;
          p) PRINTER="$OPTARG"  ;;
          u) USER="$OPTARG"     ;;
          h) usage ;;
          *) usage ;;
        esac
      done

      log() {
        echo "$(date +'%F %T') [print-watcher] $*" >&2
        logger -t print-watcher "$*"
      }

      command -v inotifywait >/dev/null
      2>&1 || { log "inotifywait not found. Exiting."; exit 2; }
      command -v lp >/dev/null 2>&1 || { log "lp not found. Exiting."; exit 2; }

      if [[ ! -d "$WATCH_DIR" ]]; then
        log "Watch dir $WATCH_DIR missing. Exiting."
        exit 3
      fi

      log "Starting watch on $WATCH_DIR for *.pdf, printer='$PRINTER', user='$USER'"

      stopping=0
      term_handler() {
        stopping=1
        log "Term received, exiting..."
      }
      trap term_handler SIGINT SIGTERM

      inotifywait -m -e close_write,moved_to --format '%w%f' --quiet "$WATCH_DIR" | while IFS= read -r FILE; do
        if [[ "$stopping" -ne 0 ]]; then
          log "Stopping watcher loop"
          break
        fi
        case "${FILE,,}" in
          *.pdf)
            if [[ -f "$FILE" ]]; then
              log "Detected PDF: $FILE — submitting to printer '$PRINTER' as user '$USER'"
              if lp -U "$USER" -d "$PRINTER" "$FILE"; then
                rm -f -- "$FILE"
                log "Printed and removed $FILE"
              else
                log "Failed to print $FILE"
              fi
            else
              log "File no longer exists: $FILE"
            fi
            ;;
          *) ;;
        esac
      done

      log "Watcher stopped"
      EOF

      chmod 0755 "$SCRIPT_PATH"
      echo "Installed watcher script at $SCRIPT_PATH"

      # write systemd unit
      backup_if_exists "$SERVICE_PATH"
      cat > "$SERVICE_PATH" <<EOF
      [Unit]
      Description=Watch printdrop and print PDF files
      After=network.target

      [Service]
      ExecStart=${SCRIPT_PATH} -d ${WATCH_DIR} $(if [[ ! -z "$PRINTER" ]];then echo "-p $PRINTER";fi) -u ${PRINT_USER}
      Restart=always
      RestartSec=5
      User=lp
      Group=lp
      TimeoutStopSec=10

      [Install]
      WantedBy=multi-user.target
      EOF

      echo "Installed systemd unit at $SERVICE_PATH"

      # reload systemd and enable service
      systemctl daemon-reload
      systemctl enable --now print-watcher.service

      echo "Service enabled and started. Status:"
      systemctl status --no-pager -l print-watcher.service || true

      echo
      echo "To view logs: journalctl -u print-watcher -f"
      echo "If you need to change parameters later, edit $SERVICE_PATH and run 'systemctl daemon-reload && systemctl restart print-watcher'"
      echo "Done."
      ```

      {% endcut %}

      Once you run the `install-print-watcher.sh` script, it will create an automatic system to intercept PDF files from the remote desktop and print them out on a local printer. It will install a background service to monitor the files appearing in a dedicated folder and will automatically send them to the printer via CUPS. The script requires administrator permissions to install the system service and uses standard Linux tools.

  1. Make the script file executable and run it:

      ```bash
      sudo chmod +x install-print-watcher.sh
      sudo ./install-print-watcher.sh \
        --user <username> \
        --dir <folder_path> \
        --printer <printer_name> \
        --fwdir <folder_path>
      ```

      Where:

      * `--user`: Username of local machine user. This is a required parameter.
      * `--dir`: Monitored folder. The default value is `/srv/printdrop`.
      * `--printer`: CUPS printer name. If you do not specify this parameter, the default system printer will be used.
      * `--fwdir`: Name of the desktop folder for forwarding. The default value is `yc-print`.

  1. Check the service status:

      ```bash
      systemctl status print-watcher.service
      ```

      Result:

      ```text
            ● print-watcher.service - Watch printdrop and print PDF files
                Loaded: loaded (/etc/systemd/system/print-watcher.service; enabled; preset>
                ...
      ```

{% endlist %}


## Configure the desktop {#config-desktop}

Configure the desktop to send files to the local machine.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. [Connect](../../cloud-desktop/operations/desktops/connect.md) to the desktop.
  1. Create a file named `install-printdrop-backend.sh` and paste this script code into it:

      {% cut "install-printdrop-backend.sh" %}

      ```bash
      #!/usr/bin/env bash
      # install-printdrop-backend.sh
      # Requires: --user USERNAME and --dir DROP_DIR (they must be already exist).
      set -euo pipefail

      PROG="$(basename "$0")"
      DEFAULT_PRINTER="DropPrinter"
      DEFAULT_DROP_DIR="yc-print"

      usage() {
        cat <<EOF
      Usage: $PROG --user USERNAME [--dir DROP_DIR --printer PRINTER_NAME] [-y|--yes] [-h|--help]

        --user USERNAME       local user who owns DROP_DIR and to whom helper will switch (required)
        --dir DROP_DIR        existing directory to place print jobs (required)
        --printer PRINTER     CUPS printer name to create (default: ${DEFAULT_PRINTER})
        -y, --yes             automatic yes (no interactive prompt)
        -h, --help            show this help
      EOF
      }

      # Defaults
      AUTO_NO_PROMPT="no"
      PRINTER_NAME="$DEFAULT_PRINTER"
      USERNAME=""
      DROP_DIR="$DEFAULT_DROP_DIR"
      FULL_DROP_DIR=""

      # parse args
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --user) USERNAME="$2"; shift 2 ;;
          --dir) DROP_DIR="$2"; shift 2 ;;
          --printer) PRINTER_NAME="$2"; shift 2 ;;
          -y|--yes) AUTO_NO_PROMPT="yes"; shift ;;
          -h|--help) usage; exit 0 ;;
          *) echo "Unknown arg: $1"; usage; exit 1 ;;
        esac
      done


      FULL_DROP_DIR="/home/$USERNAME/thinclient_drives/$DROP_DIR"
      echo "Final directory to put print jobs set to $FULL_DROP_DIR"

      if [[ -z "$USERNAME" ]] ; then
        echo "Error: --user and --dir are required." >&2
        usage
        exit 2
      fi

      if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root." >&2
        exit 3
      fi

      echo "Parameters:"
      echo "  USER:          $USERNAME"
      echo "  FULL_DROP_DIR: $FULL_DROP_DIR"
      echo "  PRINTER:       $PRINTER_NAME"

      if [[ "$AUTO_NO_PROMPT" != "yes" ]]; then
        read -rp "Continue? [y/N] " ans
        case "${ans,,}" in y|yes) ;; *) echo "Aborted."; exit 1 ;; esac
      fi

      # Validate that user exists
      if ! id -u "$USERNAME" >/dev/null 2>&1; then
        echo "Error: user '$USERNAME' does not exist. Exiting." >&2
        exit 4
      fi

      # Validate that the user can write into FULL_DROP_DIR (best-effort)
      if ! sudo -u "$USERNAME" test -w "$FULL_DROP_DIR" >/dev/null 2>&1; then
        echo "Warning: user '$USERNAME' may not have write permission to '$FULL_DROP_DIR'." >&2
        echo "Please ensure the user can write into the directory before using the backend."
      fi

      timestamp() { date +%Y%m%d%H%M%S; }

      # detect package manager
      PKG_MGR=""
      if command -v apt-get >/dev/null 2>&1; then
        PKG_MGR="apt"
      elif command -v dnf >/dev/null 2>&1; then
        PKG_MGR="dnf"
      elif command -v yum >/dev/null 2>&1; then
        PKG_MGR="yum"
      elif command -v pacman >/dev/null 2>&1; then
        PKG_MGR="pacman"
      elif command -v zypper >/dev/null 2>&1; then
        PKG_MGR="zypper"
      fi

      install_cups() {
        echo "Installing cups (package manager: ${PKG_MGR:-unknown})..."
        case "$PKG_MGR" in
          apt)
            apt-get update
            apt-get install -y --no-install-recommends cups
            ;;
          dnf)
            dnf install -y cups
            ;;
          yum)
            yum install -y cups
            ;;
          pacman)
            pacman -Sy --noconfirm cups
            ;;
          zypper)
            zypper --non-interactive install cups
            ;;
          *)
            echo "Warning: package manager not detected. Please install 'cups' manually and re-run the script." >&2
            ;;
        esac
      }

      install_cups

      # prepare /tmp/cups-shared
      TMP_SHARED="/tmp/cups-shared"
      mkdir -p "$TMP_SHARED"
      chmod 0777 "$TMP_SHARED"
      echo "Prepared $TMP_SHARED (0777)"

      # find backend dir
      BACKENDDIR=""
      if [[ -d /usr/lib/cups/backend ]]; then
        BACKENDDIR="/usr/lib/cups/backend"
      elif [[ -d /usr/libexec/cups/backend ]]; then
        BACKENDDIR ="/usr/libexec/cups/backend"
      else
        # create standard location if neither exists (best-effort)
        BACKENDDIR="/usr/lib/cups/backend"
        mkdir -p "$BACKENDDIR"
      fi
      BACKENDPATH="${BACKENDDIR}/printdrop"

      # backup existing files if present
      backupifexists() {
        local f="$1"
        if [ -e "$f" ]; then
          local bak="${f}.bak.$(timestamp)"
          mv "$f" "$bak"
          echo "Backed up existing $f -> $bak"
        fi
      }
      backupifexists "$BACKENDPATH"

      # write backend (embed FULL_DROP_DIR and USERNAME)
      cat > "$BACKENDPATH" <<EOF
      #!/bin/bash
      # CUPS backend 'printdrop' generated by install-printdrop-backend.sh
      # When called without args, list device URI
      if test "\$#" = "0"; then
        echo 'file printdrop:/ "${PRINTER_NAME}" "/"'
        exit 0
      fi

      DROPDIR="${FULL_DROP_DIR}"
      mkdir -p /tmp/cups-shared

      JOBFILE="\$6"  # CUPS may pass filename as 6th argument
      TS=\$(date +%s)-\$RANDOM
      OUT="\$DROPDIR/job-\$TS.pdf"
      SHAREDOUT="/tmp/cups-shared/job-\$TS.pdf"

      if [ -n "\$JOBFILE" ] && [ -f "\$JOBFILE" ]; then
        cp "\$JOBFILE" "\$SHAREDOUT"
        chmod -R 0777 /tmp/cups-shared
        sudo -u ${USERNAME} /usr/local/bin/copy-as-user.sh "\$SHAREDOUT" "\$OUT"
      else
        cat - > "\$SHAREDOUT"
        sudo -u ${USERNAME} /usr/local/bin/copy-as-user.sh "\$SHAREDOUT" "\$OUT"
      fi
      EOF

      chmod 0755 "$BACKENDPATH"
      chown root:root "$BACKENDPATH"
      echo "Installed CUPS backend at $BACKENDPATH (owned root:root, mode 0755)"

      # helper script
      HELPERPATH="/usr/local/bin/copy-as-user.sh"
      backupifexists "$HELPERPATH"
      cat > "$HELPERPATH" <<'EOF'
      #!/bin/bash
      # copy-as-user.sh
      # Moves a temporary file atomically into final location.
      # Usage: copy-as-user.sh /tmp/cups-shared/job-xxx.pdf /home/username/...
      set -euo pipefail

      if [[ $# -ne 2 ]]; then
        echo "Usage: $0 <src> <dst>"
        exit 1
      fi

      SRC="$1"
      DST="$2"

      # atomic move: move src -> dst.tmp then rename
      mv -- "$SRC" "$DST.tmp"
      mv -- "$DST.tmp" "$DST"
      EOF

      chmod 0755 "$HELPERPATH"
      chown root:root "$HELPERPATH"
      echo "Installed helper $HELPERPATH (owned root:root, mode 0755)"

      # sudoers entry to allow lp to run helper as the target USERNAME without password
      SUDOERSFILE="/etc/sudoers"
      cat >> "$SUDOERSFILE" <<EOF
      # Allow CUPS lp user to run the helper as ${USERNAME}
      lp ALL=(${USERNAME}) NOPASSWD: ${HELPERPATH}
      EOF

      # ensure cups service running
      if command -v systemctl >/dev/null 2>&1; then
        systemctl daemon-reload || true
        systemctl enable --now cups || systemctl start cups || true
      else
        service cups start || true
      fi

      # create printer via lpadmin
      if command -v lpadmin >/dev/null 2>&1; then
        echo "Creating printer '${PRINTER_NAME}' with URI printdrop:/"
        if lpstat -p 2>/dev/null | grep -q "^printer ${PRINTER_NAME}\b"; then
          echo "Printer ${PRINTER_NAME} already exists. Deleting old one."
          lpadmin -x "${PRINTER_NAME}" || true
        fi

        lpadmin -p "${PRINTER_NAME}" -E -v "printdrop:/" || { echo "lpadmin failed"; }
        cupsenable "${PRINTER_NAME}" || true
        cupsaccept "${PRINTER_NAME}" || true
        echo "Printer ${PRINTER_NAME} created and enabled."
      else
        echo "lpadmin not found — cannot create printer. Please create a printer with:"
        echo "  lpadmin -p ${PRINTER_NAME} -E -v printdrop:/"
      fi

      echo
      echo "Installation complete."
      echo "Backend: $BACKENDPATH"
      echo "Helper:  $HELPERPATH"
      echo "Drop dir: $FULL_DROP_DIR (must exist and be writable by $USERNAME)"
      echo "Sudoers entry: $SUDOERSFILE"
      echo
      echo "To test, run:"
      echo "  lp -d ${PRINTER_NAME} somefile.pdf"
      echo "or"
      echo "  cat somefile.pdf | lp -d ${PRINTER_NAME}"
      echo
      echo "To view logs: journalctl -u cups -f"
      ```

      {% endcut %}

      Once you run the `install-printdrop-backend.sh` script, it will set up a desktop to send printing jobs to the common folder. It will create a CUPS virtual printer to forward all documents to a dedicated folder the local machine has access to. The script requires administrator permissions to set up the printing system and uses CUPS mechanisms for integration with the cloud environment.

  1. Make the script file executable and run it:

      ```bash
      sudo chmod +x install-printdrop-backend.sh
      sudo ./install-printdrop-backend.sh \
        --user <desktop_user_name> \
        --dir <folder_path> \
        --printer <printer_name>
      ```

      Where:

      * `--user`: Username of the desktop user with permissions for the printing jobs folder. The utility will switch to that user when you run it. This is a required parameter.
      * `--dir`: Printing jobs folder. The default value is `yc-print`.
      * `--printer`: Name of the CUPS printer that needs to be created. The default value is `DropPrinter`.

  1. Make sure `DropPrinter` has been created:

      ```bash
      lpstat -p
      ```

      Result:

      ```text
      printer DropPrinter is idle.  enabled since Wed 24 Dec 2025 03:46:54 PM UTC
      ```

{% endlist %}


## Check the result {#check-result}

To check the result, send a PDF file for printing.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. On the desktop, create or [download](https://pdfobject.com/pdf/sample.pdf) any PDF file.
  1. On the desktop, send the PDF file to print by selecting the new virtual printer named `DropPrinter`.

      You will see a message that the file has been added to the print queue.

  1. On your local machine, check the files sent from the desktop for printing:

      ```bash
      ls -lt ~/PDF
      ```

      Result:

      ```text
      total 312
      -rw------- 1 your-user your-user 48122 дек 29 14:19 job-1766992742-18941-job_2.pdf
      -rw------- 1 your-user your-user 48122 дек 29 13:36 job-1766990196-17574-job_1.pdf
      ```

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
1. [Delete the desktop](../../cloud-desktop/operations/desktops/delete.md).

Optionally, delete the [subnets](../../vpc/operations/subnet-delete.md), [network](../../vpc/operations/network-delete.md), and the [desktop group](../../cloud-desktop/operations/desktop-groups/delete.md).