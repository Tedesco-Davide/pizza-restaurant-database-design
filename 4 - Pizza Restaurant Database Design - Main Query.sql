------------ Tables creation ------------

-- Customer orders

USE PizzaRestaurant
CREATE TABLE Orders (
	row_id INT,
	order_id VARCHAR(10),
	created_at DATETIME,
	item_id INT,
	quantity INT,
	customer_id INT,
	delivery BIT,
	address_id INT,
    CONSTRAINT PK_Orders PRIMARY KEY(row_id)
)

USE PizzaRestaurant
CREATE TABLE Customers (
	customer_id INT,
	customer_firstname VARCHAR(50),
	customer_lastname VARCHAR(50),
	CONSTRAINT PK_Customers PRIMARY KEY(customer_id)
)

USE PizzaRestaurant
CREATE TABLE Addresses (
	address_id INT,
	delivery_address1 VARCHAR(200),
	delivery_address2 VARCHAR(200) NULL,
	delivery_city VARCHAR(50),
	delivery_zipcode VARCHAR(20),
	CONSTRAINT PK_Addresss PRIMARY KEY(address_id)
)

USE PizzaRestaurant
CREATE TABLE Items (
	item_id INT,
	sku VARCHAR(20),
	item_name VARCHAR(100),
	item_cat VARCHAR(100),
	item_size VARCHAR(50),
	item_price DECIMAL(10,2),
	CONSTRAINT PK_Items PRIMARY KEY(item_id)
)

-- Stock control

USE PizzaRestaurant
CREATE TABLE Recipes (
	row_id INT,
	recipe_id VARCHAR(20),
	ingredient_id VARCHAR(20),
	quantity INT,
	CONSTRAINT PK_Recipes PRIMARY KEY(row_id)
)

USE PizzaRestaurant
CREATE TABLE Ingredients (
	ingredient_id VARCHAR(20),
	ingredient_name VARCHAR(200),
	ingredient_weight INT,
	ingredient_measure_unit VARCHAR(20),
	ingredient_price DECIMAL(10,2),
	CONSTRAINT PK_Ingredients PRIMARY KEY(ingredient_id)
)

USE PizzaRestaurant
CREATE TABLE Inventory (
	inventory_id INT,
	ingredient_id VARCHAR(20),
	quantity INT,
	CONSTRAINT PK_Inventory PRIMARY KEY(inventory_id)
)

-- Staff management

USE PizzaRestaurant
CREATE TABLE Schedules (
	row_id INT,
	schedule_id VARCHAR(20),
	schedule_date DATETIME,
	shift_id VARCHAR(20),
	staff_id VARCHAR(20),
	CONSTRAINT PK_Schedules PRIMARY KEY(row_id)
)

USE PizzaRestaurant
CREATE TABLE Staff (
	staff_id VARCHAR(20),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	position VARCHAR(100),
	hourly_rate DECIMAL(5,2),
	CONSTRAINT PK_Staff PRIMARY KEY(staff_id)
)

USE PizzaRestaurant
CREATE TABLE Shifts (
	shift_id VARCHAR(20),
	day_of_week VARCHAR(10),
	start_time TIME,
	end_time TIME,
	CONSTRAINT PK_Shifts PRIMARY KEY(shift_id)
)

------------ Foreign keys creation ------------

-- Towards Orders

ALTER TABLE Addresses ADD CONSTRAINT FK_Customer_Address FOREIGN KEY(address_id) 
REFERENCES Orders(address_id)
ALTER TABLE Addresses CHECK CONSTRAINT FK_Customer_Address

ALTER TABLE Items ADD CONSTRAINT FK_Item_Properties FOREIGN KEY(item_id) 
REFERENCES Orders(item_id)
ALTER TABLE Items CHECK CONSTRAINT FK_Item_Properties

ALTER TABLE Customers ADD CONSTRAINT FK_Customer_Info FOREIGN KEY(customer_id) 
REFERENCES Orders(customer_id)
ALTER TABLE Customers CHECK CONSTRAINT FK_Customer_Info

ALTER TABLE Schedules ADD CONSTRAINT FK_Order_Created_From FOREIGN KEY(schedule_date) 
REFERENCES Orders(created_at)
ALTER TABLE Schedules CHECK CONSTRAINT FK_Order_Created_From

-- Towards Items

ALTER TABLE Recipes ADD CONSTRAINT FK_Recipe_Item FOREIGN KEY(recipe_id) 
REFERENCES Items(sku)
ALTER TABLE Recipes CHECK CONSTRAINT FK_Recipe_Item

-- Towards Recipes

ALTER TABLE Ingredients ADD CONSTRAINT FK_Ingredient_Info FOREIGN KEY(ingredient_id) 
REFERENCES Recipes(ingredient_id)
ALTER TABLE Ingredients CHECK CONSTRAINT FK_Ingredient_Info

ALTER TABLE Inventory ADD CONSTRAINT FK_Ingredient_Stock_Info FOREIGN KEY(ingredient_id) 
REFERENCES Recipes(ingredient_id)
ALTER TABLE Inventory CHECK CONSTRAINT FK_Ingredient_Stock_Info

-- Towards Schedules

ALTER TABLE Shifts ADD CONSTRAINT FK_Schedule_Shift_Info FOREIGN KEY(shift_id)
REFERENCES Schedules(shift_id)
ALTER TABLE Shifts CHECK CONSTRAINT FK_Schedule_Shift_Info

-- Towards Staff

ALTER TABLE Schedules ADD CONSTRAINT FK_Staff_Info FOREIGN KEY(staff_id)
REFERENCES Staff(staff_id)
ALTER TABLE Schedules CHECK CONSTRAINT FK_Staff_Info      