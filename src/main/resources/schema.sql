CREATE TABLE incident(
    id INT AUTO_INCREMENT PRIMARY KEY ,
    date DATE NOT NULL ,
    incident_name VARCHAR(100) NOT NULL ,
    description VARCHAR(500) NOT NULL ,
    location VARCHAR(100) NOT NULL ,
    reporting_person VARCHAR(100) NOT NULL
);
CREATE TABLE picture(
    incident_id INT PRIMARY KEY ,
    path VARCHAR(1000) NOT NULL ,
    CONSTRAINT fk_picture FOREIGN KEY (incident_id) REFERENCES incident(id)
                    ON UPDATE CASCADE
);

CREATE TABLE user(
                     username VARCHAR(100) PRIMARY KEY,
                     password VARCHAR(300) NOT NULL,
                     full_name VARCHAR(100) NOT NULL
);


