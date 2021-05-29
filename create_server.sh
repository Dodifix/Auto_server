#!/bin/bash

cd
cd desktop
mkdir mc_server
cd mc_server
curl  https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar -o server.jar
echo "java -Xmx2048M -Xms2048M -jar server.jar" > start.bat

bash start.bat

clear

read -n 1 -s -r -p "Nyomj meg egy gombot a folytatáshoz. Ezzel elfogadod a felhasználási feltételeket. (https://account.mojang.com/documents/minecraft_eula)"
clear
sed 's/false/true/' eula.txt > eula_tmp.txt; mv eula_tmp.txt eula.txt

sleep 1

sed 's/online-mode=true/online-mode=false/' server.properties > prop_tmp.properties; mv prop_tmp.properties server.properties

sleep 1

bash start.bat