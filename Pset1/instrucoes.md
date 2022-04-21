# _Instruções para utilizar o script do Postgres_ 
 ### Para deixar mais fácil o entendimento, eu criei dois scripts, um criando o usuario e o outro criando o banco de dados.
* Primeiramente, você entra no Postgres pelo terminal, usando o comando: ` psql -U postgres -W ` e insira a senha: **"computacao@raiz"**. Feito isso, você usa o script **"criando_user_postgres.sql"**.
* Logo depois, você entra com o usuário "marialuiza" criado anteriormente, usando o seguinte comando: `psql -U marialuiza postgres -W` e insira a senha: **"123456"**. Depois de feito você usa o script **"criando_db_postgres.sql"**. Nele será criado o banco de dados "uvv", depois de cirado, faça a alteração para o mesmo usando o comando escrito no script, o qual pedirá a senha, para isso, basta inserir **"123456"**, e rodar o restestante do script.  

# _Instrucões para utilizar o script do MariaDB_ 
 ### Como feito anteriormente no Postgres, no MariaDB eu também separei em dois scripts. 
 * Primeiramente, você entra no MariaDB pelo terminal, usando o comando: `mysql -u root -p` e insira a senha: **"computacao@raiz"**. Feito isso, você usa o script **"create_user_mariadb.sql"**.
 * Logo depois você usa o script **"create_db_mariadb.sql"** que lá vai criar o banco de dados, o schema e todo o corpo do banco de dados.
### Pronto!  
