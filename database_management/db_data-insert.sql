INSERT INTO Waermepumpen (interne_bezeichnung, typ)
VALUES
    ('WP-LW-001', 'Luft-Wasser'),
    ('WP-ER-002', 'Erdwärme'),
    ('WP-GW-003', 'Grundwasser'),
    ('WP-LW-004', 'Luft-Wasser'),
    ('WP-HY-005', 'Hybrid');

INSERT INTO Fertigungslinien (bezeichnung, Kapazitaet)
Values 
    ('Linie 1', 13000),
    ('Linie 2', 12000),
    ('Linie 3', 19000),
    ('Linie 4', 15000),
    ('Linie 5', 17000);

INSERT INTO WaermepumpeFertigungslinie (waermepumpe_id, fertigungslinie_id)
SELECT 
    w.ID AS waermepumpe_id,
    f.ID AS fertigungslinie_id
FROM 
    Waermepumpen w
JOIN 
    Fertigungslinien f
ON 
    RANDOM() < 0.5;


INSERT INTO Fertigungsstationen (bezeichnung, fertigungslinie_id) VALUES
 
('Station 1-1', 1),
('Station 1-2', 1),
('Station 1-3', 1),
('Station 1-4', 1),
('Station 1-5', 1),
('Station 1-6', 1),
('Station 1-7', 1),
 
('Station 2-1', 2),
('Station 2-2', 2),
('Station 2-3', 2),
('Station 2-4', 2),
('Station 2-5', 2),
('Station 2-6', 2),
('Station 2-7', 2),
 
('Station 3-1', 3),
('Station 3-2', 3),
('Station 3-3', 3),
('Station 3-4', 3),
('Station 3-5', 3),
('Station 3-6', 3),
('Station 3-7', 3),
 
('Station 4-1', 4),
('Station 4-2', 4),
('Station 4-3', 4),
('Station 4-4', 4),
('Station 4-5', 4),
('Station 4-6', 4),
('Station 4-7', 4),
 
('Station 5-1', 5),
('Station 5-2', 5),
('Station 5-3', 5),
('Station 5-4', 5),
('Station 5-5', 5),
('Station 5-6', 5),
('Station 5-7', 5);



INSERT INTO Kunden (
    firmenname, strasse, hausnummer, postleitzahl, stadt, land,
    ansprechpartner_vorname, ansprechpartner_nachname, ansprechpartner_handynummer
) 
VALUES 
    ('Musterfirma GmbH', 'Hauptstr.', '12', '10115', 'Berlin', 'Deutschland', 'Max', 'Mustermann', '01701234567'),
    ('TechSolutions AG', 'Industriestr.', '3', '70173', 'Stuttgart', 'Deutschland', 'Laura', 'Schmidt', '01709876543'),
    ('GreenTech Innovations', 'Parkstr.', '45', '20095', 'Hamburg', 'Deutschland', 'John', 'Doe', '01707654321'),
    ('SmartEnergy GmbH', 'Feldstr.', '23', '80331', 'München', 'Deutschland', 'Anna', 'Müller', '01706543210'),
    ('EcoPower Systems', 'Waldstr.', '15', '90402', 'Nürnberg', 'Deutschland', 'Peter', 'Schneider', '01702345678'),
    ('SolarTech Industries', 'Berliner Str.', '56', '10785', 'Berlin', 'Deutschland', 'Jana', 'Fischer', '01705678901'),
    ('WindTurbine Solutions', 'Lindenstr.', '77', '40210', 'Düsseldorf', 'Deutschland', 'Markus', 'Bauer', '01709876567'),
    ('FutureEnergy GmbH', 'Bahnhofstr.', '9', '50667', 'Köln', 'Deutschland', 'Lena', 'Weber', '01703456789'),
    ('CleanEnergy Co.', 'Schulstr.', '34', '30159', 'Hannover', 'Deutschland', 'Tom', 'Klein', '01708901234'),
    ('PowerTech GmbH', 'Brückenstr.', '10', '41061', 'Mönchengladbach', 'Deutschland', 'Sophie', 'Wagner', '01704567890'),
    ('BioEnergy Systems', 'Sonnenweg', '8', '67059', 'Kaiserslautern', 'Deutschland', 'Paul', 'Zimmermann', '01706123456'),
    ('Solaris AG', 'Am Turm', '21', '96047', 'Bamberg', 'Deutschland', 'Julia', 'Hoffmann', '01707654321'),
    ('EcoSolar Innovations', 'Bergstr.', '14', '52062', 'Aachen', 'Deutschland', 'David', 'Schulz', '01702346789'),
    ('GreenWorld GmbH', 'Dorfstr.', '11', '70327', 'Stuttgart', 'Deutschland', 'Stefan', 'Schmitt', '01709567890'),
    ('FutureTech Solutions', 'Gartenstr.', '17', '76133', 'Karlsruhe', 'Deutschland', 'Claudia', 'Schuster', '01705432109'),
    ('EnergiePlus GmbH', 'Wiesenstr.', '22', '47051', 'Duisburg', 'Deutschland', 'Michael', 'Koch', '01703456765');


