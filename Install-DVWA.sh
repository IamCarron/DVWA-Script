#!/bin/bash

# Color Palette Definition - Cyberpunk / Neon Hacker
C_RESET="\033[0m"
C_BOLD="\033[1m"
C_DIM="\033[2m"
C_CYAN="\033[1;96m"
C_GREEN="\033[1;92m"
C_YELLOW="\033[1;93m"
C_RED="\033[1;91m"
C_MAGENTA="\033[1;95m"
C_WHITE="\033[1;97m"

# Get language prefix (check LC_ALL -> LC_MESSAGES -> LANG -> default 'en')
locale_var="${LC_ALL:-${LC_MESSAGES:-${LANG:-en}}}"
lang="${locale_var:0:2}"

# Declare associative arrays for translations
declare -A en_strings
declare -A es_strings
declare -A fr_strings

batch_mode=${batch_mode:-""}

# English translations
en_strings=(
    ["error_missing_input"]="${C_RED}[!] Missing input: %s${C_RESET}"
    ["error_not_root"]="${C_RED}[!] This script must be run by the root user.${C_RESET}"
    ["welcome_message"]="Welcome to the DVWA setup!"
    ["script_name"]="Script Name: Install-DVWA.sh"
    ["author"]="Author: IamCarron"
    ["github_repo"]="Github Repo: https://github.com/IamCarron/DVWA-Script"
    ["installer_version"]="Installer Version: 2.0"
    ["package_not_installed"]="${C_YELLOW}[➜]${C_RESET} %s is not installed. Installing it now..."
    ["package_installed"]="${C_GREEN}[✓]${C_RESET} %s is installed!"
    ["default_credentials"]="${C_CYAN}[i] Default credentials:${C_RESET}"
    ["password_prompt_info"]="Password: ${C_YELLOW}[No password, just hit Enter]${C_RESET}"
    ["enter_sql_user"]="${C_MAGENTA}[?]${C_RESET} Enter SQL user: "
    ["enter_sql_password"]="${C_MAGENTA}[?]${C_RESET} Enter SQL password (press Enter for no password): "
    ["invalid_sql_credentials"]="${C_RED}[!] Error: Invalid SQL credentials. Please check your username and password. If you are trying to use root user and blank password make sure that you are running the script as root user.${C_RESET}"
    ["sql_success"]="${C_GREEN}[✓]${C_RESET} SQL commands executed successfully."
    ["error_create_db"]="${C_RED}[!] An error occurred while creating the DVWA database.${C_RESET}"
    ["error_create_user"]="${C_RED}[!] An error occurred while creating the DVWA user.${C_RESET}"
    ["error_grant_privileges"]="${C_RED}[!] An error occurred while granting privileges.${C_RESET}"
    ["step_dependencies"]="${C_BOLD}${C_MAGENTA}[1/5] Updating Repositories & Dependencies${C_RESET}"
    ["updating_repos"]="${C_CYAN}[➜]${C_RESET} Updating repositories..."
    ["verifying_dependencies"]="${C_CYAN}[➜]${C_RESET} Verifying and installing necessary dependencies..."
    ["step_download"]="${C_BOLD}${C_MAGENTA}[2/5] Downloading DVWA Application${C_RESET}"
    ["dvwa_folder_exists"]="${C_YELLOW}[!]${C_RESET} Attention! The DVWA folder already exists."
    ["prompt_delete_folder"]="${C_MAGENTA}[?]${C_RESET} Do you want to delete the existing folder and download it again? (y/n): "
    ["downloading_dvwa"]="${C_CYAN}[➜]${C_RESET} Downloading DVWA from GitHub..."
    ["continuing_without_download"]="${C_GREEN}[✓]${C_RESET} Continuing without downloading DVWA."
    ["invalid_response"]="${C_RED}[!] Error: Invalid response. Exiting the script.${C_RESET}"
    ["step_services"]="${C_BOLD}${C_MAGENTA}[3/5] Configuring Database & Services${C_RESET}"
    ["mariadb_already_enabled"]="${C_GREEN}[✓]${C_RESET} MariaDB service is already enabled."
    ["enabling_mariadb"]="${C_CYAN}[➜]${C_RESET} Enabling MariaDB service..."
    ["mariadb_already_running"]="${C_GREEN}[✓]${C_RESET} MariaDB service is already running."
    ["starting_mariadb"]="${C_CYAN}[➜]${C_RESET} Starting MariaDB service..."
    ["step_config"]="${C_BOLD}${C_MAGENTA}[4/5] Configuring Web Server & PHP${C_RESET}"
    ["configuring_dvwa"]="${C_CYAN}[➜]${C_RESET} Configuring DVWA configuration file..."
    ["configuring_permissions"]="${C_CYAN}[➜]${C_RESET} Configuring directory permissions..."
    ["configuring_php"]="${C_CYAN}[➜]${C_RESET} Configuring PHP directives..."
    ["php_config_not_found"]="${C_YELLOW}[!]${C_RESET} Warning: PHP configuration file not found in Apache or FPM folders."
    ["apache_already_enabled"]="${C_GREEN}[✓]${C_RESET} Apache service is already enabled."
    ["enabling_apache"]="${C_CYAN}[➜]${C_RESET} Enabling Apache service..."
    ["restarting_apache"]="${C_CYAN}[➜]${C_RESET} Restarting Apache service..."
    ["step_finalize"]="${C_BOLD}${C_MAGENTA}[5/5] Initializing Database & Finalizing${C_RESET}"
    ["initializing_database"]="${C_CYAN}[➜]${C_RESET} Initializing DVWA database tables..."
    ["installation_success_title"]="DVWA INSTALLED SUCCESSFULLY!"
    ["access_url_label"]="URL:"
    ["username_label"]="Username:"
    ["password_label"]="Password:"
    ["final_signature"]="${C_DIM}─── [ ${C_WHITE}Made with ${C_RED}♥${C_RESET} ${C_WHITE}by ${C_CYAN}${C_BOLD}IamCarron${C_RESET}${C_DIM} ] ───${C_RESET}"
)

