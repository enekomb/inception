# Inception — Docker Infrastructure

> 42 Urduliz — Common Core project

A complete containerized infrastructure built from scratch using **Docker Compose**. Three custom Docker images orchestrated together: NGINX (reverse proxy with TLS), WordPress (with php-fpm), and MariaDB.

---

## Features

- NGINX with TLSv1.2/1.3 — only HTTPS entry point
- WordPress + php-fpm (no nginx in the same container)
- MariaDB — dedicated database container
- Persistent volumes for database and WordPress files
- Custom Docker network (no `--link`, no `network: host`)
- All images built from scratch (Debian/Alpine based, no DockerHub pre-built images)

## Build & Run

```bash
make
```

> Requires Docker and Docker Compose. Configure your credentials in `srcs/.env` (see `.env.example`).

## Project Structure

```
inception/
├── Makefile
├── bootstrap.sh
└── srcs/
    ├── docker-compose.yml
    ├── .env                  # credentials (gitignored)
    └── requirements/
        ├── nginx/            # NGINX + TLS Dockerfile
        ├── wordpress/        # WordPress + php-fpm Dockerfile
        └── mariadb/          # MariaDB Dockerfile
```

## Architecture

```
           HTTPS (443)
  Browser ──────────────▶ NGINX ──▶ WordPress (php-fpm) ──▶ MariaDB
                           │              │                     │
                      ssl certs      wp-content vol         db vol
```

## Technical Highlights

| | |
|---|---|
| Orchestration | Docker Compose |
| Reverse Proxy | NGINX with TLSv1.2/1.3 |
| CMS | WordPress 6 + php-fpm |
| Database | MariaDB |
| Volumes | Named Docker volumes |

## Skills

`Docker` `Docker Compose` `NGINX` `WordPress` `MariaDB` `System Administration` `Networking`

---

## Academic Integrity

This repository is shared for **educational and portfolio purposes only**.

**For 42 students:**
- Do not copy this code for your own project submissions
- Use it as a reference to understand concepts and approaches
- Write your own original solution — that is the only way to actually learn

*42's core values are learning through practice, peer collaboration, and genuine problem-solving.*

---

## License

MIT — see [LICENSE](LICENSE) for details.
Copyright (c) 2026 Eneko Muñoz Bordona
