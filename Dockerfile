FROM cm2network/steamcmd

RUN mkdir /home/steam/server
RUN ./steamcmd.sh +login anonymous +force_install_dir /home/steam/server +app_update 232370 validate +quit

RUN curl -L "https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1156-linux.tar.gz" -o metamod.tar.gz && \
    tar -xzf metamod.tar.gz -C /home/steam/server/hl2mp && \
    rm metamod.tar.gz

RUN curl -L "https://sm.alliedmods.net/smdrop/1.12/sourcemod-1.12.0-git7172-linux.tar.gz" -o sourcemod.tar.gz && \
    tar -xzf sourcemod.tar.gz -C /home/steam/server/hl2mp && \
    rm sourcemod.tar.gz

ENV MAX_PLAYERS=16

CMD /home/steam/server/srcds_run -game hl2mp -port 27015 +maxplayers $MAX_PLAYERS +map dm_lockdown
