FROM pihole/pihole

RUN apt-get -y update
RUN apt-get -y install vim git