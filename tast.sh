#!/bin/bash

DB_HOST="127.0.0.1"
DB_PORT="3306"

mysqldump -h "$DB_HOST" -P "$DB_PORT" --protocol=TCP \
  -u "$DB_USER" -p"$DB_PASSWORD" --no-tablespaces ShopDB \
  | mysql -h "$DB_HOST" -P "$DB_PORT" --protocol=TCP \
  -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

mysqldump -h "$DB_HOST" -P "$DB_PORT" --protocol=TCP \
  -u "$DB_USER" -p"$DB_PASSWORD" --no-tablespaces \
  --no-create-info --skip-triggers ShopDB \
  | mysql -h "$DB_HOST" -P "$DB_PORT" --protocol=TCP \
  -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
