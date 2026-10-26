#!/bin/bash
set -e

DB_HOST="127.0.0.1"
CONN="-h $DB_HOST --protocol=TCP -u $DB_USER -p$DB_PASSWORD"

EXTRA=""
if mysqldump --help 2>/dev/null | grep -q column-statistics; then
  EXTRA="--column-statistics=0"
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

mysqldump $CONN $EXTRA --no-tablespaces ShopDB > "$TMP/full.sql"
mysql $CONN ShopDBReserve < "$TMP/full.sql"

mysqldump $CONN $EXTRA --no-tablespaces --no-create-info --skip-triggers ShopDB > "$TMP/data.sql"
mysql $CONN ShopDBDevelopment < "$TMP/data.sql"
