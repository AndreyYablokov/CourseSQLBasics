SET @user_id = 1001;

SELECT COUNT(*) as count_messages, from_user_id FROM messages
WHERE (
to_user_id = @user_id 
AND 
from_user_id IN (
SELECT initiator_user_id FROM friend_requests
WHERE target_user_id = @user_id AND status = 'approved'
UNION
SELECT target_user_id FROM friend_requests
WHERE initiator_user_id = @user_id and status = 'approved'))
GROUP BY from_user_id
ORDER BY count_messages DESC
LIMIT 1;