INSERT INTO Auftraege (kunde_id, bestelldatum, lieferdatum, status) VALUES
(1, '2024-11-01 10:00:00', '2024-11-05 12:00:00', 'Abgeschlossen'),
(2, '2024-11-10 14:30:00', '2024-11-15 16:00:00', 'Abgeschlossen'),
(3, '2024-11-12 09:00:00', '2024-11-20 18:00:00', 'In Bearbeitung'),
(4, '2024-11-05 08:00:00', '2024-11-07 11:30:00', 'Abgeschlossen'),
(5, '2024-11-15 11:00:00', '2024-11-18 10:00:00', 'Abgeschlossen'),
(6, '2024-11-18 17:00:00', '2024-11-20 09:00:00', 'In Bearbeitung'),
(1, '2024-11-20 14:00:00', '2024-11-25 17:00:00', 'Abgeschlossen'),
(3, '2024-11-25 10:00:00', '2024-11-30 12:00:00', 'In Bearbeitung'),
(2, '2024-11-28 13:00:00', '2024-12-02 15:00:00', 'Abgeschlossen'),
(4, '2024-11-02 16:00:00', '2024-11-04 14:00:00', 'Abgeschlossen'),
(5, '2024-11-10 09:30:00', '2024-11-13 13:00:00', 'Abgeschlossen'),
(6, '2024-11-13 11:30:00', '2024-11-17 10:00:00', 'In Bearbeitung');



-- Fertigungsbatches einfügen

-- AUFTRAG 1
-- Fertigungsbatch für Auftrag 1, Linie 1 (9.900 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(3, 1, 1, 9900, '2024-11-01 08:00:00', '2024-11-04 18:00:00');

-- Fertigungsbatch für Auftrag 1, Linie 2 (9.600 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(3, 1, 2, 9600, '2024-11-05 08:00:00', '2024-11-08 18:00:00');

-- Fertigungsbatch für Auftrag 1, Linie 3 (10.200 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(3, 1, 4, 10200, '2024-11-09 08:00:00', '2024-11-12 18:00:00');

-- Fertigungsbatch für Auftrag 1, Linie 4 (10.020 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(3, 2, 5, 10020, '2024-11-13 08:00:00', '2024-11-16 18:00:00');

-- Fertigungsbatch für Auftrag 1, Linie 5 (9.480 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(3, 2, 3, 9480, '2024-11-17 08:00:00', '2024-11-20 18:00:00');


-- AUFTRAG 2
-- Fertigungsbatch für Auftrag 2, Linie 2 (9.600 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(6, 4, 2, 9600, '2024-11-21 08:00:00', '2024-11-24 18:00:00');

-- Fertigungsbatch für Auftrag 2, Linie 3 (10.200 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(6, 4, 3, 10200, '2024-11-25 08:00:00', '2024-11-28 18:00:00');

-- Fertigungsbatch für Auftrag 2, Linie 5 (9.480 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(6, 5, 5, 9480, '2024-11-29 08:00:00', '2024-12-02 18:00:00');

--AUFTRAG 3
-- Fertigungsbatch für Auftrag 3, Linie 1 (9.900 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(8, 3, 1, 9900, '2024-12-03 08:00:00', '2024-12-06 18:00:00');

-- Fertigungsbatch für Auftrag 3, Linie 4 (10.020 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(8, 3, 3, 10020, '2024-12-07 08:00:00', '2024-12-10 18:00:00');

-- Fertigungsbatch für Auftrag 3, Linie 2 (9.600 Wärmepumpen)
INSERT INTO Auftragsbatches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(8, 1, 2, 9600, '2024-12-11 08:00:00', '2024-12-14 18:00:00');




INSERT INTO Alarm (start, ende, bezeichnung, typ, station_id)
VALUES
    ('2024-11-01 09:00:00', '2024-11-01 09:30:00', 'Übertemperatur', 'Warnung', 22),
    ('2024-11-05 09:00:00', '2024-11-05 09:15:00', 'Verkantet', 'Störung', 14),
    ('2024-11-09 10:00:00', '2024-11-09 10:30:00', 'Neues Material einsetzen', 'Warnung', 5),
    ('2024-11-13 14:00:00', '2024-11-13 15:00:00', 'Maschine kann nicht weiterlaufen', 'Störung', 6),
    ('2024-11-21 08:30:00', '2024-11-21 09:00:00', 'Übertemperatur', 'Warnung', 29),
    ('2024-11-25 09:30:00', '2024-11-25 10:00:00', 'Verkantet', 'Störung', 9),
    ('2024-11-29 14:00:00', '2024-11-29 14:45:00', 'Neues Material einsetzen', 'Warnung', 17),
    ('2024-12-03 09:30:00', '2024-12-03 10:00:00', 'Maschine kann nicht weiterlaufen', 'Störung', 12),
    ('2024-12-07 10:00:00', '2024-12-07 10:30:00', 'Übertemperatur', 'Warnung', 19),
    ('2024-12-11 09:00:00', '2024-12-11 09:10:00', 'Verkantet', 'Störung', 29);

INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (1, '2024-11-01 08:00:00', '2024-11-01 08:30:00', 1),
    (2, '2024-11-01 08:30:00', '2024-11-01 09:00:00', 1),
    (3, '2024-11-01 09:00:00', '2024-11-01 09:30:00', 2),
    (4, '2024-11-01 09:30:00', '2024-11-01 10:00:00', 2),
    (5, '2024-11-02 08:00:00', '2024-11-02 08:20:00', 3),
    (6, '2024-11-02 08:20:00', '2024-11-02 08:40:00', 3),
    (7, '2024-11-02 08:40:00', '2024-11-02 09:00:00', 4),
    (8, '2024-11-03 08:00:00', '2024-11-03 08:25:00', 5),
    (9, '2024-11-03 08:25:00', '2024-11-03 08:50:00', 5),
    (10, '2024-11-03 08:50:00', '2024-11-03 09:15:00', 4);












