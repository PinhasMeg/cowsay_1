FROM node:16.8
#WORKDIR /cowsay

#copy source files from host to WORKDIR, if there is not WRKDIR we write COPY . /cowsay
COPY . /cowsay
#mv/cd to the dir which cintain the source files AND package.json
WORKDIR /cowsay/src

RUN npm install

#in order to enter in entrypoint.sh we need to go to the directory before src 
#WORKDIR /cowsay

RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "8080" ]


#handle port exposing
