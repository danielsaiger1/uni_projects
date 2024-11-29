Insert into Fertigungslinien( bezeichnung, Kapazitaet)
Values 
    ('Linie 1', 100),
    ('Linie 2', 120),
    ('Linie 3', 90),
    ('Linie 4', 110),
    ('Linie 5', 150);
 
INSERT INTO Waermepumpen (interne_bezeichnung, typ)
VALUES
    ('WP-LW-001', 'Luft-Wasser'),
    ('WP-ER-002', 'Erdwärme'),
    ('WP-GW-003', 'Grundwasser'),
    ('WP-LW-004', 'Luft-Wasser'),
    ('WP-HY-005', 'Hybrid');
 
 
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
    ('EnergiePlus GmbH', 'Wiesenstr.', '22', '47051', 'Duisburg', 'Deutschland', 'Michael', 'Koch', '01703456765'),
    ('EnergyTech Co.', 'Freudenstr.', '7', '76135', 'Karlsruhe', 'Deutschland', 'Eva', 'Mayer', '01703456721'),
    ('TechSolar GmbH', 'Talstr.', '38', '48153', 'Münster', 'Deutschland', 'Ralph', 'Hug', '01706234789'),
    ('BrightFuture AG', 'Schlehenweg', '27', '80333', 'München', 'Deutschland', 'Karoline', 'Lange', '01706432109'),
    ('GreenEnergy Solutions', 'Ringstr.', '50', '44135', 'Dortmund', 'Deutschland', 'Tim', 'Richter', '01709812345'),
    ('SolarMax GmbH', 'Alleeweg', '3', '22303', 'Hamburg', 'Deutschland', 'Hannah', 'Roth', '01707765432'),
    ('EcoPower Co.', 'Lindenweg', '63', '60439', 'Frankfurt', 'Deutschland', 'Niklas', 'Steiner', '01704567812'),
    ('SunPower Innovations', 'Fischerweg', '5', '90489', 'Nürnberg', 'Deutschland', 'Clara', 'Peters', '01702223344'),
    ('NextEnergy Systems', 'Holzstr.', '42', '79100', 'Freiburg', 'Deutschland', 'Benjamin', 'Haas', '01706789012'),
    ('EnergyMakers GmbH', 'Neustadtstr.', '16', '40213', 'Düsseldorf', 'Deutschland', 'Anna', 'Schwarz', '01706543254'),
    ('GreenWave AG', 'Blumenstr.', '11', '10115', 'Berlin', 'Deutschland', 'Jan', 'Friedrich', '01707456123'),
    ('CleanTech GmbH', 'Wasserstr.', '10', '22041', 'Hamburg', 'Deutschland', 'Felix', 'Brandt', '01704321678'),
    ('SolarWorld Co.', 'Kirchstr.', '18', '50672', 'Köln', 'Deutschland', 'Mia', 'Becker', '01706453821'),
    ('WindEnergy Solutions', 'Talweg', '36', '49090', 'Osnabrück', 'Deutschland', 'Philipp', 'Kaiser', '01703567893'),
    ('Solardream GmbH', 'Holzweg', '22', '67063', 'Kaiserslautern', 'Deutschland', 'Marta', 'Vogel', '01703456789'),
    ('Energiemarkt AG', 'Neustadtweg', '41', '70176', 'Stuttgart', 'Deutschland', 'Johannes', 'Pohl', '01701234598'),
    ('GreenEnergy Innovations', 'Eichenstr.', '54', '90482', 'Nürnberg', 'Deutschland', 'Sabine', 'Müller', '01706890876'),
    ('WindFuture GmbH', 'Altstadtstr.', '7', '67098', 'Bonn', 'Deutschland', 'Lukas', 'Wolff', '01706321789'),
    ('EcoFusion Co.', 'Seestr.', '12', '46045', 'Essen', 'Deutschland', 'Tina', 'Jung', '01707451980'),
    ('CleanEnergy GmbH', 'Hoffmannstr.', '16', '60329', 'Frankfurt', 'Deutschland', 'Carla', 'Gruber', '01702987432'),
    ('SolarVista GmbH', 'Brückenstr.', '28', '69115', 'Heidelberg', 'Deutschland', 'Maximilian', 'Weiss', '01703214689'),
    ('GreenSolutions GmbH', 'Lindenstr.', '5', '10245', 'Berlin', 'Deutschland', 'Paul', 'Thomsen', '01702468290'),
    ('RenewPower AG', 'Bahnhofstr.', '11', '28359', 'Bremen', 'Deutschland', 'Elisabeth', 'Timmermann', '01706258791'),
    ('SolarPlus Co.', 'Sonnenstr.', '29', '71063', 'Sindelfingen', 'Deutschland', 'Axel', 'Schumacher', '01709348124'),
    ('FutureSolar GmbH', 'Dorfstr.', '3', '80469', 'München', 'Deutschland', 'Elias', 'Keller', '01707451973'),
    ('GreenTech Solutions', 'Platzstr.', '20', '39031', 'Bozen', 'Italien', 'Nina', 'Hoffmann', '01703456790'),
    ('SolarEnergy AG', 'Grünstr.', '15', '70176', 'Stuttgart', 'Deutschland', 'Katrin', 'Böhm', '01706543286'),
    ('EcoWind GmbH', 'Steinstr.', '34', '70272', 'Stuttgart', 'Deutschland', 'Stefan', 'Bauer', '01704587622'),
    ('SolarPower Systems', 'Rosenweg', '50', '60311', 'Frankfurt', 'Deutschland', 'Franz', 'Lang', '01707543210'),
    ('CleanWave AG', 'Neubauweg', '5', '37073', 'Göttingen', 'Deutschland', 'Sabrina', 'Schröder', '01702874512'),
    ('TechSolar Systems', 'Wiesenweg', '21', '60435', 'Frankfurt', 'Deutschland', 'Diana', 'Feldmann', '01707564327'),
    ('EnergiePlus Systems', 'Waldweg', '9', '40213', 'Düsseldorf', 'Deutschland', 'Henrik', 'Koch', '01704235467'),
    ('NextGen Energy GmbH', 'Bachstr.', '3', '10117', 'Berlin', 'Deutschland', 'Michael', 'Becker', '01703987465'),
    ('FutureWave AG', 'Südstraße', '12', '20148', 'Hamburg', 'Deutschland', 'Sandra', 'Richter', '01708763490');
 
