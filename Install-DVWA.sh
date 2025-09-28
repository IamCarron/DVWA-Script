#!/bin/bash

# Get language prefix
if [ -z "$LC_MESSAGES" ]; then
    lang="en"
else
    lang="${LC_MESSAGES:0:2}"
fi

# Declare associative arrays for translations
declare -A en_strings
declare -A es_strings
declare -A fr_strings

batch_mode=${batch_mode:-""}

# English translations
en_strings=(
    ["error_missing_input"]="\033[91mMissing input %s.\033[0m"
    ["error_not_root"]="\033[91mThis script must be run by the root user.\033[0m"
    ["welcome_message"]="Welcome to the DVWA setup!"
    ["script_name"]="Script Name: Install-DVWA.sh "
    ["author"]="Author: IamCarron "
    ["github_repo"]="Github Repo: https://github.com/IamCarron/DVWA-Script"
    ["installer_version"]="Installer Version: 1.0.5 "
    ["package_not_installed"]="\033[91m%s is not installed. Installing it now...\033[0m"
    ["package_installed"]="\033[92m%s is installed!\033[0m"
    ["default_credentials"]="\033[96mDefault credentials:\033[0m"
    ["password_prompt_info"]="Password: \033[93m[No password just hit Enter]\033[0m"
    ["enter_sql_user"]="\033[96mEnter SQL user:\033[0m"
    ["enter_sql_password"]="\033[96mEnter SQL password (press Enter for no password):\033[0m"
    ["invalid_sql_credentials"]="\033[91mError: Invalid SQL credentials. Please check your username and password. If you are trying to use root user and blank password make sure that you are running the script as root user.\033[0m"
    ["sql_success"]="\033[92mSQL commands executed successfully.\033[0m"
    ["error_create_db"]="\033[91mAn error occurred while creating the DVWA database.\033[0m"
    ["error_create_user"]="\033[91mAn error occurred while creating the DVWA user.\033[0m"
    ["error_grant_privileges"]="\033[91mAn error occurred while granting privileges.\033[0m"
    ["updating_repos"]="\033[96mUpdating repositories...\033[0m"
    ["verifying_dependencies"]="\033[96mVerifying and installing necessary dependencies...\033[0m"
    ["dvwa_folder_exists"]="\033[91mAttention! The DVWA folder is already created.\033[0m"
    ["prompt_delete_folder"]="\033[96mDo you want to delete the existing folder and download it again (y/n):\033[0m"
    ["downloading_dvwa"]="\033[96mDownloading DVWA from GitHub...\033[0m"
    ["continuing_without_download"]="\033[96mContinuing without downloading DVWA.\033[0m"
    ["invalid_response"]="\033[91mError! Invalid response. Exiting the script.\033[0m"
    ["mariadb_already_enabled"]="\033[92mMariaDB service is already enabled.\033[0m"
    ["enabling_mariadb"]="\033[96mEnabling MariaDB...\033[0m"
    ["mariadb_already_running"]="\033[92mMariaDB service is already running.\033[0m"
    ["starting_mariadb"]="\033[96mStarting MariaDB...\033[0m"
    ["configuring_dvwa"]="\033[96mConfiguring DVWA...\033[0m"
    ["configuring_permissions"]="\033[96mConfiguring permissions...\033[0m"
    ["configuring_php"]="\033[96mConfiguring PHP...\033[0m"
    ["php_config_not_found"]="\033[91mWarning: PHP configuration file not found in Apache or FPM folders.\033[0m"
    ["apache_already_enabled"]="\033[92mApache service is already enabled.\033[0m"
    ["enabling_apache"]="\033[96mEnabling Apache...\033[0m"
    ["restarting_apache"]="\033[96mRestarting Apache...\033[0m"
    ["installation_success"]="\033[92mDVWA has been installed successfully. Access \033[93mhttp://localhost/DVWA\033[0m \033[92mto get started.\033[0m"
    ["credentials"]="\033[92mCredentials:\033[0m"
    ["final_signature"]="\033[95mWith ♡ by IamCarron\033[0m"
)

