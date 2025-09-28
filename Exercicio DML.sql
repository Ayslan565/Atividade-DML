create database Amphoreos;
use Amphoreos;

CREATE TABLE Departamento (
    dnum INT PRIMARY KEY,
    dnome VARCHAR(100) NOT NULL,
    gerRG CHAR(9),
    dt_inicio DATE
);
CREATE TABLE Empregado (
    RG CHAR(9) PRIMARY KEY,
    pnome VARCHAR(50) NOT NULL,
    unome VARCHAR(50) NOT NULL,
    sexo CHAR(1),
    dt_nasc DATE,
    rua VARCHAR(100),
    cidade VARCHAR(50),
    estado CHAR(2),
    salario DECIMAL(10, 2),
    dnum INT,
    supRG CHAR(9), 
    FOREIGN KEY (dnum) REFERENCES Departamento(dnum)
);

CREATE TABLE Projeto (
    pnum INT PRIMARY KEY,
    pnome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100),
    dnum INT,
    FOREIGN KEY (dnum) REFERENCES Departamento(dnum)
);

CREATE TABLE Localizacao (
    dnum INT,
    localizacao VARCHAR(100),
    PRIMARY KEY (dnum, localizacao), -- Chave primária composta
    FOREIGN KEY (dnum) REFERENCES Departamento(dnum)
);

CREATE TABLE Dependente (
    empRG CHAR(9),
    dep_nome VARCHAR(100),
    dep_sexo CHAR(1),
    dep_dt_nasc DATE,
    PRIMARY KEY (empRG, dep_nome), -- Chave primária composta
    FOREIGN KEY (empRG) REFERENCES Empregado(RG)
);

CREATE TABLE Trabalha_em (
    RG CHAR(9),
    pnum INT,
    horas DECIMAL(5, 1),
    PRIMARY KEY (RG, pnum), -- Chave primária composta
    FOREIGN KEY (RG) REFERENCES Empregado(RG),
    FOREIGN KEY (pnum) REFERENCES Projeto(pnum)
);


ALTER TABLE Departamento
ADD CONSTRAINT fk_gerente
FOREIGN KEY (gerRG) REFERENCES Empregado(RG);

ALTER TABLE Empregado
ADD CONSTRAINT fk_supervisor
FOREIGN KEY (supRG) REFERENCES Empregado(RG);
 
 
 
 
INSERT INTO Departamento (dnum, dnome, dt_inicio) VALUES
(5, 'Pesquisa', NULL),
(4, 'Administração', NULL),
(1, 'Matriz', NULL);


INSERT INTO Empregado (RG, pnome, unome, sexo, dt_nasc, rua, cidade, estado, salario, dnum, supRG) VALUES
('123456789', 'João', 'Silva', 'M', '1965-01-09', 'Rua das Flores, 731', 'São Paulo', 'SP', 30000.00, 5, NULL),
('333445555', 'Fernando', 'Wong', 'M', '1955-12-08', 'Rua da Lapa, 44', 'São Paulo', 'SP', 40000.00, 5, NULL),
('999887777', 'Alice', 'Pereira', 'F', '1968-01-19', 'Rua Tuiuti, 35', 'São Paulo', 'SP', 25000.00, 4, NULL),
('987654321', 'Jennifer', 'Souza', 'F', '1941-06-20', 'Av. Mutinga, 55', 'São Paulo', 'SP', 43000.00, 4, NULL),
('666884444', 'Ronaldo', 'Lima', 'M', '1962-09-15', 'Rua do Sapo, 22', 'Itu', 'SP', 38000.00, 5, NULL),
('453453453', 'Joice', 'Leite', 'F', '1972-07-31', 'Av. do Contorno, 100', 'São Paulo', 'SP', 25000.00, 5, NULL),
('987987987', 'André', 'Vieira', 'M', '1969-03-29', 'Rua dos Bobos, 0', 'São Paulo', 'SP', 25000.00, 4, NULL),
('888665555', 'Jorge', 'Brito', 'M', '1937-11-10', 'Rua do Centro, 1000', 'Houston', 'TX', 55000.00, 1, NULL);



UPDATE Departamento SET gerRG = '333445555', dt_inicio = '1988-05-22' WHERE dnum = 5;
UPDATE Departamento SET gerRG = '987654321', dt_inicio = '1995-01-01' WHERE dnum = 4;
UPDATE Departamento SET gerRG = '888665555', dt_inicio = '1981-06-19' WHERE dnum = 1;

