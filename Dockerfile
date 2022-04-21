FROM adoptopenjdk/openjdk11

# Update Ubuntu
RUN apt-get update --fix-missing && apt-get -y upgrade

# Add oracle java 11 
RUN apt-get -y install openjdk-11-jdk

# Install supervisor
RUN apt-get -y install supervisor

ADD payingguest-authentication-service /opt/payingguest-authentication-service
ADD payingguest-gateway-service /opt/payingguest-gateway-service
ADD payingguest-payment-service /opt/payingguest-payment-service
ADD payingguest-service-registry-service /opt/payingguest-service-registry-service
ADD payingguest-guest-service /opt/payingguest-guest-service
ADD payingguest-room-service /opt/payingguest-room-service 

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports.
EXPOSE 8080 8080
EXPOSE 8761 8761
EXPOSE 29092 29092

#CMD /bin/bash
CMD ["/usr/bin/supervisord", "-n"]
