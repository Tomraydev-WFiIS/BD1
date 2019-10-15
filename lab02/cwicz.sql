CREATE TABLE  test (Imie VARCHAR(32),
                    Numer INT  not null, 
                    Pensja INT check (pensja > 100),
                    Test_id INT PRIMARY KEY, 
                    Kod INT UNIQUE
);
