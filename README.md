# Ammyy Relay & Router Service for Alpine Linux

Lightweight, standalone glibc compatibility layer for running Ammyy binaries directly in Alpine Linux without heavy chroot/debootstrap environments.

---

## One-Line Installation

You can install the entire application bundle, dependencies, and OpenRC system services automatically using the following command:

```bash
curl -fsSL https://githubusercontent.com | sh
```

The installer will automatically fetch all binaries, config files, library layers, and register the components as system daemons.

---

## Directory Structure

All files and components are consolidated under the `/opt/ammyy` directory:

*   **`config/`** - Contains configuration files (`router.cfg`, `relay.cfg`).
*   **`logs/`** - Directory designated for application log files (e.g., `relay_log.txt`).
*   **`scripts/`** - Houses helper scripts for manual management and uninstallation.

---

## Management Scripts

Navigate to the `/opt/ammyy/scripts/` directory to manage the services manually:

*   **`manual_start.sh`** - Starts both the Router and Relay services in the correct sequence.
*   **`manual_stop.sh`** - Gracefully stops both services and releases network ports.
*   **`uninstall.sh`** - Completely purges the application, OpenRC services, and all directories from the system.

---

## Service Management (OpenRC)

The installer configures both components as system-wide background daemons. You can control them using standard Alpine commands:

```bash
rc-service ammyy-router status
rc-service ammyy-relay status
```

