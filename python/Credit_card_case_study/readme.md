# ANALYTICS IN CREDIT CARD INDUSTRY

Analytics has penetrated every industry owing to the various technology platforms that collect information and thus, the service providers know what exactly customers want. The Credit Card industry is no exception. Within credit card payment processing, there is a significant amount of data available that can be beneficial in countless ways.

## Understanding Customer Behavior
The data available from a credit card processor identifies the types of consumers and their business spending behaviors. Hence, developing marketing campaigns to directly address their behaviors grows revenue and results in greater sales.

## Personalizing Offerings Based on Data
Data reveals specific interests and needs in individual customers that a company can leverage to address their needs more efficiently. Specific promotions can be sent out based on customer location, leading to quicker sales.

## Using Trends and Patterns to Acquire New Customers
The transactions and activities of existing customers in terms of purchase behavior reflect larger trends. This information provides a strategy to target potential customers in the desired audience.

## Uncovering Suspicious Activity
Data from credit card processing is becoming increasingly important in combating fraud. When combined with artificial intelligence, this data is quickly analyzed to detect fraudulent purchases.

## Reducing Chargebacks
The ability to detect suspicious activity and patterns in data can also assess whether a transaction might result in a chargeback. Analytics can track transactions to identify anomalies, helping businesses prevent chargebacks.

# BUSINESS PROBLEM
To make quality decisions in the modern credit card industry, knowledge must be gained through effective data analysis and modeling. By using dynamic, data-driven decision-making tools and procedures, information can be gathered to evaluate all aspects of credit card operations.

**Scenario:** PSPD Bank operates in over 50 countries. Mr. Jim Watson, CEO, wants to evaluate areas of bankruptcy, fraud, and collections while responding to customer requests with proactive offers and services.

# DATA AVAILABLE
This dataset consists of three sheets:
- **Customer Acquisition**: Details of customers at the time of card issuance.
- **Spend (Transaction Data)**: Credit card spending for each customer.
- **Repayment**: Credit card payments made by customers.

## Analysis Requirements
### Data Cleaning:
1. If a customer's age is less than 18, replace it with the mean age value.
2. If a spend amount exceeds the limit, replace it with 50% of that customer’s limit (as provided in the acquisition table).
3. If the repayment amount exceeds the limit, replace it with the limit.

### Summaries to be Created:
1. How many distinct customers exist?
2. How many distinct categories exist?
3. What is the average monthly spend by customers?
4. What is the average monthly repayment by customers?
5. If the monthly rate of interest is 2.9%, what is the bank's profit for each month?
   - Profit is defined as interest earned on positive Monthly Profit.
   - Monthly Profit = Monthly Repayment - Monthly Spend.
   - Interest is earned only on positive profits.
6. What are the top 5 product types?
7. Which city has the highest spend?
8. Which age group spends the most money?
9. Who are the top 10 customers in terms of repayment?

### Additional Analysis:
- Calculate city-wise yearly spend on each product and provide a graphical representation.
- Create visualizations for:
  1. Monthly comparison of total spends, city-wise.
  2. Yearly spend comparison on air tickets.
  3. Monthly spend comparison for each product to identify seasonality.

### User-Defined Python Function:
Develop a Python function that:
- Identifies the top 10 customers for each city in terms of repayment amount.
- Allows the user to specify the product type (Gold/Silver/Platinum).
- Allows the user to specify the time period (yearly or monthly).
- Automatically adjusts based on user inputs to generate results.

This project aims to enhance customer insights, reduce risks, and improve profitability through data-driven decision-making in the credit card industry.