# Spanish translations
es_strings=(
    ["error_missing_input"]="${C_RED}[!] Falta el parámetro: %s${C_RESET}"
    ["error_not_root"]="${C_RED}[!] Este script debe ejecutarse como usuario root.${C_RESET}"
    ["welcome_message"]="¡Bienvenido al instalador de DVWA!"
    ["script_name"]="Nombre del Script: Install-DVWA.sh"
    ["author"]="Autor: IamCarron"
    ["github_repo"]="GitHub Repo: https://github.com/IamCarron/DVWA-Script"
    ["installer_version"]="Versión del Instalador: 2.0"
    ["package_not_installed"]="${C_YELLOW}[➜]${C_RESET} %s no está instalado. Instalándolo ahora..."
    ["package_installed"]="${C_GREEN}[✓]${C_RESET} %s ¡Está instalado!"
    ["default_credentials"]="${C_CYAN}[i] Credenciales por defecto:${C_RESET}"
    ["password_prompt_info"]="Password: ${C_YELLOW}[Sin contraseña, solo presiona Enter]${C_RESET}"
    ["enter_sql_user"]="${C_MAGENTA}[?]${C_RESET} Ingrese el usuario de SQL: "
    ["enter_sql_password"]="${C_MAGENTA}[?]${C_RESET} Ingrese la contraseña de SQL (presiona Enter si no hay contraseña): "
    ["invalid_sql_credentials"]="${C_RED}[!] Error: Credenciales SQL inválidas. Por favor, compruebe su usuario y contraseña. Si estás intentando utilizar el usuario root y contraseña en blanco, asegúrate de ejecutar el script como root.${C_RESET}"
    ["sql_success"]="${C_GREEN}[✓]${C_RESET} Comandos SQL ejecutados con éxito."
    ["error_create_db"]="${C_RED}[!] Se ha producido un error al crear la base de datos DVWA.${C_RESET}"
    ["error_create_user"]="${C_RED}[!] Se ha producido un error al crear el usuario DVWA.${C_RESET}"
    ["error_grant_privileges"]="${C_RED}[!] Se ha producido un error al otorgar privilegios.${C_RESET}"
    ["step_dependencies"]="${C_BOLD}${C_MAGENTA}[1/5] Actualizando repositorios y dependencias${C_RESET}"
    ["updating_repos"]="${C_CYAN}[➜]${C_RESET} Actualizando repositorios..."
    ["verifying_dependencies"]="${C_CYAN}[➜]${C_RESET} Verificando e instalando dependencias necesarias..."
    ["step_download"]="${C_BOLD}${C_MAGENTA}[2/5] Descargando aplicación DVWA${C_RESET}"
    ["dvwa_folder_exists"]="${C_YELLOW}[!]${C_RESET} ¡Atención! La carpeta DVWA ya está creada."
    ["prompt_delete_folder"]="${C_MAGENTA}[?]${C_RESET} ¿Desea borrar la carpeta existente y descargarla de nuevo? (s/n): "
    ["downloading_dvwa"]="${C_CYAN}[➜]${C_RESET} Descargando DVWA desde GitHub..."
    ["continuing_without_download"]="${C_GREEN}[✓]${C_RESET} Continuando sin descargar DVWA."
    ["invalid_response"]="${C_RED}[!] ¡Error! Respuesta no válida. Saliendo del script.${C_RESET}"
    ["step_services"]="${C_BOLD}${C_MAGENTA}[3/5] Configurando base de datos y servicios${C_RESET}"
    ["mariadb_already_enabled"]="${C_GREEN}[✓]${C_RESET} El servicio MariaDB ya está habilitado."
    ["enabling_mariadb"]="${C_CYAN}[➜]${C_RESET} Habilitando MariaDB..."
    ["mariadb_already_running"]="${C_GREEN}[✓]${C_RESET} El servicio MariaDB ya está en ejecución."
    ["starting_mariadb"]="${C_CYAN}[➜]${C_RESET} Iniciando MariaDB..."
    ["step_config"]="${C_BOLD}${C_MAGENTA}[4/5] Configurando servidor web y PHP${C_RESET}"
    ["configuring_dvwa"]="${C_CYAN}[➜]${C_RESET} Configurando archivo de DVWA..."
    ["configuring_permissions"]="${C_CYAN}[➜]${C_RESET} Configurando permisos de directorios..."
    ["configuring_php"]="${C_CYAN}[➜]${C_RESET} Configurando directivas de PHP..."
    ["php_config_not_found"]="${C_YELLOW}[!]${C_RESET} Advertencia: No se encuentra el fichero de configuración PHP en las carpetas de Apache o FPM."
    ["apache_already_enabled"]="${C_GREEN}[✓]${C_RESET} El servicio Apache ya está habilitado."
    ["enabling_apache"]="${C_CYAN}[➜]${C_RESET} Habilitando Apache..."
    ["restarting_apache"]="${C_CYAN}[➜]${C_RESET} Reiniciando Apache..."
    ["step_finalize"]="${C_BOLD}${C_MAGENTA}[5/5] Inicializando base de datos y finalizando${C_RESET}"
    ["initializing_database"]="${C_CYAN}[➜]${C_RESET} Inicializando las tablas de la base de datos DVWA..."
    ["installation_success_title"]="¡DVWA INSTALADO CORRECTAMENTE!"
    ["access_url_label"]="URL:"
    ["username_label"]="Usuario:"
    ["password_label"]="Contraseña:"
    ["final_signature"]="${C_DIM}─── [ ${C_WHITE}Hecho con ${C_RED}♥${C_RESET} ${C_WHITE}por ${C_CYAN}${C_BOLD}IamCarron${C_RESET}${C_DIM} ] ───${C_RESET}"
)

