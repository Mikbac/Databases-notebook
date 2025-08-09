-- Two-Phase Transactions
--
-- PostgreSQL supports a two-phase commit (2PC) protocol that allows multiple distributed systems to work together
-- in a transactional manner.
-- https://www.postgresql.org/docs/current/two-phase.html

-- Phase 1
BEGIN;
INSERT INTO orders
VALUES (1, 'new order');
PREPARE TRANSACTION 'tx1';

-- Phase 2 (later)
COMMIT PREPARED 'tx1';
-- or
ROLLBACK PREPARED 'tx1';
