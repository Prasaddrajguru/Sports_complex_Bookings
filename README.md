# Sports_complex_Bookings

Description - In this project, we are required to build a simple database to help us manage the booking process of a sports complex. The sports complex has the following facilities: 2 tennis courts, 2 badminton courts, 2 multi-purpose fields and 1 archery range. Each facility can be booked for a duration of one hour.

Only registered users are allowed to make a booking. After booking, the complex allows users to cancel their bookings latest by the day prior to the booked date. Cancellation is free. However, if this is the third (or more) consecutive cancellation, the complex imposes a $10 fine.

## Tables
1. members
2. pending_terminations
3. rooms
4. bookings

## Views
1. member_bookings

## Stored Procedures

1. insert_new_member
2. delete_member
3. update_member_password
4. update_member_email
5. make_booking
6. update_payment
7. view_bookings
8. search_room
9. cancel_booking

## Trigger
1. payment_check

## Stored Function
1. check_cancellation

### Creating the Database

We are going to create a database called sports_booking.

```sql
CREATE DATABASE sports_booking;
```

### Using the Database

To use the Database use below query:
```sql
USE sports_booking;
```

### Table creation

#### members table:

The members table has five columns:

id

This column stores the id of each member. 

The id is alphanumeric (VARCHAR(255) will be a good choice) and uniquely identifies each member (in other words, it is a primary key).

password

This column stores the password of each member. It is alphanumeric and cannot be null.

email

This column stores the email of each member. It is also alphanumeric and cannot be null.

member_since

This column stores the timestamp (consisting of the date and time) that a particular member is added to the table. It cannot be null and uses the NOW() function to get the current date and time as the DEFAULT value.

payment_due

This column stores the amount of balance that a member has to pay. The amount is in dollars and cents (e.g. 12.50). The column cannot be null and has a default value of 0.

Refer SQL Query:

```sql
CREATE TABLE members(
id VARCHAR(255) PRIMARY KEY,
password VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
member_since TIMESTAMP NOT NULL DEFAULT NOW(),
payment_due DECIMAL(6,2) NOT NULL DEFAULT 0
);
```

#### pending_terminations table:

The pending_terminations table has four columns: id, email, request_date and payment_due. The data types and constraints of the id, password and payment_due columns match that of the same columns in the members table. The remaining column, request_date, stores the timestamp that a particular member is added to the table. It cannot be null and uses the NOW() function to get the current date and time as the DEFAULT value.

Refer SQL Query:

```sql
CREATE TABLE pending_terminations(
id VARCHAR(255) PRIMARY KEY,
email VARCHAR(255) NOT NULL,
request_date TIMESTAMP NOT NULL DEFAULT NOW(),
payment_due DECIMAL(6,2) NOT NULL DEFAULT 0
);
```

#### rooms table:

id

This column stores the id of each room. It is alphanumeric and uniquely identifies each room.

room_type

This column stores a short description of each room. It is also alphanumeric and cannot be null.

price

This column stores the price of each room. Prices are stored up to 2 decimal places. It cannot be null.

Refer SQL Query:

```sql
CREATE TABLE rooms (
id VARCHAR(255) PRIMARY KEY,
room_type VARCHAR(255) NOT NULL,
price DECIMAL(6,2) NOT NULL
);
```

#### bookings table:

id

This column stores the id of each booking. It is numeric, auto incremented and uniquely identifies each booking.

room_id

This column has the same data type as the id column in the rooms table and cannot be null.

booked_date

This column stores a date in the YYYY-MM-DD format (e.g. '2017-10-18') and cannot be null.

booked_time

This column stores time in the HH:MM:SS format and cannot be null.

member_id

This column has the same data type as the id column in the members table and cannot be null.

datetime_of_booking

This column stores the timestamp that a particular booking is added to the table. It cannot be null and uses the NOW() function to get the current date and
time as the DEFAULT value.

payment_status

This column stores the status of the booking. It is alphanumeric, cannot be null and has a default value of 'Unpaid'.

##### Note:

I have also added the UNIQUE constraint called uc1.

This constraint states that the room_id, booked_date and booked_time columns must be unique. In other words, if one row has the values:

room_id = 'AR', booked_date = '2017-10-18', booked_time =
'11:00:00'

No other rows can have the same combination of values for these three columns.

Refer SQL Query:

```sql
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
```

We also need to add two foreign key's to the bookings table as below:

