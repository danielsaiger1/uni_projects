-- Auslastung Fertigungslinien
WITH zeitinterval AS (
    SELECT 
        '2024-12-01 00:00:00'::timestamp AS startzeit,
        '2024-12-05 23:59:59'::timestamp AS endzeit
),
genutzte_zeit AS (
    SELECT 
        fertigungslinie_id,
        LEAST(produktion_ende, zi.endzeit) - GREATEST(produktion_start, zi.startzeit) AS genutzte_zeit
    FROM 
        auftrag_batches, zeitinterval zi
    WHERE 
        produktion_start < zi.endzeit AND produktion_ende > zi.startzeit
),
summierte_zeiten AS (
    SELECT 
        fertigungslinie_id,
        SUM(EXTRACT(EPOCH FROM genutzte_zeit)) AS genutzte_sekunden
    FROM 
        genutzte_zeit
    GROUP BY 
        fertigungslinie_id
)
SELECT 
    sz.fertigungslinie_id,
    ROUND((sz.genutzte_sekunden / (EXTRACT(EPOCH FROM (zi.endzeit - zi.startzeit))) * 100), 2) AS auslastung_prozent
FROM 
    summierte_zeiten sz, zeitinterval zi;



---- Auslastung Fertigungsstationen
WITH zeitinterval AS (
    SELECT 
        '2024-12-02 08:00:00'::timestamp AS startzeit,
        '2024-12-02 13:30:00'::timestamp AS endzeit
),
genutzte_zeit AS (
    SELECT 
        station_id,
        LEAST(bearbeitungsende, zi.endzeit) - GREATEST(bearbeitungsstart, zi.startzeit) AS genutzte_zeit
    FROM 
        track_trace, zeitinterval zi
    WHERE 
        bearbeitungsstart < zi.endzeit AND bearbeitungsende > zi.startzeit
),
summierte_zeiten AS (
    SELECT 
        station_id,
        SUM(EXTRACT(EPOCH FROM genutzte_zeit)) AS genutzte_sekunden
    FROM 
        genutzte_zeit
    GROUP BY 
        station_id
)
SELECT 
    sz.station_id,
    ROUND((sz.genutzte_sekunden / (EXTRACT(EPOCH FROM (zi.endzeit - zi.startzeit))) * 100), 2) AS auslastung_prozent
FROM 
    summierte_zeiten sz, zeitinterval zi;




--- Statistische Kennzahlen zu Störungen
SELECT 
    station_id,
    COUNT(*) AS anzahl_stoerungen,
    ROUND((SUM(EXTRACT(EPOCH FROM (ende - start))) / 3600), 2) AS summe_dauer_stunden,  -- Gesamte Störungsdauer in Stunden
    ROUND((AVG(EXTRACT(EPOCH FROM (ende - start))) / 3600), 2) AS durchschnitt_dauer_stunden,  -- Durchschnittliche Störungsdauer in Stunden
	(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (ende - start))) / 3600)::decimal(8,2) AS q1_dauer_stunden,  -- 1. Quartil --> cast als decimal, da round funktion nicht auf percentile_cont angewendet werden kann
    (PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (ende - start))) / 3600)::decimal(8,2) AS median_dauer_stunden,  -- Median
    (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM (ende - start))) / 3600)::decimal(8,2) AS q3_dauer_stunden  -- 3. Quartil
	
FROM 
	alarm
WHERE 
    station_id IN (1, 14, 31)  -- Beispiel für spezifische stationen
    AND start >= '2024-12-02'  -- Startdatum Zeitraum
    AND ende <= '2024-12-04'  -- Enddatum Zeitraum
    AND typ = 'Störung'  -- Filter auf nur Störungen --> Typ 'Warnung' wird ausgeschlossen
GROUP BY 
    station_id
ORDER BY
	station_id;
-- Notiz: Man kann noch Join mit Fertigungsstationen machen, um Name der Fertigungsstation zu ziehen

--- Ausschuss pro Auftrag
SELECT 
    a.ID,
    ab.waermepumpe_id,
    ab.fertigungslinie_id,
    ab.anzahl,
    ab.produktion_start,
    ab.produktion_ende,
    (ab.anzahl - SUM(tt.anzahl_ausschuss)) AS anzahl_gutteile,
    SUM(tt.anzahl_ausschuss) AS anzahl_schlechtteile
FROM
    auftrag a
JOIN
    auftrag_batches ab ON a.ID = ab.auftrag_id
JOIN
    track_trace tt ON ab.waermepumpe_id = tt.waermepumpe_id
GROUP BY
    a.ID,
    ab.waermepumpe_id, ab.fertigungslinie_id, ab.anzahl, ab.produktion_start, ab.produktion_ende
ORDER BY
    a.ID ASC;


--- Auswertung welcher Messwert für Ausschuss verantwortlich war
SELECT 
    tt.ID AS track_trace_id,
    tt.waermepumpe_id,
    tt.station_id,
    tt.ausschuss,
    tt.anzahl_ausschuss,
    tto.messwert_id,
    mt.bezeichnung AS messwert_bezeichnung,
    tto.wert,
    tto.zeit_aufzeichnung
FROM 
    track_trace tt
JOIN 
    track_trace_optional tto ON tt.track_trace_optional_id = tto.ID
JOIN 
    messwert_typen mt ON tto.messwert_id = mt.ID
WHERE 
    tt.ausschuss = TRUE AND tto.ausschuss = TRUE;

--notiz: man könnte diese query noch mit der ausschuss pro auftrag verbinden, um direkt in dieser auswertung anzuzeigen was auslöser für ausschuss war 
