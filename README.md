# Ammyy Relay & Router Service for Alpine Linux

Change Language: 🇷🇺 [Русская версия](README.ru.md)

---

Lightweight, standalone glibc compatibility layer for running Ammyy binaries directly in Alpine Linux without heavy chroot/debootstrap environments.

## One-Line Installation

You can install the entire application bundle, dependencies, and OpenRC system services automatically using the following command:

```bash
curl -fsSL https://githubusercontent.com | sh
```

The installer will automatically fetch all binaries, config files, library layers, and register the components as system daemons.

## Directory Structure

All files and components are consolidated under the `/opt/ammyy` directory. Below is the exact layout deployed on the server:

```text
/opt/ammyy/
├── README.md                # This documentation file
├── ammyy_relay              # Relay wrapper script (handles LD_LIBRARY_PATH)
├── ammyy_router             # Router wrapper script (handles LD_LIBRARY_PATH)
│
├── bin/                     # Directory for binary files and libraries
│   ├── ammyy_relay.real     # 64-bit original relay binary
│   ├── ammyy_router.real    # 32-bit original router binary
│   │
│   ├── lib32/               # 32-bit glibc compatibility libraries for router
│   │   ├── config.txt       # Symlink -> /opt/ammyy/config/router.cfg
│   │   ├── failed.log       # Symlink -> /opt/ammyy/logs/failed.log
│   │   ├── ld-linux.so.2    # 32-bit ELF dynamic linker
│   │   ├── ld-linux.so.2.log # Symlink -> /opt/ammyy/logs/ld-linux.so.2.log
│   │   ├── libc.so.6        # 32-bit standard C library
│   │   ├── libgcc_s.so.1    # 32-bit GCC support library
│   │   ├── libm.so.6        # 32-bit math library
│   │   ├── libpthread.so.0  # 32-bit POSIX threads library
│   │   ├── libstdc++.so.6   # 32-bit GNU Standard C++ library
│   │   ├── logins.log       # Symlink -> /opt/ammyy/logs/logins.log
│   │   └── sessions.log     # Symlink -> /opt/ammyy/logs/sessions.log
│   │
│   └── lib64/               # 64-bit glibc compatibility libraries for relay
│       ├── ld-linux-x86-64.so.2 # 64-bit ELF dynamic linker
│       ├── libc.so.6        # 64-bit standard C library
│       └── libm.so.6        # 64-bit math library
│
├── config/                  # Configuration directory
│   ├── relay.cfg            # Relay configuration (port, log path, and IP list)
│   └── router.cfg           # Router active configuration file
│
├── init/                    # OpenRC init scripts backup folder
│   ├── ammyy-relay          # Managed OpenRC script for the relay service
│   └── ammyy-router         # Managed OpenRC script for the router service
│
├── logs/                    # Centralized application log storage
│   ├── failed.log           # Router connection failure history
│   ├── ld-linux.so.2.log    # Router dynamic linker tracking log
│   ├── logins.log           # Router successful authentication tracking
│   ├── relay.log            # Active relay operation log file
│   └── sessions.log         # Router active session statistics
│
└── scripts/                 # Manual management and maintenance scripts
    ├── manual_start.sh      # Starts both services in the correct sequence
    ├── manual_stop.sh       # Safely stops both services and releases ports
    └── uninstall.sh         # Complete system purge sequence via /tmp execution
```

## Management Scripts

Navigate to the `/opt/ammyy/scripts/` directory to manage the services manually:

*   **`manual_start.sh`** - Starts both the Router and Relay services in the correct sequence.
*   **`manual_stop.sh`** - Gracefully stops both services and releases network ports.
*   **`uninstall.sh`** - Completely purges the application, OpenRC services, and all directories from the system.

## Service Management (OpenRC)

The installer automatically configures both components as system-wide background daemons. You can control them using standard Alpine commands:

```bash
rc-service ammyy-router status
rc-service ammyy-relay status
```

