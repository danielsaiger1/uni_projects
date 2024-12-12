INSERT INTO waermepumpe (interne_bezeichnung, typ)
VALUES
    ('WP-LW-001', 'Luft-Wasser'),
    ('WP-ER-002', 'Erdwärme'),
    ('WP-GW-003', 'Grundwasser'),
    ('WP-LW-004', 'Luft-Wasser'),
    ('WP-HY-005', 'Hybrid');

INSERT INTO fertigungslinie (bezeichnung, max_cap)
Values 
    ('Linie 1', 16000),
    ('Linie 2', 15000),
    ('Linie 3', 17000),
    ('Linie 4', 16500),
    ('Linie 5', 16200);


INSERT INTO waermepumpe_fertigungslinie (waermepumpe_id, fertigungslinie_id)
VALUES
    (1, 1),
    (3, 1),
    (5, 1),
    (3, 2),
    (5, 2),
    (3, 3),
    (4, 3),
    (4, 4),
    (1, 5),
    (2, 5),
    (3, 5),
    (4, 5);


INSERT INTO fertigungsstation (bezeichnung, fertigungslinie_id) VALUES
 
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



INSERT INTO kunde (
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
    ('BioEnergy Systems', 'Sonnenweg', '8', '67059', 'Kaiserslautern', 'Deutschland', 'Paul', 'Zimmermann', '01706123456');


----- AUFTRAG 1

INSERT INTO auftrag (kunde_id, bestelldatum, lieferdatum, status) VALUES
(1, '2024-12-01 10:00:00', '2024-12-05 12:00:00', 'In Bearbeitung');

-- Batch 1
INSERT INTO auftrag_batches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(1, 1, 1, 10200, '2024-12-02 08:00:00', '2024-12-03 19:00:00');


-- Batch 2
INSERT INTO auftrag_batches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(1, 3, 2, 9800, '2024-12-03 08:00:00', '2024-12-04 18:00:00');


-- T&T Batch 1
INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (1, '2024-12-02 08:00:00', '2024-12-02 12:00:00', 1),
    (2, '2024-12-02 12:30:00', '2024-12-02 15:00:00', 1),
    (3, '2024-12-02 15:15:00', '2024-12-02 18:00:00', 1),
    (4, '2024-12-03 08:00:00', '2024-12-02 11:45:00', 1),
    (5, '2024-12-03 12:00:00', '2024-12-03 15:00:00', 1),
    (6, '2024-12-03 15:15:00', '2024-12-03 17:00:00', 1),
    (7, '2024-12-03 17:10:00', '2024-12-03 19:00:00', 1);


-- T&T Batch 2
INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (8, '2024-12-03 08:00:00', '2024-12-03 12:00:00', 3),
    (9, '2024-12-03 12:30:00', '2024-12-03 15:00:00', 3),
    (10, '2024-12-03 15:15:00', '2024-12-03 18:00:00', 3),
    (11, '2024-12-04 08:00:00', '2024-12-04 11:45:00', 3),
    (12, '2024-12-04 12:00:00', '2024-12-04 15:00:00', 3),
    (13, '2024-12-04 15:15:00', '2024-12-04 17:00:00', 3),
    (14, '2024-12-04 17:10:00', '2024-12-04 18:00:00', 3);


---- AUFTRAG 2

INSERT INTO auftrag (kunde_id, bestelldatum, lieferdatum, status) VALUES
(5, '2024-12-01 10:00:00', '2024-12-06 12:00:00', 'In Bearbeitung');

-- Batch 1
INSERT INTO auftrag_batches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(2, 5, 1, 10500, '2024-12-02 12:30:00', '2024-12-03 21:00:00');


-- Batch 2
INSERT INTO auftrag_batches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(2, 5, 2, 9000, '2024-12-03 11:00:00', '2024-12-04 21:00:00');


-- Batch 3
INSERT INTO auftrag_batches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(2, 4, 5, 10100, '2024-12-02 08:00:00', '2024-12-03 19:00:00');


-- T&T Batch 1
INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (1, '2024-12-02 12:30:00', '2024-12-02 14:30:00', 5),
    (2, '2024-12-02 15:10:00', '2024-12-02 18:15:00', 5),
    (3, '2024-12-02 18:30:00', '2024-12-02 21:00:00', 5),
    (4, '2024-12-03 12:00:00', '2024-12-03 15:45:00', 5),
    (5, '2024-12-03 16:00:00', '2024-12-03 17:00:00', 5),
    (6, '2024-12-03 17:15:00', '2024-12-03 19:10:00', 5),
    (7, '2024-12-03 19:15:00', '2024-12-03 21:00:00', 5);


-- T&T Batch 2
INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (8, '2024-12-03 13:00:00', '2024-12-03 15:00:00', 5),
    (9, '2024-12-03 15:15:00', '2024-12-03 18:00:00', 5),
    (10, '2024-12-03 18:45:00', '2024-12-03 21:00:00', 5),
    (11, '2024-12-04 12:00:00', '2024-12-04 16:15:00', 5),
    (12, '2024-12-04 16:30:00', '2024-12-04 18:00:00', 5),
    (13, '2024-12-04 18:15:00', '2024-12-04 19:45:00', 5),
    (14, '2024-12-04 20:00:00', '2024-12-04 21:00:00', 5);

-- T&T Batch 3
INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (29, '2024-12-02 08:00:00', '2024-12-02 12:00:00', 4),
    (30, '2024-12-02 12:30:00', '2024-12-02 15:00:00', 4),
    (31, '2024-12-02 15:15:00', '2024-12-02 18:00:00', 4),
    (32, '2024-12-03 08:00:00', '2024-12-02 11:45:00', 4),
    (33, '2024-12-03 12:00:00', '2024-12-03 15:00:00', 4),
    (34, '2024-12-03 15:15:00', '2024-12-03 17:00:00', 4),
    (35, '2024-12-03 17:10:00', '2024-12-03 19:00:00', 4);


---- AUFTRAG 3

INSERT INTO auftrag (kunde_id, bestelldatum, lieferdatum, status) VALUES
(3, '2024-12-01 17:00:00', '2024-12-05 12:00:00', 'In Bearbeitung');

-- Batch 1
INSERT INTO auftrag_batches (auftrag_id, waermepumpe_id, fertigungslinie_id, anzahl, produktion_start, produktion_ende)
VALUES
(3, 2, 5, 10100, '2024-12-02 10:00:00', '2024-12-03 21:00:00');

-- T&T Batch 1
INSERT INTO track_trace (station_id, bearbeitungsstart, bearbeitungsende, waermepumpe_id)
VALUES
    (29, '2024-12-02 12:30:00', '2024-12-02 15:15:00', 4),
    (30, '2024-12-02 15:30:00', '2024-12-02 18:05:00', 4),
    (31, '2024-12-02 18:15:00', '2024-12-02 21:00:00', 4),
    (32, '2024-12-03 12:00:00', '2024-12-03 15:45:00', 4),
    (33, '2024-12-03 16:00:00', '2024-12-03 17:00:00', 4),
    (34, '2024-12-03 17:15:00', '2024-12-03 19:00:00', 4),
    (35, '2024-12-03 19:30:00', '2024-12-03 21:00:00', 4);


INSERT INTO track_trace_optional (messwert_id, typ, wert)



INSERT INTO alarm (start, ende, bezeichnung, typ, station_id)
VALUES
    ('2024-12-02 12:30:00', '2024-12-02 12:50:00', 'Übertemperatur', 'Warnung', 29),
    ('2024-12-03 19:40:00', '2024-12-03 19:46:00', 'Verkantet', 'Störung', 14),
    ('2024-12-02 13:00:00', '2024-12-02 13:30:00', 'Neues Material einsetzen', 'Störung', 1),
    ('2024-12-04 12:56:00', '2024-12-04 13:30:00', 'Maschine kann nicht weiterlaufen', 'Störung', 11),
    ('2024-12-04 17:50:00', '2024-12-04 17:55:00', 'Drucküberschreitung', 'Warnung', 14),
    ('2024-12-02 17:20:00', '2024-12-02 17:45:00', 'Verkantet', 'Störung', 31),
    ('2024-12-04 14:30:00', '2024-12-04 14:50:00', 'Neues Material einsetzen', 'Störung', 17),
    ('2024-12-02 15:55:00', '2024-12-02 16:40:00', 'Maschine kann nicht weiterlaufen', 'Störung', 31),
    ('2024-12-03 08:50:00', '2024-12-03 09:10:00', 'Übertemperatur', 'Warnung', 8),
    ('2024-12-04 15:40:00', '2024-12-04 16:20:00', 'Verkantet', 'Störung', 13);











-- Notizen
-- Auslastung: Wir brauchen die Max Kapazität nicht, weil wir die Auslastung nur auf Basis der Zeit berechnen --> Wann läuft eine Fertigungslinie und wann nicht?
-- In T&T Daten noch einfügen, ob Ausschuss produziert wurde