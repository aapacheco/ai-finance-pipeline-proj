-- schema initializer

-- 1. Table for tracking individual stocks (look-up table)
CREATE TABLE IF NOT EXISTS stocks (
    id SERIAL PRIMARY KEY,
    ticker VARCHAR(10) UNIQUE NOT NULL, -- e.g., 'AAPL', 'GOOGL'
    company_name VARCHAR(255)
);

-- 2. Table for storing individual analyzed news articles
CREATE TABLE IF NOT EXISTS news_articles (
    id SERIAL PRIMARY KEY,
    ticker_id INTEGER REFERENCES stocks(id) NOT NULL,
    headline TEXT NOT NULL,
    sentiment_score DECIMAL(5, 4),      -- The model's score (-1.0 to 1.0)
    classification VARCHAR(10),         -- 'Positive', 'Negative', 'Neutral'
    source_url VARCHAR(512),
    published_at TIMESTAMP WITH TIME ZONE
);

-- 3. Table for storing the final, aggregated rolling score
-- This is what the React frontend will query frequently.
CREATE TABLE IF NOT EXISTS sentiment_aggregates (
    ticker_id INTEGER REFERENCES stocks(id) UNIQUE NOT NULL,
    rolling_24hr_score DECIMAL(5, 4),
    last_updated TIMESTAMP WITH TIME ZONE
);

-- Optional: Insert a few stocks to start testing immediately
INSERT INTO stocks (ticker, company_name)
VALUES
('AAPL', 'Apple Inc.'),
('MSFT', 'Microsoft Corp.'),
('GOOGL', 'Alphabet Inc.')
ON CONFLICT (ticker) DO NOTHING;