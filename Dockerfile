FROM node:16.8
#WORKDIR /cowsay

#copy source files from host to WORKDIR, if there is not WRKDIR we write COPY . /cowsay
COPY . /cowsay
#mv/cd to the dir which cintain the source files AND package.json
WORKDIR /cowsay/src

RUN npm install

ENTRYPOINT npm start


#handle port exposing
