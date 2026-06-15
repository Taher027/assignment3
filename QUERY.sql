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