# French translations
fr_strings=(
    ["error_missing_input"]="${C_RED}[!] Entrée manquante : %s${C_RESET}"
    ["error_not_root"]="${C_RED}[!] Ce script doit être exécuté par l'utilisateur root.${C_RESET}"
    ["welcome_message"]="Bienvenue à la configuration de DVWA !"
    ["script_name"]="Nom du script : Install-DVWA.sh"
    ["author"]="Auteur : IamCarron"
    ["github_repo"]="Repo Github : https://github.com/IamCarron/DVWA-Script"
    ["installer_version"]="Version de l'installateur : 2.0"
    ["package_not_installed"]="${C_YELLOW}[➜]${C_RESET} %s n'est pas installé. Installation en cours..."
    ["package_installed"]="${C_GREEN}[✓]${C_RESET} %s est installé !"
    ["default_credentials"]="${C_CYAN}[i] Identifiants par défaut :${C_RESET}"
    ["password_prompt_info"]="Mot de passe : ${C_YELLOW}[Pas de mot de passe, appuyez sur Entrée]${C_RESET}"
    ["enter_sql_user"]="${C_MAGENTA}[?]${C_RESET} Entrez l'utilisateur SQL : "
    ["enter_sql_password"]="${C_MAGENTA}[?]${C_RESET} Entrez le mot de passe SQL (appuyez sur Entrée pour aucun mot de passe) : "
    ["invalid_sql_credentials"]="${C_RED}[!] Erreur : Identifiants SQL invalides. Veuillez vérifier votre nom d'utilisateur et votre mot de passe. Si vous essayez d'utiliser l'utilisateur root et un mot de passe vide, assurez-vous d'exécuter le script en tant qu'utilisateur root.${C_RESET}"
    ["sql_success"]="${C_GREEN}[✓]${C_RESET} Commandes SQL exécutées avec succès."
    ["error_create_db"]="${C_RED}[!] Une erreur s'est produite lors de la création de la base de données DVWA.${C_RESET}"
    ["error_create_user"]="${C_RED}[!] Une erreur s'est produite lors de la création de l'utilisateur DVWA.${C_RESET}"
    ["error_grant_privileges"]="${C_RED}[!] Une erreur s'est produite lors de l'attribution des privilèges.${C_RESET}"
    ["step_dependencies"]="${C_BOLD}${C_MAGENTA}[1/5] Mise à jour des dépôts et dépendances${C_RESET}"
    ["updating_repos"]="${C_CYAN}[➜]${C_RESET} Mise à jour des dépôts..."
    ["verifying_dependencies"]="${C_CYAN}[➜]${C_RESET} Vérification et installation des dépendances nécessaires..."
    ["step_download"]="${C_BOLD}${C_MAGENTA}[2/5] Téléchargement de l'application DVWA${C_RESET}"
    ["dvwa_folder_exists"]="${C_YELLOW}[!]${C_RESET} Attention ! Le dossier DVWA est déjà créé."
    ["prompt_delete_folder"]="${C_MAGENTA}[?]${C_RESET} Voulez-vous supprimer le dossier existant et le télécharger à nouveau (o/n) : "
    ["downloading_dvwa"]="${C_CYAN}[➜]${C_RESET} Téléchargement de DVWA depuis GitHub..."
    ["continuing_without_download"]="${C_GREEN}[✓]${C_RESET} Continuation sans télécharger DVWA."
    ["invalid_response"]="${C_RED}[!] Erreur ! Réponse invalide. Sortie du script.${C_RESET}"
    ["step_services"]="${C_BOLD}${C_MAGENTA}[3/5] Configuration de la base de données et services${C_RESET}"
    ["mariadb_already_enabled"]="${C_GREEN}[✓]${C_RESET} Le service MariaDB est déjà activé."
    ["enabling_mariadb"]="${C_CYAN}[➜]${C_RESET} Activation de MariaDB..."
    ["mariadb_already_running"]="${C_GREEN}[✓]${C_RESET} Le service MariaDB est déjà en cours d'exécution."
    ["starting_mariadb"]="${C_CYAN}[➜]${C_RESET} Démarrage de MariaDB..."
    ["step_config"]="${C_BOLD}${C_MAGENTA}[4/5] Configuration du serveur web et PHP${C_RESET}"
    ["configuring_dvwa"]="${C_CYAN}[➜]${C_RESET} Configuration du fichier DVWA..."
    ["configuring_permissions"]="${C_CYAN}[➜]${C_RESET} Configuration des permissions des répertoires..."
    ["configuring_php"]="${C_CYAN}[➜]${C_RESET} Configuration de PHP..."
    ["php_config_not_found"]="${C_YELLOW}[!]${C_RESET} Avertissement : Fichier de configuration PHP non trouvé dans les dossiers Apache ou FPM."
    ["apache_already_enabled"]="${C_GREEN}[✓]${C_RESET} Le service Apache est déjà activé."
    ["enabling_apache"]="${C_CYAN}[➜]${C_RESET} Activation d'Apache..."
    ["restarting_apache"]="${C_CYAN}[➜]${C_RESET} Redémarrage d'Apache..."
    ["step_finalize"]="${C_BOLD}${C_MAGENTA}[5/5] Initialisation de la base de données et finalisation${C_RESET}"
    ["initializing_database"]="${C_CYAN}[➜]${C_RESET} Initialisation des tables de la base de données DVWA..."
    ["installation_success_title"]="DVWA A ÉTÉ INSTALLÉ AVEC SUCCÈS !"
    ["access_url_label"]="URL :"
    ["username_label"]="Identifiant :"
    ["password_label"]="Mot de passe :"
    ["final_signature"]="${C_DIM}─── [ ${C_WHITE}Créé avec ${C_RED}♥${C_RESET} ${C_WHITE}par ${C_CYAN}${C_BOLD}IamCarron${C_RESET}${C_DIM} ] ───${C_RESET}"
)

