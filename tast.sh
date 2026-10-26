#!/bin/bash

# DB_USER і DB_PASSWORD беремо зі змінних середовища
if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "Set DB_USER and DB_PASSWORD" >&2
  exit 1
fi

set -e -o pipefail

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-tablespaces ShopDB \
  | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-tablespaces \
  --no-create-info --skip-triggers ShopDB \
  | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
