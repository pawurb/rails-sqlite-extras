/* Run integrity checks on the database. */

SELECT integrity_check as message
FROM pragma_integrity_check;