# Function to get translation
get_translation() {
    local key="$1"
    local target_lang="$2"
    local translation

    case "$target_lang" in
        es) translation="${es_strings[$key]}" ;;
        fr) translation="${fr_strings[$key]}" ;;
        *)  translation="${en_strings[$key]}" ;;
    esac

    # If translation is empty, fall back to English
    if [[ -z "$translation" ]]; then
        translation="${en_strings[$key]}"
    fi

    echo "$translation"
}

# Check if the user is root
if [ "$EUID" -ne 0 ]; then
    echo -e "$(get_translation "error_not_root" "$lang")"
    exit 1
fi

if [[ -n "$batch_mode" ]]; then
    [[ -z "${sql_user+x}" ]] && echo -e "$(printf "$(get_translation "error_missing_input" "$lang")" "sql_user")" && exit 1
    [[ -z "${sql_password+x}" ]] && echo -e "$(printf "$(get_translation "error_missing_input" "$lang")" "sql_password")" && exit 1
    [[ -z "${force_download+x}" ]] && echo -e "$(printf "$(get_translation "error_missing_input" "$lang")" "force_download")" && exit 1
fi

# Function for printing dynamic width borders
print_border() {
    local left="$1"
    local fill="$2"
    local right="$3"
    local len="$4"
    local border=""
    for ((i=0; i<len; i++)); do border+="$fill"; done
    printf "%s%s%s\n" "$left" "$border" "$right"
}

