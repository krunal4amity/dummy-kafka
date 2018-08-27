FROM node:10
WORKDIR /usr/src/app
COPY package*.json ./
#COPY wait.sh ./
RUN npm install
RUN apt-get update \
    && apt-get install netcat -y \
    && apt-get install dos2unix -y \
    && apt-get clean
COPY . .
RUN chmod 755 waitfor.sh \
    && dos2unix waitfor.sh
EXPOSE 8080
#HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 CMD nc -zv kafka 9092
CMD ./waitfor.sh