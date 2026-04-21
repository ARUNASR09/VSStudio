CREATE TABLE IF NOT EXISTS courses (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL,
  rating DECIMAL(3,1) NOT NULL
);

INSERT INTO courses (name, rating) VALUES
('Docker and Kubernetes', 4.5),
('AI-102 Azure AI Engineer', 4.6),
('AZ-104 Azure Administrator', 4.7);