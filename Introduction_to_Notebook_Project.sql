/*
We've added an incorrect answer below. Try hitting submit with the wrong answer to see how the feedback works.

Given it a try? Now try updating to filter on order_id 10 and submit again.

Now you know everything to be successful with Notebook SQL projects. Good luck!*/

-- Here's an example query solution. 
-- Try submitting the project without changing anything to see the feedback message.
-- Now update the query to filter on order_id 10 to get it correct.
select customer_id
from sales.orders
where order_id = 9; -- replace with 10 and submit to complete the project.

select customer_id
from sales.orders
where order_id = 10;