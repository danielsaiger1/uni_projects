---- Auslastung Fertigungslinien

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
        auftragsbatches, zeitinterval zi
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







