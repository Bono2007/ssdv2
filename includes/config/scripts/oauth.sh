#!/bin/bash
source ${SETTINGS_SOURCE}/profile.sh
clear
logo

## Variable
oauth_client=$1
oauth_secret=$2
email=$3

echo -e "${BLUE}###" $(gettext "Google OAuth2 avec Traefik – Secure SSO pour les services Docker") "###${NC}"
echo ""
echo -e "${CCYAN}------------------------------------------------------------------${CEND}"
echo -e "${CCYAN}"$(gettext "Protocole d'identification via Google OAuth2")    "${CEND}"
echo -e "${CCYAN}"$(gettext "Securisation SSO pour les services Docker")       "${CEND}"
echo -e "${CCYAN}------------------------------------------------------------------${CEND}"
echo ""
echo -e "${CRED}------------------------------------------------------------------${CEND}"
echo -e "${CRED}"IMPORTANT: $(gettext "Au préalable créer un projet et vos identifiants")"${CEND}"
echo -e "${CRED}https://github.com/laster13/patxav/wiki 		             ${CEND}"
echo -e "${CRED}------------------------------------------------------------------${CEND}"
echo ""

while [ -z "$oauth_client" ]; do
    >&2 echo -n -e "${BWHITE}Oauth_client: ${CEND}"
    read oauth_client
    manage_account_yml oauth.client $oauth_client
done

while [ -z "$oauth_secret" ]; do
    >&2 echo -n -e "${BWHITE}Oauth_secret: ${CEND}"
    read oauth_secret
    manage_account_yml oauth.secret $oauth_secret
done

while [ -z "$email" ]; do
    echo >&2 -n -e "${BWHITE}"$(gettext "Compte Gmail utilisé(s), séparés d'une virgule si plusieurs:") "${CEND}"
    read email
    manage_account_yml oauth.account $email
done

openssl=$(openssl rand -hex 16)
manage_account_yml oauth.openssl $openssl

## reinstallation traefik
echo ""
suppression_appli traefik
install_traefik

    echo -e "${CRED}---------------------------------------------------------------${CEND}"
    echo -e "${CRED}"$(gettext "Réinitialiser manuellement les applis qui seront")"${CEND}"
    echo -e "${CRED}"$(gettext "Concernées par l'authentification Google OAuth2") "${CEND}"
    echo -e "${CRED}"$(gettext "Choix 1 puis 3 dans le menu")                     "${CEND}"

    echo -e "${CRED}---------------------------------------------------------------${CEND}"
    echo ""
    echo -e "${CRED}---------------------------------------------------------------${CEND}"
    echo -e "${CCYAN}"    IMPORTANT:	$(gettext "Avant la 1ere connexion")"${CEND}"
    echo -e "${CCYAN}"    		- $(gettext "Nettoyer l'historique de votre navigateur")"${CEND}"
    echo -e "${CCYAN}"   		- $(gettext "déconnection de tout compte google")"${CEND}"
    echo -e "${CRED}---------------------------------------------------------------${CEND}"
    echo ""
    echo -e "\n $(gettext "Appuyer sur") ${CCYAN}[$(gettext "ENTREE")]${CEND} $(gettext "pour continuer")"
    read -r
