-- Query 1
SELECT Title 
FROM Material 
WHERE Material_ID NOT IN(SELECT Material_ID FROM Borrow WHERE Return_Date IS NULL);

-- Qeury 2
SELECT Material.Title, Borrow.Borrow_Date, Borrow.Due_Date
FROM Material 
JOIN Borrow ON Material.Material_ID = Borrow.Material_ID
WHERE Borrow.Due_Date < "2023-04-01" AND Borrow.Return_Date IS NULL;

-- Query 3
SELECT Material.Title, COUNT(*) N_Borrowed
FROM Material
JOIN Borrow ON Material.Material_ID = Borrow.Material_ID 
GROUP BY Material.Material_ID 
ORDER BY N_Borrowed DESC 
LIMIT 10;

-- Query 4
SELECT COUNT(*) AS N_Books
FROM Authorship 
JOIN Material ON Authorship.Material_ID = Material.Material_ID 
JOIN Author ON Authorship.Author_ID = Author.Author_ID 
JOIN Catalog ON Material.Catalog_ID = Catalog.Catalog_ID 
WHERE Author.AName = "Lucas Piki" AND Catalog.CName = "book";

-- Query 5
SELECT Title 
FROM Material 
JOIN Authorship ON Material.Material_ID = Authorship.Material_ID 
JOIN Catalog ON Material.Catalog_ID = Catalog.Catalog_ID 
WHERE Catalog.CName = "Book"
GROUP BY Material.Title 
HAVING COUNT(DISTINCT Authorship.Author_ID) >= 2;

-- Query 6
SELECT GName, COUNT(*) AS Count_Most
FROM Genre 
JOIN Material ON Genre.Genre_ID = Material.Genre_ID 
GROUP BY GName 
ORDER BY Count_Most DESC;

-- Query 7
SELECT Title, COUNT(*) AS N_Borrowed
FROM Material
JOIN Borrow ON Material.Material_ID = Borrow.Material_ID
WHERE Borrow_Date >= "2020-09-01" AND Borrow_Date <= "2020-10-31"
GROUP BY Title;

-- Query 8
UPDATE Borrow
SET Return_Date = "2023-04-01"
WHERE Material_ID IN (SELECT Material_ID FROM Material
					 WHERE Title = "Harry Potter and the Philosopher's Stone")
AND Return_Date IS NULL;

-- Query 9
DELETE FROM Borrow WHERE Member_ID = 
(SELECT Member_ID from LMember WHERE MName = "Emily Miller");

DELETE FROM LMember WHERE MName = "Emily Miller";

-- Query 10
INSERT INTO Author(Author_ID, AName)
VALUES
(21, "Lucas Pipi");

INSERT INTO Material(Material_ID, Title, Publication_Date, Catalog_ID, Genre_ID)
VALUES
(32, "New book", "2020-08-01",
(SELECT Catalog_ID FROM Catalog WHERE CName = "E-books"), (SELECT Genre_ID FROM Genre WHERE GName = "Mystery and Thriller"));

INSERT INTO Authorship(Authorship_ID, Material_ID, Author_ID)
VALUES
(34, (SELECT Material_ID FROM Material WHERE Title = "New Book"),  (SELECT Author_ID FROM Author WHERE AName = "Lucas Pipi"));
