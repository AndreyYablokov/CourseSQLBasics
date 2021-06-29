CREATE OR REPLACE VIEW top_new_records AS SELECT id FROM messages ORDER BY created_at DESC LIMIT 5;

DELETE FROM messages 
WHERE id NOT IN(SELECT * FROM top_new_records);

SELECT id, created_at FROM messages;