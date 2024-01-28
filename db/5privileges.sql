CREATE USER 'nacos'@'localhost'  IDENTIFIED BY '~!LCnacos';
CREATE USER 'nacos'@'%'  IDENTIFIED BY '~!LCnacos';

grant all privileges on `nacos`.* to "nacos"@"localhost" ;

grant all privileges on `nacos`.* to "nacos"@"%";

flush privileges;


CREATE USER 'martin'@'localhost'  IDENTIFIED BY '~!LCmartin';
CREATE USER 'martin'@'%'  IDENTIFIED BY '~!LCmartin';

grant all privileges on `martin`.* to "martin"@"localhost" ;

grant all privileges on `martin`.* to "martin"@"%";

flush privileges;


CREATE USER 'erd'@'localhost'  IDENTIFIED BY '~!LCerd';
CREATE USER 'erd'@'%'  IDENTIFIED BY '~!LCerd';

grant all privileges on `erd`.* to "erd"@"localhost" ;

grant all privileges on `erd`.* to "erd"@"%";

flush privileges;
