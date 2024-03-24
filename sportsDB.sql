-- Database creation
CREATE DATABASE sports_booking;

-- Use below command if wants to delete the database
-- DROP DATABASE sports_booinking;

-- TO use the database
USE sports_booking;

-- members table Creation
CREATE TABLE members(
id VARCHAR(255) PRIMARY KEY,
password VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
member_since TIMESTAMP NOT NULL DEFAULT NOW(),
payment_due DECIMAL(6,2) NOT NULL DEFAULT 0
);

-- pending_terminations table Creation
CREATE TABLE pending_terminations(
id VARCHAR(255) PRIMARY KEY,
email VARCHAR(255) NOT NULL,
request_date TIMESTAMP NOT NULL DEFAULT NOW(),
payment_due DECIMAL(6,2) NOT NULL DEFAULT 0
);

-- rooms table Creation
CREATE TABLE rooms (
id VARCHAR(255) PRIMARY KEY,
room_type VARCHAR(255) NOT NULL,
price DECIMAL(6,2) NOT NULL
);

-- bookings table Creation
CREATE TABLE bookings (
id INT AUTO_INCREMENT PRIMARY KEY,
room_id VARCHAR(255) NOT NULL,
booked_date DATE NOT NULL,
booked_time TIME NOT NULL,
member_id VARCHAR(255) NOT NULL,
datetime_of_booking TIMESTAMP NOT NULL DEFAULT NOW(),
payment_status VARCHAR(255) NOT NULL DEFAULT 'Unpaid',

CONSTRAINT uc1 UNIQUE (room_id,booked_date,booked_time)
);