# Spanish translations
es_strings=(
    ["error_not_root"]="\033[91mEste script debe ejecutarse como usuario root.\033[0m"
    ["welcome_message"]="¡Bienvenido al instalador de DVWA!"
    ["script_name"]="Nombre del Script: Install-DVWA.sh "
    ["author"]="Autor: IamCarron "
    ["github_repo"]="GitHub Repo: https://github.com/IamCarron/DVWA-Script"
    ["installer_version"]="Versión del Instalador: 1.0.5 "
    ["package_not_installed"]="\033[91m%s no está instalado. Instalándolo ahora...\033[0m"
    ["package_installed"]="\033[92m%s !Está instalado!\033[0m"
    ["default_credentials"]="\033[96mCredenciales por defecto:\033[0m"
    ["password_prompt_info"]="Password: \033[93m[Sin contraseña solo presiona Enter.]\033[0m"
    ["enter_sql_user"]="\033[96mIngrese el usuario de SQL:\033[0m"
    ["enter_sql_password"]="\033[96mIngrese la contraseña de SQL (presiona Enter si no hay contraseña):\033[0m"
    ["invalid_sql_credentials"]="\033[91mError: Credenciales SQL inválidas. Por favor, compruebe su nombre de usuario y contraseña. Si usted estas intentando de utilizar el usuario root y la contraseña en blanco asegúrate de que estas ejecutando el script como usuario root.\033[0m"
    ["sql_success"]="\033[92mComandos SQL ejecutados con éxito.\033[0m"
    ["error_create_db"]="\033[91mSe ha producido un error al crear la base de datos DVWA.\033[0m"
    ["error_create_user"]="\033[91mSe ha producido un error al crear el usuario DVWA.\033[0m"
    ["error_grant_privileges"]="\033[91mSe ha producido un error al otorgar privilegios.\033[0m"
    ["updating_repos"]="\033[96mActualizando repositorios...\033[0m"
    ["verifying_dependencies"]="\033[96mVerificando e instalando dependencias necesarias...\033[0m"
    ["dvwa_folder_exists"]="\033[91m¡Atención! La carpeta DVWA ya está creada.\033[0m"
    ["prompt_delete_folder"]="\033[96m¿Desea borrar la carpeta existente y descargarla de nuevo? (s/n):\033[0m"
    ["downloading_dvwa"]="\033[96mDescargando DVWA desde GitHub...\033[0m"
    ["continuing_without_download"]="\033[96mContinuando sin descargar DVWA.\033[0m"
    ["invalid_response"]="\033[91m¡Error! Respuesta no válida. Saliendo del script.\033[0m"
    ["mariadb_already_enabled"]="\033[92mEl servicio MariaDB ya está en habilitado.\033[0m"
    ["enabling_mariadb"]="\033[96mHabilitando MariaDB...\033[0m"
    ["mariadb_already_running"]="\033[92mEl servicio MariaDB ya está en ejecución.\033[0m"
    ["starting_mariadb"]="\033[96mIniciando MariaDB...\033[0m"
    ["configuring_dvwa"]="\033[96mConfigurando DVWA...\033[0m"
    ["configuring_permissions"]="\033[96mConfigurando permisos...\033[0m"
    ["configuring_php"]="\033[96mConfigurando PHP...\033[0m"
    ["php_config_not_found"]="\033[91mAdvertencia: No se encuentra el fichero de configuración PHP en las carpetas de Apache o FPM.\033[0m"
    ["apache_already_enabled"]="\033[92mEl servicio Apache ya está en habilitado.\033[0m"
    ["enabling_apache"]="\033[96mHabilitando Apache...\033[0m"
    ["restarting_apache"]="\033[96mReiniciando Apache...\033[0m"
    ["installation_success"]="\033[92mDVWA se ha instalado correctamente. Accede a \033[93mhttp://localhost/DVWA\033[0m \033[92mpara comenzar.\033[0m"
    ["credentials"]="\033[92mCredentials:\033[0m"
    ["final_signature"]="\033[95mCon ♡ by IamCarron"
)

