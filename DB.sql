CREATE DATABASE IF NOT EXISTS cafeteria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cafeteria;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario CHAR(5) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL,
    tipo ENUM('admin', 'financeiro', 'atendente') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cardapio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    custo DECIMAL(10,2) DEFAULT 0.00,
    lucro DECIMAL(10,2) AS (preco - custo) STORED,
    descricao TEXT,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela pedidos 
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_custom CHAR(5) NOT NULL UNIQUE,
    cliente_nome VARCHAR(100),
    status ENUM('EM PREPARO', 'PRONTO', 'ENTREGUE') DEFAULT 'EM PREPARO',
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    cardapio_id INT,
    quantidade DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (cardapio_id) REFERENCES cardapio(id) ON DELETE RESTRICT
);

CREATE TABLE contas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('PAGAR', 'RECEBER') NOT NULL,
    descricao VARCHAR(255),
    valor DECIMAL(10,2) NOT NULL,
    status ENUM('PENDENTE', 'PAGO', 'RECEBIDO') DEFAULT 'PENDENTE',
    data_vencimento DATE,
    data_pagamento DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_custom CHAR(5) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    unidade VARCHAR(20),
    quantidade DECIMAL(10,2) DEFAULT 0,
    tipo ENUM('INGREDIENTE', 'EMBALAGEM') NOT NULL
);

-- Entradas de estoque (compras)
CREATE TABLE entradas_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade DECIMAL(10,2),
    nota_fiscal VARCHAR(50),
    data_entrada DATE,
    FOREIGN KEY (produto_id) REFERENCES produtos_estoque(id) ON DELETE CASCADE
);

CREATE TABLE producao_diaria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_producao DATE,
    produto VARCHAR(100),
    quantidade DECIMAL(10,2)
);

INSERT INTO usuarios (id_usuario, nome, email, senha, tipo) VALUES
('A0001', 'Admin Master', 'admin@cafe.com', '1234', 'admin'),
('F0001', 'Finan', 'finan@cafe.com', 'fin123', 'financeiro'),
('O0001', 'Atendente', 'aten@cafe.com', 'atend123', 'atendente');


SELECT id_usuario, senha, tipo FROM usuarios;
