#!/bin/bash

# Verifica se o arquivo de certificado foi fornecido como argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 /caminho/para/certificado.pem"
    exit 1
fi

CERT_FILE=$1

# Verifica se o arquivo existe
if [ ! -f "$CERT_FILE" ]; then
    echo "Arquivo não encontrado: $CERT_FILE"
    exit 1
fi

# Obtém a data de expiração do certificado
expiry_date=$(openssl x509 -enddate -noout -in "$CERT_FILE" | cut -d= -f2)

# Converte a data de expiração em segundos desde epoch
expiry_date_seconds=$(date -d "$expiry_date" +%s)

# Obtém a data atual em segundos desde epoch
current_date_seconds=$(date +%s)

# Calcula a diferença em dias entre a data atual e a data de expiração
days_until_expiry=$(( (expiry_date_seconds - current_date_seconds) / 86400 ))

echo $days_until_expiry