-- To modify the table
ALTER TABLE bookings 
ADD CONSTRAINT fk1 FOREIGN KEY(member_id) REFERENCES members(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk2 FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Record Insertion (syntax 1)
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('afeil','feik1988<3','Abdul.Feil@hotmail.com','2017-04-15 12:10:13',0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('amely_18', 'loseweightin18', 'Amely.Bauch91@yahoo.com', '2018-02-06 16:48:43', 0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('bbahringer', 'iambeau17', 'Beaulah_Bahringer@yahoo.com', '2017-12-28 05:36:50', 0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('little31', 'whocares31', 'Anthony_Little31@gmail.com', '2017-06-01 21:12:11', 10);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('macejkovic73', 'jadajeda12', 'Jada.Macejkovic73@gmail.com','2017-05-30 17:30:22', 0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('marvin1', 'if0909mar', 'Marvin_Schulist@gmail.com', '2017-09-09 02:30:49', 10);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('nitzsche77', 'bret77@#', 'Bret_Nitzsche77@gmail.com', '2018-01-09 17:36:49', 0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('noah51', '18Oct1976#51', 'Noah51@gmail.com', '2017-12-16 22:59:46', 0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('oreillys', 'reallycool#1', 'Martine_OReilly@yahoo.com', '2017-10-12 05:39:20', 0);
INSERT INTO members(id,password,email,member_since,payment_due) VALUES ('wyattgreat', 'wyatt111', 'Wyatt_Wisozk2@gmail.com', '2017-07-18 16:28:35', 0);

-- Record Insertion (syntax 2)
INSERT INTO rooms (id, room_type, price) VALUES
('AR', 'Archery Range', 120),
('B1', 'Badminton Court', 8),
('B2', 'Badminton Court', 8),
('MPF1', 'Multi Purpose Field', 50),
('MPF2', 'Multi Purpose Field', 60),
('T1', 'Tennis Court', 10),
('T2', 'Tennis Court', 10);

-- Record Insertion (syntax 2)
INSERT INTO bookings (id, room_id, booked_date, booked_time,member_id, datetime_of_booking, payment_status) VALUES
(1, 'AR', '2017-12-26', '13:00:00', 'oreillys', '2017-12-20 20:31:27', 'Paid'),
(2, 'MPF1', '2017-12-30', '17:00:00', 'noah51', '2017-12-22 05:22:10', 'Paid'),
(3, 'T2', '2017-12-31', '16:00:00', 'macejkovic73', '2017-12-28 18:14:23', 'Paid'),
(4, 'T1', '2018-03-05', '08:00:00', 'little31', '2018-02-22 20:19:17', 'Unpaid'),
(5, 'MPF2', '2018-03-02', '11:00:00', 'marvin1', '2018-03-01 16:13:45', 'Paid'),
(6, 'B1', '2018-03-28', '16:00:00', 'marvin1', '2018-03-23 22:46:36', 'Paid'),
(7, 'B1', '2018-04-15', '14:00:00', 'macejkovic73', '2018-04-12 22:23:20', 'Cancelled'),
(8, 'T2', '2018-04-23', '13:00:00', 'macejkovic73', '2018-04-19 10:49:00', 'Cancelled'),
(9, 'T1', '2018-05-25', '10:00:00', 'marvin1', '2018-05-21 11:20:46', 'Unpaid'),
(10, 'B2', '2018-06-12', '15:00:00', 'bbahringer', '2018-05-30 14:40:23', 'Paid');

-- Create View
CREATE VIEW member_bookings AS
SELECT b.id,b.room_id,r.room_type,b.booked_date,b.booked_time,b.member_id,b.datetime_of_booking,r.price,b.payment_status
FROM bookings b
JOIN rooms r
ON b.room_id = r.id
ORDER BY b.id


/* Now we will create the stored procedures and function.
We will also change the delimiter to the $$ and will change it back to the ; once we finish the stored procedures */

DELIMITER $$

# insert_new_member

CREATE PROCEDURE inser_new_member(IN p_id VARCHAR(255),IN p_password VARCHAR(255),IN p_email VARCHAR(255))
BEGIN
	INSERT INTO members(p_id,p_password,p_email) VALUES (p_id,p_password,p_email);
END $$


# delete_member
CREATE PROCEDURE delete_member(IN p_id VARCHAR(255))
BEGIN
	DELETE FROM members WHERE id = p_id;
END $$

# update_member_password
CREATE PROCEDURE update_member_password(IN p_id VARCHAR(255),IN p_password VARCHAR(255))
BEGIN
	UPDATE members SET password = p_password WHERE id = p_id;
END $$

# update_member_email
CREATE PROCEDURE update_member_email(IN p_id VARCHAR(255),IN p_email VARCHAR(255))
BEGIN
	UPDATE members SET email = p_email WHERE id = p_id;
END $$

# make_booking
CREATE PROCEDURE make_booking(IN p_roomid VARCHAR(255), p_booked_date DATE,p_booked_time TIME,p_member_id VARCHAR(255))
BEGIN
	DECLARE v_price DECIMAL(6,2);
    DECLARE v_payment_due DECIMAL(6,2);
    
    SELECT price INTO v_price FROM rooms WHERE id = p_room_id;
    INSERT INTO bookings(room_id,booked_date,booked_time,member_id) VALUES (p_room_id,p_booked_date, p_booked_time,p_member_id);
    SELECT payment_due INTO v_payment_due FROM members WHERE id = p_member_id;
	UPDATE members SET payment_due = v_payment_due + v_price WHERE id = p_member_id;
END $$

# update_payment
CREATE PROCEDURE update_payment (IN p_id INT)
BEGIN
	DECLARE v_member_id VARCHAR(255);
	DECLARE v_payment_due DECIMAL(6, 2);
	DECLARE v_price DECIMAL(6, 2);

	UPDATE bookings SET payment_status = 'Paid' WHERE id = p_id;
	SELECT member_id, price INTO v_member_id, v_price FROM member_bookings WHERE id = p_id;
	SELECT payment_due INTO v_payment_due FROM members WHERE id = v_member_id;
	UPDATE members SET payment_due = v_payment_due - v_price WHERE id = v_member_id;
END $$

# view_bookings
CREATE PROCEDURE view_bookings(IN p_id VARCHAR(225))
BEGIN
	SELECT * FROM member_bookings WHERE id = p_id;
END $$

# search_room
CREATE PROCEDURE search_room (IN p_room_type VARCHAR(255), IN p_booked_date DATE, IN p_booked_time TIME)
BEGIN
	SELECT * FROM rooms WHERE id NOT IN (
		SELECT room_id FROM bookings 
		WHERE booked_date = p_booked_date 
		AND booked_time = p_booked_time 
		AND payment_status != 'Cancelled') 
    AND room_type = p_room_type;
END $$

# cancel_booking
CREATE PROCEDURE cancel_booking (IN p_booking_id INT, OUT p_message VARCHAR(255))
BEGIN
	DECLARE v_cancellation INT;
	DECLARE v_member_id VARCHAR(255);
	DECLARE v_payment_status VARCHAR(255);
	DECLARE v_booked_date DATE;
	DECLARE v_price DECIMAL(6, 2);
	DECLARE v_payment_due VARCHAR(255);
	SET v_cancellation = 0;
    
    SELECT member_id, booked_date, price, payment_status INTO v_member_id, v_booked_date, v_price, v_payment_status 
    FROM member_bookings WHERE id = p_booking_id;
    
    SELECT payment_due INTO v_payment_due 
    FROM members WHERE id = v_member_id;
    
    IF curdate() >= v_booked_date THEN 
		SELECT 'Cancellation cannot be done on/after the booked date' INTO p_message;
        
		ELSEIF v_payment_status = 'Cancelled' OR v_payment_status = 'Paid' THEN 
        SELECT 'Booking has already been cancelled or paid' INTO p_message;
        
		ELSE 
			UPDATE bookings SET payment_status = 'Cancelled' WHERE id = p_booking_id;
    
			SET v_payment_due = v_payment_due - v_price;
			SET v_cancellation = check_cancellation(p_booking_id);
	
			IF v_cancellation >= 2 THEN SET v_payment_due = v_payment_due + 10;
			END IF;
    
			UPDATE members SET payment_due = v_payment_due WHERE id = v_member_id;
    
			SELECT 'Booking Cancelled' INTO p_message;
	END IF;
END $$

# payment_check
CREATE TRIGGER payment_check BEFORE DELETE ON members FOR EACH ROW
BEGIN
	DECLARE v_payment_due DECIMAL(6, 2);
	SELECT payment_due INTO v_payment_due FROM members WHERE id = OLD.id;
    
	IF v_payment_due > 0 THEN
		INSERT INTO pending_terminations (id, email,payment_due) VALUES (OLD.id, OLD.email, OLD.payment_due);
	END IF;
END $$

# check_cancellation
CREATE FUNCTION check_cancellation (p_booking_id INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_done INT;
	DECLARE v_cancellation INT;
	DECLARE v_current_payment_status VARCHAR(255);
	DECLARE cur CURSOR FOR
		SELECT payment_status FROM bookings WHERE member_id = (SELECT member_id FROM bookings WHERE id = p_booking_id) ORDER BY datetime_of_booking DESC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;
	SET v_done = 0;
	SET v_cancellation = 0;
	OPEN cur;
	cancellation_loop : LOOP
		FETCH cur INTO v_current_payment_status;
		IF v_current_payment_status != 'Cancelled' OR v_done = 1 THEN LEAVE cancellation_loop;
			ELSE SET v_cancellation = v_cancellation + 1;
		END IF;
	END LOOP;
	CLOSE cur;
	RETURN v_cancellation;
END $$

