SELECT c.fname, o.date_placed FROM customer c JOIN orderinfo o ON c.customer_id=o.customer_id WHERE c.fname = 'Ann' AND c.lname = 'Stones';
