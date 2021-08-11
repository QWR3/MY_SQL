#найти все машины старше 2000 г
SELECT * FROM april_2021.cars WHERE year > 2000;	
#найти все машины младше 2015 г
SELECT * FROM april_2021.cars WHERE year < 2015;
#найти все машины 2008, 2009, 2010 годов
SELECT * FROM april_2021.cars WHERE year IN(2008,2009,2010);
#найти все машины не с этих годов 2008, 2009, 2010 годов
SELECT * FROM april_2021.cars WHERE year NOT IN(2008,2009,2010);
#найти все машины год которых совпадает с ценой
SELECT * FROM  april_2021.cars WHERE year = price;
#найти все машины bmw старше 2014 года
SELECT * FROM april_2021.cars WHERE year > 2014 AND model = 'bmw';
#найти все машины audi младше 2014 года;
SELECT * FROM april_2021.cars WHERE model = 'audi' AND year < 2014;
#найти первые 5 машин
SELECT * FROM april_2021.cars LIMIT 5;
#найти последние 5 машин
SELECT * FROM april_2021.cars ORDER BY `id` DESC LIMIT 5;
#найти среднее арифметическое цен машин модели KIA
SELECT AVG(price) FROM april_2021.cars WHERE model = "KIA";
#найти среднее арифметическое цен каждой машины
SELECT AVG(price), model FROM april_2021.cars GROUP BY model; 
#посчитать количество каждой марки машин
SELECT COUNT(model),model FROM april_2021.cars GROUP BY model;
#найти марку машины количество которых больше всего
SELECT COUNT(model),model FROM april_2021.cars GROUP BY model ORDER BY COUNT(model) DESC LIMIT 1;
#найти все машины в модели которых вторая и предпоследняя буква "а"
SELECT * FROM april_2021.cars WHERE model LIKE "_a%a";
#найти все машины модели которых больше 8 символов
SELECT * FROM april_2021.cars WHERE LENGTH(model) = 8;
#
#***найти машины цена которых больше чем цена среднего арифметического всех машин
SELECT AVG(price) FROM april_2021.cars INTO @avgPrice;
SELECT @avgPrice,model,price,id,year from april_2021.cars WHERE price>@avgPrice group by id;