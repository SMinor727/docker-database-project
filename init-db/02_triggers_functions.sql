CREATE OR REPLACE FUNCTION seats_taken(p_event_id INT)
RETURNS INT LANGUAGE sql AS $$
  SELECT COUNT(*) FROM registrations
  WHERE event_id=p_event_id AND status IN ('registered','checked_in');
$$;

CREATE OR REPLACE FUNCTION register_user(p_event_id INT,p_user_id INT)
RETURNS TEXT LANGUAGE plpgsql AS $$
DECLARE
  cap INT; taken INT; next_pos INT;
BEGIN
  SELECT capacity INTO cap FROM events WHERE event_id=p_event_id;
  taken:=seats_taken(p_event_id);
  IF taken<cap THEN
    INSERT INTO registrations(event_id,user_id,status)
    VALUES(p_event_id,p_user_id,'registered'); RETURN 'registered';
  ELSE
    SELECT COALESCE(MAX(waitlist_position),0)+1 INTO next_pos
    FROM registrations WHERE event_id=p_event_id AND waitlist_position IS NOT NULL;
    INSERT INTO registrations(event_id,user_id,status,waitlist_position)
    VALUES(p_event_id,p_user_id,'waitlisted',next_pos); RETURN 'waitlisted';
  END IF;
END;
$$;

CREATE OR REPLACE FUNCTION promote_from_waitlist()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
DECLARE promote_id INT; cap INT; taken INT;
BEGIN
  IF TG_OP='UPDATE' AND NEW.status='canceled' THEN
    SELECT capacity INTO cap FROM events WHERE event_id=NEW.event_id;
    taken:=seats_taken(NEW.event_id);
    IF taken<cap THEN
      SELECT registration_id INTO promote_id FROM registrations
       WHERE event_id=NEW.event_id AND status='waitlisted'
       ORDER BY waitlist_position LIMIT 1;
      IF promote_id IS NOT NULL THEN
        UPDATE registrations SET status='registered',waitlist_position=NULL,
        registered_at=CURRENT_TIMESTAMP WHERE registration_id=promote_id;
      END IF;
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_promote_waitlist
AFTER UPDATE ON registrations
FOR EACH ROW EXECUTE FUNCTION promote_from_waitlist();
