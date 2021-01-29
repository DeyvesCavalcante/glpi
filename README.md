## Descrição do Projeto
<p align="center">Script para atualizar o GLPI para a versão 9.5.3</p>

* Antes de iniciar a instalação efetuar backup do banco de dados e da pasta glpi.
* Salvar a script na pasta /tmp e executar nessa pasta.
* Necessário permissão  ao usuário glpi no banco de dados mysql/mariadb na tabela mysql.time_zone_name.
`mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -p -u root mysql`
Acessar o mysql com usuário root
mysql -uroot -p
Executar os comandos abaixo:
GRANT SELECT ON `mysql`.`time_zone_name` TO 'seu_usuario_aqui'@'localhost';
FLUSH PRIVILEGES`;  