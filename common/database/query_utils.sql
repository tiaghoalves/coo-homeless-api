INSERT INTO `organization`(`id`,`name`,`desc_organization`,`cnpj`) 
VALUES(null, 'Centro POP','Centro de Referência Especializado para População em Situação de Rua','12345678910123');

ALTER TABLE contributor MODIFY contributor.CPF varchar (50);
ALTER TABLE organization MODIFY organization.CNPJ varchar (50);

select * from organization;
select * from contributor;
select * from homeless;
select * from meeting_point_contributor;