The first foreign key is called fk1 and links the member_id column with the id column in the members table. In addition, if the record in the parent table is updated or deleted, the record in the child table will also be updated or deleted accordingly.

The second foreign key is called fk2 and links the room_id column with the id column in the rooms table. If the record in the parent table is updated or deleted, the record in the child table will also be updated or deleted accordingly.

Refer SQL Query:

```sql
ALTER TABLE bookings 
ADD CONSTRAINT fk1 FOREIGN KEY(member_id) REFERENCES members(id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk2 FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE ON UPDATE CASCADE;
```

### Inserting Data

#### members table

![image](https://github.com/Prasaddrajguru/Sports_complex_Bookings/assets/148168175/58dae944-f941-41f1-8471-6ae66f79a93f)

Refer SQL Query:

This is one of the syntaxes of the Insert query to insert the records into the particular tables:
```sql
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
```

#### rooms table

![image](https://github.com/Prasaddrajguru/Sports_complex_Bookings/assets/148168175/a82b0061-9126-4fb3-9638-811188f6a434)

This is the second syntax for the Insert query:

Refer SQL Query:

```sql
INSERT INTO rooms (id, room_type, price) VALUES
('AR', 'Archery Range', 120),
('B1', 'Badminton Court', 8),
('B2', 'Badminton Court', 8),
('MPF1', 'Multi Purpose Field', 50),
('MPF2', 'Multi Purpose Field', 60),
('T1', 'Tennis Court', 10),
('T2', 'Tennis Court', 10);
```

#### bookings table

![image](https://github.com/Prasaddrajguru/Sports_complex_Bookings/assets/148168175/a414e00a-5d1d-491d-9cb9-15b3e146e80d)

Refer SQL Query:

```sql
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
```

### View Creation

Now we will create a view that shows us all the booking details of a booking.

To create a view, we will use the bookings and rooms table.

Refer SQL Query:

```sql
CREATE VIEW member_bookings AS
SELECT b.id,b.room_id,r.room_type,b.booked_date,b.booked_time,b.member_id,b.datetime_of_booking,r.price,b.payment_status
FROM bookings b
JOIN rooms r
ON b.room_id = r.id
ORDER BY b.id
```

### Stored procedures

#### insert_new_member

The first stored procedure is for inserting a new member into the members table.

The members table has a total of 5 columns: id, password, email, member_since and payment_due.

As the last two columns have default values, we only need to provide values for the first three columns when inserting a new member.

Refer SQL Query:

```sql
DELIMITER $$

CREATE PROCEDURE inser_new_member(IN p_id VARCHAR(255),IN p_password VARCHAR(255),IN p_email VARCHAR(255))
BEGIN
	INSERT INTO members(p_id,p_password,p_email) VALUES (p_id,p_password,p_email);
END $$

DELIMITER ;
```

#### delete_member

This procedure is for deleting a member from the members table.

This stored procedure only has one IN parameter, p_id. Its data type matches that of the id column in the members table.

Within the procedure, we have a DELETE statement that deletes the member whose id equals p_id.

Refer SQL Query:

```sql
DELIMITER $$

CREATE PROCEDURE delete_member(IN p_id VARCHAR(255))
BEGIN
	DELETE FROM members WHERE id = p_id;
END $$

DELIMITER ;
```

#### update_member_password and update_member_email

The first stored procedure is called update_member_password and has two IN parameters, p_id and p_password.

The second procedure is called update_member_email and has two IN parameters, p_id and p_email.

Both procedures use the UPDATE statement to update the password and email of a member with id = p_id.

Refer SQL Query:

```sql
DELIMITER $$

CREATE PROCEDURE update_member_password(IN p_id VARCHAR(255),IN p_password VARCHAR(255))
BEGIN
	UPDATE members SET password = p_password WHERE id = p_id;
END $$

CREATE PROCEDURE update_member_email(IN p_id VARCHAR(255),IN p_email VARCHAR(255))
BEGIN
	UPDATE members SET email = p_email WHERE id = p_id;
END $$

DELIMITER ;
```

#### make_booking

The make_booking procedure is for making a new booking. We need to insert the booking into the bookings table and update the members table to reflect the charges that the member making the booking needs to pay.

The procedure has four IN parameters, p_room_id, p_booked_date, p_booked_time and p_member_id.

The data types of the parameters match the data types of the room_id, booked_date, booked_time and member_id columns of the bookings table.

Refer SQL Query:

```sql
DELIMITER $$

CREATE PROCEDURE make_booking(IN p_roomid VARCHAR(255), p_booked_date DATE,p_booked_time TIME,p_member_id VARCHAR(255))
BEGIN
	DECLARE v_price DECIMAL(6,2);
    DECLARE v_payment_due DECIMAL(6,2);
    
    SELECT price INTO v_price FROM rooms WHERE id = p_room_id;
    INSERT INTO bookings(room_id,booked_date,booked_time,member_id) VALUES (p_room_id,p_booked_date, p_booked_time,p_member_id);
    SELECT payment_due INTO v_payment_due FROM members WHERE id = p_member_id;
	UPDATE members SET payment_due = v_payment_due + v_price WHERE id = p_member_id;
END $$

DELIMITER ;
```

#### update_payment

This procedure is for updating the bookings and members tables after a member makes payment for his/her booking.

The update_payment procedure has one IN parameter called p_id, whose data type matches the id column of the bookings table.

Refer SQL Query:

```sql
DELIMITER $$

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

DELIMITER ;
```

#### view_bookings

This procedure allows us to view all the bookings made by a particular member and has one IN parameter called p_id that identifies the member.

Refer SQL Query:

```sql
DELIMITER $$

CREATE PROCEDURE view_bookings(IN p_id VARCHAR(225))
BEGIN
	SELECT * FROM member_bookings WHERE id = p_id;
END $$

DELIMITER ;
```

#### search_room

This procedure will allow us to search for available rooms.

It has three IN parameters, p_room_type, p_booked_date and p_booked_time.

Refer SQL Query:

```sql
DELIMITER $$

CREATE PROCEDURE search_room (IN p_room_type VARCHAR(255), IN p_booked_date DATE, IN p_booked_time TIME)
BEGIN
	SELECT * FROM rooms WHERE id NOT IN (
		SELECT room_id FROM bookings 
		WHERE booked_date = p_booked_date 
		AND booked_time = p_booked_time 
		AND payment_status != 'Cancelled') 
    AND room_type = p_room_type;
END $$

DELIMITER ;
```

#### cancel_booking

This procedure has an IN parameter called p_booking_id (whose data type corresponds to the data type of the id column in the bookings table) and an OUT parameter called p_message (that is of VARCHAR(255) type).

Now, we will declare some variables:

1. v_cancellation
2. v_member_id
3. v_payment_status
4. v_booked_date
5. v_price
6. v_payment_due

And SET v_cancellation to 0.

Now, we need to select the member_id, booked_date, price and payment_status columns from the member_bookings view where id = p_booking_id and store them into the v_member_id, v_booked_date, v_price and v_payment_status variables respectively.

In addition, we need to select the payment_due column from the members table for the member making the cancellation (WHERE id = v_member_id) and store the result into the v_payment_due variable.

Also, The sports complex allows members to cancel their bookings latest by the day prior to the booked date. In addition, members are not allowed to cancel bookings that have already
been cancelled or paid for.

Now, we need to update the bookings table to change the payment_status column to 'Cancelled' for this particular booking.

Next, we need to calculate how much the member owes the sports complex now.

Next, we need to check if this is the third consecutive cancellation by the member. If it is, we’ll impose a $10 fine on the member.

For the last step, we simply need to use a SELECT statement to store the message 'Booking Cancelled' into the OUT parameter.

Refer SQL Query:

```sql
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
```

### Triggers

#### payment_check

This trigger checks the outstanding balance of a member, which is recorded in the payment_due column of the members table.

If payment_due is more than $0 and the member terminates his/her account, we’ll transfer the data to the pending_terminations table. This table records all the termination requests that are pending due to an outstanding payment.

Refer SQL Query:

```sql
DELIMITER $$

CREATE TRIGGER payment_check BEFORE DELETE ON members FOR EACH ROW
BEGIN
	DECLARE v_payment_due DECIMAL(6, 2);
	SELECT payment_due INTO v_payment_due FROM members WHERE id = OLD.id;
    
	IF v_payment_due > 0 THEN
		INSERT INTO pending_terminations (id, email,payment_due) VALUES (OLD.id, OLD.email, OLD.payment_due);
	END IF;
END $$

DELIMITER ;
```

### Stored Function

#### check_cancellation

This function checks the number of consecutive cancellations made by the member who's trying to cancel a booking. It has one parameter p_booking_id whose data type matches that of the id column in the bookings table. In addition, it returns an integer and is deterministic.

Refer SQL Query:

```sql
DELIMITER $$

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

DELIMITER ;
```