UPDATE Empregado SET supRG = '333445555' WHERE RG = '123456789';
UPDATE Empregado SET supRG = '333445555' WHERE RG = '666884444';
UPDATE Empregado SET supRG = '333445555' WHERE RG = '453453453';
UPDATE Empregado SET supRG = '987654321' WHERE RG = '999887777';
UPDATE Empregado SET supRG = '987654321' WHERE RG = '987987987';
UPDATE Empregado SET supRG = '888665555' WHERE RG = '333445555'; -- Fernando Wong é supervisionado pelo Jorge Brito
UPDATE Empregado SET supRG = '888665555' WHERE RG = '987654321'; -- Jennifer Souza é supervisionada pelo Jorge Brito

select count(RG) from Empregado;

INSERT INTO Localizacao (dnum, localizacao) VALUES
(1, 'Londrina'),
(4, 'São Paulo'),
(5, 'São Paulo'),
(5, 'Rio de Janeiro'),
(5, 'Belo Horizonte');


INSERT INTO Projeto (pnum, pnome, localizacao, dnum) VALUES
(1, 'ProdutoX', 'Rio de Janeiro', 5),
(2, 'ProdutoY', 'Belo Horizonte', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10, 'Informatização', 'São Paulo', 4),
(20, 'Reorganização', 'Londrina', 1),
(30, 'Novosbenefícios', 'São Paulo', 4);


INSERT INTO Trabalha_em (RG, pnum, horas) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, NULL); 


INSERT INTO Dependente (empRG, dep_nome, dep_sexo, dep_dt_nasc) VALUES
('333445555', 'Alicia', 'F', '1986-04-05'),
('333445555', 'Tiago', 'M', '1983-10-25'),
('333445555', 'Janaina', 'F', '1958-05-03'),
('123456789', 'Michael', 'M', '1988-01-04'),
('123456789', 'Alicia', 'F', '1988-12-30'),
('123456789', 'Elizabeth', 'F', '1967-05-05'),
('987654321', 'Abner', 'M', '1942-02-28');

select P.pnome, P.dnum, E.pnome, E.sexo from Projeto P join Departamento D on P.dnum = D.dnum join Empregado E on D.gerRG = E.RG where P.localizacao = "Londrina";


/* Exercicio
1.       select * from Empregado where dnum = 5;
2.       select * from Empregado where salario > 3000.00;
3.       select * from Empregado where dnum  = 5 and salario > 3000.00;
4.       select * from Empregado where dnum  = 5 and salario > 3000.00 or dnum = 4 and salario >2000.00;
5. 		 select pnome, salario from Empregado ;
6. 		 select pnome, salario from Empregado where dnum = 5;
7.		 select RG from Empregado where dnum = 5  union  select supRG = dnum = 5  ;
8.		 select pnome from Empregado where pnome in (select dep_nome from Dependente);
9.		 select E.pnome as NomeEmpregado, D.dep_nome as NomeDepende from Empregado E Cross join Dependente D;
10.		 select E.pnome, E.unome, D.dep_nome from Empregado E join Dependente D On E.RG = D.empRG ;
11.		 select E.pnome, E.unome, D.dnome from Departamento D join Empregado E on D.gerRG = E.RG;
12.		 select dnum,dnome, localizacao from Departamento natural join Localizacao;
13.		 select E.pnome, E.unome ,P.pnum from Empregado E join Trabalha_em T on E.RG = T.RG join Projeto P on T.pnum = P.pnum;
14.		 select E.pnome, E.unome from Empregado E join Trabalha_em T on E.RG = T.RG join Projeto P on T.pnum = P.pnum where P.dnum = 5;
15.		 select count(RG) from Empregado;
16.		 select dnum, count(pnome) from Empregado group by dnum;
17.		 select dnum, round(avg(salario), 2 )as MediaSalario from Empregado group by dnum;
18.	 	 select E.pnome, E.unome, E.rua, E.cidade, E.estado from Empregado E join Departamento D on E.dnum = D.dnum where D.nome = 'Pesquisa'
19.		 select P.pnome, P.dnum, E.pnome, E.sexo from Projeto P join Departamento D on P.dnum = D.dnum join Empregado E on D.gerRG = E.RG where P.localizacao = "Londrina";


*/