# French translations
fr_strings=(
    ["error_not_root"]="\033[91mCe script doit être exécuté par l'utilisateur root.\033[0m"
    ["welcome_message"]="Bienvenue à la configuration de DVWA !"
    ["script_name"]="Nom du script : Install-DVWA.sh "
    ["author"]="Auteur : IamCarron "
    ["github_repo"]="Repo Github : https://github.com/IamCarron/DVWA-Script"
    ["installer_version"]="Version de l'installateur : 1.0.5 "
    ["package_not_installed"]="\033[91m%s n'est pas installé. Installation en cours...\033[0m"
    ["package_installed"]="\033[92m%s est installé !\033[0m"
    ["default_credentials"]="\033[96mIdentifiants par défaut :\033[0m"
    ["password_prompt_info"]="Mot de passe : \033[93m[Pas de mot de passe, appuyez simplement sur Entrée]\033[0m"
    ["enter_sql_user"]="\033[96mEntrez l'utilisateur SQL :\033[0m"
    ["enter_sql_password"]="\033[96mEntrez le mot de passe SQL (appuyez sur Entrée pour aucun mot de passe) :\033[0m"
    ["invalid_sql_credentials"]="\033[91mErreur : Identifiants SQL invalides. Veuillez vérifier votre nom d'utilisateur et votre mot de passe. Si vous essayez d'utiliser l'utilisateur root et un mot de passe vide, assurez-vous d'exécuter le script en tant qu'utilisateur root.\033[0m"
    ["sql_success"]="\033[92mCommandes SQL exécutées avec succès.\033[0m"
    ["error_create_db"]="\033[91mUne erreur s'est produite lors de la création de la base de données DVWA.\033[0m"
    ["error_create_user"]="\033[91mUne erreur s'est produite lors de la création de l'utilisateur DVWA.\033[0m"
    ["error_grant_privileges"]="\033[91mUne erreur s'est produite lors de l'attribution des privilèges.\033[0m"
    ["updating_repos"]="\033[96mMise à jour des dépôts...\033[0m"
    ["verifying_dependencies"]="\033[96mVérification et installation des dépendances nécessaires...\033[0m"
    ["dvwa_folder_exists"]="\033[91mAttention ! Le dossier DVWA est déjà créé.\033[0m"
    ["prompt_delete_folder"]="\033[96mVoulez-vous supprimer le dossier existant et le télécharger à nouveau (o/n) :\033[0m"
    ["downloading_dvwa"]="\033[96mTéléchargement de DVWA depuis GitHub...\033[0m"
    ["continuing_without_download"]="\033[96mContinuation sans télécharger DVWA.\033[0m"
    ["invalid_response"]="\033[91mErreur ! Réponse invalide. Sortie du script.\033[0m"
    ["mariadb_already_enabled"]="\033[92mLe service MariaDB est déjà activé.\033[0m"
    ["enabling_mariadb"]="\033[96mActivation de MariaDB...\033[0m"
    ["mariadb_already_running"]="\033[92mLe service MariaDB est déjà en cours d'exécution.\033[0m"
    ["starting_mariadb"]="\033[96mDémarrage de MariaDB...\033[0m"
    ["configuring_dvwa"]="\033[96mConfiguration de DVWA...\033[0m"
    ["configuring_permissions"]="\033[96mConfiguration des permissions...\033[0m"
    ["configuring_php"]="\033[96mConfiguration de PHP...\033[0m"
    ["php_config_not_found"]="\033[91mAvertissement : Fichier de configuration PHP non trouvé dans les dossiers Apache ou FPM.\033[0m"
    ["apache_already_enabled"]="\033[92mLe service Apache est déjà activé.\033[0m"
    ["enabling_apache"]="\033[96mActivation d'Apache...\033[0m"
    ["restarting_apache"]="\033[96mRedémarrage d'Apache...\033[0m"
    ["installation_success"]="\033[92mDVWA a été installé avec succès. Accédez à \033[93mhttp://localhost/DVWA\033[0m \033[92mpour commencer.\033[0m"
    ["credentials"]="\033[92mIdentifiants :\033[0m"
    ["final_signature"]="\033[95mAvec ♡ par IamCarron"
)

# Function to get translation
get_translation() {
    local key="$1"
    local lang="$2"
    local translation

    case "$lang" in
        es) translation="${es_strings[$key]}" ;;
        fr) translation="${fr_strings[$key]}" ;;
        *) translation="${en_strings[$key]}" ;;
    esac

    # If translation is empty, fall back to English
    if [[ -z "$translation" ]]; then
        translation="${en_strings[$key]}"
    fi

    echo "$translation"
}

# Check if the user is root
if [ "$EUID" -ne 0 ]; then
    error_message="$(get_translation "error_not_root" "$lang")"
    echo -e "$error_message"
    exit 1
fi

if [[ -n "$batch_mode" ]]; then
    [[ ! -v "sql_user" ]] && echo -e "$(printf "$(get_translation "error_missing_input" "$lang")" "sql_user")" && exit 1
    [[ ! -v "sql_password" ]] && echo -e "$(printf "$(get_translation "error_missing_input" "$lang")" "sql_password")" && exit 1
    [[ ! -v "force_download" ]] && echo -e "$(printf "$(get_translation "error_missing_input" "$lang")" "force_download")" && exit 1
fi

