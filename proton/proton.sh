#!/usr/bin/env sh


# init
previous_port1=0
previous_port2=0


# env params
gw=$ENV_GW
rtorrent_port=$ENV_RTORRENT_PORT
rtorrent_url=$ENV_RTORRENT_URL
aria2_url=$ENV_ARIA2_URL
aria2_token=$ENV_ARIA2_TOKEN
aria2_port=$ENV_ARIA2_PORT

# wait a bit
sleep 10;


while [ 1 ]; do
  ### RTORRENT
  # port forwarding request
  port=$(natpmp-client.py -g $gw $rtorrent_port $rtorrent_port 2>/dev/null | sed -e 's/.*public port \(.*\)\, lifetime.*/\1/');
  # set forwarded port to rtorrent
  date=$(date "+%m/%d (%H:%M)");
  if [ -z "$port" ]; then
    # error
    echo "> [$date] (!) no port 1 from NAT-PMP";
  else
    if [ $previous_port1 != $port ]; then
      wget -q -O/dev/null $rtorrent_url --post-data="<methodCall><methodName>system.multicall</methodName><params><param><value><array><data><value><struct><member><name>methodName</name><value><string>network.port_range.set</string></value></member><member><name>params</name><value><array><data><value><string></string></value>,<value><string>$port-$port</string></value></data></array></value></member></struct></value></data></array></value></param></params></methodCall>";
      echo "> [$date] port 1 updated : $port";
      previous_port1=$port;
    fi
  fi

  ### ARIA2
  # port forwarding request
  port=$(natpmp-client.py -g $gw $aria2_port $aria2_port 2>/dev/null | sed -e 's/.*public port \(.*\)\, lifetime.*/\1/');
  # set forwarded port to rtorrent
  date=$(date "+%m/%d (%H:%M)");
  if [ -z "$port" ]; then
    # error
    echo "> [$date] (!) no port 2 from NAT-PMP";
  else
    if [ $previous_port2 != $port ]; then
      python3 /usr/local/sbin/aria2.py $aria2_url $aria2_token $port
      echo "> [$date] port 2 updated : $port";
      previous_port2=$port;
    fi
  fi
  sleep 50;
done