WITH Bestelldaten AS (
    SELECT 
        k.ID AS kunde_id,
        (CURRENT_DATE - (RANDOM() * 365)::int) AS bestelldatum 
    FROM 
        Kunden k
),
AuftraegeMitLieferdatum AS (
    SELECT 
        kunde_id,
        bestelldatum,
        bestelldatum + INTERVAL '21 days' + (RANDOM() * 7)::int * INTERVAL '1 day' AS lieferdatum 
    FROM 
        Bestelldaten
)
INSERT INTO Auftraege (kunde_id, bestelldatum, lieferdatum, status)
SELECT 
    kunde_id, 
    bestelldatum, 
    lieferdatum, 
    CASE
        WHEN lieferdatum > CURRENT_DATE THEN 
        ELSE 
    END AS status
FROM 
    AuftraegeMitLieferdatum;
	
INSERT INTO Alarm (start, ende, bezeichnung, typ, station_id)
SELECT
    CURRENT_DATE - (RANDOM() * 30)::int * INTERVAL '1 day' + 
    (RANDOM() * 24 * 60 * 60)::int * INTERVAL '1 second' AS start,
 
   -- (zwischen 2 und 20 Minuten später als Startzeit)
    CURRENT_DATE - (RANDOM() * 30)::int * INTERVAL '1 day' + 
    (RANDOM() * 24 * 60 * 60)::int * INTERVAL '1 second' + 
    ((RANDOM() * (20 - 2) + 2)::int * INTERVAL '1 minute') AS ende,
 
    Case 
        WHEN RANDOM() < 0.2 THEN 'Übertemperatur'
        WHEN RANDOM() >= 0.2 AND RANDOM() < 0.5 THEN 'Verkantet'
        WHEN RANDOM() >= 0.5 AND RANDOM() < 0.7 THEN 'Neues Material einsetzen'
        ELSE 'Maschine kann nicht weiterlaufen'
    END AS bezeichnung,
    CASE
        WHEN RANDOM() < 0.5 THEN 'Warnung'
        ELSE 'Störung'
    END AS typ,
    FLOOR(1 + RANDOM() * 35) AS station_id
FROM generate_series(1, 50);

INSERT INTO 
    MesswertDetails (messwert_id, messwert_name)
VALUES 
    (101, "Druck (Bar)"),
    (102, "Temperatur (°C)"),
    (103, "Leistung (kW)"),
    (104, "Durchflussrate (l/s)"),
    (105, "Energieverbrauch (kWh)");

INSERT INTO 
    Messwerte (ID, messwert_id, wert, start, ende, ausschuss, station_id, waermepumpe_id)
VALUES
    (1, 101, 5.2, '2024-11-29 08:00:00', '2024-11-29 08:30:00', FALSE, 1, 2),
    (2, 102, 56.0, '2024-11-29 09:00:00', '2024-11-29 09:20:00', FALSE, 2, 1),
    (3, 1033, 2.3, '2024-11-29 09:30:00', '2024-11-29 09:50:00', TRUE, 31, 4),
    (4, 101, 6.1, '2024-11-29 10:00:00', '2024-11-29 10:25:00', FALSE, 4, 5),
    (5, 102, 65.0, '2024-11-29 10:30:00', '2024-11-29 10:50:00', TRUE, 22, 5),
    (6, 104, 12.5, '2024-11-29 11:00:00', '2024-11-29 11:15:00', FALSE, 6, 3), 
    (7, 103, 3.1, '2024-11-29 11:20:00', '2024-11-29 11:40:00', FALSE, 17, 2), 
    (8, 101, 5.8, '2024-11-29 11:45:00', '2024-11-29 12:00:00', TRUE, 29, 1),  
    (9, 105, 1.4, '2024-11-29 12:05:00', '2024-11-29 12:25:00', FALSE, 34, 4),
    (10, 102, 48.3, '2024-11-29 12:30:00', '2024-11-29 12:50:00', TRUE, 10, 5); 



