-- Tabelle: Waermepumpen
CREATE TABLE Waermepumpen (
    ID SERIAL PRIMARY KEY, 
    interne_bezeichnung VARCHAR(255),
    typ VARCHAR(255)
);

-- Tabelle: Fertigungslinien
CREATE TABLE Fertigungslinien (
    ID SERIAL PRIMARY KEY, 
    bezeichnung VARCHAR(255), 
    kapazitaet INT
);

-- Tabelle: WaermepumpeFertigungslinie
CREATE TABLE WaermepumpeFertigungslinie (
    ID SERIAL PRIMARY KEY,
    waermepumpe_id INT, 
    fertigungslinie_id INT, 
    FOREIGN KEY (waermepumpe_id) REFERENCES Waermepumpen(ID),
    FOREIGN KEY (fertigungslinie_id) REFERENCES Fertigungslinien(ID)
);

-- Tabelle: Fertigungsstationen
CREATE TABLE Fertigungsstationen (
    ID SERIAL PRIMARY KEY, 
    bezeichnung VARCHAR(255),
    fertigungslinie_id INT, 
    FOREIGN KEY (fertigungslinie_id) REFERENCES Fertigungslinien(ID)
);

-- Tabelle: Alarm
CREATE TABLE Alarm (
    ID SERIAL PRIMARY KEY, 
    start TIMESTAMP, 
    ende TIMESTAMP, 
    bezeichnung VARCHAR(255), 
    typ VARCHAR(255), 
    station_id INT, 
    FOREIGN KEY (station_id) REFERENCES Fertigungsstationen(ID)
);

-- Tabelle: Kunden
CREATE TABLE Kunden (
    ID SERIAL PRIMARY KEY, 
    firmenname VARCHAR(255), 
    strasse VARCHAR(255), 
    hausnummer VARCHAR(255),
    postleitzahl VARCHAR(255), 
    stadt VARCHAR(255),
    land VARCHAR(255),
    ansprechpartner_vorname VARCHAR(255),
    ansprechpartner_nachname VARCHAR(255),
    ansprechpartner_handynummer VARCHAR(255)
);

-- Tabelle: Auftraege
CREATE TABLE Auftraege (
    ID SERIAL PRIMARY KEY, 
    kunde_id INT, 
    bestelldatum TIMESTAMP, 
    lieferdatum TIMESTAMP, 
    status VARCHAR(255),
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

-- Tabelle: MesswertDetails
CREATE TABLE MesswertDetails (
    ID SERIAL PRIMARY KEY, 
    messwert_name VARCHAR(255)
);

-- Tabelle: Messwerte
CREATE TABLE Messwerte (
    ID SERIAL PRIMARY KEY, 
    messwert_id INT, 
    wert VARCHAR(255), 
    start TIMESTAMP, 
    ende TIMESTAMP, 
    ausschuss BOOLEAN, 
    station_id INT, 
    waermepumpe_id INT, 
    FOREIGN KEY (messwert_id) REFERENCES MesswertDetails(ID),
    FOREIGN KEY (station_id) REFERENCES Fertigungsstationen(ID), 
    FOREIGN KEY (waermepumpe_id) REFERENCES Waermepumpen(ID)
);
