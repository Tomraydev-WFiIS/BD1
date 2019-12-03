
CREATE SEQUENCE rodzaj_statystyki_rs_id_seq_1;

CREATE TABLE Rodzaj_Statystyki (
                RS_ID INTEGER NOT NULL DEFAULT nextval('rodzaj_statystyki_rs_id_seq_1'),
                Nazwa VARCHAR NOT NULL,
                CONSTRAINT rodzaj_statystyki_pk PRIMARY KEY (RS_ID)
);


ALTER SEQUENCE rodzaj_statystyki_rs_id_seq_1 OWNED BY Rodzaj_Statystyki.RS_ID;

CREATE SEQUENCE umiejetnosci_um_id_seq;

CREATE TABLE Umiejetnosci (
                UM_ID INTEGER NOT NULL DEFAULT nextval('umiejetnosci_um_id_seq'),
                Nazwa VARCHAR NOT NULL,
                Waga INTEGER NOT NULL,
                RS_ID INTEGER NOT NULL,
                CONSTRAINT umiejetnosci_pk PRIMARY KEY (UM_ID)
);


ALTER SEQUENCE umiejetnosci_um_id_seq OWNED BY Umiejetnosci.UM_ID;

CREATE SEQUENCE cechy_c_id_seq;

CREATE TABLE Cechy (
                C_ID INTEGER NOT NULL DEFAULT nextval('cechy_c_id_seq'),
                Nazwa VARCHAR NOT NULL,
                Waga INTEGER NOT NULL,
                RS_ID INTEGER NOT NULL,
                CONSTRAINT cechy_pk PRIMARY KEY (C_ID)
);


ALTER SEQUENCE cechy_c_id_seq OWNED BY Cechy.C_ID;

CREATE SEQUENCE rasy_r_id_seq_1;

CREATE TABLE Rasy (
                R_ID INTEGER NOT NULL DEFAULT nextval('rasy_r_id_seq_1'),
                Nazwa VARCHAR NOT NULL,
                CONSTRAINT rasy_pk PRIMARY KEY (R_ID)
);


ALTER SEQUENCE rasy_r_id_seq_1 OWNED BY Rasy.R_ID;

CREATE TABLE R_C (
                R_ID INTEGER NOT NULL,
                C_ID INTEGER NOT NULL,
                CONSTRAINT r_c_pk PRIMARY KEY (R_ID, C_ID)
);


CREATE SEQUENCE users_u_id_seq;

CREATE TABLE Users (
                U_ID INTEGER NOT NULL DEFAULT nextval('users_u_id_seq'),
                Login VARCHAR NOT NULL,
                Pass VARCHAR NOT NULL,
                email VARCHAR NOT NULL,
                CONSTRAINT users_pk PRIMARY KEY (U_ID)
);


ALTER SEQUENCE users_u_id_seq OWNED BY Users.U_ID;

CREATE SEQUENCE postacie_p_id_seq;

CREATE TABLE Postacie (
                P_ID INTEGER NOT NULL DEFAULT nextval('postacie_p_id_seq'),
                Imie VARCHAR NOT NULL,
                U_ID INTEGER NOT NULL,
                R_ID INTEGER NOT NULL,
                CONSTRAINT postacie_pk PRIMARY KEY (P_ID)
);


ALTER SEQUENCE postacie_p_id_seq OWNED BY Postacie.P_ID;

CREATE SEQUENCE przedmioty_rr_id_seq;

CREATE TABLE Przedmioty (
                RR_ID INTEGER NOT NULL DEFAULT nextval('przedmioty_rr_id_seq'),
                Nazwa VARCHAR NOT NULL,
                Waga INTEGER NOT NULL,
                RS_ID INTEGER NOT NULL,
                P_ID INTEGER NOT NULL,
                CONSTRAINT przedmioty_pk PRIMARY KEY (RR_ID)
);


ALTER SEQUENCE przedmioty_rr_id_seq OWNED BY Przedmioty.RR_ID;

CREATE TABLE Statystyki (
                P_ID INTEGER NOT NULL,
                RS_ID INTEGER NOT NULL,
                Wartosc INTEGER NOT NULL,
                CONSTRAINT statystyki_pk PRIMARY KEY (P_ID, RS_ID)
);


CREATE TABLE UM_P (
                UM_ID INTEGER NOT NULL,
                P_ID INTEGER NOT NULL,
                CONSTRAINT um_p_pk PRIMARY KEY (UM_ID, P_ID)
);


ALTER TABLE Przedmioty ADD CONSTRAINT rodzaj_statystyki_przedmioty_fk
FOREIGN KEY (RS_ID)
REFERENCES Rodzaj_Statystyki (RS_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Cechy ADD CONSTRAINT rodzaj_statystyki_cechy_fk
FOREIGN KEY (RS_ID)
REFERENCES Rodzaj_Statystyki (RS_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Umiejetnosci ADD CONSTRAINT rodzaj_statystyki_umiejetnosci_fk
FOREIGN KEY (RS_ID)
REFERENCES Rodzaj_Statystyki (RS_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Statystyki ADD CONSTRAINT rodzaj_statystyki_statystyki_fk
FOREIGN KEY (RS_ID)
REFERENCES Rodzaj_Statystyki (RS_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE UM_P ADD CONSTRAINT umiejetnosci_um_p_fk
FOREIGN KEY (UM_ID)
REFERENCES Umiejetnosci (UM_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE R_C ADD CONSTRAINT cechy_r_c_fk
FOREIGN KEY (C_ID)
REFERENCES Cechy (C_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Postacie ADD CONSTRAINT rasy_postacie_fk
FOREIGN KEY (R_ID)
REFERENCES Rasy (R_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE R_C ADD CONSTRAINT rasy_r_c_fk
FOREIGN KEY (R_ID)
REFERENCES Rasy (R_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Postacie ADD CONSTRAINT users_postacie_fk
FOREIGN KEY (U_ID)
REFERENCES Users (U_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE UM_P ADD CONSTRAINT postacie_um_p_fk
FOREIGN KEY (P_ID)
REFERENCES Postacie (P_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Statystyki ADD CONSTRAINT postacie_statystyki_fk
FOREIGN KEY (P_ID)
REFERENCES Postacie (P_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Przedmioty ADD CONSTRAINT postacie_przedmioty_fk
FOREIGN KEY (P_ID)
REFERENCES Postacie (P_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
