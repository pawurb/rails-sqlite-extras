/* Metadata of the indexes, descending by size. */

SELECT
    d.name        AS name,
    s.tbl_name    AS table_name,
    i.name        AS column_name,
    d.payload     AS payload_size,
    d.unused      AS unused_size,
    d.pgsize      AS page_size,
    d.ncell       AS cells,
    d.pageno      AS pages,
    d.mx_payload  AS max_payload_size
FROM
    dbstat AS d,
    sqlite_schema AS s,
    pragma_index_info(d.name) AS i
WHERE
        d.name      = s.name
    AND s.type      = 'index'
    AND d.aggregate = TRUE
ORDER BY page_size DESC;