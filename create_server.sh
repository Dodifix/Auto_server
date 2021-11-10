#!/bin/bash

cd
cd desktop
if [[ -d mc_server ]]
then
cd mc_server
bash start.bat
else
    mkdir mc_server
    cd mc_server
    curl https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/377/downloads/paper-1.17.1-377.jar -o server.jar
    echo "java -Xmx512M -Xms512M -jar server.jar" > start.bat
    ip=$(curl -s https://api.ipify.org)
    echo "A szerverhez ezen az ip címen lehet csatlakozni: $ip" > olvass_el.txt
    bash start.bat
    clear

    ###### felhasználási feltételek elfogadása ######
    read -n 1 -s -r -p "Nyomj meg egy gombot a folytatáshoz. Ezzel elfogadod a felhasználási feltételeket. (https://account.mojang.com/documents/minecraft_eula)"
    clear
    sed 's/false/true/' eula.txt > eula_tmp.txt; mv eula_tmp.txt eula.txt
    sleep 1

    ###### offline módra állítás ######
    sed 's/online-mode=true/online-mode=false/' server.properties > prop_tmp.properties; mv prop_tmp.properties server.properties
    sleep 1

    ###### plugin letöltés ######
    while :
    do
    echo -n "Szeretnél letölteni pár fontosabb plugint? (y/n)? "
    read answer
    clear

    [ "$answer" != "${answer#[Yy]}" ] && mkdir plugins && cd plugins && curl https://dev.bukkit.org/projects/worldedit/files/latest -o worldedit.jar && break ||  [ "$answer" != "${answer#[Nn]}" ] && break || echo "(Kérlek az alábbiak közül válassz: igen: y ,nem: n )"  
    sleep 2
    done


    ###### szerver indítása ######

    while :
    do
    echo -n "Szeretnéd elindítani most a szervert? (y/n)? "
    read answer
    clear

    [ "$answer" != "${answer#[Yy]}" ] && cd && cd desktop/mc_server && bash start.bat && break ||  [ "$answer" != "${answer#[Nn]}" ] && break || echo "(Kérlek az alábbiak közül válassz: igen: y ,nem: n )"  
    sleep 2
    done
fi

