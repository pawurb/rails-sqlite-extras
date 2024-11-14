/* Metadata of the tables (excluding indexes), descending by size. */
SELECT
    name,
    payload AS payload_size,
    unused as unused_size,
    pgsize - payload - unused as vacuum_size,
    pgsize as page_size,
    ncell as cells,
    pageno as pages,
    mx_payload as max_payload_size
FROM dbstat
WHERE
    name IN (SELECT name FROM sqlite_schema WHERE type='table')
    AND aggregate=TRUE
ORDER BY page_size DESC;