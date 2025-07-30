USE meubanco;

CREATE TABLE IF NOT EXISTS mensagens (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    comentario TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO mensagens (id, nome, email, comentario) VALUES 
(1, 'João Silva', 'joao@example.com', 'Este é um comentário de teste'),
(2, 'Maria Santos', 'maria@example.com', 'Outro comentário de exemplo');