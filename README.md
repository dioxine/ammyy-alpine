# Ammyy Relay & Router Service for Alpine Linux

Change Language: 🇷🇺 [Русская версия](README.ru.md)

---

Lightweight glibc compatibility layer for running Ammyy binaries directly in Alpine Linux using a highly optimized, production-ready minimal Docker container.

> [!NOTE]
> Container Total Content Size: **8.86 MB** | Disk Usage: **29.9 MB**

## Network Architecture & Ports Mapping

The stack operates in **Host Network Mode (`network_mode: host`)**. This completely eliminates Docker's virtual NAT translation layer, prevents routing overhead, and resolves anti-spoofing firewall drop bugs unique to Alpine Linux.

The binaries bind directly to your host machine's interfaces using the following non-standard destination ports to prevent any conflicts with pre-existing web servers (like Apache or Nginx):

| Port     | Protocol | Component      | Description                                                |
|:---------|:-------- |:---------------|:-----------------------------------------------------------|
| **8080** | TCP      | `ammyy_router` | Main router port for incoming client connections           |
| **8443** | TCP      | `ammyy_router` | Alternative secure router port (instead of standard `443`) |
| **85**   | TCP      | `ammyy_router` | Router built-in web management console                     |
| **3080** | TCP      | `ammyy_relay`  | Active relay listening port (instead of standard `80`)     |

---

## Docker Compose Quick Deployment

> [!IMPORTANT]
> Administrative privileges are required to manage Docker daemons and workspace paths. Please ensure you are running as `root` or using `sudo`.

### 1. Clone the Repository
Clone the repository directly into the `/opt` directory to establish the complete pre-configured structure:

```bash
git clone -b docker https://github.com/dioxine/ammyy-alpine.git /opt/ammyy
```

### 2. Start the Stack
Navigate to the newly created workspace directory and spin up the micro-container in detached mode:

```bash
cd /opt/ammyy
docker compose up -d
```
*Docker will deploy the optimized image `gdioxine/ammyy-stack:latest` from Docker Hub. The container attaches natively to the host interface without modifying host firewall structures.*

> [!NOTE]
> **Alpine Linux Networking Note:** If you encounter packet-drop connection timeouts on older setups upon first launch, ensure your system rules are normalized by flushing conflicting tables using `nft flush ruleset` or `iptables -F FORWARD`.

---

## Workspace Layout

The application isolates execution states within the image payload, leaving only text assets on the host machine:

```text
/opt/ammyy/
├── docker-compose.yml     # Orchestration layout file
├── config/                # Mutable tracking settings
│   ├── relay.cfg          # Active relay endpoints and port listeners
│   └── router.cfg         # Active router operational configurations
└── logs/                  # Volatile system metrics storage
    ├── failed.log         # Connection denial tracking logs
    ├── ld-linux.so.2.log  # 32-bit interpreter troubleshooting log
    ├── logins.log         # Successful authorization auditing
    ├── relay.log          # Master relay transaction traces
    └── sessions.log       # Active sessions and circuit diagnostics
```

---

## Container Lifecycle Automation

Control the background process engine using native Docker Compose operations inside `/opt/ammyy`:

*   **View execution streams:** `docker compose logs -f ammyy-app`
*   **Apply setting modifications:** `docker compose restart ammyy-app`
*   **Kill and purge resources:** `docker compose down`

