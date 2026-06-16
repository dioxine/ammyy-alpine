# Ammyy Relay & Router Service for Alpine Linux

🌐 **Select Language / Выберите язык:**
*   [English Version](#-english-version)
*   [Русская версия](#-русская-версия)

---

## 🇬🇧 English Version

Lightweight, standalone glibc compatibility layer for running Ammyy binaries directly in Alpine Linux without heavy chroot/debootstrap environments.

### One-Line Installation

You can install the entire application bundle, dependencies, and OpenRC system services automatically using the following command:

```bash
curl -fsSL https://githubusercontent.com | sh
```

The installer will automatically fetch all binaries, config files, library layers, and register the components as system daemons.

### Directory Structure

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

### Management Scripts

Navigate to the `/opt/ammyy/scripts/` directory to manage the services manually:

*   **`manual_start.sh`** - Starts both the Router and Relay services in the correct sequence.
*   **`manual_stop.sh`** - Gracefully stops both services and releases network ports.
*   **`uninstall.sh`** - Completely purges the application, OpenRC services, and all directories from the system.

### Service Management (OpenRC)

The installer automatically configures both components as system-wide background daemons. You can control them using standard Alpine commands:

```bash
rc-service ammyy-router status
rc-service ammyy-relay status
```

---

## 🇷🇺 Русская версия

Легковесный слой совместимости glibc для запуска бинарных файлов Ammyy напрямую в Alpine Linux без использования тяжелых изолированных окружений chroot или debootstrap.

### Быстрая установка в одну команду

Вы можете автоматически установить весь пакет приложения, системные зависимости и службы автозапуска OpenRC с помощью следующей команды:

```bash
curl -fsSL https://githubusercontent.com | sh
```

Инсталлятор самостоятельно загрузит бинарники, файлы конфигурации, необходимые библиотеки совместимости glibc и зарегистрирует компоненты как системные демоны.

### Структура директорий

Все файлы и модули централизованно собраны внутри каталога `/opt/ammyy`. Ниже приведена точная структура файлов, разворачиваемая на сервере:

```text
/opt/ammyy/
├── README.md                # Этот файл документации
├── ammyy_relay              # Скрипт-обертка реле (задает LD_LIBRARY_PATH)
├── ammyy_router             # Скрипт-обертка роутера (задает LD_LIBRARY_PATH)
│
├── bin/                     # Каталог для бинарных файлов и библиотек
│   ├── ammyy_relay.real     # Оригинальный 64-битный бинарник реле
│   ├── ammyy_router.real    # Оригинальный 32-битный бинарник роутера
│   │
│   ├── lib32/               # 32-битные библиотеки glibc для работы роутера
│   │   ├── config.txt       # Симлинк -> /opt/ammyy/config/router.cfg
│   │   ├── failed.log       # Симлинк -> /opt/ammyy/logs/failed.log
│   │   ├── ld-linux.so.2    # 32-битный динамический линкер ELF
│   │   ├── ld-linux.so.2.log # Симлинк -> /opt/ammyy/logs/ld-linux.so.2.log
│   │   ├── libc.so.6        # 32-битная стандартная библиотека C
│   │   ├── libgcc_s.so.1    # 32-битная системная библиотека GCC
│   │   ├── libm.so.6        # 32-битная математическая библиотека
│   │   ├── libpthread.so.0  # 32-битная библиотека потоков POSIX
│   │   ├── libstdc++.so.6   # 32-битная стандартная библиотека C++
│   │   ├── logins.log       # Симлинк -> /opt/ammyy/logs/logins.log
│   │   └── sessions.log     # Симлинк -> /opt/ammyy/logs/sessions.log
│   │
│   └── lib64/               # 64-битные библиотеки glibc для работы реле
│       ├── ld-linux-x86-64.so.2 # 64-битный динамический линкер ELF
│       ├── libc.so.6        # 64-битная standard C library
│       └── libm.so.6        # 64-битная математическая библиотека
│
├── config/                  # Директория файлов конфигурации
│   ├── relay.cfg            # Конфигурация реле (порт, путь к логу и список IP)
│   └── router.cfg           # Активный файл конфигурации роутера
│
├── init/                    # Резервная папка оригинальных OpenRC скриптов
│   ├── ammyy-relay          # Копия OpenRC скрипта для службы реле
│   └── ammyy-router         # Копия OpenRC скрипта для службы роутера
│
├── logs/                    # Централизованное хранилище логов приложения
│   ├── failed.log           # История неудавшихся подключений к роутеру
│   ├── ld-linux-x86-64.so.2.log # Лог отслеживания линкера роутера
│   ├── logins.log           # Лог успешных авторизаций на роутере
│   ├── relay.log            # Активный файл лога работы реле
│   └── sessions.log         # Статистика активных сессий роутера
│
└── scripts/                 # Скрипты ручного управления и обслуживания
    ├── manual_start.sh      # Запуск обеих служб в правильном порядке
    ├── manual_stop.sh       # Безопасная остановка служб и освобождение портов
    └── uninstall.sh         # Полное удаление проекта из системы через /tmp
```

### Скрипты управления

Используйте скрипты из папки `/opt/ammyy/scripts/` для ручного контроля служб:

*   **`manual_start.sh`** — запускает службы роутера и реле в строго необходимой последовательности.
*   **`manual_stop.sh`** — корректно останавливает процессы и освобождает сетевые порты.
*   **`uninstall.sh`** — полностью удаляет приложение, конфигурации, OpenRC-службы и папки из системы.

### Управление службами (OpenRC)

Инсталлятор автоматически настраивает оба компонента как системные фоновые демоны. Вы можете управлять ими стандартными командами Alpine Linux:

```bash
rc-service ammyy-router status
rc-service ammyy-relay status
```