# Function for centering text on a line of specified length
center_text() {
    local text="$1"
    local line_length="$2"
    local text_length=${#text}
    local padding_before=$(( (line_length - text_length) / 2 ))
    local padding_after=$(( line_length - text_length - padding_before ))

    printf "%s%*s%s%*s%s\n" "║" "$padding_before" "" "$text" "$padding_after" "" "║"
}

# Function for left-aligned row in a box
box_row() {
    local text="$1"
    local line_length="$2"
    local text_length=${#text}
    local padding=$(( line_length - text_length ))

    printf "%s%s%*s%s\n" "║" "$text" "$padding" "" "║"
}

line_length=60

# Cyberpunk ASCII Art with Duo-tone Gradient
echo -e "${C_MAGENTA}${C_BOLD}
                  ██████╗ ██╗   ██╗██╗    ██╗ █████╗
                  ██╔══██╗██║   ██║██║    ██║██╔══██╗
                  ██║  ██║██║   ██║██║ █╗ ██║███████║
                  ██║  ██║╚██╗ ██╔╝██║███╗██║██╔══██║
                  ██████╔╝ ╚████╔╝ ╚███╔███╔╝██║  ██║
                  ╚═════╝   ╚═══╝   ╚══╝╚══╝ ╚═╝  ╚═╝
${C_CYAN}
  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
  ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
  ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
${C_RESET}"
echo
echo -e -n "${C_MAGENTA}"
print_border "╔" "═" "╗" "$line_length"
center_text "$(get_translation "welcome_message" "$lang")" "$line_length"
center_text "$(get_translation "script_name" "$lang")" "$line_length"
center_text "$(get_translation "author" "$lang")" "$line_length"
center_text "$(get_translation "github_repo" "$lang")" "$line_length"
center_text "$(get_translation "installer_version" "$lang")" "$line_length"
print_border "╚" "═" "╝" "$line_length"
echo -e -n "${C_RESET}"
echo

# Service Manager Abstraction (systemd -> service -> /etc/init.d fallback)
has_systemd() {
    [ -d /run/systemd/system ] && command -v systemctl &>/dev/null
}

svc_is_running() {
    local svc="$1"
    if has_systemd; then
        systemctl is-active --quiet "$svc"
    elif command -v service &>/dev/null; then
        service "$svc" status &>/dev/null
    elif [ -x "/etc/init.d/$svc" ]; then
        "/etc/init.d/$svc" status &>/dev/null
    else
        pgrep -f "$svc" &>/dev/null
    fi
}

svc_is_enabled() {
    local svc="$1"
    if has_systemd; then
        systemctl is-enabled "$svc" &>/dev/null
    else
        ls /etc/rc*.d/S*"$svc"* &>/dev/null
    fi
}

svc_enable() {
    local svc="$1"
    if has_systemd; then
        systemctl enable "$svc" &>/dev/null
    elif command -v update-rc.d &>/dev/null; then
        update-rc.d "$svc" defaults &>/dev/null
    elif command -v chkconfig &>/dev/null; then
        chkconfig "$svc" on &>/dev/null
    fi
}

svc_start() {
    local svc="$1"
    if has_systemd; then
        systemctl start "$svc" &>/dev/null
    elif command -v service &>/dev/null; then
        service "$svc" start &>/dev/null
    elif [ -x "/etc/init.d/$svc" ]; then
        "/etc/init.d/$svc" start &>/dev/null
    fi
}

svc_restart() {
    local svc="$1"
    if has_systemd; then
        systemctl restart "$svc" &>/dev/null
    elif command -v service &>/dev/null; then
        service "$svc" restart &>/dev/null
    elif [ -x "/etc/init.d/$svc" ]; then
        "/etc/init.d/$svc" restart &>/dev/null
    fi
}

# Function to verify the existence of a program
check_program() {
    if ! dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"; then
        echo -e "$(printf "$(get_translation "package_not_installed" "$lang")" "$1")"
        apt install -y "$1"
    else
        echo -e "$(printf "$(get_translation "package_installed" "$lang")" "$1")"
    fi
}

sql_commands() {
    local user="$1"
    local pass="$2"
    local mysql_cmd=(mysql -u"$user")

    if [[ -n "$pass" ]]; then
        mysql_cmd+=(-p"$pass")
    fi

    # Check if the database already exists
    if ! "${mysql_cmd[@]}" -e "CREATE DATABASE IF NOT EXISTS dvwa;"; then
        echo -e "$(get_translation "error_create_db" "$lang")"
        return 1
    fi

    # Check if the user already exists
    if ! "${mysql_cmd[@]}" -e "CREATE USER IF NOT EXISTS 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';"; then
        echo -e "$(get_translation "error_create_user" "$lang")"
        return 1
    fi

    # Grant privileges to the user
    if ! "${mysql_cmd[@]}" -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost'; FLUSH PRIVILEGES;"; then
        echo -e "$(get_translation "error_grant_privileges" "$lang")"
        return 1
    fi

    return 0
}

run_sql_commands() {
    while true; do
        echo -e "\n$(get_translation "default_credentials" "$lang")"
        echo -e "Username: ${C_YELLOW}root${C_RESET}"
        if [[ -z "$batch_mode" ]]; then
            echo -e "\n$(get_translation "password_prompt_info" "$lang")"
            echo -e -n "$(get_translation "enter_sql_user" "$lang")"
            read -r sql_user
            sql_user=${sql_user:-root}
            echo -e -n "$(get_translation "enter_sql_password" "$lang")"
            read -r -s sql_password
        fi
        echo

        # Verify if credentials are valid before executing SQL commands
        local mysql_test_cmd=(mysql -u"$sql_user")
        if [[ -n "$sql_password" ]]; then
            mysql_test_cmd+=(-p"$sql_password")
        fi

        if ! "${mysql_test_cmd[@]}" -e ";" &>/dev/null; then
            echo -e "\n$(get_translation "invalid_sql_credentials" "$lang")"
            if [[ -n "$batch_mode" ]]; then
                exit 1
            fi
        else
            break
        fi
    done

    # Execute SQL commands and check success directly
    if sql_commands "$sql_user" "$sql_password"; then
        echo -e "$(get_translation "sql_success" "$lang")"
    else
        exit 1
    fi
}

# -------------------------------------------------------------
# STAGE 1: Update Repositories & Dependencies
# -------------------------------------------------------------
echo -e "\n$(get_translation "step_dependencies" "$lang")"
echo -e "$(get_translation "updating_repos" "$lang")"
apt update

echo -e "\n$(get_translation "verifying_dependencies" "$lang")"
dependencies=(
    apache2
    mariadb-server
    mariadb-client
    php
    php-mysql
    php-gd
    libapache2-mod-php
    git
    curl
)

for package in "${dependencies[@]}"; do
    check_program "$package"
done

# -------------------------------------------------------------
# STAGE 2: Download DVWA Repository
# -------------------------------------------------------------
echo -e "\n$(get_translation "step_download" "$lang")"
if [ -d "/var/www/html/DVWA" ]; then
    echo -e "$(get_translation "dvwa_folder_exists" "$lang")"

    if [[ -z "$batch_mode" ]]; then
        echo -e -n "$(get_translation "prompt_delete_folder" "$lang")"
        read -r force_download
    fi

    if [[ "$force_download" == "s" || "$force_download" == "y" || "$force_download" == "o" ]]; then
        rm -rf /var/www/html/DVWA
        echo -e "$(get_translation "downloading_dvwa" "$lang")"
        git clone --depth=1 https://github.com/digininja/DVWA.git /var/www/html/DVWA
        sleep 2
    elif [[ "$force_download" == "n" ]]; then
        echo -e "$(get_translation "continuing_without_download" "$lang")"
    else
        echo -e "$(get_translation "invalid_response" "$lang")"
        exit 1
    fi
else
    echo -e "$(get_translation "downloading_dvwa" "$lang")"
    git clone --depth=1 https://github.com/digininja/DVWA.git /var/www/html/DVWA
    sleep 2
fi

# -------------------------------------------------------------
# STAGE 3: Configure Services & Database
# -------------------------------------------------------------
echo -e "\n$(get_translation "step_services" "$lang")"
if svc_is_enabled mariadb || svc_is_enabled mysql; then
    echo -e "$(get_translation "mariadb_already_enabled" "$lang")"
else
    echo -e "$(get_translation "enabling_mariadb" "$lang")"
    svc_enable mariadb || svc_enable mysql
    sleep 2
fi

if svc_is_running mariadb || svc_is_running mysql; then
    echo -e "$(get_translation "mariadb_already_running" "$lang")"
else
    echo -e "$(get_translation "starting_mariadb" "$lang")"
    svc_start mariadb || svc_start mysql
    sleep 2
fi

run_sql_commands
sleep 2

# -------------------------------------------------------------
# STAGE 4: Web Server & PHP Configuration
# -------------------------------------------------------------
echo -e "\n$(get_translation "step_config" "$lang")"
echo -e "$(get_translation "configuring_dvwa" "$lang")"
cp /var/www/html/DVWA/config/config.inc.php.dist /var/www/html/DVWA/config/config.inc.php
sleep 2

echo -e "$(get_translation "configuring_permissions" "$lang")"
chown -R www-data:www-data /var/www/html/DVWA
chmod -R 755 /var/www/html/DVWA
sleep 2

echo -e "$(get_translation "configuring_php" "$lang")"
php_version=$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;')
php_config_file_apache="/etc/php/${php_version}/apache2/php.ini"
php_config_file_fpm="/etc/php/${php_version}/fpm/php.ini"

php_target_file=""
if [ -f "$php_config_file_apache" ]; then
    php_target_file="$php_config_file_apache"
elif [ -f "$php_config_file_fpm" ]; then
    php_target_file="$php_config_file_fpm"
else
    echo -e "$(get_translation "php_config_not_found" "$lang")"
fi

if [ -n "$php_target_file" ]; then
    sed -i \
        -e 's/^\(allow_url_include =\).*/\1 on/' \
        -e 's/^\(allow_url_fopen =\).*/\1 on/' \
        -e 's/^\(display_errors =\).*/\1 on/' \
        -e 's/^\(display_startup_errors =\).*/\1 on/' \
        -e 's/^;\{0,1\}[[:space:]]*pcre\.jit[[:space:]]*=.*/pcre.jit = 0/' \
        "$php_target_file"
    if ! grep -q "^pcre\.jit = 0" "$php_target_file"; then
        echo "pcre.jit = 0" >> "$php_target_file"
    fi
fi
sleep 2

if svc_is_enabled apache2; then
    echo -e "$(get_translation "apache_already_enabled" "$lang")"
else
    echo -e "$(get_translation "enabling_apache" "$lang")"
    svc_enable apache2
    sleep 2
fi

echo -e "$(get_translation "restarting_apache" "$lang")"
svc_restart apache2
sleep 2

# -------------------------------------------------------------
# STAGE 5: Initialize Database Tables & Summary
# -------------------------------------------------------------
echo -e "\n$(get_translation "step_finalize" "$lang")"
echo -e "$(get_translation "initializing_database" "$lang")"
cookie_file=$(mktemp)
setup_html=$(curl -s -c "$cookie_file" http://localhost/DVWA/setup.php || true)
user_token=$(echo "$setup_html" | sed -n "s/.*name=['\"]user_token['\"] value=['\"]\([^'\"]*\)['\"].*/\1/p")

if [[ -n "$user_token" ]]; then
    curl -s -b "$cookie_file" -d "create_db=Create+%2F+Reset+Database&user_token=${user_token}" http://localhost/DVWA/setup.php &>/dev/null || true
fi
rm -f "$cookie_file"
sleep 1

# Display Final Summary Card
echo
echo -e -n "${C_GREEN}"
print_border "╔" "═" "╗" "$line_length"
center_text "$(get_translation "installation_success_title" "$lang")" "$line_length"
print_border "╠" "═" "╣" "$line_length"
center_text "" "$line_length"
if [[ "$lang" == "es" ]]; then
    box_row "   URL:          http://localhost/DVWA" "$line_length"
    box_row "   Usuario:      admin" "$line_length"
    box_row "   Contraseña:   password" "$line_length"
elif [[ "$lang" == "fr" ]]; then
    box_row "   URL :         http://localhost/DVWA" "$line_length"
    box_row "   Identifiant : admin" "$line_length"
    box_row "   Mot de passe : password" "$line_length"
else
    box_row "   URL:          http://localhost/DVWA" "$line_length"
    box_row "   Username:     admin" "$line_length"
    box_row "   Password:     password" "$line_length"
fi
center_text "" "$line_length"
print_border "╚" "═" "╝" "$line_length"
echo -e -n "${C_RESET}"
echo
echo -e "           $(get_translation "final_signature" "$lang")"
echo
