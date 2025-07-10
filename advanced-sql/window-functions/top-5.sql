-- =================
-- 1. SUM          
-- =================
SELECT o.occurred_at,
    SUM(o.gloss_qty) OVER (ORDER BY o.occurred_at) as running_gloss_orders
FROM
    demo.orders o

-- =================
-- 2. ROW NUMBER   
-- =================
WITH order_ranks as (
    SELECT o.id,
        o.account_id,
        o.gloss_qty,
        o.gloss_amt_usd,
        ROW_NUMBER() OVER(PARTITION BY o.account_id ORDER BY o.occurred_at DESC) as acct_order_rank
    FROM demo.orders o
)
SELECT *
    FROM  order_ranks
WHERE  acct_order_rank = 1

-- =================
-- 3. DENSE RANK   
-- =================
SELECT o.id,
    o.account_id,
    DATE_TRUNC('day',o.occurred_at) as occurred_day,
    o.gloss_qty,
    o.gloss_amt_usd,
    DENSE_RANK() OVER(PARTITION BY o.account_id ORDER BY DATE_TRUNC('day',o.occurred_at)) as dense_rank
FROM demo.orders o

-- =================
-- 4. LAG   
-- =================
SELECT o.id,
    o.occurred_at,
    o.gloss_qty,
    LAG(gloss_qty,1) OVER(ORDER BY o.occurred_at) as order_lag_1,
    LAG(gloss_qty,2) OVER(ORDER BY o.occurred_at) as order_lag_2,
    LAG(gloss_qty,3) OVER(ORDER BY o.occurred_at) as order_lag_3
FROM demo.orders o

-- =================
-- 5. MAX   
-- =================
SELECT o.id,
    o.occurred_at,
    o.gloss_qty,
    MAX(gloss_qty) OVER(ORDER BY o.occurred_at ROWS BETWEEN 5 PRECEDING AND 1 PRECEDING) as max_order
FROM demo.orders o