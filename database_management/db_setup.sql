-- Tabelle: Waermepumpen
CREATE TABLE Waermepumpen (
    ID SERIAL PRIMARY KEY, 
    interne_bezeichnung VARCHAR,
    typ VARCHAR
);

-- Tabelle: Fertigungslinien
CREATE TABLE Fertigungslinien (
    ID SERIAL PRIMARY KEY, 
    bezeichnung VARCHAR
);


-- Tabelle: WaermepumpeFertigungslinie
CREATE TABLE Waermepumpe_Fertigungslinie (
    ID SERIAL PRIMARY KEY,
    waermepumpe_id INT, 
    fertigungslinie_id INT, 
    FOREIGN KEY (waermepumpe_id) REFERENCES Waermepumpen(ID),
    FOREIGN KEY (fertigungslinie_id) REFERENCES Fertigungslinien(ID)
);


-- Tabelle: Fertigungsstationen
CREATE TABLE Fertigungsstationen (
    ID SERIAL PRIMARY KEY, 
    bezeichnung VARCHAR,
    fertigungslinie_id INT, 
    FOREIGN KEY (fertigungslinie_id) REFERENCES Fertigungslinien(ID)
);


-- Tabelle: Kunden
CREATE TABLE Kunden (
    ID SERIAL PRIMARY KEY, 
    firmenname VARCHAR, 
    strasse VARCHAR, 
    hausnummer VARCHAR,
    postleitzahl VARCHAR, 
    stadt VARCHAR,
    land VARCHAR,
    ansprechpartner_vorname VARCHAR,
    ansprechpartner_nachname VARCHAR,
    ansprechpartner_handynummer VARCHAR
);

-- Tabelle: Auftraege
CREATE TABLE Auftraege (
    ID SERIAL PRIMARY KEY, 
    kunde_id INT, 
    bestelldatum TIMESTAMP, 
    lieferdatum TIMESTAMP, 
    status VARCHAR,
    FOREIGN KEY (kunde_id) REFERENCES Kunden(ID)
);


-- Tabelle: Auftragsbatches
CREATE TABLE Auftragsbatches (
    ID SERIAL PRIMARY KEY, 
    auftrag_id INT, 
    waermepumpe_id INT, 
    fertigungslinie_id INT, 
    anzahl INT, 
    produktion_start TIMESTAMP, 
    produktion_ende TIMESTAMP, 
    FOREIGN KEY (auftrag_id) REFERENCES Auftraege(ID), 
    FOREIGN KEY (waermepumpe_id) REFERENCES Waermepumpen(ID), 
    FOREIGN KEY (fertigungslinie_id) REFERENCES Fertigungslinien(ID)
);


-- Tabelle: Alarm
CREATE TABLE Alarm (
    ID SERIAL PRIMARY KEY, 
    start TIMESTAMP, 
    ende TIMESTAMP, 
    bezeichnung VARCHAR, 
    typ VARCHAR, 
    station_id INT, 
    FOREIGN KEY (station_id) REFERENCES Fertigungsstationen(ID)
);

-- Tabelle: Messwerte
CREATE TABLE track_trace (
    ID SERIAL PRIMARY KEY,
    station_id INT,
    bearbeitungsstart TIMESTAMP,
    bearbeitungsende TIMESTAMP,
    ausschuss BOOLEAN, 
    waermepumpe_id INT,
    FOREIGN KEY (station_id) REFERENCES Fertigungsstationen(ID), 
    FOREIGN KEY (waermepumpe_id) REFERENCES Waermepumpen(ID)
);

-- Tabelle: track_trace_optional --> optionale Messwerte
CREATE TABLE track_trace_optional (
    ID SERIAL PRIMARY KEY,
    messwert_id INT,
    messwert_typ VARCHAR,   
    wert FLOAT,    
    FOREIGN KEY (messwert_id) REFERENCES track_trace(ID)
);


