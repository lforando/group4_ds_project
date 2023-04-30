-- Table: listings
DROP TABLE IF EXISTS listings;
CREATE TABLE listings(
    id int PRIMARY KEY,
    listing_url text,
    scrape_id bigint,
    last_scraped datetime,
    name text,
    description text,
    neighborhood_overview text,
    picture_url text,
    host_id integer,
    host_url text,
    host_name text,
    host_since date,
    host_location text,
    host_about text,
    host_response_time blob,
    host_response_rate blob,
    host_acceptance_rate blob,
    host_is_superhost boolean,
    host_thumbnail_url text,
    host_picture_url text,
    host_neighbourhood text,
    host_listings_count text,
    host_total_listings_count text,
    host_verifications blob,
    host_has_profile_pic boolean,
    host_identity_verified boolean,
    neighbourhood text,
    neighbourhood_cleansed text,
    neighbourhood_group_cleansed text,
    latitude numeric,
    longitude numeric,
    property_type text,
    room_type text,
    accommodates integer,
    bathrooms numeric,
    bathrooms_text string,
    bedrooms integer,
    beds integer,
    amenities json,
    price currency,
    minimum_nights integer,
    maximum_nights integer,
    minimum_minimum_nights integer,
    maximum_minimum_nights integer,
    minimum_maximum_nights integer,
    maximum_maximum_nights integer,
    minimum_nights_avg_ntm numeric,
    maximum_nights_avg_ntm numeric,
    calendar_updated date,
    has_availability boolean,
    availability_30 integer,
    availability_60 integer,
    availability_90 integer,
    availability_365 integer,
    calendar_last_scraped date,
    number_of_reviews integer,
    number_of_reviews_ltm integer,
    number_of_reviews_l30d integer,
    first_review date,
    last_review date,
    review_scores_rating blob,
    review_scores_accuracy blob,
    review_scores_cleanliness blob,
    review_scores_checkin blob,
    review_scores_communication blob,
    review_scores_location blob,
    review_scores_value blob,
    license text,
    instant_bookable boolean,
    calculated_host_listings_count integer,
    calculated_host_listings_count_entire_homes integer,
    calculated_host_listings_count_private_rooms integer,
    calculated_host_listings_count_shared_rooms integer,
    reviews_per_month integer
);

-- Table: reviews
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews(
    id int PRIMARY KEY,
    listing_id int,
    date blob,
    reviewer_id blob,
    reviewer_name blob,
    comments blob
);

-- Table: calendar
DROP TABLE IF EXISTS calendar;
CREATE TABLE calendar(
    listing_id int,
    date datetime,
    available boolean,
    price currency,
    adjusted_price blob,
    minimum_nights integer,
    maximum_nights integer
);

-- Table: weather
DROP TABLE IF EXISTS weather;
CREATE TABLE weather(
    id int PRIMARY KEY,
    weatherdate datetime,
    tempmax numeric,
    tempmin  numeric,
    tempday  numeric,
    feelslikemax numeric,
    feelslikemin numeric,
    dew numeric,
    humidity numeric,
    precip numeric,
    precipprob numeric,
    precipcover numeric,
    preciptype  numeric,
    snow numeric,
    snowdepth numeric,
    winggust numeric,
    windspeed numeric,
    winddir numeric,
    sealevelpressure numeric,
    cloudcover numeric,
    visibility  numeric,
    solarradition numeric,
    solarenergy numeric,
    uvindex numeric,
    severerisk numeric,
    sunrise datetime,
    sunset datetime,
    moonphase numeric,
    conditions text,
    description text,
    icon text,
    stations text,
     text
);

-- Table: property_info
DROP TABLE IF EXISTS property_info;
CREATE TABLE property_info(
    PROPTYPE text,
    NBHDNAME text,
    ASSESSMENT float
);
