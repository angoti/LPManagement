# Intruções para rodar o back-end


## Iniciando o MongoDB no Docker
### No terminal 
`docker run mongo`

`docker run --name mongodb -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=root mongo`

`docker exec -it mongodb mongosh -u "root" -p "root"`

`use luz`


## Iniciando a aplicação
### Na IDE

Rodar o projeto cliente. 


## Abrindo o Swagger para vizualizar e testar os endpoints

[Link para acessar o Swagger](http://localhost:8080/swagger-ui/index.html#/cliente-controller)