# Function for centering text on a line of specified length
center_text() {
    local text="$1"
    local line_length="$2"
    local text_length=${#text}
    local padding_before=$(( (line_length - text_length) / 2 ))
    local padding_after=$(( line_length - text_length - padding_before ))

    printf "%s%-${padding_before}s%s%-*s%s\n" "║" " " "$text" "$padding_after" " " "║"
}

# Desired line length
line_length=60

# ASCII Art
echo -e "\033[96m\033[1m
                  ██████╗ ██╗   ██╗██╗    ██╗ █████╗
                  ██╔══██╗██║   ██║██║    ██║██╔══██╗
                  ██║  ██║██║   ██║██║ █╗ ██║███████║
                  ██║  ██║╚██╗ ██╔╝██║███╗██║██╔══██║
                  ██████╔╝ ╚████╔╝ ╚███╔███╔╝██║  ██║
                  ╚═════╝   ╚═══╝   ╚══╝╚══╝ ╚═╝  ╚═╝

  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
  ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
  ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
\033[0m"
echo
echo -e "\033[92m╓────────────────────────────────────────────────────────────╖"
center_text "$(get_translation "welcome_message" "$lang")" "$line_length"
center_text "$(get_translation "script_name" "$lang")" "$line_length"
center_text "$(get_translation "author" "$lang")" "$line_length"
center_text "$(get_translation "github_repo" "$lang")" "$line_length"
center_text "$(get_translation "installer_version" "$lang")" "$line_length"
echo -e "╙────────────────────────────────────────────────────────────╜\033[0m"
echo

# Function to verify the existence of a program
check_program() {
    if ! dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -q "install ok installed"; then
        message="$(get_translation "package_not_installed" "$lang")"
        echo -e "$(printf "$message" "$1")"
        apt install -y "$1"
    else
        success_message="$(get_translation "package_installed" "$lang")"
        echo -e "$(printf "$success_message" "$1")"
    fi
}

run_sql_commands() {
    # local sql_user
    # local sql_password

    while true; do
        echo -e "\n$(get_translation "default_credentials" "$lang")"
        echo -e "Username: \033[93mroot\033[0m"
        if [[ -z "$batch_mode" ]]; then
            echo -e "\n$(get_translation "password_prompt_info" "$lang")"
            echo -e -n "$(get_translation "enter_sql_user" "$lang")"
            read sql_user
            # Set root as default user for unattended installations.
            sql_user=${sql_user:-root}
            echo -e -n "$(get_translation "enter_sql_password" "$lang")"
            read -s sql_password
        fi
        echo
        # Verify if credentials are valid before executing SQL commands
        if ! mysql -u "$sql_user" -p"$sql_password" -e ";" &>/dev/null; then
            echo -e "\n$(get_translation "invalid_sql_credentials" "$lang")"
        else
            break
        fi
    done

    local success=false
    while [ "$success" != true ]; do
        # Execute SQL commands
        sql_commands_output=$(sql_commands "$sql_user" "$sql_password")

        if [ $? -eq 0 ]; then
            echo -e "$(get_translation "sql_success" "$lang")"
            success=true
        else
            if [ "$recreate_choice" != "no" ]; then
                break
            fi
        fi
    done
}

sql_commands() {
    local sql_user="$1"
    local sql_password="$2"
    local sql_command="mysql -u$sql_user"

    if [ -n "$sql_password" ]; then
        sql_command+=" -p$sql_password"
    fi

    # Check if the database already exists
    if ! $sql_command -e "CREATE DATABASE IF NOT EXISTS dvwa;"; then
        echo -e "$(get_translation "error_create_db" "$lang")"
        return 1
    fi

    # Check if the user already exists
    if ! $sql_command -e "CREATE USER IF NOT EXISTS 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';"; then
        echo -e "$(get_translation "error_create_user" "$lang")"
        return 1
    fi

    # Grant privileges to the user
    if ! $sql_command -e "GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'localhost'; FLUSH PRIVILEGES;"; then
        echo -e "$(get_translation "error_grant_privileges" "$lang")"
        return 1
    fi

    echo 0
}

# Installer startup

# Update repositories
echo -e "$(get_translation "updating_repos" "$lang")"
apt update

# Check if the dependencies are installed
echo -e "$(get_translation "verifying_dependencies" "$lang")"

check_program apache2
check_program mariadb-server
check_program mariadb-client
check_program php
check_program php-mysql
check_program php-gd
check_program libapache2-mod-php
check_program git

# Download DVWA repository from GitHub

# Checking if the folder already exists
if [ -d "/var/www/html/DVWA" ]; then
    # The folder already exists
    echo -e "$(get_translation "dvwa_folder_exists" "$lang")"

    # Ask the user what action to take
    if [[ -z "$batch_mode" ]]; then
        echo -e -n "$(get_translation "prompt_delete_folder" "$lang")"
        read force_download
    fi

    if [[ "$force_download" == "s" || "$force_download" == "y" || "$force_download" == "o" ]]; then  # Added "o" for French oui
        # Delete existing folder
        rm -rf /var/www/html/DVWA

        # Download DVWA from GitHub
        echo -e "$(get_translation "downloading_dvwa" "$lang")"
        git clone https://github.com/digininja/DVWA.git /var/www/html/DVWA
        sleep 2
    elif [[ "$force_download" == "n" ]]; then
        # User chooses not to download
        echo -e "$(get_translation "continuing_without_download" "$lang")"
    else
        # Invalid answer
        echo -e "$(get_translation "invalid_response" "$lang")"
        exit 1
    fi
else
    # Folder does not exist, download DVWA from GitHub
    echo -e "$(get_translation "downloading_dvwa" "$lang")"
    git clone https://github.com/digininja/DVWA.git /var/www/html/DVWA
    sleep 2
fi

# Check if MariaDB is already enabled
if systemctl is-enabled mariadb.service &>/dev/null; then
    echo -e "$(get_translation "mariadb_already_enabled" "$lang")"
else
    # Enable MariaDB
    echo -e "$(get_translation "enabling_mariadb" "$lang")"
    systemctl enable mariadb.service &>/dev/null
    sleep 2
fi

# Check if MariaDB is already started
if systemctl is-active --quiet mariadb.service; then
    echo -e "$(get_translation "mariadb_already_running" "$lang")"
else
    # Start MariaDB
    echo -e "$(get_translation "starting_mariadb" "$lang")"
    systemctl start mariadb.service
    sleep 2
fi

# Call the function
run_sql_commands
sleep 2

# Copying DVWA config to /var/www/html
echo -e "$(get_translation "configuring_dvwa" "$lang")"
cp /var/www/html/DVWA/config/config.inc.php.dist /var/www/html/DVWA/config/config.inc.php
sleep 2

# Assign the appropriate permissions to DVWA
echo -e "$(get_translation "configuring_permissions" "$lang")"
chown -R www-data:www-data /var/www/html/DVWA
chmod -R 755 /var/www/html/DVWA
sleep 2

echo -e "$(get_translation "configuring_php" "$lang")"
# Trying to find the php.ini file in the Apache folder
php_config_file_apache="/etc/php/$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;')/apache2/php.ini"

# Trying to find the php.ini file in the FPM folder
php_config_file_fpm="/etc/php/$(php -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;')/fpm/php.ini"

# Check if the php.ini file exists in the Apache folder and use it if present.
if [ -f "$php_config_file_apache" ]; then
    php_config_file="$php_config_file_apache"
    sed -i 's/^\(allow_url_include =\).*/\1 on/' $php_config_file
    sed -i 's/^\(allow_url_fopen =\).*/\1 on/' $php_config_file
    sed -i 's/^\(display_errors =\).*/\1 on/' $php_config_file
    sed -i 's/^\(display_startup_errors =\).*/\1 on/' $php_config_file
# Check if the php.ini file exists in the FPM folder and use it if present.
elif [ -f "$php_config_file_fpm" ]; then
    php_config_file="$php_config_file_fpm"
    sed -i 's/^\(allow_url_include =\).*/\1 on/' $php_config_file
    sed -i 's/^\(allow_url_fopen =\).*/\1 on/' $php_config_file
    sed -i 's/^\(display_errors =\).*/\1 on/' $php_config_file
    sed -i 's/^\(display_startup_errors =\).*/\1 on/' $php_config_file
else
    # Warning message if not found in any of the folders
    echo -e "$(get_translation "php_config_not_found" "$lang")"
fi
sleep 2

# Check if Apache is already enabled
if systemctl is-enabled apache2 &>/dev/null; then
    echo -e "$(get_translation "apache_already_enabled" "$lang")"
else
    # Enable Apache
    echo -e "$(get_translation "enabling_apache" "$lang")"
    systemctl enable apache2 &>/dev/null
    sleep 2
fi

# Apache restart
echo -e "$(get_translation "restarting_apache" "$lang")"
systemctl enable apache2 &>/dev/null
systemctl restart apache2 &>/dev/null
sleep 2

echo -e "$(get_translation "installation_success" "$lang")"

# Show user credentials after configuration
echo -e "$(get_translation "credentials" "$lang")"
echo -e "Username: \033[93madmin\033[0m"
echo -e "Password: \033[93mpassword\033[0m"

# End of installer
echo
echo -e "$(get_translation "final_signature" "$lang")"