
# Installation de Traefik

- Ajouter le Chart Helm de Traefik dans le repository
  - helm repo add traefik https://helm.traefik.io/traefik
  - helm repo update

- Déploiment de Traefik avec Helm dans le cluster AKS:
  - helm install traefik traefik/traefik

## BasicAuth HTTP

   1. Objectif

        Limiter l'accès à l'application par des utilisateurs autorisés

   2. Process

      - Création d'un secret avec combinaison user:password
      - Ajout d'un middleware de basic auth pour Traefik
      - Ajout dans l'ingress d'une annotation pour activer la basic auth

## Filtrage d'IP

  1. Objectif

        Mise en place un filtrage IP (Whitelist) pour autoriser l'accès aux seules adresses IP autorisées

  2. Process

     - Ajout d'un middleware de type ipwhitelist
     - Ajout d'une annotation dans l'ingress

## Certificats TLS

   1. Objectif
     - Mise en place d'un certificat TLS pour renforcer la sécurité de l'appli

   2. Process
     - Installation de cert manager sur le cluster
     - Création d'un Issuer pour générer le certificat signé par let's encrypt
     - Ajout dans l'ingress d'annotation de cert-manager

## Authentification avec Certificat TLS Client

  1. Objectif
     - Authentification avec un certificat client unique validé par une autorité de certification.

  2. Process
     - Création d'une clé et un certificat d'autorité déposé grace à un secret sur le cluster
     - Création d'un TLSOption qui utilise le secret et configure traefik pour vérifier le certificat client
     - Création d'une nouvelle clé, une nouvelle requête de certificat et d'un nouveau certificat
     - Validation par l'autorité de certification du certificat généré en pfx
     - Création d'un pfx à partir du certificat afin de l'importer sur firefox
     - Le pfx est ensuite importé dans firefox pour donner l'accés

## Authentification par SSO Google

   1. Objectifs
     - Ne plus passer par l'authenfication basique mais par l'authentification Google
   2. Process
     - Création d'un project google cloud
     - Création page de consentement
     - Création Oauth id
     - Création d'un secret avec les élements de connexion google
     - Déploiement d'un pod pour gérer le sso avec Traefik
     - Mise en place d'un middleware sso
     - Ajout d'annotations dans l'ingress
  