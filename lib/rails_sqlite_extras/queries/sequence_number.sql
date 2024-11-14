/* Sequence numbers of autoincrement columns. */

SELECT name AS table_name, seq AS sequence_number
FROM sqlite_sequence
ORDER BY sequence_number DESC