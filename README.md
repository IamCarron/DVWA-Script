# DVWA Installer 🚀

![DVWA Logo](https://raw.githubusercontent.com/ethicalhack3r/DVWA/master/dvwa/images/logo.png)

[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg?logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/IamCarron/DVWA-Script/pulls)

Automated, modern, and zero-touch installer for **[DVWA (Damn Vulnerable Web Application)](https://github.com/digininja/DVWA)** on Debian and Ubuntu-based Linux distributions.

---

## 🌟 Features / Características / Fonctionnalités

- ⚡ **Zero-Touch Setup:** Automatically installs all dependencies, configures Apache & MariaDB, fixes PHP directives, and initializes the DVWA database tables via `setup.php` without requiring manual browser interaction.
- 🛡️ **PHP & PCRE JIT Compatibility:** Automatically tunes PHP directives (`allow_url_include`, `allow_url_fopen`, `display_errors`) and applies the `pcre.jit = 0` fix for modern PHP environments.
- 🐳 **Universal Service Fallback:** Supports `systemd`, `service`, and `/etc/init.d/` — fully compatible with standard Linux servers, **Docker containers**, **WSL 1/2**, and minimal environments.
- 🎨 **Cyberpunk / Neon UI:** 5-stage progress indicators (`[1/5]` to `[5/5]`), clear status badges (`[➜]`, `[✓]`, `[!]`, `[?]`), and an access summary card.
- 🤖 **Batch / Headless Mode:** Supports automated, non-interactive execution via environment variables.
- 🌐 **Multi-Language Support:** Full automatic detection for English, Español, and Français (`LC_ALL` / `LC_MESSAGES` / `LANG`).

---

## 🛠️ Quick Installation / Instalación Rápida

Run the one-liner command in your terminal as **root** / **sudo**:

```bash
sudo bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/IamCarron/DVWA-Script/main/Install-DVWA.sh)"
```

> **Note / Nota / Remarque:** If you intend to use the `root` user with an empty MySQL password, ensure you run the script directly as the `root` user.

---

## 🤖 Non-Interactive / Batch Mode

For CI/CD pipelines, Dockerfiles, or automated setups, you can pass parameters as environment variables:

```bash
sudo batch_mode=1 sql_user="root" sql_password="" force_download="y" bash -c "$(curl -fsSL https://raw.githubusercontent.com/IamCarron/DVWA-Script/main/Install-DVWA.sh)"
```

---

## 🔐 Credentials / Credenciales / Identifiants

Once the installation finishes, open your browser and navigate to `http://localhost/DVWA`:

| Field / Campo | Value / Valor |
| :--- | :--- |
| **URL** | `http://localhost/DVWA` |
| **Username / Usuario** | `admin` |
| **Password / Contraseña** | `password` |

---

## 🌐 Language Support / Idiomas

The script automatically detects your system locale:
- 🇬🇧 **English** (`en`)
- 🇪🇸 **Español** (`es`)
- 🇫🇷 **Français** (`fr`)

---

## 🤝 Contributing & License

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/IamCarron/DVWA-Script/issues).

Distributed under the **MIT License**. See `LICENSE` for more information.

<div align="center">
  <sub>Made with ♥ by <a href="https://github.com/IamCarron">IamCarron</a></sub>
</div>
