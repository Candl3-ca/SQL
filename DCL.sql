-- DCL TO MANAGE USERS, TABLES USED MOSTLY BY THE DBA (HIGHEST PRIVILAGE)

CREATE USER username
IDENTIFIED BY password


-- to grant acces

GRANT [Privilege list| ALL PRIVIEGES] ON objectName TO {AuthorizedList | PUBLIC | role_name} [WITH GRANT OPTIONS]

-- creating roles

CREATE ROLE role_name [IDENTIFIED BY password] [NOT IDENTIFIED]


/* This language consists of mainly 2 commands, to grant permission and to revoke permission  */
