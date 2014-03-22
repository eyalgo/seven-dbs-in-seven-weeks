-- 1. rule for soft-delete 
CREATE RULE delete_venue AS ON DELETE TO venues DO INSTEAD
UPDATE venues
SET active = false
WHERE name = OLD.name;

-- 2. use generate_series instead of temorarily table
SELECT * FROM crosstab(
'SELECT extract(year from starts) as year,
extract(month from starts) as month, count(*)
FROM events
GROUP BY year, month
ORDER BY year, month',
'SELECT * FROM generate_series(1,12) as month_count'
) AS (
year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;

-- 3. pivot table for calendar
SELECT * FROM crosstab(

year int,
jan int, feb int, mar int, apr int, may int, jun int,
jul int, aug int, sep int, oct int, nov int, dec int
) ORDER BY YEAR;