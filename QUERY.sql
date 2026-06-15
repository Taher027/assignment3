CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  full_name varchar(50),
  email varchar(50) UNIQUE NOT NULL,
  role varchar(50) CHECK (role IN ('Ticket Manager', 'Football Fan')),
  phone_number varchar(30)
);


CREATE TABLE matches (
  match_id SERIAL PRIMARY KEY,
  fixture varchar(100) NOT NULL,
  tournament_category varchar(100) NOT NULL,
  base_ticket_price int NOT NULL CHECK (base_ticket_price >= 0),
  match_status varchar(50) NOT NULL CHECK (
    match_status IN ('Available', 'Selling Fast', 'Sold Out')
  )
);


CREATE TABLE Bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id int NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
  match_id int NOT NULL REFERENCES matches (match_id) ON DELETE CASCADE,
  seat_number varchar(15),
  payment_status varchar(50) CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost int NOT NULL CHECK (total_cost >= 0)
);



-- insert data to tables 
INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );


INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );


INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending', 120.00);

 -- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  matches
WHERE
  match_status = 'Available' AND tournament_category = 'Champions League' ;

  -- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
  SELECT
  user_id,
  full_name,
  email
FROM
  users
WHERE
  full_name ILIKE 'Tanvir%' 
OR full_name ILIKE '%Haque%';

-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
SELECT booking_id, match_id, user_id ,'Action Required' as systematic_status from bookings
WHERE payment_status IS NULL;