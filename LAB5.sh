#!bin/bash

# Instalação NodeJS Ubuntu 18.04
# apt-get install nodejs
# apt-get install npm 
# npm install -g yarn 

# Criando diretorios do projeto LAB5

# Nome do Projeto
projeto='lab5'

#Criando Pasta do Projeto
mkdir ${projeto} && cd ${projeto} && git init

# Definindo Gerenciador de Pacotes
packageManager='yarn'
packageInstall='add'

# Deninindo template vue
template='webpack'


# Frontend
mkdir ${projeto}-client && cd ${projeto}-client && git init
    
    mkdir src
    cd src
        mkdir assets components router 
        touch main.js 
        touch App.vue
        cd ..
    mkdir config
    cd config
        touch dev.env.js
        touch prod.env.js
        touch test.env.js 
        touch index.js
        cd ..

    mkdir static 
    mkdir test
    cd ..
   
vue init ${template} ${projeto}-client

cd ${projeto}-client
    ${packageManager} ${packageInstall} vue vue-material axios firebase-tools vue-cli
    ${packageManager} ${packageInstall}  vueify budo -D
    cd ..

# Backend
mkdir ${projeto}-service && cd ${projeto}-service && git init
    
    mkdir src
    cd src 
            touch main.js 
            echo // src/main.js > main.js
            echo const knex = require'("./db.js")'.knex >> main.js
            echo const express = require '("express")' >> main.js
            echo const bodyParser = require '("body-parser")' >> main.js
            echo const morgan = require'("morgan")' >> main.js
            echo const app = express '()' >> main.js
	    echo '' >>  main.js
	    echo app.use'(morgan("dev"))' >> main.js
            echo app.use'(bodyParser.json())' >> main.js
            echo '' >>  main.js
	    echo app.get'("/online",(req, res) => res.send("ONLINE"))' >> main.js
	    echo '' >>  main.js
            echo exports.start = porta '=>' >> main.js
            echo knex.migrate.latest'()'.then'( _ => app.listen(porta))' >> main.js
	    

       	   touch db.js
       	   echo // src/db.js > db.js
       	   echo const cfg = require'("../knexfile")' >> db.js
       	   echo const knex = require'("knex")(cfg.development)' >> db.js
       	   echo exports.knex = knex >> db.js
           

        mkdir features
            cd features
            cd ..

	    mkdir routes
	        cd routes
            cd ..


    cd ..

# Iniciando o Projeto e instalando as dependências
    ${packageManager} init -y && npm init -y
    ${packageManager} ${packageInstall} knex pg express body-parser morgan  
    ${packageManager} ${packageInstall} nodemon -D
    
# Preparando o Knex
    knex init .
    # example configuration knexfile.js (https://knexjs.org/)
   
   #development: {
    #client: 'postgresql',
    #connection: {
        #host: '10.10.0.15', 
        #database: 'lab5_dev',
        #user: 'postgres',
        #password: '*******'
    #}

    # knex migrate:make schema_inicial --env development
    # edit migrations 
    
    # exports.up = knex => knex.schema.createTable("usuario", tb => {
  	#tb.increments("idusuario")
  	#tb.string("nomeusuario")
	#tb.timestamp("datanascusuario").notNullable().defaultTo(knex.fn.now())
	#})

    #exports.down = knex => knex.schema
  	#.dropTable("usuario")
    
    # knex migrate:latest 

# Criando index.js
    touch index.js
    echo // index.js > index.js
    echo const main = require'("./src/main")' >> index.js
    echo console.log'("Server Entry Point!")' >> index.js 
    echo main.start'(3000)' >> index.js

# Criando Script "dev" no package.json
    sed -i '7s/"test":.*1"/"dev": "nodemon index.js"/g' package.json
    
# Criando Readme.md com Informações utilizadas no projeto backend
    touch README.md 
    echo '#' STACK BACKEND'\n' > README.md
    echo '#' Express - http://expressjs.com/ >> README.md
    echo npm install express --save'\n' >> README.md
    echo '#' expressjs - http://expressjs.com/ >> README.md
    echo npm install body-parser --save'\n' >> README.md
    echo '#' Knex - http://knexjs.org/ >> README.md
    echo '#' Contrutor de Consultas SQL >> README.md
    echo npm install knex --save'\n' >> README.md
    echo '#' PostgreSQL - https://www.npmjs.com/package/pg >> README.md
    echo '#' Plugin para conexão ao banco de dados Postgres >> README.md
    echo npm install pg --save'\n' >> README.md
    echo '#' Morgan - http://expressjs.com/ >> README.md
    echo '#' Logger utilizado para registrar os acessos ao serviço >> README.md
    echo npm install morgan --save'\n' >> README.md
    echo '#' Nodemon - https://nodemon.io/ >> README.md
    echo '#' recarrega as alterações feitas no projeto sem matar o serviço >> README.md
    echo npm install nodemon --save-dev'\n' >> README.md
    cd ..
    
 # Baixando Complementos do Projeto
 wget https://github.com/ricardopadua/quik/raw/master/LAB5.sh


# Criando arquivo .gitignore para não enviar dependências para o projeto git
echo node_modules > .gitignore

# Definindo permissões do projeto
chmod 755 -Rf *
