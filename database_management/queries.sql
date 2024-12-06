CREATE TABLE Kunden (
    KundenID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Kontakt VARCHAR(255)
);
CREATE TABLE Auftraege (
    AuftragID SERIAL PRIMARY KEY,
    KundeID INT REFERENCES Kunden(KundenID),
    WaermepumpenTyp VARCHAR(50) NOT NULL,
    Menge INT NOT NULL
);
CREATE TABLE Fertigungslinien (
    FertigungslinieID SERIAL PRIMARY KEY,
    Beschreibung VARCHAR(255)
);

CREATE TABLE Stationen (
    StationID SERIAL PRIMARY KEY,
    FertigungslinieID INT REFERENCES Fertigungslinien(FertigungslinieID),
    Beschreibung VARCHAR(255)
);
CREATE TABLE Batches (
    BatchID SERIAL PRIMARY KEY,
    FertigungslinieID INT REFERENCES Fertigungslinien(FertigungslinieID),
    WaermepumpenTyp VARCHAR(50) NOT NULL,
    KundeID INT REFERENCES Kunden(KundenID),
    Startzeit TIMESTAMP,
    Endzeit TIMESTAMP,
    Status VARCHAR
);

CREATE TABLE Waermepumpen (
    WaermepumpenID SERIAL PRIMARY KEY,
    Typ VARCHAR(50) NOT NULL,
    InterneBezeichnung VARCHAR(50),
    Produktionstyp VARCHAR(50),
    KundenauftragID INT REFERENCES Auftraege(AuftragID),
    BatchID INT REFERENCES Batches(BatchID),
    Status VARCHAR CHECK (Status IN ('Gutteil', 'Schlechtteil'))
);



CREATE TABLE Alarme (
    AlarmID SERIAL PRIMARY KEY,
    StationID INT REFERENCES Stationen(StationID),
    Typ VARCHAR(20) CHECK (Typ IN ('Warnung', 'Stoerung')),
    Bezeichnung VARCHAR(255),
    Startzeit TIMESTAMP,
    Endzeit TIMESTAMP
);
CREATE TABLE TrackAndTrace (
    ID SERIAL PRIMARY KEY,
    WaermepumpeID INT REFERENCES Waermepumpen(WaermepumpenID),
    StationID INT REFERENCES Stationen(StationID),
    Bearbeitungsstart TIMESTAMP,
    Bearbeitungsende TIMESTAMP,
    Ausschuss BOOLEAN,
    Messwert1 NUMERIC,
    Messwert2 NUMERIC,
    Messwert3 NUMERIC,
    Messwert4 NUMERIC,
    Messwert5 NUMERIC
);


-- Einfügen von Beispieldaten

-- 1. Kunden
INSERT INTO Kunden (Name, Kontakt) VALUES 
('Kunde A', 'kontakt@kunde-a.de'),
('Kunde B', 'kontakt@kunde-b.de');

-- 2. Aufträge
INSERT INTO Auftraege (KundeID, WaermepumpenTyp, Menge) VALUES 
(1, 'Typ-1', 50),
(1, 'Typ-2', 30),
(2, 'Typ-3', 40);

-- 3. Fertigungslinien
INSERT INTO Fertigungslinien (Beschreibung) VALUES 
('Linie 1: Hochleistung'),
('Linie 2: Standard'),
('Linie 3: Spezialanforderungen');

-- 4. Stationen
INSERT INTO Stationen (FertigungslinieID, Beschreibung) VALUES 
(1, 'Station 1: Zuschnitt'),
(1, 'Station 2: Montage'),
(1, 'Station 3: Prüfung'),
(2, 'Station 1: Zuschnitt'),
(2, 'Station 2: Montage'),
(2, 'Station 3: Prüfung');

-- 5. Batches
INSERT INTO Batches (FertigungslinieID, WaermepumpenTyp, KundeID, Startzeit, Endzeit, Status) VALUES 
(1, 'Typ-1', 1, '2024-01-01 08:00:00', '2024-01-01 12:00:00', 'Abgeschlossen'),
(2, 'Typ-2', 1, '2024-01-02 09:00:00', '2024-01-02 13:00:00', 'Abgeschlossen'),
(3, 'Typ-3', 2, '2024-01-03 10:00:00', '2024-01-03 14:00:00', 'Abgeschlossen');

-- 6. Wärmepumpen
INSERT INTO Waermepumpen (Typ, InterneBezeichnung, Produktionstyp, KundenauftragID, BatchID, Status) VALUES 
('Typ-1', 'WP1001', 'Standard', 1, 1, 'Gutteil'),
('Typ-1', 'WP1002', 'Standard', 1, 1, 'Schlechtteil'),
('Typ-2', 'WP2001', 'Spezial', 2, 2, 'Gutteil'),
('Typ-3', 'WP3001', 'Standard', 3, 3, 'Gutteil'),
('Typ-3', 'WP3002', 'Standard', 3, 3, 'Schlechtteil');

-- 7. Alarme
INSERT INTO Alarme (StationID, Typ, Bezeichnung, Startzeit, Endzeit) VALUES 
(1, 'Stoerung', 'Drucksensorfehler', '2024-01-01 08:15:00', '2024-01-01 08:45:00'),
(2, 'Warnung', 'Temperaturgrenze erreicht', '2024-01-02 09:30:00', '2024-01-02 09:45:00'),
(3, 'Stoerung', 'Motorblockade', '2024-01-03 10:20:00', '2024-01-03 10:50:00');

-- 8. Track&Trace
INSERT INTO TrackAndTrace (WaermepumpeID, StationID, Bearbeitungsstart, Bearbeitungsende, Ausschuss, Messwert1, Messwert2, Messwert3, Messwert4, Messwert5) VALUES 
(1, 1, '2024-01-01 08:00:00', '2024-01-01 08:10:00', FALSE, 65.0, NULL, NULL, NULL, NULL),
(1, 2, '2024-01-01 08:10:00', '2024-01-01 08:20:00', FALSE, 3.0, NULL, NULL, NULL, NULL),
(2, 1, '2024-01-01 08:30:00', '2024-01-01 08:40:00', TRUE, 70.0, NULL, NULL, NULL, NULL),
(3, 2, '2024-01-02 09:00:00', '2024-01-02 09:15:00', FALSE, NULL, 15.0, NULL, NULL, NULL),
(4, 3, '2024-01-03 10:00:00', '2024-01-03 10:30:00', FALSE, NULL, NULL, 2.0, NULL, NULL);



SELECT 
    f.FertigungslinieID,
    f.Beschreibung,
    SUM(EXTRACT(EPOCH FROM (t.Bearbeitungsende - t.Bearbeitungsstart))) / 
    (EXTRACT(EPOCH FROM (MAX(t.Bearbeitungsende) - MIN(t.Bearbeitungsstart))) * COUNT(DISTINCT s.StationID)) * 100 AS AuslastungProzent
FROM 
    Fertigungslinien f
JOIN Stationen s ON f.FertigungslinieID = s.FertigungslinieID
JOIN TrackAndTrace t ON s.StationID = t.StationID
WHERE 
    t.Bearbeitungsstart >= '2024-01-01' AND t.Bearbeitungsende <= '2024-12-31'
GROUP BY 
    f.FertigungslinieID, f.Beschreibung;