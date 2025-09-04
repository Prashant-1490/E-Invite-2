-- Sample data for E-Invite application
-- Run this script after setup-database.sql to populate with sample data

-- Sample events data
INSERT INTO "events" ("name_gujarati", "name_english", "time_gujarati", "time_english", "datetime", "icon", "image_url", "color_scheme", "sort_order") VALUES
    ('હરિદ્રા', 'Haldi Ceremony', 'સવારે ૧૦:૦૦ વાગ્યે', '10:00 AM', '2024-12-15 10:00:00', 'sun', NULL, 'yellow', 1),
    ('મહેંદી', 'Mehndi Ceremony', 'સાંજે ૪:૦૦ વાગ્યે', '4:00 PM', '2024-12-16 16:00:00', 'hand', NULL, 'green', 2),
    ('સંગમ', 'Sangam', 'સાંજે ૭:૦૦ વાગ્યે', '7:00 PM', '2024-12-17 19:00:00', 'music', NULL, 'purple', 3),
    ('લગ્ન', 'Wedding', 'સવારે ૮:૦૦ વાગ્યે', '8:00 AM', '2024-12-18 08:00:00', 'heart', NULL, 'red', 4),
    ('રિસેપ્શન', 'Reception', 'સાંજે ૭:૦૦ વાગ્યે', '7:00 PM', '2024-12-18 19:00:00', 'party', NULL, 'blue', 5);

-- Sample couples data
INSERT INTO "couples" ("groom_name_gujarati", "groom_name_english", "bride_name_gujarati", "bride_name_english", "couple_slug") VALUES
    ('રાજ પટેલ', 'Raj Patel', 'પ્રિયા શાહ', 'Priya Shah', 'raj-priya'),
    ('અમિત ગુપ્તા', 'Amit Gupta', 'રિયા જોશી', 'Riya Joshi', 'amit-riya');

-- Sample gifts/donations data
INSERT INTO "gifts" ("donor_name_gujarati", "donor_name_english", "organization_gujarati", "organization_english", "gift_description_gujarati", "gift_description_english", "gift_icon", "amount") VALUES
    ('શ્રી રમેશ પટેલ', 'Shri Ramesh Patel', 'પટેલ ફેમિલી', 'Patel Family', 'સોનાની વાસણો', 'Gold Utensils', 'gift', 25000),
    ('શ્રીમતી સુનીતા શાહ', 'Smt. Sunita Shah', 'શાહ ફેમિલી', 'Shah Family', 'ચાંદીની થાળી', 'Silver Plate Set', 'gift', 15000),
    ('શ્રી કિરણ ભાઈ', 'Shri Kiran Bhai', 'મિત્ર મંડળ', 'Friends Circle', 'કેશ ગિફ્ટ', 'Cash Gift', 'money', 5000),
    ('શ્રીમતી મીના દેવી', 'Smt. Meena Devi', 'સમાજ સેવા સંસ્થા', 'Social Service Organization', 'વસ્ત્રો', 'Clothes', 'shirt', 8000);

-- Sample contact information
INSERT INTO "contact_info" ("organization_gujarati", "organization_english", "address_gujarati", "address_english", "phone_number", "whatsapp_number", "email", "is_primary") VALUES
    ('પટેલ ફેમિલી', 'Patel Family', '૧૨૩, રામ નગર, અમદાવાદ', '123, Ram Nagar, Ahmedabad', '+91-9876543210', '+91-9876543210', 'patel.family@email.com', true),
    ('શાહ ફેમિલી', 'Shah Family', '૪૫૬, શાંતિ સોસાયટી, સુરત', '456, Shanti Society, Surat', '+91-9876543211', '+91-9876543211', 'shah.family@email.com', false);

-- Print success message
DO $$
BEGIN
    RAISE NOTICE 'Sample data inserted successfully!';
END $$;
