#!/bin/sh

CONF="/etc/chrony/chrony.conf"

printf "# Generated by entrypoint.sh\n\n" > "$CONF"

for SERVER in $NTP_SERVERS
do
    case "$SERVER" in
        *pool*) echo "pool $SERVER iburst" >> "$CONF" ;;
        *) echo "server $SERVER iburst" >> "$CONF" ;;
    esac
done

for SUBNET in ${ALLOWED_CLIENTS:-""}
do
    echo "allow $SUBNET" >> "$CONF"
done

if [ -n "$DENIED_CLIENTS" ]
then
    for SUBNET in $DENIED_CLIENTS
    do
        echo "deny $SUBNET" >> "$CONF"
    done
fi

cat <<EOF >> "$CONF"
driftfile /var/lib/chrony/chrony.drift
logdir /var/log/chrony
rtcsync
makestep $MAKESTEP
EOF

exec "$@"