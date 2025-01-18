CREATE TABLE users
(
    id         SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    username   VARCHAR(30) NOT NULL,
    phone      VARCHAR(25),
    email      VARCHAR(40),
    password   VARCHAR(50),
    CHECK (COALESCE(phone, email) IS NOT NULL)
);

CREATE TABLE movies
(
    id         SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    title      VARCHAR(240),
    user_id    INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE comments
(
    id         SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    contents   VARCHAR(240) NOT NULL,
    user_id    INTEGER      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    movie_id   INTEGER      NOT NULL REFERENCES movies (id) ON DELETE CASCADE
);

CREATE TYPE reaction_type AS ENUM ('positive', 'negative');

CREATE TABLE movies_reactions
(
    id         SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id    INTEGER       NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    movie_id   INTEGER REFERENCES movies (id) ON DELETE CASCADE,
    type       reaction_type NOT NULL,
    UNIQUE (user_id, movie_id)
);

CREATE TABLE comments_reactions
(
    id         SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_id    INTEGER       NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments (id) ON DELETE CASCADE,
    type       reaction_type NOT NULL,
    UNIQUE (user_id, comment_id)
);
